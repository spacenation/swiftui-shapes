import SwiftUI

struct Triangle: Shape {
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let sides = 3
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

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle(radius: 30)
            .stroke(lineWidth: 3)
            .foregroundColor(.blue)
            .background(Circle())
            .animation(.linear)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
