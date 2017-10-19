<p align="center">
<img src="Preview/logo.png"width="422" height="130"/>
</p>

<p align="center">
    <a href="https://itunes.apple.com/app/id1275441372"><img src="https://img.shields.io/badge/App Store-iPhone | iPad-blue.svg"/></a>
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-Swift 4-<COLOR>.svg"/></a>
    <a href="https://itunes.apple.com/app/id1275441372"><img src="https://img.shields.io/badge/platform-iOS 8.0+ -lightgrey.svg"/></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"/></a>
    <a href="README.zh-cn.md"><img src="https://img.shields.io/badge/中文-README-orange.svg"/></a>
</p>
## Get Started

This project is written by **Swift 4.0** and requires **Xcode 9+**.

* Open the TimerS workspace in Xcode 9+
* Build and run

## Feature

#### Run Background

TimerS does not have background process. If you terminate the process or even shutdown the device, Timers still counts time correctly. TimerS records users' operations in **UserDefaults**, it compares the current time and start time to calculate displayed time when you are using.

![iPhoneX](Preview/userDefault.gif)

#### Customed UIPickView

Customed UIPickerView displays hours, minutes and seconds. When set timer to 0:

![iPhoneX2](Preview/pickerView.gif)

#### Autolayout & Universal

Build interface by AutoLayout and Storyboard. Support universal devices and split view on iPad:

![horizontal](Preview/horizontal.png)

![a](Preview/splitView.png)
## License
TimerS is released under the **MIT** license. See [LICENSE](https://opensource.org/licenses/MIT) for details

<a href="https://itunes.apple.com/app/id1275441372"> <img src="https://github.com/Ramotion/navigation-stack/raw/master/Download_on_the_App_Store_Badge_US-UK_135x40.png" width="170" height="58"></a>

## [中文介绍](README.zh-cn.md) ##