import SwiftUI

public extension Path {
    mutating func addCircularCornerRadiusArc(from point: CGPoint, via viaPoint: CGPoint, to nextPoint: CGPoint, radius: CGFloat, clockwise: Bool) {
        let lineAngle = atan2(viaPoint.y - point.y, viaPoint.x - point.x)
        let nextLineAngle = atan2(nextPoint.y - viaPoint.y, nextPoint.x - viaPoint.x)
        
        let lineVector = CGVector(dx: -sin(lineAngle) * radius, dy: cos(lineAngle) * radius)
        let nextLineVector = CGVector(dx: -sin(nextLineAngle) * radius, dy: cos(nextLineAngle) * radius)
        
        let offsetStart1 = CGPoint(x: point.x + lineVector.dx, y: point.y + lineVector.dy)
        let offsetEnd1 = CGPoint(x: viaPoint.x + lineVector.dx, y: viaPoint.y + lineVector.dy)
        
        let offsetStart2 = CGPoint(x: viaPoint.x + nextLineVector.dx, y: viaPoint.y + nextLineVector.dy)
        
        let offsetEnd2 = CGPoint(x: nextPoint.x + nextLineVector.dx, y: nextPoint.y + nextLineVector.dy)
        
        let intersection = CGPoint.intersection(start1: offsetStart1, end1: offsetEnd1, start2: offsetStart2, end2: offsetEnd2)
        
        let startAngle = lineAngle - (.pi / 2)
        let endAngle = nextLineAngle - (.pi / 2)
        
        self.addArc(
            center: intersection,
            radius: radius,
            startAngle: Angle(radians: startAngle),
            endAngle: Angle(radians:endAngle),
            clockwise: clockwise
        )
    }
}
