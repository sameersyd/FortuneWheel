//
//  ViewController.swift
//  FortuneWheel
//
//  Created by sameersyd on 04/07/2021.
//  Copyright (c) 2021 sameersyd. All rights reserved.
//

import UIKit
import SwiftUI
import FortuneWheel

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            let hostingController = UIHostingController(rootView: FortuneWheel(titles: ["Player 1", "Player 2"], size: 320, onSpinEnd: { i in
                print("value =", i)
            }))
            view.addSubview(hostingController.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

