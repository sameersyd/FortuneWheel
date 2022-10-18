//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

@available(macOS 11.0, *)
@available(iOS 14.0, *)
public struct FortuneWheel: View {

    private var titles: [String], size: CGFloat, onSpinEnd: ((Int) -> ())?, strokeWidth: CGFloat, strokeColor: Color = Color(hex: "252D4F")
    private var colors: [Color] = Color.spin_wheel_color, pointerColor: Color = Color(hex: "DA4533")
    @StateObject var viewModel: FortuneWheelViewModel
    
    public init(
        titles: [String], size: CGFloat, onSpinEnd: ((Int) -> ())?,
        colors: [Color]? = nil, pointerColor: Color? = nil,
        strokeWidth: CGFloat = 15, strokeColor: Color? = nil,
        animDuration: Double = Double(6), animation: Animation? = nil,
        getWheelItemIndex: (() -> (Int))? = nil
    ) {
        self.titles = titles
        self.size = size
        self.strokeWidth = strokeWidth
        
        if let colors = colors { self.colors = colors }
        if let pointerColor = pointerColor { self.pointerColor = pointerColor }
        if let strokeColor = strokeColor { self.strokeColor = strokeColor }
        
        let timeCurveAnimation = Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration)
        _viewModel = StateObject(wrappedValue: FortuneWheelViewModel(
            titles: titles,
            animDuration: animDuration,
            animation: animation ?? timeCurveAnimation,
            onSpinEnd: onSpinEnd,
            getWheelItemIndex: getWheelItemIndex
        ))
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                SpinWheelView(data: (0..<titles.count).map { _ in Double(100/titles.count) },
                              labels: titles, colors: colors)
                    .frame(width: size, height: size)
                    .overlay(
                        RoundedRectangle(cornerRadius: size/2).stroke(lineWidth: strokeWidth)
                            .foregroundColor(strokeColor)
                    )
                    .rotationEffect(.degrees(viewModel.degree))
                    .gesture(
                        DragGesture().onChanged({ (value) in
                            if value.translation.width < 0 {
                                viewModel.degree = Double(-value.translation.width)
                            }
                        }).onEnded({ (value) in
                            viewModel.spinWheel()
                        })
                    )
                SpinWheelBolt()
            }
            SpinWheelPointer(pointerColor: pointerColor).offset(x: 0, y: -25)
        }
    }
}

@available(macOS 10.15, *)
@available(iOS 13.0, *)
extension Color {
    static let spin_wheel_color: [Color] = [
        Color(hex: "FBE488"), Color(hex: "75AB53"),
        Color(hex: "D1DC59"), Color(hex: "EC9D42"),
        Color(hex: "DE6037"), Color(hex: "DA4533"),
        Color(hex: "992C4D"), Color(hex: "433589"),
        Color(hex: "4660A8"), Color(hex: "4291C8")
    ]
    
    init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        let scanner = Scanner(string: cString)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(.sRGB, red: Double(r) / 0xff, green: Double(g) / 0xff, blue:  Double(b) / 0xff, opacity: alpha)
    }
}
