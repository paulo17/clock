//
//  Font.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit

func generateStyleLabel(label: UILabel, font: String, color: String, size: CGFloat, alpha: Float, text: String?) {
    
    label.font = UIFont(name: "\(font)", size: size)
    label.textColor = UIColorFromRGBA("\(color)", alpha: alpha)
    label.text = "\(text)"
    
}