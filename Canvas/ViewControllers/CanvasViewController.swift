//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Joakim Jorde on 10/20/18.
//  Copyright © 2018 Joakim Jorde. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 200
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down

        // Do any additional setup after loading the view.
    }
    
 
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            var velocity = sender.velocity(in: view)
            if(velocity.y > 0)
            {
                //Moving down
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            else
            {
                //Moving up
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGesture)
            newlyCreatedFace.isUserInteractionEnabled = true

        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            
        }
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
          let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFace = (sender.view as! UIImageView) // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
