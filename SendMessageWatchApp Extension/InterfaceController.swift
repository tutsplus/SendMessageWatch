//
//  InterfaceController.swift
//  SendMessageWatchApp Extension
//
//  Created by Jorge Costa on 06/07/15.
//  Copyright © 2015 Tuts+. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController,WCSessionDelegate{
    
    var session : WCSession!
    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    @IBOutlet var sendButton: WKInterfaceButton!
    
    @IBAction func sendMessage() {
        let messageToSend = ["Value":"Hello iPhone"]
        
        session.sendMessage(messageToSend, replyHandler: { replyMessage in
            let value = replyMessage["Value"] as? String
            
            self.messageLabel.setText(value)
            
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    
    //Swift
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let value = message["Value"] as? String
        
        dispatch_async(dispatch_get_main_queue()) {
            self.messageLabel.setText(value)
        }
        
        //send a reply
        replyHandler(["Value":"Yes"])
        
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
