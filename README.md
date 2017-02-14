# Lipstick

[![CI Status](http://img.shields.io/travis/Brightify/Lipstick.svg?style=flat)](https://travis-ci.org/Brightify/Lipstick)
[![Version](https://img.shields.io/cocoapods/v/Lipstick.svg?style=flat)](http://cocoapods.org/pods/Lipstick)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Lipstick.svg?style=flat)](http://cocoapods.org/pods/Lipstick)
[![Platform](https://img.shields.io/cocoapods/p/Lipstick.svg?style=flat)](http://cocoapods.org/pods/Lipstick)
[![Slack Status](http://swiftkit.brightify.org//badge.svg)](http://swiftkit.brightify.org)

## Introduction

Lipstick is small library which aim to improve usage of UIKit (UIColor, CGRect ...). It consists mostly of convenience inits, helper methods etc. Main motivation behind this library is the protocol `Stylable` which allows easy style application to `UIView` (See Usage/Stylable).

## Changelog

List of all changes and new features can be found [here](CHANGELOG.md).

## Requirements

* **Swift 3**
* **iOS 8+**

## Installation

### CocoaPods
Lipstick is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your target in your Podfile:

```Ruby
pod "Lipstick"
```

### Carthage
To use Lipstick with [Carthage](https://github.com/Carthage/Carthage) add in your Cartfile this line:

```
github "Brightify/Lipstick"
```

## Usage

Due to the nature of this library, the easiest way to learn its content is to look at [tests](Tests) or directly into [source code](Source). Below is listed complete content (sorted alphabetically except for Stylable) for quick reference.

Note: Inits for all structs like CGRect are created so that any parameter can be omitted (has default value of 0). For example: `CGRect(x: 1)`, `CGRect(origin: origin, width: 1)` and `CGRect(x: 1, size: size)` are all valid and these possibilities are skipped from this documentation.   

### Styleable

`Styleable` allows you to easily separate code defining view appearance from the rest. It is basically syntax sugar for using closures which modify passed object.

```Swift
protocol Styleable { }

extension UIView: Styleable { }

typealias Style<T> = (T) -> Void

extension Styleable {

    func apply(style: Style<Self>)

    func apply(styles: Style<Self>...)

    func apply(styles: [Style<Self>])

    func styled(using styles: Style<Self>...) -> Self

    func styled(using styles: [Style<Self>]) -> Self

    func with(_ style: Style<Self>) -> Self
}
```

We recommend to put these styles into struct `Styles` and nest it to extension like this:

```Swift
class SomeView: UIView {

    private let label = UILabel().styled(using: Styles.blueBackground)
}

fileprivate extension SomeView {

    fileprivate struct Styles {

        static func blueBackground(_ view: UILabel) {
            view.backgroundColor = UIColor.blue
        }

        static func whiteBackground(_ view: UILabel) {
            view.backgroundColor = UIColor.whiteBackground
        }
    }
}
```

To later change the appearance of view do:

```Swift
class SomeView: UIView {

    private let label ...

    func changeAppearanceOfLabel() {
        label.apply(style: Styles.whiteBackground)
    }
}
```

It is possible to use static var with closure instead of function like this:

```Swift
static var style: Style<UILabel> = { view in
    view.backgroundColor = UIColor.blue
}
```

Or any other syntax that you are happy with.

You can also define some base styles globally and then call them from another styles like so:

```Swift
struct BaseStyles {

    static func blueBackground(_ view: UIView) {
        view.backgroundColor = UIColor.blue
    }
}

struct LabelStyles {

    static func yellowTintWithBlueBackground(_ label: UILabel) {
        label.apply(style: BaseStyles.blueBackground)

        label.tintColor = UIColor.yellow
    }
}
```

### CGAffineTransform

```Swift
func + (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform

func rotate(_ degrees: CGFloat) -> CGAffineTransform

func translate(x: CGFloat, y: CGFloat) -> CGAffineTransform

func scale(x: CGFloat, y: CGFloat) -> CGAffineTransform
```

Notes: `rotate`, `translate` and `scale` are all global functions. They create corresponding `CGAffineTransform`. All of them have default values (`scale` has as default values 1).

### CGPoint

```Swift
extension CGPoint {

    init(_ both: CGFloat)

    init(x: CGFloat, y: CGFloat)
}
```

### CGRect

```Swift
extension CGRect {

    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)

    init(x: CGFloat, y: CGFloat, size: CGSize)

    init(origin: CGPoint, width: CGFloat, height: CGFloat)
}
```

### CGSize

```Swift
extension CGSize {

    init(_ both: CGFloat)

    init(width: CGFloat, height: CGFloat)
}
```

### NSAttributedString

#### `+` operator

```Swift
func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString

func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString

func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString
```

#### Attribute

```Swift
/// Enum which represents NS attributes for NSAttributedString (like NSStrokeColorAttributeName). Each case has value and assigned name.
enum Attribute {

    ...
    ...
    ...

    var name: String

    var value: AnyObject
}
```

```Swift
extension Sequence where Iterator.Element == Attribute {

    /// Creates dictionary from sequence of attributes by merging them together. String is name of case and AnyObject value corresponding to it.
    func toDictionary() -> [String: AnyObject]
}
```

#### String

```Swift
extension String {

    func attributed(_ attributes: [Attribute]) -> NSAttributedString

    func attributed(_ attributes: Attribute...) -> NSAttributedString
}
```

### Percent

```Swift
/// Returns input / 100.
postfix func %(input: CGFloat) -> CGFloat
```

### UIButton

```Swift
extension UIButton {

    init(title: String)

    func setBackgroundColor(_ color: UIColor, forState state: UIControlState)
}
```

### UICollectionView

```Swift
extension UICollectionView {

    init(collectionViewLayout layout: UICollectionViewLayout)
}
```

### UIColor

```Swift
extension UIColor {

    /// Accepted formats: "#RRGGBB" and "#RRGGBBAA".
    init(hex: String)

    init(rgb: UInt)

    init(rgba: UInt)

    /// Increases color's brightness.
    func lighter(by percent: CGFloat) -> UIColor

    /// Reduces color's brightness.
    func darker(by percent: CGFloat) -> UIColor

    /// Increases color's saturation.
    func saturated(by percent: CGFloat) -> UIColor

    /// Reduces color's saturation.
    func desaturated(by percent: CGFloat) -> UIColor

    /// Increases color's alpha.
    func fadedIn(by percent: CGFloat) -> UIColor

    /// Reduces color's alpha.
    func fadedOut(by percent: CGFloat) -> UIColor
}
```

### UIEdgeInsets

```Swift
extension UIEdgeInsets {

    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)

    init(_ all: CGFloat)

    init(horizontal: CGFloat, vertical: CGFloat)

    init(horizontal: CGFloat, top: CGFloat, bottom: CGFloat)

    init(vertical: CGFloat, left: CGFloat, right: CGFloat)
}
```

### UIFont

```Swift
extension UIFont {

    init(_ name: String, _ size: CGFloat)
}
```

### UILabel

```Swift
extension UILabel {

    init(text: String)
}
```

### UIOffset

```Swift
extension UIOffset {

    init(_ all: CGFloat)

    init(horizontal: CGFloat)

    init(vertical: CGFloat)
}
```

### UITableView

```Swift
extension UITableView {

    init(style: UITableViewStyle)
}
```

## Versioning

This library uses semantic versioning. Until version 1.0 API breaking changes may occur even in minor versions. We consider version 0.5 to be prerelease, which means that API should be stable but is not tested yet in real project. After that testing we make needed adjustments and bump the version to 1.0 (first release).

## Author

* Tadeas Kriz, [tadeas@brightify.org](mailto:tadeas@brightify.org)
* Filip Dolník, [filip@brightify.org](mailto:filip@brightify.org)

## Used libraries in tests

* [Quick](https://github.com/Quick/Quick)
* [Nimble](https://github.com/Quick/Nimble)

## License

Lipstick is available under the [MIT License](LICENSE).
