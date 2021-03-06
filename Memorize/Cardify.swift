//
//  Cardify.swift
//  Memorize
//
//  Created by Eric Hou on 10/11/20.
//

import SwiftUI

// AnimatableModifier is the same as saying ViewModifier, Animatable
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    // Essentially renamed rotation to animatable data to something the animation system can recognize
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    // Content is whatever view the view modifier is being called on
    func body(content: Content) -> some View {
        ZStack {
            Group {
                // Rounded Rectangle behavies like a view and a shape
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                // Stroke returns a view to use in the ZStack
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)  // Hides the view if the card is facedown
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)

        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1 , 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
