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
    static func intersection(start1: CGPoint, end1: CGPoint, start2: CGPoint, end2: CGPoint) -> CGPoint? {
        let denominator = (end1.x - start1.x) * (end2.y - start2.y) - (end1.y - start1.y) * (end2.x - start2.x)
        if denominator == 0 {
            // Lines are parallel or coincident
            return nil
        }

        let ua = ((end2.x - start2.x) * (start1.y - start2.y) - (end2.y - start2.y) * (start1.x - start2.x)) / denominator

        let x = start1.x + ua * (end1.x - start1.x)
        let y = start1.y + ua * (end1.y - start1.y)

        return CGPoint(x: x, y: y)
    }
}

public extension Collection where Element == UnitPoint {
    func points(in rect: CGRect) -> [CGPoint] {
        self.map { CGPoint(unitPoint: $0, in: rect) }
    }
}
