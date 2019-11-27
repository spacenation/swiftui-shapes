import SwiftUI

public struct QuadCurve: Shape {
    let unitPoints: [UnitPoint]

    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard self.unitPoints.count > 0 else { return }
            var lastUnitPoint = self.unitPoints[0]
            path.move(to: CGPoint(unitPoint: lastUnitPoint, in: rect))
            
            (1..<self.unitPoints.count).forEach { index in
                let nextUnitPoint = self.unitPoints[index]
                let nextPoint = CGPoint(unitPoint: nextUnitPoint, in: rect)
                
                let halfwayUnitPoint = lastUnitPoint.halfway(to: nextUnitPoint)
                let halfwayPoint = CGPoint(unitPoint: halfwayUnitPoint, in: rect)
                
                let firstControlUnitPoint = halfwayUnitPoint.quadCurveControlUnitPoint(with: lastUnitPoint)
                let firstControlPoint = CGPoint(unitPoint: firstControlUnitPoint, in: rect)
                path.addQuadCurve(to: halfwayPoint, control: firstControlPoint)
                
                let secondControlUnitPoint = halfwayUnitPoint.quadCurveControlUnitPoint(with: nextUnitPoint)
                let secondControlPoint = CGPoint(unitPoint: secondControlUnitPoint, in: rect)
                path.addQuadCurve(to: nextPoint, control: secondControlPoint)
                
                lastUnitPoint = nextUnitPoint
            }
        }
    }
    
    public init(unitPoints: [UnitPoint]) {
        self.unitPoints = unitPoints
    }
}

public extension QuadCurve {
    init<Data: RandomAccessCollection>(unitData: Data) where Data.Element : BinaryFloatingPoint {
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        self.unitPoints = unitData.enumerated().map { (index, dataPoint) in UnitPoint(x: step * CGFloat(index), y: CGFloat(dataPoint)) }
    }
}

struct Curve_Previews: PreviewProvider {
    static var previews: some View {
        QuadCurve(unitPoints: [
            UnitPoint(x: 0.1, y: 0.1),
            UnitPoint(x: 0.5, y: 0.9),
            UnitPoint(x: 0.9, y: 0.1)
        ])
            .stroke(Color.red, style: .init(lineWidth: 4, lineCap: .round))
            .background(Color.black)
            .drawingGroup()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
