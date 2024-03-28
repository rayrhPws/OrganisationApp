//
//  UIViewController.swift
//  Mobile Classifieds(PEMS)
//
//  Created by Muneeb on 22/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        UIView.animate(withDuration: 0.5) { [self] in
            view.addSubview(child.view)
            child.didMove(toParent: self)
        }
    }
  
    func removeChild() {
        guard parent != nil else {
            return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        print("children after removing\(self.children.count)")
    }
    
    

    
}
