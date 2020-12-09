import SwiftUI

public struct RegularPolygon: InsettableShape {
    let sides: Int
    let inset: CGFloat
	let radius: CGFloat
    
    public func inset(by amount: CGFloat) -> RegularPolygon {
        RegularPolygon(sides: self.sides, inset: self.inset + amount, radius: radius)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: self.sides, in: rect, inset: inset, radius: radius)
    }
    
	public init(sides: Int, radius: CGFloat = 0) {
        self.sides = sides
        self.inset = 0
		self.radius = radius
    }

	public init(sides: Double, radius: CGFloat = 0) {
        self.sides = Int(sides.rounded(.down))
        self.inset = 0
		self.radius = radius
    }
}

extension RegularPolygon {
	init(sides: Int, inset: CGFloat, radius: CGFloat = 0) {
        self.sides = sides
        self.inset = inset
		self.radius = radius
    }
}

struct RegularPolygon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegularPolygon(sides: 4, radius: 5)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.blue)
            
            Pentagon(radius: 5)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.yellow)
            
            Hexagon()
                .foregroundColor(.orange)
            
            Heptagon(radius: 5)
                .foregroundColor(.blue)
            
            Octagon()
                .foregroundColor(.pink)
            
            Nonagon()
                .foregroundColor(.red)
            
            Decagon()
                .foregroundColor(.green)
        }
    }
}
