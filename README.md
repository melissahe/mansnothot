# mansnothot Something Professional
Brough to you by Team Perspiration!

Whether you're looking to express yourself within a professional limelight, or searching for a exciting night with new friends and coworkers, the mansnothot Professional Thoughts iOS app makes finding the perfect time easy.

## Overview
//to do

## Gifs
//to do

## Features
//to do

## Requirements
- iOS 8.0+ / Mac OS X 10.11+ / tvOS 9.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ sudo gem install cocoapods`

### Pods
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Firebase](https://firebase.google.com)
- Firebase/Core
- Firebase/Auth
- Firebase/Database
- [KingFisher](https://github.com/onevcat/Kingfisher)
- [SnapKit](http://snapkit.io/docs)
- [TableFlip](https://github.com/mergesort/TableFlip)
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [Toucan](https://cocoapods.org/pods/Nuke-Toucan-Plugin)

### How to Install Pods
To integrate these pods into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'Alamofire'
pod 'SnapKit'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'TableFlip'
pod 'Kingfisher'
pod 'Toucan'
pod 'IQKeyboardManagerSwift'

end
```

Then, run the following command in Terminal:

`$ pod install`


## Deployment to iOS Device
You can sideload this app into your iOS Device with. Xcode with the following steps:
- **Open** the mansnothot project - the file that says "mansnothot.xcworkspace".
- **Click** on mansnothot in the left sidebar
- **Go** to “Xcode -> Preferences“, and click on the “Accounts” tab. You’ll have to add your Apple ID here. You can simply click on the plus icon in the bottom of the screen and add your Apple ID. (It doesn’t need to be a developer ID; your free Apple ID works as well.)
- **Change** the value next to “Bundle Identifier“, and make it anything that is unique, and looks like com.foo.mansnothot (Replace “foo” with your desired name.)
- **Click** on the drop down box next to “Development Team”, and select "Your Name (Personal team)".
- **Connect** your iPhone to your Mac. Then, go to “Product -> Destination“, and select your iPhone from the list.
- **Click** on the “Run” button in Xcode. Xcode will then begin compiling the app for your iPhone.
- Xcode will prompt you with an error saying that you need to trust the developer on the iPhone. On your iPhone, **Go To** “Settings -> General -> Profiles and Device Management“. Tap on the entry under “Developer App”, and tap on “Trust”.
- You can now go to your homescreen, and look for mansnothot. **Tap** on the app to launch mansnothot Professional Thoughts!

## Credits (Team Perspiration!!)
- **Project Manager**: [Richard Crichlow](www.github.com "Github")
- **Tech Lead**: [Melissa He](https://github.com/melissahe "Github")
- **UI/UX**: [Margaret (Maggie) Chan](https://github.com/margarethchan "Github")
- **QA**: [Izza Nadeem](https://github.com/IzzaNadeem "Github")

## EULA
Copyright 2018 Team Perspiration

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
