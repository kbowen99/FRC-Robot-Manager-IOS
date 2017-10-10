//
//  RobotServiceManager.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 3/12/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol RobotServiceManagerDelegate {
    
    func connectedDevicesChanged(manager : RobotServiceManager, connectedDevices: [String])
    //func colorChanged(manager : RobotServiceManager, colorString: String)
    func magicBot(robo: Robot)
    
}

class RobotServiceManager : NSObject {
    
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private let robotServiceType = "robotmanager"
    
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    
    var delegate : RobotServiceManagerDelegate?
    
    @objc lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        return session
    }()
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: robotServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: robotServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    @objc func send(robot : Robot) {
        NSLog("%@", "sendingBot to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                let data = NSKeyedArchiver.archivedData(withRootObject: robot)
                //let data = NSKeyedArchiver.archivedData(withRootObject: robot)
                try self.session.send(data, toPeers: session.connectedPeers, with: .reliable)
                //try self.session.send(robot.desc.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
}

extension RobotServiceManager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}

extension RobotServiceManager : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 100)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension RobotServiceManager : MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let test = NSKeyedUnarchiver.unarchiveObject(with: data)
        print("DECODING BOT");
        //let magics:Robot = (NSKeyedUnarchiver(forReadingWith: data).decodeObject() as? Robot)!
        //let unarchiver = NSKeyedUnarchiver(forReadingWith: data);
        //unarchiver.requiresSecureCoding = true
        ////let object = unarchiver.decodeObject()
        //unarchiver.finishDecoding()
        print((test as! Robot).desc);
        self.delegate?.magicBot(robo: (test as! Robot))
        //RobotTableViewController.addBot(object);
        //print("\(magics.desc)")
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }
    
    //func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    //    NSLog("%@", "didReceiveData: \(data)")
    //    let str = String(data: data, encoding: .utf8)!
    //    self.delegate?.colorChanged(manager: self, colorString: str)
    //}
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
