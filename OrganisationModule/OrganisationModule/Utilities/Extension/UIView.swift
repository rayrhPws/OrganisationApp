//
//  UIView.swift
//  Tablon
//
//  Created by Muneeb on 22/04/2022.
//

import Foundation
import UIKit
extension UIView {
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius =  newValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity =  newValue
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
   
    func setShadow(shadowRadius: CGFloat, shadowOpacity: Float, shadowColor: UIColor, shadowOffset: CGSize = CGSize(width: 0, height: 0)) {
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
    }
}
