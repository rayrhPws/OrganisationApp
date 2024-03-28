//
//  IMAlertViewController.swift
//  GaredenCraft
//
//  Created by Muneeb on 20/05/2022.
//

import Foundation
import UIKit

class IMAlertViewController {
    static let shared = IMAlertViewController()
    private init() {}
    
    func showAlertControllerWithMessage(msgString: String, rootController: UIViewController) {
        let controller = UIAlertController(title: "PEMS", message: msgString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        controller.addAction(okAction)
        rootController.present(controller, animated: true)
    }
    
    func showAlertControllerWithCallBackHandler(msgString: String, rootController: UIViewController, completionHandler : @escaping(_ result: Bool) -> Void) {
        let controller = UIAlertController(title: "PEMS", message: msgString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){_ in
            completionHandler(true)
        }
        controller.addAction(okAction)
        rootController.present(controller, animated: true)
    }
    
    func showAlertControllerWithMultipleActions(msgString: String, rootController: UIViewController, completionHandler : @escaping(_ result: Bool) -> Void) {
        let controller = UIAlertController(title: "PEMS", message: msgString, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) {_ in
            completionHandler(true)
        }
        let noAction = UIAlertAction(title: "No", style: .destructive) {_ in
            completionHandler(false)
        }
        controller.addAction(yesAction)
        controller.addAction(noAction)
        rootController.present(controller, animated: true)
    }
}
