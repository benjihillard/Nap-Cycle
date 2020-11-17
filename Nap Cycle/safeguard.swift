//
//  safeguard.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit

class safeguard: UIViewController {
    var duration = 0
    var wakeUp = Date()
    var timeTill = 0.0
    var wakeUpString = ""
    var pm = false
    @IBOutlet weak var wakeUpTime: UIPickerView!
    
    @IBOutlet weak var toggle: UIButton!
    @IBOutlet weak var napButton: UIButton!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var moon: UIImageView!
    var alarmClockPicker = AlarmClockPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wakeUpTime.delegate = alarmClockPicker
        wakeUpTime.dataSource = alarmClockPicker
        setTime()
        
    }
    
    
    @IBAction func toggleAmPm(_ sender: Any) {
        if(pm){
            pm = false
            toggle.setImage(UIImage(named: "amtoggle"), for: .normal)
            moon.isHidden = true
            sun.isHidden = false
            
        } else {
            pm = true
            toggle.setImage(UIImage(named: "pmtoggle"), for: .normal)
            moon.isHidden = false
            sun.isHidden = true
        }
    }
    
    
    
    

    
    @IBAction func takeNap(_ sender: Any){
        var hours = Int(wakeUpTime.selectedRow(inComponent: 0).description + wakeUpTime.selectedRow(inComponent: 1).description)!
        let minutes = Int(wakeUpTime.selectedRow(inComponent: 2).description + wakeUpTime.selectedRow(inComponent: 3).description)!
        
        wakeUpString = wakeUpTime.selectedRow(inComponent: 0).description + wakeUpTime.selectedRow(inComponent: 1).description + ":" + wakeUpTime.selectedRow(inComponent: 2).description + wakeUpTime.selectedRow(inComponent: 3).description
        
        if(pm){
            hours = hours + 12
        }
        var dateComponents: DateComponents = (Calendar.current as NSCalendar).components([NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second], from: Date())
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 00
        var fixedDate: Date = Calendar.current.date(from: dateComponents)!
        
        //fixedDate.timeIntervalSinceNow - Date().timeIntervalSinceNow
        var timeTilWakeUp = (fixedDate.timeIntervalSinceNow - Date().timeIntervalSinceNow)/3600
        if timeTilWakeUp < 0 {
            timeTilWakeUp = 24 + timeTilWakeUp
        }
        timeTill = Double(round(100 * timeTilWakeUp) / 100)
        timeTilWakeUp = timeTilWakeUp * 3600
        wakeUp = Calendar.current.date(byAdding: .second, value: Int((timeTilWakeUp)), to: Date())!
        self.performSegue(withIdentifier: "sleep", sender: nil)
        
        
    }
    
    
    
    
    func setTime(){
        var calendar = Calendar.current
        calendar.timeZone = .current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: wakeUp)
        var hour = Int(components.hour!)
        let  minute = Int(components.minute!)
        if(hour > 12){
            hour = hour - 12
            toggle.setImage(UIImage(named: "pmtoggle"), for: .normal)
            pm = true
            moon.isHidden = false
        } else {
            sun.isHidden = false
            moon.isHidden = true
        }
        let place1 = hour/10
        let place2 = hour%10
        let place3 = minute/10
        let place4 = minute%10
        self.wakeUpTime?.selectRow(place4, inComponent: 3, animated: true)
        self.wakeUpTime?.selectRow(place3, inComponent: 2, animated: true)
        self.wakeUpTime?.selectRow(place2, inComponent: 1, animated: true)
        self.wakeUpTime?.selectRow(place1, inComponent: 0, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? sleep {
            destVC.duration = duration
            destVC.wakeUp = wakeUp
            destVC.timeTill = timeTill
            destVC.pm = pm
            destVC.wakeUpString = wakeUpString
        }
        
    }
    
    @IBAction func backtosafe(_ sender: UIStoryboardSegue) {}


}
