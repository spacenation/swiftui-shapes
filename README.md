## Custom SwiftUI Shapes
Collection of custom shapes for iOS and macOS

## Regular polygons
<center>
<img src="Resources/regularRectangles.png"/>
</center>

```swift
Pentagon()
Hexagon()
RegularPolygon(sides: 32)
```

## Lines and Curves
<center>
<img src="Resources/lines.png"/>
</center>

```swift
QuadCurve(points: [
    UnitPoint(x: 0.1, y: 0.1),
    UnitPoint(x: 0.5, y: 0.9),
    UnitPoint(x: 0.9, y: 0.1)
])
.stroke(Color.blue, style: .init(lineWidth: 2, lineCap: .round))
.frame(height: 200)
```

## How to use

Add this swift package to your project
```
git@github.com:SwiftUIExtensions/Shapes.git
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
