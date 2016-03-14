//
//  ViewController.swift
//  UCI9DC L90 Shake It Baby
//
//  Created by Stanislav Sidelnikov on 14/03/16.
//  Copyright © 2016 Stanislav Sidelnikov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    private var soundFilesNames: [NSURL]?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        soundFilesNames = NSBundle.mainBundle().URLsForResourcesWithExtension("mp3", subdirectory: "Sounds")
        if soundFilesNames == nil || soundFilesNames?.count == 0 {
            NSLog("Cannot find sound files in directory specified")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard let soundFilesNames = soundFilesNames where soundFilesNames.count > 0 else {
            return
        }
        if event?.subtype == .MotionShake {
            player?.stop()
            let i = Int(arc4random_uniform(UInt32(soundFilesNames.count)))
            do {
                player = try AVAudioPlayer(contentsOfURL: soundFilesNames[i])
            } catch let error {
                NSLog("Unable to create player for file \(soundFilesNames[i]). Error: \(error)")
                return
            }
            print("Playing sound \(player!.url!.relativeString!)")
            player?.play()
        }
    }

}

