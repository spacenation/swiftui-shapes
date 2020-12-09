import SwiftUI

public struct Heptagon: InsettableShape {
    let inset: CGFloat
	let radius: CGFloat
    
    public func inset(by amount: CGFloat) -> Heptagon {
        Heptagon(inset: self.inset + amount, radius: radius)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 7, in: rect, inset: inset, radius: radius)
    }
    
	public init() {
		inset = 0
		radius = 0
	}

	public init(radius: CGFloat) {
		self.inset = 0
		self.radius = radius
	}
}

extension Heptagon {
	init(inset: CGFloat, radius: CGFloat) {
		self.inset = inset
		self.radius = radius
	}
}

struct Heptagon_Previews: PreviewProvider {
    static var previews: some View {
        Heptagon()
    }
}
