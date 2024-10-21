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

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    static func nib() -> UINib {
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



protocol RegisterableForColl: AnyObject {
    static var identifier: String { get }
    static func getNIB() -> UINib
}

extension UICollectionViewCell: RegisterableForColl {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func getNIB() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    // MARK: - Public Methods
    
    // Register multiple cell types
    func register(types: RegisterableForColl.Type...) {
        for type in types {
            register(type.getNIB(), forCellWithReuseIdentifier: type.identifier)
        }
    }
    
    // Dequeue a reusable cell with the given type and indexPath
    func getCell<T: RegisterableForColl>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
//    // Dequeue a reusable cell with the given type
//    func getCell<T: RegisterableForColl>(type: T.Type) -> T? {
//        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: IndexPath) as? T
//    }
    
    // Check if a specific index path exists in the collection view
    func hasItemAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.item < self.numberOfItems(inSection: indexPath.section)
    }
    
    // Scroll to the bottom of the collection view
    func scrollToBottom() {
        DispatchQueue.main.async { [self] in
            let lastSectionIndex = self.numberOfSections - 1
            let lastItemIndex = self.numberOfItems(inSection: lastSectionIndex) - 1
            let indexPath = IndexPath(item: lastItemIndex, section: lastSectionIndex)
            
            if hasItemAtIndexPath(indexPath) {
                self.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
}
