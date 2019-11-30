import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            RegularPolygonsView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill.on.square.fill")
                        Text("RegularPolygons")
                    }
                }
                .tag(0)
            
            LinesView()
                .tabItem {
                    VStack {
                        Image(systemName: "arrow.swap")
                        Text("Lines")
                    }
                }
                .tag(1)
            
            PatternsView()
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.split.3x3")
                        Text("Patterns")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
