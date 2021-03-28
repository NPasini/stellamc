# Star Gazers Application

This iOS Application display the list of Star Gazers of a selected repository. 

## Getting Started

To get the most updated version of the code, download the last commit in the master branch.

### Prerequisites

This project has been created using XCode 12.4.

## Organization of the Project

stellamc is the main target, which is structured in the following way:

* Page folder: this folder contain all the files related to the pages here you can find ViewControllers, ViewModels, Views and all related files;
* Dependency Injection folder: is the folder containing the definitions of the services that will be injected and their registration;
* API folder: contains the implementation of the service called to retrieve the data;
* Models folder: contains the models;
* Service folder: this folder contains the implementation of the Network Connection Service which monitors the availability of the network connection and the Navigation service which enables the navigation between scrreens;
* Utilities folder: in this folder you can find some Extensions, the definition of the Errors used and protocols.

The Product detail page (PDP) has been implemented using Swift UI. In this page some basics information about the product are displayed (name, price, categories= plus some additionals information (colors and sizes) which are showed after been retrieved using the API provided for the product details.

Inside the Department Page, the one showing the list of products for a specific category, there is a monitor for the network connection; in case the connection is not available a message is showed to the user.

The Test targets for Unit tests and UI tests contains several test for only the Department page. I choose to test only this page to provide some examples of tests for one of the pages that contains both presentation logics and calls api to get paginated data.

## Dependencies ##
The dependencies are managed using both CocoaPods and Swift Package Manager. The dependencies used are:

* [OSLogger](https://github.com/NPasini/OSLogger): which contains my custom implementation of a logger based on os.log;
* [Network Manager](https://github.com/NPasini/NetworkManager): which is my custom implementation of the Network Manager based on URLSession.
* ReactiveSwift
* ReactiveCocoa;
* SDWebImage + SDWebImageSwiftUI: used for caching the images downloaded;
* Swinject: used for managing the dependency injection;
* Quick: used to make more readable tests;
* Nimble: is a dpendency of Quick;

## Author ##

**Nicolò Pasini**



