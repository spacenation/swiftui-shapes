import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ShapesView()
                .tabItem {
                    Text("Shapes")
                }
                .tag(0)
            
            Text("Builder")
                .font(.title)
                .tabItem {
                    Text("Builder")
                }
                .tag(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
