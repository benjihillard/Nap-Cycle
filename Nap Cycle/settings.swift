//
//  settings.swift
//  Nap Cycle
//
//  Created by Benjamin Hillard on 10/28/20.
//  Copyright © 2020 Benjamin Hillard. All rights reserved.
//

import UIKit

class settings: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deviceConnections(_ sender: Any) {
        
        UIApplication.shared.open(URL(string:"App-prefs:root=Bluetooth")!)
    }
    
    @IBAction func healthSettings(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "x-apple-health://")!)
    }
    
    
    @IBAction func customAlarm(_ sender: Any) {
        
        let alert = UIAlertController(title: "This is a premium feature.", message: "Please sign up for nap cycle premium for this feature", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backtoprev(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
