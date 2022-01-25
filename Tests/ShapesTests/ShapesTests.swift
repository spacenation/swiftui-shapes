import XCTest
import Shapes

final class ShapesTests: XCTestCase {
    
    func testSlope() {
        let start = CGPoint(x: 0.0, y: 0.0)
        let end = CGPoint(x: 0, y: 100.0)
        let angle = atan2(end.y - start.y, end.x - start.x)
        
        XCTAssertEqual(angle, .pi / 2)
    }
    
    func testIntersection() {
        let start1 = CGPoint(x: 10.0, y: 0.0)
        let end1 = CGPoint(x: 10, y: 100.0)
        let start2 = CGPoint(x: 0.0, y: 20.0)
        let end2 = CGPoint(x: 100, y: 20)
        
        XCTAssertEqual(
            CGPoint.intersection(start1: start1, end1: end1, start2: start2, end2: end2),
            CGPoint(x: 10, y: 20)
        )
    }
    
}
