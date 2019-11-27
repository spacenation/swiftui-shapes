import SwiftUI

public extension CGPoint {
    init(unitPoint: UnitPoint, in rect: CGRect) {
        self.init(
            x: rect.width * unitPoint.x,
            y: rect.height - (rect.height * unitPoint.y)
        )
    }
}

public extension UnitPoint {
    func halfway(to unitPoint: UnitPoint) -> UnitPoint {
        UnitPoint(x: (self.x + unitPoint.x) * 0.5, y: (self.y + unitPoint.y) * 0.5)
    }
    
    func quadCurveControlUnitPoint(with unitPoint: UnitPoint) -> UnitPoint {
        let halfwayUnitPoint = self.halfway(to: unitPoint)
        let absoluteUnitDistance = abs(unitPoint.y - halfwayUnitPoint.y)
        
        if self.y < unitPoint.y {
            return UnitPoint(x: halfwayUnitPoint.x, y: halfwayUnitPoint.y + absoluteUnitDistance)
        } else if self.y > unitPoint.y {
            return UnitPoint(x: halfwayUnitPoint.x, y: halfwayUnitPoint.y - absoluteUnitDistance)
        } else {
            return halfwayUnitPoint
        }
    }
}
