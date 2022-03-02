
<div id="top"></div>

<!-- TABLE OF CONTENTS -->

<details>

<summary>Table of Contents</summary>

<ol>

<li>

<a href="#about-the-project">About The Project</a>

<ul>

<li><a href="#built-with">Built With</a></li>

</ul>

</li>

<li>

<a href="#getting-started">Getting Started</a>

<ul>

<li><a href="#prerequisites">Prerequisites</a></li>

<li><a href="#installation">Installation</a></li>

</ul>

</li>

<li><a href="#usage">Usage</a></li>

<li><a href="#roadmap">Roadmap</a></li>

<li><a href="#contributing">Contributing</a></li>

<li><a href="#contact">Contact</a></li>

<li><a href="#acknowledgments">Acknowledgments</a></li>

</ol>

</details>

<!-- ABOUT THE PROJECT -->

##  About The Project

Shortly will provide you with a greate tool to utlize the power of [shortco.app](https://shortco.app/), you will be able to easily enter any valid link, and the shortly will shotening it for you, and save your results and give you the ability to use them for later with one click to copy, and delete not needed old results when you don't wan them anymore, happy shortnening :smile:

<p align="right">(<a href="#top">back to top</a>)</p>

###  Built With

* Xcode 13.0
* Target platform version: iOS 13
* macOS Big Sur version 11.4
* Reactive using Comine 
* Handle asynchronous tasks and results with Promise Kit
* Alamofile to handle the backend API
* UserDefaults to persist the data

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

##  Getting Started

###  Prerequisites

Before run the project you need to make sure that you have Pod installed on your device, you can download it using the below command:

* CocoaPods

```sh

$ sudo gem install cocoapods

```

###  Installation

After you installed the CocoaPods, you can proceed and install the required dependencies of the project:

1. Open terminal app on your device

2. Go to the project main directory

```sh

cd your_main_directory_path/Shortly\ Challeng

```

3. Run pod install

```sh

pod install

```

4. Open project workspace file

5. You are don, you can run the application now
<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

##  Used Technologies

### The used archeticture that I used in the project is MVVM, it can provide a juge flexibility, separate between models and views, apply the reactive programming by controling all the interactions and handling models in the ViewModels.

### Dependency Pattern:
Dependency Injection pattern was used here to  manage the app shared Repositories and ViewModels.

### Design Pattern:
Repository was used to provide a facade design pattern to help fetching data from the cloud service endpoints and to store the data on the local device storage.

### Reactive programming: 
Comine was the method used to apply it, I prefer to use Combine over other tools or third libraries is because it is provided by apple, it's applied on the level of foundation and UIKit, so anything you may use from those two Appld Kits will be supported, Apple has access to all public and private functions and attributes in their libraries, so it will be able to apply the reacitve with more powerful that any other third parties that will have linit access to Apple libraries' components.

### Asynchronous and handling results:
Promise kit will shine up here, it can provide a lot of poweful options and possiblities, from chainig the requests, and get rid of the boiledcode that you need to wrote to handle the results, delegates and completion handles.

### Domain Layer:
I created a domain layer, and specific data layer for each data source, for the RemoteAPI we used DTOs, for the UserDefaults persist storage, we used UDS.
This approach will help you let the ViewModel only handle one Model, and any change that could affect the DTOs or UDS will not affect the ViewModel, because we have a mapping functions that should know how to apply and create Domain models from DTOs or UDSs.

### ViewModel Abstraction:
When we abstract the ViewModel, we can use different implementation of the same ViewModel, and we can use that later on with UnitTesting the ViewModel by creating Mock data implementation and test the needed cases and scenarios.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

##  Contact

Ammar Alaranji - [LinkedIn](https://www.linkedin.com/in/ammar-al-aranji-5a5951190/) - ammararangy@gmail.com

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

##  Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Alamofire](https://github.com/Alamofire/Alamofire)

* [PromiseKit](https://github.com/mxcl/PromiseKit)

* [SnapKit](https://github.com/SnapKit/SnapKit)

<p align="right">(<a href="#top">back to top</a>)</p>

[product-screenshot]: images/screenshot.png
