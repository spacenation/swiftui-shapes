import SwiftUI

public extension CGPoint {
    init(unitPoint: UnitPoint, in rect: CGRect) {
        self.init(
            x: rect.width * unitPoint.x,
            y: rect.height - (rect.height * unitPoint.y)
        )
    }
}

public extension CGPoint {
    func halfway(to point: CGPoint) -> CGPoint {
        CGPoint(x: (self.x + point.x) * 0.5, y: (self.y + point.y) * 0.5)
    }
    
    func quadCurveControlPoint(with point: CGPoint) -> CGPoint {
        let halfwayPoint = self.halfway(to: point)
        let absoluteDistance = abs(point.y - halfwayPoint.y)
        
        if self.y < point.y {
            return CGPoint(x: halfwayPoint.x, y: halfwayPoint.y + absoluteDistance)
        } else if self.y > point.y {
            return CGPoint(x: halfwayPoint.x, y: halfwayPoint.y - absoluteDistance)
        } else {
            return halfwayPoint
        }
    }
}

public extension CGPoint {
    static func intersection(start1: CGPoint, end1: CGPoint, start2: CGPoint, end2: CGPoint) -> CGPoint {
        let x1 = start1.x
        let y1 = start1.y
        let x2 = end1.x
        let y2 = end1.y
        let x3 = start2.x
        let y3 = start2.y
        let x4 = end2.x
        let y4 = end2.y
        
        let intersectionX: CGFloat = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4-y3*x4)) / ((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4))
        let intersectionY: CGFloat = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4-y3*x4)) / ((x1-x2)*(y3-y4) - (y1-y2)*(x3-x4))
        
        return CGPoint(x: intersectionX, y: intersectionY)
    }
}

public extension Collection where Element == UnitPoint {
    func points(in rect: CGRect) -> [CGPoint] {
        self.map { CGPoint(unitPoint: $0, in: rect) }
    }
}
