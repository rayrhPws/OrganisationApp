//
//  UITableView.swift
//  Tablon
//
//  Created by Muneeb on 19/04/2022.
//

import UIKit

protocol Registerable: AnyObject {
    static var identifier: String { get }
    static func getNIB() -> UINib
}

extension Registerable {
    static var identifier: String {
        return String(describing: self)
    }
    static func getNIB() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UITableView {
    // MARK: - Public Methods
    func getCell<T: Registerable>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func getCell<T: Registerable>(type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func register(types: Registerable.Type ...) {
        for type in types {
            register(type.getNIB(), forCellReuseIdentifier: type.identifier)
        }
    }
    
    func hasRowAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    
    func scrollToBottom(){
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            if hasRowAtIndexPath(indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
}
