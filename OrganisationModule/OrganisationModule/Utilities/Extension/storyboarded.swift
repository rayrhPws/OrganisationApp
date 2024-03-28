//
//  storyboarded.swift
//  Clinic
//
//  Created by Arif ww on 06/09/2023.
//



import UIKit

/// A protocol that lets us instantiate view controllers from Main storyboard.
protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    // Creates a view controller from our storyboard. This relies on view controllers having the same storyboard identifier as their class name. This method shouldn't be overridden in conforming types.
    static func instantiateHome() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    
    static func instantiateAuth() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Auth", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    static func instantiateJobs() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Jobs", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    
    static func instantiateCategory() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Jobs", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    
    static func instantiateAccount() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Account", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    
    static func instantiateOrder() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Order", bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
    
  

}
