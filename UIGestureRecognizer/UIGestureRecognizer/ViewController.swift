//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Piera Marchesini on 17/04/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        //Amount to move the center of the monkey the same amount the finger has been dragged
        if let view = recognizer.view {
            //Using view.center makes your code more generic
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        //Extremely important to set the translation back to zero once you are done
        //Otherwise, the translation will keep compounding each time, and you’ll see your monkey rapidly move off the screen!
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            //Figure out the length of the velocity vector (i.e. the magnitude)
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            //If the length is < 200, then decrease the base speed, otherwise increase it.
            let slideFactor = 0.1 * slideMultiplier //Increase for more of a slide
            
            //Calculate a final point based on the velocity and the slideFactor.
            var finalPoint = CGPoint(x: recognizer.view!.center.x + (velocity.x * slideFactor), y: recognizer.view!.center.y + (velocity.y * slideFactor))
            
            //Make sure the final point is within the view’s bounds
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            //Animate the view to the final resting place
            UIView.animate(withDuration: Double(slideFactor * 2), delay: 0,
                           //Use the “ease out” animation option to slow down the movement over time.
                options: UIViewAnimationOptions.curveEaseOut, animations: { 
                    recognizer.view!.center = finalPoint
            }, completion: nil)
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer){
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }

    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer){
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    @objc func gestureRecognizer(_: UIGestureRecognizer,
                                 shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}

