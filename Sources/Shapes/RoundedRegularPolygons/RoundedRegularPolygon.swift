import SwiftUI

public struct RoundedRegularPolygon: Shape {
    let sides: UInt
	let radius: CGFloat
    private let inset: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        Path.roundedRegularPolygon(sides: self.sides, in: rect, inset: inset, radius: radius)
    }
    
	public init(sides: UInt, radius: CGFloat) {
        self.init(sides: sides, radius: radius, inset: 0)
    }
    
    init(sides: UInt, radius: CGFloat, inset: CGFloat) {
        self.sides = sides
        self.radius = radius
        self.inset = inset
    }
}

extension RoundedRegularPolygon: InsettableShape {
    public func inset(by amount: CGFloat) -> RoundedRegularPolygon {
        RoundedRegularPolygon(sides: self.sides, radius: radius, inset: self.inset + amount)
    }
}

struct RoundedRegularPolygon_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRegularPolygon(sides: 3, radius: 30)
            .fill(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .previewLayout(.fixed(width: 200, height: 200))
        
        RoundedRegularPolygon(sides: 6, radius: 20)
            .strokeBorder(lineWidth: 20)
            .foregroundColor(.yellow)
            .previewLayout(.fixed(width: 200, height: 200))
        
        RoundedRegularPolygon(sides: 16, radius: 10)
            .strokeBorder(lineWidth: 20)
            .foregroundColor(.green)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
