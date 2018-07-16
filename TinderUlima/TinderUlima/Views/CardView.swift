//
//  CardView.swift
//  TinderUlima
//
//  Created by Eros Campos on 16/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//

import UIKit

class CardView: UIView {

    var onCarDraggedDelegate: OnCarDraggedDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let cardDraggedRecognizer: UIGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCardDragged(_:)))
        addGestureRecognizer(cardDraggedRecognizer)
    }
    
    @objc private func onCardDragged(_ gestureRecognizer : UIPanGestureRecognizer){
        let initialX = self.bounds.width / 2
        let initialY = self.bounds.height / 2
        
        let cardPoint = gestureRecognizer.translation(in: self)
        self.center = CGPoint(x: self.bounds.width / 2 + cardPoint.x, y: self.bounds.height / 2 + cardPoint.y)
        
        if gestureRecognizer.state == .ended{
            if self.center.x < (self.bounds.width / 2 - 100){
                print("dislike")
            }
            if self.center.x > (self.bounds.width / 2 + 100){
                print("like")
            }
            
            self.center = CGPoint(x: initialX, y: initialY)
        }
        
        if let delegate = onCarDraggedDelegate{
            delegate.OnCardDragged()
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
