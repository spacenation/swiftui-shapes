import SwiftUI

public struct Decagon: InsettableShape {
    let inset: CGFloat
	let radius: CGFloat
    
    public func inset(by amount: CGFloat) -> Decagon {
        Decagon(inset: self.inset + amount, radius: radius)
    }
    
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: 10, in: rect, inset: inset, radius: radius)
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

extension Decagon {
    init(inset: CGFloat, radius: CGFloat) {
        self.inset = inset
		self.radius = radius
    }
}

struct Decagon_Previews: PreviewProvider {
    static var previews: some View {
        Decagon()
    }
}
