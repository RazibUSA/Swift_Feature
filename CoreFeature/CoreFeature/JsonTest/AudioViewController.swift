//: Playground - noun: a place where people can play

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var noOfRecords: Int = 0
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBAction func recordPressed(_ sender: Any) {
        if audioRecorder == nil{
            
            noOfRecords += 1
            let fileName =   getDirectory().appendingPathComponent("Recording\(noOfRecords).m4a")
            print(fileName)
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            do{
                //record the audio
                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder.record()
                audioRecorder.delegate = self
                recordButton.setTitle("Stop Recording", for: .normal)
                
            }catch{
                displayAlert(title: "OOPS", message: "Recording failed")
            }
        } else {
            audioRecorder.stop()
            audioRecorder = nil
            recordButton.setTitle("Start Recording", for: .normal)
            //store the last no for naming
            UserDefaults.standard.set(noOfRecords, forKey: "myNumber")
            myTableView.reloadData()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ask permission for Mic
        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission { print("Accepted")}
            
            //storing numbering logic
            if let number = UserDefaults.standard.object(forKey: "myNumber") as? Int
            { self.noOfRecords = number }
            
        }
    }
    //func to give path(URL) to store the recording
    func getDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectory = path[0]
        return docDirectory
    }
    
    //func to display Alert
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    //setting up table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let path = getDirectory().appendingPathComponent("Recording\(indexPath.row + 1).m4a")
        let fileName = URL(fileURLWithPath: path.absoluteString).deletingPathExtension().lastPathComponent
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fileName
        return cell
    }
    
    // listen to recorded audio
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("Recording\(indexPath.row + 1).m4a")
        print(path)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        } catch{
            displayAlert(title: "OOPS", message: "Playback failed")
        }
    }
    // to delete the recording
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("Recording\(indexPath.row + 1).m4a")
        if editingStyle == .delete {
            do{
                print("test", indexPath)
                try? FileManager.default.removeItem(at: path)
                 noOfRecords -= 1
                tableView.deleteRows(at: [indexPath], with: .automatic)
                UserDefaults.standard.set(noOfRecords, forKey: "myNumber")
            } catch{
                displayAlert(title: "OOPS", message: "Delete failed")
            }
        }
    }
}
