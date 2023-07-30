import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var lableInfo: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var dictionary = ["Soft": 2, "Medium": 4, "Hard": 6]
    var totalTime = 0
    var secondsPasssed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func eggsButtonClick(_ sender: UIButton) {
        lableInfo.text = "How do you like your eggs?"
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPasssed = 0
        let hardness = sender.currentTitle!
        totalTime = dictionary[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPasssed < totalTime {
            secondsPasssed += 1
            let percentProgress = Float(secondsPasssed)/Float(totalTime)
            progressBar.progress = percentProgress
            
        } else {
            timer.invalidate()
            lableInfo.text = "DONE!"
            playAlarm()
        }
    }
    
    func playAlarm(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
