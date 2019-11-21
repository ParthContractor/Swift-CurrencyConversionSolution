# Swift-CurrencyConversionSolution
DemoProject: (Workspace with framework, and 2 application targets)                                                     
It consist of swift framework with required currency conversion APIs to be used in application. Also, two different application target(white label or application specific changes)

##Overview

Create an app that makes a call for international currency data (JSON) and use it to create a currency converter app that converts international currencies into Australian Dollars.

##Requirements:

* Use of suitable design patterns, and a strict separation of concerns when developing a mobile application
* Create a library containing all functionality that could be reused by 3rd party developers in any application that requires exchange rate calculations. 3rd parties using this library should not be tightly coupled to any specific technology and should be able to consume the library in any way they choose
* Code should be commented sufficiently to allow auto generation of library API documentation
* Use all the data the API provided
  * Asynchronous development principals when retrieving and displaying data originating from network calls
* UI interaction and data binding principals
  * Sound management of User Interface
  * The application should be able to be re-branded (colours, fonts, assets) - 2 distinct branded targets/variants should be included in the project
  * The app should be built with a universal UI.
* Correct use of the application life cycle, management of the UI thread
* Unit tests/mocks to demonstrate the code is testable

##Getting Started
* The URL to get the fx data is ``https://api.myjson.com/bins/100fjy``.
* For other platforms the use of frameworks, libraries, and open-source code is allowed – but please reference their use in comments in the code. Please use package management for open source dependencies where suitable.

