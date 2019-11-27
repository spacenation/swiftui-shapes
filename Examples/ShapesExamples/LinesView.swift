import SwiftUI
import Shapes

struct LinesView: View {
    var body: some View {
        ScrollView {
            Line(points: [
                UnitPoint(x: 0.1, y: 0.1),
                UnitPoint(x: 0.5, y: 0.9),
                UnitPoint(x: 0.9, y: 0.1)
            ])
            .stroke(Color.red, style: .init(lineWidth: 4, lineCap: .round))
            .frame(height: 200)
            
            QuadCurve(points: [
                UnitPoint(x: 0.1, y: 0.1),
                UnitPoint(x: 0.5, y: 0.9),
                UnitPoint(x: 0.9, y: 0.1)
            ])
            .stroke(Color.blue, style: .init(lineWidth: 2, lineCap: .round))
            .frame(height: 200)
        }

    }
}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView()
    }
}
