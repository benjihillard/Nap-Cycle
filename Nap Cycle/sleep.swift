import UIKit
import Swift
import HealthKit

class sleep: UIViewController {
    
    
    let healthStore = HKHealthStore()
    let dateFormatter = DateFormatter()
    let group = DispatchGroup()
    var offset = 0
    var duration = 0
    var counter = 0
    var wakeUp = Date()
    var start = Date()
    var end = Date()
    var alarm = Date()
    var timer = Timer()
    var visUpdate = Timer()
    var asleep = false
    var timeTill = 0.0
    var pm = false
    var wakeUpString = ""
    
    
    
    @IBOutlet weak var sleepInfo: UILabel!
    
    @IBOutlet weak var sleepInfoTwo: UILabel!
    
    @IBOutlet weak var visualizer: UIView!
    
    
    var mic = MicrophoneMonitor(numberOfSamples: 10)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        getAuthorization()
        setDisplayMessage()
        start = Date()
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(awakeLoop), userInfo: nil, repeats: true)
        visUpdate = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(vizloop), userInfo: nil, repeats: true)
        
    }
    
    
    
    // get authorization of health kit
    func getAuthorization(){
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
                let setType = Set<HKSampleType>(arrayLiteral: sleepType)
                healthStore.requestAuthorization(toShare: setType, read: setType) { (success, error) in
                    
                    if !success || error != nil {
                        print("failure")
                        return
                    }
                    
                    print("access granted")
                }
            }
    }
    
    // set up UX
    func setDisplayMessage(){
        var ampm = ""
        if(pm){
            ampm = "PM"
        } else {
            ampm = "AM"
        }
        sleepInfo.text = "We got your back. take a nap well see you in: \n " + String(duration) + " minutes.\n"
        sleepInfoTwo.text = "Or if you have trouble falling a sleep. We will wake you up in:  " + String(timeTill) + " hours at " + wakeUpString + " " + ampm + ".\n Just in case."
    }

    
    // loops until safeguard time is past or user falls asleep
    @objc func awakeLoop(){
        end = Date()
        group.enter()
        isAsleep(start: start, end: end)
        group.wait()
        if(asleep){
            timer.invalidate()
            startClock();
        } else {
            print("User is awake")
            
        }
        if(safeGuard()){
            timer.invalidate()
            self.performSegue(withIdentifier: "wakeup", sender: nil)
        }
        start = end

    }
    
    
    // start timer for duartion of nap
    func startClock(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sleepLoop), userInfo: nil, repeats: true)
    }
    
    
    
    // loops untilafeguard time is past or nap duration is complete
    @objc func sleepLoop(){
        counter += 1 //speed up
        print("User has been asleep for " + String(counter) + " minutes")
        if(counter >= duration){
            timer.invalidate()
            self.performSegue(withIdentifier: "wakeup", sender: nil)
            
        }
        if(safeGuard()){
            timer.invalidate()
            self.performSegue(withIdentifier: "wakeup", sender: nil)
        }
        
    }
    
    // tells whether safe gaurd time is past
    func safeGuard() -> Bool{
        if(Date()>wakeUp){
            return true
        } else {
            return false
        }
    }
    
    

    // makes request to heathkit data to see if user is asleep
    func isAsleep(start: Date, end: Date){
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {

            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                
                if let result = tmpResult {
                    for item in result {
                        
                        if let sample = item as? HKCategorySample {
                            //print(sample.value)
                            //print(HKCategoryValueSleepAnalysis.asleep.rawValue)
                            
                            let value = (sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue)
                            
                            if (value){
                                //print(value)
                                self.asleep = true
                                
                                
                                
                            } else {
                                
                            }
                            
                            
                        }
                    }
                }
            }
            group.leave()
            healthStore.execute(query)
        }
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? wakeup{
            destVC.counter = counter
        }
        

    }
    
    
    @objc func vizloop(){
        visualizer.subviews.forEach({ $0.removeFromSuperview() })
        var x = 50
        var y = 150
        var range = mic.soundSamples
        var booster = 0
        for value in range {
            var height = Int((max(0.2, CGFloat(value) + 50) / 2) * (200/25))
            height = -1 * height
            var dirtyRect = CGRect(x: x + booster, y: y, width: 10, height: height )
            let greenView = UIView(frame: dirtyRect)
            greenView.backgroundColor = UIColor.systemBlue
            self.visualizer.addSubview(greenView)
            booster = booster + 30
        }
    }
    
    @IBAction func backtosleep(_ sender: UIStoryboardSegue) {}
}
