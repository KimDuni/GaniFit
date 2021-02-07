//
//  StackPointer.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/07.
//

import UIKit

class StackPointer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let img = UIImageView(frame: CGRect(x: 0, y: 0 - (frame.height / 2), width: frame.width, height: frame.height))
        img.image = UIImage.init(systemName: "arrowtriangle.backward.fill")
        img.tintColor = UIColor.basePink
        self.addSubview(img)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func move(to stackCenter:CGPoint){
        DispatchQueue.main.async {
            self.center = stackCenter
        }
    }
}
