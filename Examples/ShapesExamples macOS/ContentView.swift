import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            RegularPolygonsView()
                .tabItem {
                    Text("RegularPolygons")
                }
                .tag(0)
            
            LinesView()
                .tabItem {
                    Text("Lines")
                }
                .tag(1)
            
            PatternsView()
                .tabItem {
                    Text("Patterns")
                }
                .tag(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
