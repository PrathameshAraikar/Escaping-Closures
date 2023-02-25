# Escaping-Closures
This is a small project that demonstrates how to use escaping closures in Swift. It includes a simple implementation of downloading data from a remote server using an escaping closure.

## Project Overview
The project has a simple SwiftUI view called `ContentView` that displays a list of shoes. The shoe data is downloaded from a remote server using an escaping closure to handle the asynchronous response.

The view model class `DownloadWithEscapingViewModel` is responsible for downloading the shoe data from the server using the escaping closure. It also has a `getPosts` method that is called on initialization and uses the escaping closure to download the shoe data and update the view model.
