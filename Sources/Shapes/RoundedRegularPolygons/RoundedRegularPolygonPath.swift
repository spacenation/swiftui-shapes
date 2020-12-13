import SwiftUI

extension Path {
	static func roundedRegularPolygon(sides: UInt, in rect: CGRect, inset: CGFloat = 0, radius: CGFloat = 0) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: width / 2.0, y: height / 2.0)
		var testDistance: CGFloat = .zero
		var usableRadius: CGFloat = .zero


        return Path { path in
            (0...sides).forEach { index in
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180

				//control point
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
                )

				//the angle from the target control point to the next control point
				let nextAngle = ((Double(index + 1) * (360.0 / Double(sides))) - 90) * Double.pi / 180

				//coordinates of the next control point
				let nextPoint = CGPoint(
					x: centerPoint.x + CGFloat(cos(nextAngle) * hypotenuse),
					y: centerPoint.y + CGFloat(sin(nextAngle) * hypotenuse)
				)

				if testDistance == .zero {
					//The distance between two neighboring endpoints on your polygon
					testDistance = sqrt(pow(( nextPoint.x - point.x ), 2) + pow(( nextPoint.y - point.y ), 2))

					//Ensures that our 'radius' won't exceed a length of half our polygonside
					usableRadius = radius > testDistance / 2 ? testDistance / 2  : radius
				}

				//source point
				let currentPoint = index == 0 ? point : path.currentPoint!

				//distance from source point to target control point
				let distance = sqrt(pow(( point.x - currentPoint.x ), 2) + pow(( point.y - currentPoint.y ), 2))

				//distance from target control point to the start of the curve we want to draw
				let distanceToCurveStart = index == 0 ? usableRadius : distance - usableRadius

				//angle from current point to the target control point
				let angleToCurveStart = index == 0 ? 0 : atan2((point.y - currentPoint.y), (point.x - currentPoint.x))

				//coordinates of where to start the curve
				let curveStartPoint = CGPoint(
					x: currentPoint.x + (distanceToCurveStart * CGFloat(cos(angleToCurveStart))),
					y: currentPoint.y + (distanceToCurveStart * CGFloat(sin(angleToCurveStart)))
				)

				//angle from current control point to next control point
				let angleToCurveEnd = atan2((nextPoint.y - point.y), (nextPoint.x - point.x))

				//coordinates of where the curve shuold end
				let curveEndPoint = CGPoint(
					x: point.x + (usableRadius * CGFloat(cos(angleToCurveEnd))),
					y: point.y + (usableRadius * CGFloat(sin(angleToCurveEnd)))
				)

                if index == 0 {
					let altStartPoint = CGPoint(
						x: point.x + (usableRadius * CGFloat(cos(angleToCurveEnd))),
						y: point.y + (usableRadius * CGFloat(sin(angleToCurveEnd)))
					)
					path.move(to: radius == 0 ? point : altStartPoint)
                } else {
					path.addLine(to: radius > 0 ? curveStartPoint : point)
					if radius > 0 {
						path.addQuadCurve(to: curveEndPoint, control: point)
					}
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}
