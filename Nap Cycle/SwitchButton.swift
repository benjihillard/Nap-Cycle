//
//  SwitchButton.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 11/13/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit
import CoreMotion

class SwitchButton: UIButton {

    var status: Bool = false {
            didSet {
                self.update()
            }
        }
        var onImage = UIImage(named: "amtoggle")
        var offImage = UIImage(named: "pmtoggle")
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setStatus(false)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update() {
            UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
                self.status ? self.setImage(self.onImage, for: .normal) : self.setImage(self.offImage, for: .normal)
            }, completion: nil)
        }
        func toggle() {
            self.status ? self.setStatus(false) : self.setStatus(true)
        }
        
        func setStatus(_ status: Bool) {
            self.status = status
        }
        
        func touchUpInside(sender: UIButton!) {
            print("llllll")
            self.sendHapticFeedback()
            self.toggle()
            
        }
        
        func sendHapticFeedback() {
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        }

}
