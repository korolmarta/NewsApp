# News App

A news app built using UIKit and Swift. This app provides features such as sorting, filtering, searching, pagination, favourites, and more.

## Features

### iPhone and Portrait Orientation

The app is optimized for iPhone devices and supports portrait orientation.

### Discover

- Displays news articles.
- Supports sorting articles by publishing date.
- Provides filtering options by category and country.
- Implements search functionality to search for specific articles.
- Each cell includes image, source, author, title, and description information.
- Each cell has a favourite button and users can add articles to their favourite list.
- Tapping on a cell opens the relevant news article in a separate controller using WKWebView.

### Favorite

- Favourites data is stored in a database using CoreData.
- Each cell includes image, source, author, title, and description information.
- Each cell has a favourite button and users can remove articles from their favourite list.
- Tapping on a cell opens the relevant news article in a separate controller using WKWebView.

### UIRefreshControl

- Allows users to refresh the news articles list by pulling down on the UITableView.

### Pagination

- Implements pagination for news articles with a fixed itemsCount per page (10).
- Includes a loading indicator to indicate ongoing pagination.

### Architecture: MVVM 

- Followed the MVVM architecture for structured and maintainable code.

## Getting Started

Open terminal:
1. git clone git@github.com:korolmarta/NewsApp.git folder-name
2. cd ../folder-name
3. pod install

4. Visit https://newsapi.org/. Sign up/in and copy your API Key.

5. Open Xcode and select NewsApp project. In NetworkService.swift replace value of yourApiKey with your API Key.
   
6. Build, run, and enjoy news

## Usage

https://github.com/korolmarta/NewsApp/assets/32436491/69b8d1f2-ceff-4aea-927d-77ce3ee90f9a









