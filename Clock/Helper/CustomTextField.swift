//
//  CustomTextField.swift
//  clock
//
//  Created by Paul on 15/12/2015.
//  Copyright © 2015 paulboiseau. All rights reserved.
//

import UIKit

func customTextField(textField: UITextField, placeholder: String) {
    
    textField.autocorrectionType = .No
    textField.keyboardAppearance = UIKeyboardAppearance.Dark
    textField.alpha = 0.7
    textField.backgroundColor = UIColor.clearColor()
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColorFromRGBA("FFE5D3", alpha: 1.0).CGColor
    textField.layer.cornerRadius = 10
    textField.tintColor = UIColorFromRGBA("FFFAF0", alpha: 1.0)
    
    textField.font = UIFont(name: "ProximaNova-Semibold", size: 14)
    textField.attributedPlaceholder = NSAttributedString(string: placeholder.uppercaseString, attributes: [NSForegroundColorAttributeName: UIColorFromRGBA("FFFAF0", alpha: 1.0)])
    textField.textColor = UIColorFromRGBA("FFFAF0", alpha: 1.0)
    textField.leftView = UIView(frame: CGRectMake(0, 0, 15, textField.bounds.size.height))
    textField.leftViewMode = UITextFieldViewMode.Always
    
}
