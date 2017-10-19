<p align="center">
<img src="Preview/logo.png"width="422" height="130"/>
</p>

<p align="center">
    <a href="https://itunes.apple.com/app/id1275441372"><img src="https://img.shields.io/badge/App Store-iPhone | iPad-blue.svg"/></a>
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-Swift 4-<COLOR>.svg"/></a>
    <a href="https://itunes.apple.com/app/id1275441372"><img src="https://img.shields.io/badge/platform-iOS 9.0+ -lightgrey.svg"/></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"/></a>
    <a href="README.md"><img src="https://img.shields.io/badge/English-README-orange.svg"/></a>
</p>

## 开始使用

该工程由**Swift 4.0** 和**Xcode 9+** 编写.

* 使用Xcode 9+ 打开**TimerS.xcodeproj**
* 运行

## 特征

#### 后台运行

TimerS没有后台进程. 如果你结束进程甚至是关机, Timers仍然可以正确计时. TimerS使用**UserDefaults**记录用户的操作. 当你使用TimerS时,它将对比当前和开始时间来计算出当前显示的时间.

![iPhoneX](Preview/userDefault.gif)

#### 自定义UIPickerView

使用自定义的UIPickerView来同时显示时,分,秒. 当你设置时间为0时:

![iPhoneX2](Preview/pickerView.gif)

#### Autolayout & Universal

界面通过AutoLayout和Storyboard构建. 同时支持iPad和iPhone以及iPad上的分屏功能:

![horizontal](Preview/horizontal.png)

![a](Preview/splitView.png)

## License

TimerS在MIT许可下发布, 详见[LICENSE](https://opensource.org/licenses/MIT)

<a href="https://itunes.apple.com/app/id1275441372"> <img src="https://github.com/Ramotion/navigation-stack/raw/master/Download_on_the_App_Store_Badge_US-UK_135x40.png" width="170" height="58"></a>

## [English](README.md) ##