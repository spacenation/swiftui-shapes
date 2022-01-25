import SwiftUI

public struct StarPolygon: Shape {
    let points: UInt
    let smoothness: CGFloat
    private let inset: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        Path.starPolygon(points: self.points, in: rect, inset: inset, smoothness: smoothness)
    }
    
    public init(points: UInt, smoothness: CGFloat = 0.36) {
        self.init(points: points, smoothness: smoothness, inset: 0)
    }
    
    init(points: UInt, smoothness: CGFloat, inset: CGFloat) {
        self.points = points
        self.smoothness = smoothness
        self.inset = inset
    }
}

extension StarPolygon: InsettableShape {
    public func inset(by amount: CGFloat) -> StarPolygon {
        StarPolygon(points: self.points, smoothness: self.smoothness, inset: self.inset + amount)
    }
}

struct StarPolygon_Previews: PreviewProvider {
    static var previews: some View {
        
        StarPolygon(points: 5)
            .foregroundColor(.blue)
            .background(Circle())
            .previewLayout(.fixed(width: 200, height: 200))
        
        StarPolygon(points: 3)
            .foregroundColor(.red)
            .background(Circle())
            .previewLayout(.fixed(width: 200, height: 200))
        
        StarPolygon(points: 32)
            .foregroundColor(.purple)
            .background(Circle())
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
