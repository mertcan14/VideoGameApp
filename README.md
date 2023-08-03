# VideoGameApp

You can browse the most liked games in this application. You can filter or search the lists if you want. If you like a game, you can add it to your list by going to the detail page.
I developed this application for my internship at Turkcell.

## Functional Features

✔️  Internet check when opening app and making request to API

✔️  Lists the data it receives from the API. Can search in the brought list.

✔️  It can cache by downloading photos from API.

✔️  It can pull data from API again by performing sorting and filtering operations.

✔️  If the game has a site, it can redirect to the site.

✔️  You can see the games in your list even when you are offline

✔️  It can bring you new games by going to the end of the list

## This App Consists

✔️ VIPER Design:  https://github.com/mertcan14/VideoGameApp

✔️ Clean Swift(VIP) Design: https://github.com/mertcan14/VideoGameApp/tree/clean-swift/main-vip

✔️ Written Modules: CoreDataSPM, VideoGameAPI

✔️ SwiftLint

✔️ SwiftGen

✔️ Core Data

✔️ Auto Layout

✔️ Unit Test

✔️ UI Test

## API Usage

#### For more information, check out this site https://rawg.io/apidocs

```http
  GET https://api.rawg.io/api/games?key={api_key}&ordering={ordering_key}&metacritic={metacritic_min},{metacritic_max}
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `key` | `string` | **required** API Key |
| `ordering_key` | `string` | Order Key (released, -released) |
| `metacritic_min` | `string` | Min Point |
| `metacritic_max` | `string` | Max Point |


```http
  GET https://api.rawg.io/api/games/{game_id}?key={api_key}
```

| Parametre | Tip     | Açıklama                |
| :-------- | :------- | :------------------------- |
| `game_id` | `string` | **required** Id of the game for details |
| `api_key` | `string` | **required** API Key |

## Video

**Youtube:** https://youtu.be/BNAcFs4Ws8Y

## Screenshot
![1](https://github.com/mertcan14/VideoGameApp/assets/61551987/7f0fd1b3-9344-4644-83d9-21624310db2d)

![2](https://github.com/mertcan14/VideoGameApp/assets/61551987/644ba5ae-85fd-4b74-af56-9cf2d53bdd93)

![3](https://github.com/mertcan14/VideoGameApp/assets/61551987/7df09eed-9e35-47a7-9d33-1071883b70da)


