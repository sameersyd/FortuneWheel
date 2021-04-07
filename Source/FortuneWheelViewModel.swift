//
//  FortuneWheelViewModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

class FortuneWheelViewModel: ObservableObject {
    
    var titles: [String]
    
    @Published var degree = 0.0
    private let animDuration: Double
    private var timeCurveAnimation: Animation
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    init(titles: [String], animDuration: Double, timeCurveAnimation: Animation) {
        self.titles = titles
        self.animDuration = animDuration
        self.timeCurveAnimation = timeCurveAnimation
    }
    
    func spinWheel() {
        let d = Double.random(in: 720...7200)
        withAnimation(timeCurveAnimation) { self.degree += d }
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            if let count = self?.titles.count,
               let distance = self?.degree.truncatingRemainder(dividingBy: 360) {
                let pointer = floor(distance/(360/Double(count)))
                print(count - Int(pointer) - 1)
            }
        }
        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration + 1, execute: requestWorkItem)
    }
}
