//
//  File.swift
//  
//
//  Created by Sameer Nawaz on 24/10/22.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS 13.0, *)
public struct FortuneWheelModel {

    let titles: [String]
    let size: CGFloat
    let onSpinEnd: ((Int) -> ())?
    let colors: [Color]
    let pointerColor: Color
    let strokeWidth: CGFloat
    let strokeColor: Color
    let animDuration: Double
    let animation: Animation
    let getWheelItemIndex: (() -> (Int))?

    public init(
        titles: [String], size: CGFloat, onSpinEnd: ((Int) -> ())?,
        colors: [Color]? = nil,
        pointerColor: Color? = nil,
        strokeWidth: CGFloat = 15,
        strokeColor: Color? = nil,
        animDuration: Double = Double(6),
        animation: Animation? = nil,
        getWheelItemIndex: (() -> (Int))? = nil
    ) {
        self.titles = titles
        self.size = size
        self.onSpinEnd = onSpinEnd
        self.colors = colors ?? Color.spin_wheel_color
        self.pointerColor = pointerColor ?? Color(hex: "DA4533")
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor ?? Color(hex: "252D4F")
        self.animDuration = animDuration
        self.animation = animation ?? Animation.timingCurve(0.51, 0.97, 0.56, 1, duration: animDuration)
        self.getWheelItemIndex = getWheelItemIndex
    }
}
