//
//  AlarmClockPicker.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 11/12/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit


class AlarmClockPicker: UIPickerView {
    var isInTeens = false
    var hourDigitOne = 10
}

extension AlarmClockPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 3{
            return 10
        }
        else if component == 2{
            return 6
        }
        
        else if component == 1{
            return hourDigitOne
        }
        
        else if component == 0{
            return 2
        }
        else{
            return 4
        }


    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    
    
}

extension AlarmClockPicker: UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
        
        let imageName = String(row%10) + ".png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 120)
        view.addSubview(imageView)
        return view
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (row == 1 && component == 0){
            hourDigitOne = 3
            pickerView.reloadAllComponents()
        }
        if (row == 0 && component == 0){
            hourDigitOne = 10
            pickerView.reloadAllComponents()
        }
        
    }
}

