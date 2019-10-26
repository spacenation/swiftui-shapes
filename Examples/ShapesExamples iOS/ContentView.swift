import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            ShapesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill.on.circle.fill")
                        Text("Shapes")
                    }
                }
                .tag(0)
            
            Text("Builder")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.3.offgrid.fill")
                        Text("Builder")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
