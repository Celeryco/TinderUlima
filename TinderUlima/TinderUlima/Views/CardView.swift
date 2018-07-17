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
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let cardDraggedRecognizer: UIGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCardDragged(_:)))
        addGestureRecognizer(cardDraggedRecognizer)
    }
    
    @objc private func onCardDragged(_ gestureRecognizer : UIPanGestureRecognizer){
        //Valores iniciales de la vista
        let initialX = self.bounds.width / 2
        let initialY = self.bounds.height / 2
        let cardPoint = gestureRecognizer.translation(in: self)
        self.center = CGPoint(x: self.bounds.width / 2 + cardPoint.x, y: self.bounds.height / 2 + cardPoint.y)
        
        //Valores que se utilizaran para efectos de rotacion y movimiento
        let xFromCenter = self.bounds.width / 2 - self.center.x
        var rotate = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter) , 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        self.transform = finalTransform
        
        
        if self.center.x < (self.bounds.width / 2 - 100){
            self.dislikeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        if self.center.x > (self.bounds.width / 2 + 100){
            self.likeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        
        
        //Diferenciar entre like y dislike
        if gestureRecognizer.state == .ended{
            if self.center.x < (self.bounds.width / 2 - 100){
                print("dislike")
            }
            if self.center.x > (self.bounds.width / 2 + 100){
                print("like")
            }
            
            //Volver a valores iniciales
            self.dislikeImage.alpha = 0
            self.likeImage.alpha = 0

            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform = rotate.scaledBy(x: 1, y: 1)
            self.transform = finalTransform
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
