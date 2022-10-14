//
//  CasinoViewController.swift
//  TwentyOne
//
//  Created by Don Chan on 2022/11/10.
//

import UIKit
import AVFoundation

class CasinoViewController: UIViewController
{
    var looper: AVPlayerLooper?
    let player = AVQueuePlayer()
  

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fileUrl = Bundle.main.url(forResource: "Casino", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        looper = AVPlayerLooper(player: player, templateItem: playItem)
        player.play()

       
    }
    
   
    
  
    
    override var supportedInterfaceOrientations:
    UIInterfaceOrientationMask
    {
        .landscape
    }

    @IBAction func welcome(_ sender: UIButton)
    {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "TwentyOnePlayViewController") as? TwentyOnePlayViewController
        {
            present(controller, animated: true) {
                self.player.pause()
            }
        }
    }
}
