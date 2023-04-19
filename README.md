

# WorldOfPAYBACK

## Overview

The WorldOfPAYBACK app is a SwiftUI-based iOS application that allows the user to view a list of transactions grouped by booking date. The user can filter the transactions based on their category and view transaction details. The app uses the MVVM design pattern and is built using SwiftUI and Combine frameworks.

## Features

* View transactions grouped by booking date.
* Filter transactions by category.
* View transaction details by tapping on a transaction.
* If there is no internet connection, the app will show an error message.
* Error handling when there is a failure to load transactions.
* Show loader when data is being loaded.
* Show total sum of transactions.

## Prerequisites

* Xcode 13 or later.
* iOS 15 or later.

## Installation

* Clone or download the project from the GitHub repository.
* Open the project in Xcode.
* Build and run the app.

## Usage

* Upon launching the app, the user will land to home page where they see welcome message with button to go to the transaction page
* Once the user taps on the button,, the user will see a list of transactions grouped by booking date.
* The user can filter the transactions by selecting a category from the segmented control at the bottom of the screen.
* To view transaction details, the user can tap on a transaction to present a new view that shows the transaction details.
* If there is no internet connection, the app will show an error message.
* If there is a failure to load transactions, the app will show an error message.
* The app will show a loader while data is being loaded.
* The app will display the total sum of transactions at the bottom of the screen.

## Architecture

The app uses the MVVM design pattern. The view displays the data and responds to user input, the view model retrieves data from the model and prepares it for display, and the model provides the data.

## Libraries and Frameworks

The app uses the following libraries and frameworks:

* SwiftUI: A declarative framework for building user interfaces.
* Combine: A framework for reactive programming.
* URLSession: A framework for making network requests.
* XCTest: A testing framework for writing unit tests.
