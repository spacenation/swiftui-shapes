import SwiftUI

public struct GridPattern: InsettableShape {
    private let inset: CGFloat
    private let horizontalLines: Int
    private let verticalLines: Int
    
    
    public func inset(by amount: CGFloat) -> GridPattern {
        GridPattern(inset: self.inset + amount, horizontalLines: self.horizontalLines, verticalLines: self.verticalLines)
    }
    
    public func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: self.inset, dy: self.inset)
        
        return Path { path in
            /// Horizontal Lines
            if horizontalLines > 1 {
                let unitDistanceBetweenHorizontalLines = 1.0 / CGFloat(horizontalLines - 1)
                
                (0..<horizontalLines).forEach { index in
                    let unitY = unitDistanceBetweenHorizontalLines * CGFloat(index)
                    let fromPoint = CGPoint(unitPoint: UnitPoint(x: 0, y: unitY), in: rect)
                    let toPoint = CGPoint(unitPoint: UnitPoint(x: 1, y: unitY), in: rect)
                    path.addLine(from: fromPoint, to: toPoint)
                }
            }
            
            if verticalLines > 1 {
                let unitDistanceBetweenVerticalLines = 1.0 / CGFloat(verticalLines - 1)
                
                (0..<verticalLines).forEach { index in
                    let unitX = unitDistanceBetweenVerticalLines * CGFloat(index)
                    let fromPoint = CGPoint(unitPoint: UnitPoint(x: unitX, y: 0), in: rect)
                    let toPoint = CGPoint(unitPoint: UnitPoint(x: unitX, y: 1), in: rect)
                    path.addLine(from: fromPoint, to: toPoint)
                }
            }
        }
        .offsetBy(dx: inset, dy: inset)
    }
    
    private init(inset: CGFloat, horizontalLines: Int, verticalLines: Int) {
        self.inset = inset
        self.horizontalLines = horizontalLines
        self.verticalLines = verticalLines
    }
    
    public init(horizontalLines: Int = 0, verticalLines: Int = 0) {
        self.inset = 0
        self.horizontalLines = horizontalLines
        self.verticalLines = verticalLines
    }
}

struct GridPattern_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GridPattern(horizontalLines: 20, verticalLines: 40)
                .stroke(Color.white.opacity(0.3), style: .init(lineWidth: 1, lineCap: .round))
                .frame(height: 200)
                .background(Color.blue)
                .padding()
            
            
            LinearGradient(gradient: Gradient(colors: [.orange, .red, .blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 200)
                .clipShape(
                    GridPattern(horizontalLines: 25, verticalLines: 25).inset(by: 1).stroke(lineWidth: 1)
                )
                .padding()
            
            LinearGradient(gradient: Gradient(colors: [.purple, .red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(height: 200)
                .clipShape(
                    GridPattern(horizontalLines: 10)
                        .inset(by: 2)
                        .stroke(style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [10], dashPhase: 0))
                )
                .padding()
        }
    }
}
