import SwiftUI

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
                    // Step 1: Calculate the differences in coordinates
                    let deltaX = point.x - viaPoint.x
                    let deltaY = point.y - viaPoint.y
                    
                    // Step 2: Calculate the side length
                    let sideLength = sqrt(deltaX * deltaX + deltaY * deltaY)
                    
                    // Step 3: Calculate the inradius
                    let angle = .pi / CGFloat(sides)
                    let inradius = sideLength / (2 * tan(angle))
                    
                    // Step 4: Determine the usable radius
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
