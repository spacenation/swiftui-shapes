import SwiftUI

public struct Line: Shape {
    var points: [UnitPoint]

    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard self.points.count > 0 else { return }
            path.move(to: .init(unitPoint: self.points[0], in: rect))
            
            (1..<self.points.count).forEach { index in
                path.addLine(to: .init(unitPoint: self.points[index], in: rect))
            }
        }
    }
    
    public init(points: [UnitPoint]) {
        self.points = points
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(points: [
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
