# O20TechnicalTest

> It is a non-comercial application for O20 Company. The app was created for an access test to the previusly company mentioned.

[![Swift Version][swift-image]][swift-url] [![CocoaPods Compatible][pod-image]][pod-url] [![Platform][ios-version]][ios-url] [![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## Features

- [x] BeersList
- [x] Beer Detail
- [x] BeersFilter
- [x] Pagination
- [x] Reload Beers
- [x] Unit test

## Navigation & View

>The proyect doesn´t have any .xib or .storyboard. I chose to use SnapKit for UI implementations just for change a little bit the way to crate a view.
>The Navigation between diferents views are implemented througt pushViewController and his initialization is created using an own dependency injector. 

## Git

Git funcionality and branches in this repository are implemented following these instructions:

- Master: When a feature is added to the proyect automatically this version will integrated in master branch.

## Postman

In this proyect I used Postman app for all the services connection and retrieve info about how the JSON was created and witch fields i will use in my app

## Libraries

| Pods | README |
| ------ | ------ |
| Alamofire | [https://github.com/Alamofire/Alamofire][Pa] |
| RxAlamofire | [https://github.com/RxSwiftCommunity/RxAlamofire][PRa] |
| RxSwift | [https://github.com/ReactiveX/RxSwift][PRX] |
| SnapKit | [https://github.com/SnapKit/SnapKit][SK] |

In this proyect you don´t need to do any `pod install` or `pod update` for compile the proyect. 
This app doesnt have any Cocoa library integrated, just SPM who allows more facilities and speed for small proyect.

----

## Languajes

Beehave can be used in these languajes :

* English
* Spanish

  [PRs]: <https://github.com/mac-cain13/R.swift>
  [Pa]: <https://github.com/Alamofire/Alamofire>
  [PRa]: <https://github.com/RxSwiftCommunity/RxAlamofire>
  [PRX]: <https://github.com/ReactiveX/RxSwift>
  [SK]: <https://github.com/SnapKit/SnapKit>
  [PC]: <https://github.com/danielgindi/Charts>
  [Pau]: <https://github.com/auth0/Auth0.swift>
  [PS]: <https://github.com/Swinject/Swinject>
  [PAC]: <https://cocoapods.org/pods/AppCenter>
  
  [swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
  [swift-url]: https://swift.org
  [pod-image]: https://img.shields.io/badge/CocoaPods-1.9.1-green
  [pod-url]: https://cocoapods.org
  [ios-version]: https://img.shields.io/badge/platform-iOS-blue
  [ios-url]: https://www.apple.com/ios/ios-13
