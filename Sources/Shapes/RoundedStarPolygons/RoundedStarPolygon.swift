import SwiftUI

public struct RoundedStarPolygon: Shape {
    private let points: UInt
    private let smoothness: CGFloat
    private let convexRadius: CGFloat
    private let concaveRadius: CGFloat
    private let inset: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedStarPolygon(points: points, in: rect, smoothness: smoothness, convexRadius: convexRadius, concaveRadius: concaveRadius, inset: inset)
    }
    
    public init(points: UInt, smoothness: CGFloat, radius: CGFloat) {
        self.init(points: points, smoothness: smoothness, convexRadius: radius, concaveRadius: radius, inset: 0)
    }
    
    public init(points: UInt, smoothness: CGFloat, convexRadius: CGFloat , concaveRadius: CGFloat) {
        self.init(points: points, smoothness: smoothness, convexRadius: convexRadius, concaveRadius: concaveRadius, inset: 0)
    }
    
    init(points: UInt, smoothness: CGFloat, convexRadius: CGFloat, concaveRadius: CGFloat, inset: CGFloat) {
        self.points = points
        self.smoothness = smoothness
        self.convexRadius = convexRadius
        self.concaveRadius = concaveRadius
        self.inset = inset
    }
}

extension RoundedStarPolygon: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedStarPolygon {
        RoundedStarPolygon(points: points, smoothness: smoothness, convexRadius: convexRadius, concaveRadius: concaveRadius, inset: inset + amount)
    }
}

extension Path {
    static func roundedStarPolygon(points: UInt, in rect: CGRect, smoothness: CGFloat, convexRadius: CGFloat, concaveRadius: CGFloat, inset: CGFloat) -> Path {
        let sides = points * 2
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: width / 2.0, y: height / 2.0)

        var usableConvexRadius: CGFloat = .zero
        var usableConcaveRadius: CGFloat = .zero
        
        func getPoint(from centerPoint: CGPoint, angle: Double, hypotenuse: Double) -> CGPoint {
            CGPoint(
                x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
            )
        }
        
        func getViaPoint(from centerPoint: CGPoint, angle: Double, hypotenuse: Double, smoothness: CGFloat) -> CGPoint {
            CGPoint(
                x: centerPoint.x + CGFloat(cos(angle) * hypotenuse * smoothness),
                y: centerPoint.y + CGFloat(sin(angle) * hypotenuse * smoothness)
            )
        }
        
        func getLastPoint(from centerPoint: CGPoint, angle: Double, hypotenuse: Double, smoothness: CGFloat) -> CGPoint {
            CGPoint(
                x: centerPoint.x + CGFloat(cos(angle) * hypotenuse * smoothness),
                y: centerPoint.y + CGFloat(sin(angle) * hypotenuse * smoothness)
            )
        }
        
        return Path { path in
            for index in 0 ..< points {
                let angle: Double = ((Double(index * 2) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let point: CGPoint = getPoint(from: centerPoint, angle: angle, hypotenuse: hypotenuse)
                
                let viaAngle: Double = ((Double(index * 2 + 1) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let viaPoint: CGPoint = getViaPoint(from: centerPoint, angle: viaAngle, hypotenuse: hypotenuse, smoothness: smoothness)

                let px: CGFloat = point.x - viaPoint.x
                let py: CGFloat = point.y - viaPoint.y
                
                let sideLength: CGFloat = sqrt(px * px + py * py)
                
                let inradius: CGFloat = sideLength / (2 * tan(.pi / CGFloat(points * 2)))
                
                if usableConvexRadius == 0 {
                    usableConvexRadius = min(convexRadius, inradius)
                }
            
                if usableConcaveRadius == 0 {
                    usableConcaveRadius = min(concaveRadius, inradius - convexRadius)
                }
                
                let nextAngle: Double = ((Double(index * 2 + 2) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let nextPoint = CGPoint(
                    x: centerPoint.x + CGFloat(cos(nextAngle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(nextAngle) * hypotenuse)
                )
                
                let lastAngle: Double = ((Double(index * 2 + 3) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let lastPoint: CGPoint = getLastPoint(from: centerPoint, angle: lastAngle, hypotenuse: hypotenuse, smoothness: smoothness)
                
                path.addCircularCornerRadiusArc(from: point, via: viaPoint, to: nextPoint, radius: smoothness > 0.5 ? usableConcaveRadius: -usableConcaveRadius, clockwise: smoothness > 0.5 ? false : true)
                
                path.addCircularCornerRadiusArc(from: viaPoint, via: nextPoint, to: lastPoint, radius: usableConvexRadius, clockwise: false)
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}

struct RoundedStarPolygon_Previews: PreviewProvider {
    static var previews: some View {
        
        RoundedStarPolygon(points: 5, smoothness: 0.5, convexRadius: 10, concaveRadius: 10)
            .fill(Color.orange)
            .background(Circle())
            .previewLayout(.fixed(width: 400, height: 400))
        
        RoundedStarPolygon(points: 3, smoothness: 0.87, radius: 40)
            .fill(Color.orange)
            .background(Circle())
            .previewLayout(.fixed(width: 400, height: 400))
        
        RoundedStarPolygon(points: 5, smoothness: 0.5, radius: 20)
            .strokeBorder(lineWidth: 1)
            .foregroundColor(.yellow)
            .background(Circle())
            .previewLayout(.fixed(width: 200, height: 200))
        
        RoundedStarPolygon(points: 5, smoothness: 0.36, radius: 0)
            //.strokeBorder(lineWidth: 20)
            .foregroundColor(.green)
            .background(Circle())
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
