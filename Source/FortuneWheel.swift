//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

@available(iOS 14.0, *)
public struct FortuneWheel: View {
    
    var titles: [String], colors: [Color], strokeWidth: CGFloat, strokeColor: Color
    @StateObject var viewModel: FortuneWheelViewModel
    
    init(titles: [String], colors: [Color] = Color.spin_wheel_color, strokeWidth: CGFloat = 15, strokeColor: Color = Color(hex: "252D4F"),
         animDuration: Double = Double(6), timeCurveAnimation: Animation? = nil) {
        self.titles = titles
        self.colors = colors
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor
        _viewModel = StateObject(wrappedValue: FortuneWheelViewModel(titles: titles, animDuration: animDuration,
                                                                     timeCurveAnimation: timeCurveAnimation ?? Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration)))
    }
    
    public var body: some View {
        ZStack {
            SpinWheelView(data: (0..<titles.count).map { _ in Double(100/titles.count) },
                          labels: titles, colors: colors)
                .frame(width: 320, height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 160).stroke(lineWidth: strokeWidth)
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
        }
    }
}

@available(iOS 13.0, *)
fileprivate extension Color {
    
    static let spin_wheel_color: [Color] = [Color(hex: "FBE488"), Color(hex: "75AB53"), Color(hex: "D1DC59"),
                                            Color(hex: "EC9D42"), Color(hex: "DE6037"), Color(hex: "DA4533"),
                                            Color(hex: "992C4D"), Color(hex: "433589"), Color(hex: "4660A8"),
                                            Color(hex: "4291C8")]
    
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

//struct FortuneWheel_Previews: PreviewProvider {
//    static var previews: some View {
//        FortuneWheel()
//    }
//}
