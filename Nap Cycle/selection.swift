//
//  selection.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit

class selection: UIViewController {
    
    
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var dial: UIImageView!
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = indicator else {
                return
            }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        print(recognizer.view!.center)
        let translation = recognizer.translation(in: dial)
        if recognizer.state == .began {
                
        }

        if recognizer.state == .changed {
            let position :CGPoint = recognizer.location(in: dial)
            let rad = atan(((position.y - 212)/(position.x - 208)) - atan(0))
            var deg = rad * 360 / .pi
            if(deg > -107 && deg < -77){
                deg = -93.4
                generator.impactOccurred()
                print("vibbbbb")
            }
            if(deg > -21 && deg < 20){
                deg = -3.27
                generator.impactOccurred()
                print("vibbbbb")
            }
            if(deg > 74 && deg < 102){
                deg = 90
                generator.impactOccurred()
                print("vibbbbb")
            }
            
            print(deg)
            recognizerView.transform = CGAffineTransform(rotationAngle: ((deg)  * .pi)/180)
            recognizer.setTranslation(.zero, in: indicator)
            }
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
}

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


