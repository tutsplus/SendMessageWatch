//
//  ViewController.swift
//  SendMessageWatch
//
//  Created by Jorge Costa on 06/07/15.
//  Copyright © 2015 Tuts+. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession!
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func sendMessage(sender: AnyObject) {
        //Send Message to WatchKit
        let messageToSend = ["Value":"Hi watch, can you talk to me?"]
        
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            let value = replyMessage["Value"] as? String
           
            dispatch_async(dispatch_get_main_queue()) {
                self.messageLabel.text = value
            }
            
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Swift
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let value = message["Value"] as? String
        
        dispatch_async(dispatch_get_main_queue()) {
            self.messageLabel.text = value
        }
        
        //send a reply
        replyHandler(["Value":"Hello Watch"])
        
    }
    

}

