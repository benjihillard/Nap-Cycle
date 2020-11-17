//
//  titlepage.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit
import UserNotifications

class titlepage: UIViewController{

    
    @IBOutlet weak var z1: UIImageView!
    @IBOutlet weak var z2: UIImageView!
    @IBOutlet weak var z3: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.z1.alpha = 0.0
        self.z2.alpha = 0.0
        self.z3.alpha = 0.0
        UIView.animate(withDuration: 3.0, delay: 2, options: [.repeat, .autoreverse], animations: {
            self.z1.alpha = 1.0
        })
        UIView.animate(withDuration: 3.0, delay: 1,options: [.repeat, .autoreverse], animations: {
            self.z2.alpha = 1.0
        })
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.z3.alpha = 1.0
        })
       
       
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
