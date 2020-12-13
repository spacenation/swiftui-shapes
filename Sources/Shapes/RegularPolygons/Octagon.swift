import SwiftUI

public struct Octagon: InsettableShape {
    let inset: CGFloat
	let radius: CGFloat
    
    public func inset(by amount: CGFloat) -> Octagon {
        Octagon(inset: self.inset + amount, radius: radius)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 8, in: rect, inset: inset, radius: radius)
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

extension Octagon {
	init(inset: CGFloat, radius: CGFloat) {
        self.inset = inset
		self.radius = radius
    }
}

struct Octagon_Previews: PreviewProvider {
    static var previews: some View {
        Octagon()
    }
}
