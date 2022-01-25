import SwiftUI

extension Path {
    static func starPolygon(points: UInt, in rect: CGRect, inset: CGFloat = 0, smoothness: CGFloat) -> Path {
        let sides = points * 2
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: width / 2.0, y: height / 2.0)
        
        return Path { path in
            (0...sides).forEach { index in
                let isOdd = index.isMultiple(of: 2)
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * (hypotenuse * (isOdd ? 1.0 : smoothness))),
                    y: centerPoint.y + CGFloat(sin(angle) * (hypotenuse * (isOdd ? 1.0 : smoothness)))
                )
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}
