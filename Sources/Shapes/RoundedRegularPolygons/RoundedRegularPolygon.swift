import SwiftUI

public struct RoundedRegularPolygon: Shape {
    let sides: UInt
	let radius: CGFloat
    private let inset: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedRegularPolygon(sides: self.sides, in: rect, inset: inset, radius: radius)
    }
    
	public init(sides: UInt, radius: CGFloat) {
        self.init(sides: sides, radius: radius, inset: 0)
    }
    
    init(sides: UInt, radius: CGFloat, inset: CGFloat) {
        self.sides = sides
        self.radius = radius
        self.inset = inset
    }
}

extension RoundedRegularPolygon: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedRegularPolygon {
        RoundedRegularPolygon(sides: self.sides, radius: radius, inset: self.inset + amount)
    }
}

extension Path {
    static func roundedRegularPolygon(sides: UInt, in rect: CGRect, inset: CGFloat = 0, radius: CGFloat = 0) -> Path {
        let rect = rect.insetBy(dx: inset, dy: inset)
        let width = rect.width
        let height = rect.height
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        var usableRadius: CGFloat = .zero
        
        return Path { path in
            guard sides > 2 else { return }
            (0..<sides).forEach { index in
                
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
                )
                
                let viaAngle = ((Double(index + 1) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let viaPoint = CGPoint(
                    x: centerPoint.x + CGFloat(cos(viaAngle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(viaAngle) * hypotenuse)
                )
                
                if usableRadius == 0 {
                    let sideLength = sqrt((point.x - viaPoint.x) * (point.x - viaPoint.x) + (point.y - viaPoint.y) * (point.y - viaPoint.y))
                    let inradius = sideLength / (2 * tan(.pi / CGFloat(sides)))
                    
                    usableRadius = min(radius, inradius)
                }
                
                let nextAngle = ((Double(index + 2) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                
                let nextPoint = CGPoint(
                    x: centerPoint.x + CGFloat(cos(nextAngle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(nextAngle) * hypotenuse)
                )
                
                path.addCircularCornerRadiusArc(from: point, via: viaPoint, to: nextPoint, radius: usableRadius, clockwise: false)
            }
            path.closeSubpath()
        }
    }
}


struct RoundedRegularPolygon_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRegularPolygon(sides: 3, radius: 30)
            .fill(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .previewLayout(.fixed(width: 200, height: 200))
        
        RoundedRegularPolygon(sides: 6, radius: 20)
            .strokeBorder(lineWidth: 20)
            .foregroundColor(.yellow)
            .previewLayout(.fixed(width: 200, height: 200))
        
        RoundedRegularPolygon(sides: 16, radius: 10)
            .strokeBorder(lineWidth: 20)
            .foregroundColor(.green)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
