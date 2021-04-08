[![CI Status](https://img.shields.io/travis/sameersyd/FortuneWheel.svg?style=flat)](https://travis-ci.org/sameersyd/FortuneWheel)
[![Version](https://img.shields.io/cocoapods/v/FortuneWheel.svg?style=flat)](https://cocoapods.org/pods/FortuneWheel)
[![License](https://img.shields.io/cocoapods/l/FortuneWheel.svg?style=flat)](https://cocoapods.org/pods/FortuneWheel)
[![Platform](https://img.shields.io/cocoapods/p/FortuneWheel.svg?style=flat)](https://cocoapods.org/pods/FortuneWheel)

![GitHub Cards Preview](https://github.com/sameersyd/FortuneWheel/blob/master/art/GITHUB-COVER.png?raw=true)

# Fortune Wheel
Fortune spinning wheel 🎡, cocoapods library built using SwiftUI, supports dynamic content. *Made with love ❤️ by [Sameer Nawaz](https://github.com/sameersyd)*

<br />

## Preview - Spin Wheel ⚙️
<img src="https://github.com/sameersyd/FortuneWheel/blob/master/art/iPhone-preview.png" height="600">

<br />

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

FortuneWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FortuneWheel'
```

Import Fortune Wheel in your class
```ruby
import FortuneWheel
```

## Sample Code for Fortune Wheel 🌟 

```swift
struct ContentView: View {
	var players = ["Sameer", "Spikey", "Amelia", "Joan", "Karen", "Natalie"]
	var body: some View {
		ZStack {
			FortuneWheel(titles: players, size: 320, onSpinEnd: { index in
				// your action here - based on index
			})
		}
	}
}
```

## Note:
#### When used custom animation provide it duration in `animDuration` parameter
#### Change the `animDuration` only if custom animation is used, or it may cause delay in pointer result.

## Fortune Wheel properties
<table style="width:100%">
  <tr>
    <th>Parameter</th>
    <th>Optional</th> 
    <th>Type</th>
    <th>Default Value</th>
  </tr>
  <tr>
    <td>titles</td>
    <td>false</td>
    <td>[String]</td>
    <td>nil</td>
  </tr>
  <tr>
    <td>size</td>
    <td>false</td>
    <td>CGFloat</td>
    <td>nil</td>
  </tr>
  <tr>
    <td>onSpinEnd</td>
    <td>false</td>
    <td>(Int) -> ()</td>
    <td>nil</td>
  </tr>
  <tr>
    <td>colors</td>
    <td>true</td>
    <td>[Color]</td>
    <td>Color hex ["FBE488", "75AB53", "D1DC59", "EC9D42", "DE6037", "DA4533", "992C4D", "433589", "4660A8", "4291C8"]</td>
  </tr>
  <tr>
    <td>pointerColor</td>
    <td>true</td>
    <td>Color</td>
    <td>Color(hex: "DA4533")</td>
  </tr>
  <tr>
    <td>strokeWidth</td>
    <td>true</td>
    <td>CGFloat</td>
    <td>15</td>
  </tr>
  <tr>
    <td>strokeColor</td>
    <td>true</td>
    <td>Color</td>
    <td>Color(hex: "252D4F")</td>
  </tr>
  <tr>
    <td>animDuration</td>
    <td>true</td>
    <td>Double</td>
    <td>6</td>
  </tr>
  <tr>
    <td>animation</td>
    <td>true</td>
    <td>Animation</td>
    <td>Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: 6)</td>
  </tr>
</table>


## Contribute
If you want to contribute to this app, you're always welcome!
See [Contributing Guidelines](https://github.com/sameersyd/FortuneWheel/blob/master/CONTRIBUTION.md).


## Donation
If this project helped you reduce time to develop, you can buy me a cup of coffee :) 

<a href="https://www.buymeacoffee.com/sameersyd" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>


## Author

sameersyd, sameer.nwaz@gmail.com

## License
```
    Apache 2.0 License


    Copyright 2021 Sameer Nawaz

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

```
