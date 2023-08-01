//
//  String+Extension.swift
//  VideoGameApp
//
//  Created by mertcan YAMAN on 21.07.2023.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func charIsBackSpace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        return false
    }
    
    func charIsSpace() -> Bool {
        if self == " " {
            return true
        }
        return false
    }
}

extension String {
    func setParseImageURL() -> String? {
        var parsePath = self.split(separator: "/")
        parsePath.insert("crop/600/400", at: 3)
        parsePath[0] = "https:/"
        return parsePath.joined(separator: "/")
    }
}
