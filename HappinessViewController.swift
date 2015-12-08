//
//  HappinessViewController.swift
//  Happiness
//
//  Created by 李碰 on 15/7/12.
//  Copyright (c) 2015年 李碰. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController,FaceViewDataSource {


    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
        faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))

//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: faceView, action: "changeHappiness"))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
        
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0{ happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default : break
            
        }
        
    }
    
    var happiness : Int = 75 {
        didSet{
            happiness = min(max(happiness, 0), 100)
            print("happiness= \(happiness)")
            updateUI()
        }
    }

    func updateUI()
    {
        faceView.setNeedsDisplay()
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50)/50
    }
}
