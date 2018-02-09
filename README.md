# Professional Thoughts

Brought to you by Team Perspiration!

## Overview
Whether you're looking to express yourself within a professional limelight, or searching for an exciting night with new friends and coworkers, the Professional Thoughts iOS app makes finding the perfect time easy.

## Gifs
|Scrolling Through Feed|
|:-------------:|
|<img src="https://github.com/melissahe/mansnothot/blob/prod/GIFMansNotHot/scrolling.gif" width="358" height="626">|

|Accessing Camera|Reporting a User|
|:-------------:|:-------------:|
|<img src="https://github.com/melissahe/mansnothot/blob/prod/GIFMansNotHot/AccessCameraAndPosting.gif" width="358" height="626">|<img src="https://github.com/melissahe/mansnothot/blob/prod/GIFMansNotHot/reportingUserAgain.gif" width="358" height="626">|

|Comment On Post|Liking And Unliking|
|:-------------:|:-------------:|
|<img src="https://github.com/melissahe/mansnothot/blob/prod/GIFMansNotHot/commenting.gif" width="358" height="626">|<img src="https://github.com/melissahe/mansnothot/blob/prod/GIFMansNotHot/LikingAndUnliking.gif" width="358" height="626">|


## Features
- Users can make an account and custom profile with a username, image and bio
- Can post professional thoughts and images
- Can share professional thoughts
- Can flag and report a post if it is offensive
- Can comment on professional thoughts and look at the whole comment thread
- Can give posts thumbs up and thumbs down
- Most recent post are on the top of the newsfeed
- User can also see all their posts by going to their profile and clicking on "see all my posts"


## Requirements
- iOS 8.0+ / Mac OS X 10.11+ / tvOS 9.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ sudo gem install cocoapods`

### Pods
- [Firebase](https://firebase.google.com)
  - Firebase/Core
  - Firebase/Auth
  - Firebase/Database
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [KingFisher](https://github.com/onevcat/Kingfisher)
- [SnapKit](http://snapkit.io/docs)
- [SVProgessHUD](https://github.com/SVProgressHUD/SVProgressHUD)
- [Toucan](https://github.com/gavinbunney/Toucan)

### How to Install Pods
To integrate these pods into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'SnapKit'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Kingfisher'
pod 'Toucan'
pod 'IQKeyboardManagerSwift'
pod 'SVProgessHUD'
end
```

Then, run the following command in Terminal:

`$ pod install`

## Credits (Team Persperation!!)
- **Project Manager**: [Richard Crichlow](https://github.com/dementedcactus/)
- **Tech Lead**: [Melissa He](https://github.com/melissahe/)
- **UI/UX**: [Margaret Chan](https://github.com/margarethchan/)
- **QA**: [Izza Nadeem](https://github.com/izzanadeem/)

