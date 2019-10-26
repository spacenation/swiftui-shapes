import SwiftUI
import Shapes

struct ShapesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HalfCapsule()
                    .foregroundColor(.purple)
                    .frame(width: 50, height: 50)
            }
            
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesView()
    }
}
