import SwiftUI

public struct RegularPolygon: Shape {
    let sides: UInt
    private let inset: CGFloat

    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: self.sides, in: rect, inset: inset)
    }
    
    public init(sides: UInt) {
        self.init(sides: sides, inset: 0)
    }
    
    init(sides: UInt, inset: CGFloat) {
        self.sides = sides
        self.inset = inset
    }
}

extension RegularPolygon: InsettableShape {
    public func inset(by amount: CGFloat) -> RegularPolygon {
        RegularPolygon(sides: self.sides, inset: self.inset + amount)
    }
}

struct RegularPolygon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegularPolygon(sides: 4)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.blue)
            
            RegularPolygon(sides: 6)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.red)
            
            RegularPolygon(sides: 16)
                .strokeBorder(lineWidth: 10)
                .foregroundColor(.purple)
        }
    }
}
