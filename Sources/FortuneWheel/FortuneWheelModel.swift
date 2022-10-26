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

    init(
        titles: [String], size: CGFloat, onSpinEnd: ((Int) -> ())?,
        colors: [Color] = Color.spin_wheel_color,
        pointerColor: Color = Color(hex: "DA4533"),
        strokeWidth: CGFloat = 15,
        strokeColor: Color = Color(hex: "252D4F"),
        animDuration: Double = Double(6),
        animation: Animation? = nil,
        getWheelItemIndex: (() -> (Int))? = nil
    ) {
        self.titles = titles;
        self.size = size;
        self.onSpinEnd = onSpinEnd;
        self.colors = colors;
        self.pointerColor = pointerColor;
        self.strokeWidth = strokeWidth;
        self.strokeColor = strokeColor;
        self.animDuration = animDuration;
        self.animation = animation ?? Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration);
        self.getWheelItemIndex = getWheelItemIndex;
    }
}
