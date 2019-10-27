import SwiftUI
import Shapes

struct BuilderView: View {
    @State var polygonSides: Double = 3.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    RegularPolygon(sides: polygonSides)
                        .stroke(lineWidth: 8)
                        .animation(.easeInOut(duration: 1.0))
                        .foregroundColor(.green)
                        .frame(height: 300)
                        .background(Circle().foregroundColor(.white))
                }
                
            }
            
            Slider(value: $polygonSides, in: 3...32)
        }

    }
}

struct BuilderView_Previews: PreviewProvider {
    static var previews: some View {
        BuilderView()
    }
}
