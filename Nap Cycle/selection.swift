//
//  selection.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit

class selection: UIViewController {
    
    var duration = 60
    var wakeup = Date()
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var dial: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let recognizerView = indicator else {
                return
            }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        let translation = recognizer.translation(in: dial)
        if recognizer.state == .began {
                
        }

        if recognizer.state == .changed {
            let position :CGPoint = recognizer.location(in: dial)
            let rad = atan(((position.y - 212)/(position.x - 208)) - atan(0))
            var deg = rad * 360 / .pi
            if(deg > -107 && deg < -77){
                deg = -93.4
                duration = 20
                generator.impactOccurred()
            }
            else if(deg > -21 && deg < 20){
                deg = -3.27
                duration = 60
                generator.impactOccurred()
            }
            else if(deg > 74 && deg < 102){
                deg = 90
                duration = 90
                generator.impactOccurred()
            }else{
                duration = 0
            }
            recognizerView.transform = CGAffineTransform(rotationAngle: ((deg)  * .pi)/180)
            recognizer.setTranslation(.zero, in: indicator)
            }
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: [.repeat, .autoreverse], animations: ({
            
            self.arrow.center.y = self.arrow.center.y + 10
            
        }), completion: nil)

        // Do any additional setup after loading the view.
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( duration == 0){
            print(duration)
            let alert = UIAlertController(title: "No Duration Selected", message: "please place the needle on a number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if let destVC = segue.destination as? safeguard{
            destVC.duration = duration
        }
        
         
     }
     
    @IBAction func backtoselc(_ sender: UIStoryboardSegue) {}
        
}

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


