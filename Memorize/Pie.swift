//
//  Pie.swift
//  Memorize
//
//  Created by Eric Hou on 10/10/20.
//

import SwiftUI

struct Pie: Shape {
    // Start and end angles for the pie shape
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        // Designate a center for the path to move to
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        // Create an empty path and return it
        var p = Path()
        // Start at the center of the CGRect
        p.move(to: center)
        // Calculate a start position for the startAngle
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise)
        p.addLine(to: center)
        return p
    }
}
