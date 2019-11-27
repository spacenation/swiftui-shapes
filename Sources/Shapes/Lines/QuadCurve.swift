import SwiftUI

public struct QuadCurve: Shape {
    let points: [UnitPoint]

    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard self.points.count > 0 else { return }
            var lastUnitPoint = self.points[0]
            path.move(to: CGPoint(unitPoint: lastUnitPoint, in: rect))
            
            (1..<self.points.count).forEach { index in
                let nextUnitPoint = self.points[index]
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
    
    public init(points: [UnitPoint]) {
        self.points = points
    }
}

struct Curve_Previews: PreviewProvider {
    static var previews: some View {
        QuadCurve(points: [
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
