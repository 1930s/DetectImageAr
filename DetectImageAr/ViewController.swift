//
//  ViewController.swift
//  DetectImageAr
//
//  Created by claudio Cavalli on 19/01/2019.
//  Copyright © 2019 claudio Cavalli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var artistView = DetailsView()
    var descriptionView = DescriptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        sceneView.delegate = self
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let assetFolder = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) else {
            return
        }
        
    let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = assetFolder
        configuration.maximumNumberOfTrackedImages = 1
        
    sceneView.session.run(configuration)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    
}



extension ViewController: ARSCNViewDelegate{ 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            let plane = SCNPlane(width: 0.01, height: 0.01)
            let plane2 = SCNPlane(width: 0.05, height: 0.05)
            if imageAnchor.referenceImage.name == "Urlo" {
                DispatchQueue.main.async {
                    plane.firstMaterial?.diffuse.contents = self.artistView.view
      plane2.firstMaterial?.diffuse.contents = self.descriptionView.view
                }
            }
            
            DispatchQueue.main.async {
                self.artistView.view.frame.size.width = 375
                self.descriptionView.view.frame.size.width = 347
            }
            
            plane.cornerRadius = plane.width / 18
            plane.width = plane.height * 3.7
            
            let xPosition = -(imageAnchor.referenceImage.physicalSize.width / 2) + (plane.width / 2)
            
            let finalZPosition = (imageAnchor.referenceImage.physicalSize.height / 2) + (plane.height / 2) + 0.002
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            
            planeNode.position.x = Float(xPosition)
          
            planeNode.position.z = Float(-finalZPosition)
            
          
          plane2.cornerRadius = plane2.width / 18
            
            let planeNode2 = SCNNode(geometry: plane2)
            
            planeNode2.eulerAngles.x = -.pi/2
            
            planeNode2.position.x = Float(xPosition + 0.011)
            
            planeNode2.position.z = Float(finalZPosition + 0.020)
            
            node.addChildNode(planeNode)
            node.addChildNode(planeNode2)
        }
        
        return node
        
    }
}
