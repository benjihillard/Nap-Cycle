//
//  wakeup.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit
import AVFoundation

class wakeup: UIViewController {
    
    var counter = 0
    var snooze = false
    var alarm = Timer()
    let systemSoundID: SystemSoundID = 1005
    let viberate: SystemSoundID = 4095
    
    @IBOutlet weak var alarmThree: UIImageView!
    
    @IBOutlet weak var alarmTwo: UIImageView!
    
    
    @IBOutlet weak var alarmOne: UIImageView!
    
    @IBOutlet weak var welcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let toady = formatter.string(from: Date())
        
        welcome.text = "Its " + toady + " and you sleep for " + String(counter) + " minutes. Welcome back."
        
        alarm = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(alarmLoop), userInfo: nil, repeats: true)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: [.repeat, .autoreverse], animations: ({
            
            self.alarmTwo.transform = CGAffineTransform(translationX: -10, y: -10)
            self.alarmThree.transform = CGAffineTransform(translationX: 10, y: -10)
            self.alarmOne.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
            
        }), completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func alarmLoop(){
        
        if snooze {
            self.alarmTwo.layer.removeAllAnimations()
            self.alarmThree.layer.removeAllAnimations()
            self.alarmOne.layer.removeAllAnimations()
            alarm.invalidate()
        } else {
            AudioServicesPlaySystemSound (systemSoundID)
            AudioServicesPlaySystemSound (viberate)
        }
        
    }
    
    @IBAction func snoozeBtn(_ sender: Any) {
        snooze = true
    }
    
    
    func secondsToMinutes(time: Int) -> Int{
        if(time == 0){return 0}
        return time/60
    }
    
    func getDateString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone.current
        let time = dateFormatter.string(from: date)
        return time
        
    }
    
    @IBAction func backtowake(_ sender: UIStoryboardSegue) {}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
