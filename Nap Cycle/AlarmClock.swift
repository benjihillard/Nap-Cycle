//
//  alarmClock.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 11/12/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit

class AlarmClock: UIPickerView {
    //var modelDate: []!
}

extension AlarmClock: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    
}

extension AlarmClock: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "blahhhhhh"
    }
    
}
