//
//  ViewController.swift
//  MagicPaper
//
//  Created by Angela Yu on 21/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet var sceneView: ARSCNView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 1
            
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        
        
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
        var videoName = ""
            
         let imageAnchorReferance = imageAnchor.referenceImage.name
            
            switch imageAnchorReferance {
            case "harrypotter":
                
                    videoName = "harrypotter.mp4"
                
            case "adam1":
                videoName = "adam1.mp4"
            case "adam2":
                videoName = "adam2.mp4"
            case "adamlar1":
                videoName = "adamlar1.mp4"
            case "adamlar2":
                videoName = "adamlar2.mp4"
            case "kule1":
                videoName = "kule1.mp4"
        
            default:
               break
            }
            
            let videoNode = SKVideoNode(fileNamed: videoName)
            
            
            if imageAnchor.referenceImage.name == imageAnchorReferance  {
                
           

                
            videoNode.play()
        
            
            let videoScene = SKScene(size: CGSize(width: 480, height: 360))
            
            
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            
            videoNode.yScale = -1.0
            
            videoScene.addChild(videoNode)
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = videoScene
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            }
            else if imageAnchorReferance == "adam1"
            {
                videoNode.pause()
            }
           
            
        }
        
        return node
        
    }
    
    
}
