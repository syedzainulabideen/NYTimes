# NYTimes Popular Articles App



## Overview

This GitHub repository contains a demo iOS app that displays a list of the most popular articles from the New York Times website. The app is built using the MVVM (Model-View-ViewModel) architectural pattern and utilizes Swift Concurrency for asynchronous operations. It also includes a suite of unit tests to ensure code quality and reliability.

## Enviornment
To run this project, you'll need the following:

- Xcode (version 15.0)
- Swift (version 5.0)
- iOS Target (version 13.0+)

## Getting Started

Follow these steps to get the app up and running on your local development environment:

1. Clone the repository to your local machine.

```bash
git clone https://github.com/syedzainulabideen/NYTimes.git
```

## MVVM Architecture

The app follows the Model-View-ViewModel (MVVM) architectural pattern for structuring the codebase. The key components are:

- Model: The ```ArticleResponse``` class represents the data structure of New York Times articles, encapsulating their properties and related business logic.
- View: The ```ArticleListingController``` and ```ArticleDetailsController``` classes serve as the user interface components. They are responsible for rendering and presenting data to the user.
- ViewModel: The ```ArticleListingViewModel``` and ```ArticleCellViewModel``` classes act as intermediaries between the Model and View. They handle data retrieval, transformation, and presentation logic, ensuring a separation of concerns and promoting testability.


## Screenshots:
<img src="Screenshots/iphone-listing.png" alt="App Screenshot" height="600"/>
<img src="Screenshots/iphone-detail.png" alt="App Screenshot" height="600"/>


<img src="Screenshots/ipad-1.png" alt="App Screenshot" width="600"/>
<img src="Screenshots/ipad-2.png" alt="App Screenshot" width="600"/>
