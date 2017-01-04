<p align="center">
    <img src="https://github.com/alexaubry/HTMLString/raw/master/logo.png" alt="HTMLString" />
</p>

<p align="center" style="margin:30px;">
    <a href="https://alexaubry.github.io/HTMLString/">Documentation</a>
</p>

<p align="center">
    <a>
        <img src="https://img.shields.io/badge/Swift-3.0.2-ee4f37.svg" alt="Swift 3.0.2" />
    </a>
    <a href="https://travis-ci.org/alexaubry/HTMLString">
        <img src="https://travis-ci.org/alexaubry/HTMLString.svg?branch=master" alt="Build Status" />
    </a>
    <a href="https://cocoapods.org/pods/HTMLString">
        <img src="https://img.shields.io/cocoapods/v/HTMLString.svg" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" />
    </a>
    <a href="https://codecov.io/gh/alexaubry/HTMLString">
        <img src="https://codecov.io/gh/alexaubry/HTMLString/branch/master/graph/badge.svg" alt="Code coverage" />
    </a>
    <a href="https://twitter.com/leksantoine">
        <img src="https://img.shields.io/badge/Twitter-%40leksantoine-6C7A89.svg" alt="Twitter : @leksantoine" />
    </a>
</p>

`HTMLString` is a micro-library written in Swift that enables your app to encode and decode HTML `String`s.

## Features

🤖    ASCII and Unicode Escaping
🔠    Unescaping
🇺🇸    Full support of Swift extended grapheme cluster
🔣    Support of 2125 named escape sequences (`&amp;`) and all decimal (`&#128;`) and hexadecimal (`&#x1F643;`) entities
⚡     [Fast](https://github.com/alexaubry/HTMLString/tree/master/Benchmark.md)
✅    Unit tested

## Platforms

📱    iOS 8.0+
💻    macOS 10.10+
📺    tvOS 9.0+
⌚    watchOS 2.0+
🐧    Linux

## Installation

### Swift Package Manager

Add this line to your `Package.swift` :

~~~swift
.Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 2, minor: 1)
~~~

### CocoaPods

Add this line to your `Podfile`:

~~~
pod 'HTMLString'
~~~

### Carthage

Add this line to your Cartfile:

~~~
github "alexaurby/HTMLString"
~~~

### Manual

Add the `Sources/HTMLString/HTMLString.swift` and `Sources/HTMLString/Mappings.swift` files to your project.

## Usage

You interact with HTML strings with these extensions on the `String` type:

- `escapingForUnicodeHTML`: Replaces every character incompatible with HTML Unicode encoding HTML escape.
- `escapingForASCIIHTML` : Replaces every character incompatible with HTML ASCII encoding by a standard HTML escape.
- `unescapingFromHTML` : Replaces every HTML escape sequence with the matching Unicode character.

### Escaping

~~~swift
import HTMLString

let emoji = "My favorite emoji is 🙃"
let escapedEmoji = emoji.escapingForASCIIHTML // "My favorite emoji is &#128579;"

let snack = "Fish & Chips"
let escapedSnack = snack.escapingForUnicodeHTML // "Fish &amp; Chips"
~~~

### Unescaping

~~~swift
import HTMLString

let escapedEmoji = "My favorite emoji is &#x1F643;"
let emoji = escapedEmoji.unescapingFromHTML // "My favorite emoji is 🙃"

let escapedSnack = "Fish &amp; Chips"
let snack = escapedSnack.unescapingFromHTML // "Fish & Chips"
~~~

## Acknowledgements

This library was inspired by Google's `GTMNSString+HTML`.
