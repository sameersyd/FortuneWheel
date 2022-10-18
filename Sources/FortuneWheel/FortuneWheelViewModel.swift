//
//  FortuneWheelViewModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 19/04/21.
//

import SwiftUI

@available(iOS 13.0, *)
class FortuneWheelViewModel: ObservableObject {
    
    private var titles: [String]
    
    @Published var degree = 0.0
    private let animDuration: Double
    private var animation: Animation
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    private var onSpinEnd: ((Int) -> ())?, getWheelItemIndex: (() -> (Int))?
    
    init(
        titles: [String], animDuration: Double, animation: Animation,
        onSpinEnd: ((Int) -> ())?, getWheelItemIndex: (() -> (Int))?
    ) {
        self.titles = titles
        self.animDuration = animDuration
        self.animation = animation
        self.onSpinEnd = onSpinEnd
        self.getWheelItemIndex = getWheelItemIndex
    }

    private func getWheelStopDegree() -> Double {
        var index: Int? = nil;
        if let method = getWheelItemIndex { index = method() }
        if index == nil || index! >= titles.count { index = Int.random(in: 0..<titles.count) }
        /*
         itemRange - Each items degree range (For 4, each will have 360 / 4 = 90 degrees)
         indexDegree - No. of 90 degrees to reach i item
         freeRange - Flexible degree in the item, so the pointer doesn't always point start of the item
         freeSpins - No. of spins before it goes to selected item index
         finalDegree - Final exact degree to spin and stop in the index
         */
        let itemRange = 360 / titles.count;
        let indexDegree = itemRange * index!;
        let freeRange = Int.random(in: 0...itemRange);
        let freeSpins = (2...20).map({ return $0 * 360 }).randomElement()!
        let finalDegree = freeSpins + indexDegree + freeRange;
        return Double(finalDegree);
    }
    
    func spinWheel() {
        withAnimation(animation) {
            self.degree = (360 * (self.degree / 360)) + getWheelStopDegree();
        }
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            if let count = self?.titles.count,
               let distance = self?.degree.truncatingRemainder(dividingBy: 360) {
                let pointer = floor(distance/(360/Double(count)))
                if let onSpinEnd = self?.onSpinEnd { onSpinEnd(count - Int(pointer) - 1) }
            }
        }
        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration + 1, execute: requestWorkItem)
    }
}
