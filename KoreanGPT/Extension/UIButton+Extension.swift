//
//  UIButton+Extension.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/28.
//

import UIKit

class UIButtonExtension: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(named: "CustomBlue")?.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.07).isActive = true
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.80).isActive = true
    }
}
