//
//  SpinWheelView.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

struct SpinWheelView: View {
    
    var data: [Double], labels: [String]
    
    private let colors: [Color]
    private let sliceOffset: Double = -.pi / 2
    
    init(data: [Double], labels: [String], colors: [Color]) {
        self.data = data
        self.labels = labels
        self.colors = colors
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ForEach(0..<data.count) { index in
                    SpinWheelCell(startAngle: startAngle(for: index), endAngle: endAngle(for: index))
                        .fill(colors[index])
                    Text(labels[index]).foregroundColor(Color.white)
                        .offset(viewOffset(for: index, in: geo.size)).zIndex(1)
                }
            }
        }
    }
    
    private func startAngle(for index: Int) -> Double {
        switch index {
        case 0: return sliceOffset
        default:
            let ratio: Double = data[..<index].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }
    
    private func endAngle(for index: Int) -> Double {
        switch index {
        case data.count - 1: return sliceOffset + 2 * .pi
        default:
            let ratio: Double = data[..<(index + 1)].reduce(0.0, +) / data.reduce(0.0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }
    
    private func viewOffset(for index: Int, in size: CGSize) -> CGSize {
        let radius = min(size.width, size.height) / 3
        let dataRatio = (2 * data[..<index].reduce(0, +) + data[index]) / (2 * data.reduce(0, +))
        let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)
        return CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }
}
