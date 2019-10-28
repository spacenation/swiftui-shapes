## Custom SwiftUI Shapes
Collection of custom shapes for iOS and macOS

### Features
- Recular polygons

<center>
<img src="Resources/shapes.png"/>
</center>

## How to use

Add this swift package to your project
```
git@github.com:SwiftUIExtensions/Shapes.git
```

Import and use

```swift
import Shapes
import SwiftUI

struct ContentView: View {    
    var body: some View {
        Group {
            Pentagon()
            Hexagon()
            RegularPolygon(sides: 32)
        }
    }
}
```
For more examples open `/Examples/ShapesExamples.xcodeproj`

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- Xcode 11.0+

## Roadmap 
- Rounded regular polygons

## Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.
