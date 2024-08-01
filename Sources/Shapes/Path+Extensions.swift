import SwiftUI

public extension Path {
    mutating func addCircularCornerRadiusArc(from point: CGPoint, via viaPoint: CGPoint, to nextPoint: CGPoint, radius: CGFloat) {
        // Calculate the cross product to determine clockwise direction
        let v1 = CGVector(dx: viaPoint.x - point.x, dy: viaPoint.y - point.y)
        let v2 = CGVector(dx: nextPoint.x - viaPoint.x, dy: nextPoint.y - viaPoint.y)
        
        let crossProduct = v1.dx * v2.dy - v1.dy * v2.dx
        
        // Determine if the arc should be clockwise based on the cross product
        let isClockwise = crossProduct < 0
        
        let radius = isClockwise ? -radius : radius
        
        let lineAngle = atan2(viaPoint.y - point.y, viaPoint.x - point.x)
        let nextLineAngle = atan2(nextPoint.y - viaPoint.y, nextPoint.x - viaPoint.x)
        
        let lineVector = CGVector(dx: -sin(lineAngle) * radius, dy: cos(lineAngle) * radius)
        let nextLineVector = CGVector(dx: -sin(nextLineAngle) * radius, dy: cos(nextLineAngle) * radius)
        
        let offsetStart1 = CGPoint(x: point.x + lineVector.dx, y: point.y + lineVector.dy)
        let offsetEnd1 = CGPoint(x: viaPoint.x + lineVector.dx, y: viaPoint.y + lineVector.dy)
        
        let offsetStart2 = CGPoint(x: viaPoint.x + nextLineVector.dx, y: viaPoint.y + nextLineVector.dy)
        
        let offsetEnd2 = CGPoint(x: nextPoint.x + nextLineVector.dx, y: nextPoint.y + nextLineVector.dy)
        
        guard let intersection = CGPoint.intersection(start1: offsetStart1, end1: offsetEnd1, start2: offsetStart2, end2: offsetEnd2) else {
            return
        }
        
        let startAngle = lineAngle - (.pi / 2)
        let endAngle = nextLineAngle - (.pi / 2)
        
        self.addArc(
            center: intersection,
            radius: radius,
            startAngle: Angle(radians: startAngle),
            endAngle: Angle(radians: endAngle),
            clockwise: isClockwise
        )
    }
}


