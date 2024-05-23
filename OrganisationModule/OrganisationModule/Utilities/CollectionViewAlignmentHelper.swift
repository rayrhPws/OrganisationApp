//
//  CollectionViewAlignmentHelper.swift
//  OrganisationModule
//
//  Created by Arif ww on 22/05/2024.
//

import Foundation
import UIKit

enum HorizontalAlignment {
    case left, center, right
}

enum VerticalAlignment {
    case top, center, bottom
}

class AlignedCollectionViewFlowLayoutChatGPT: UICollectionViewFlowLayout {
    private let horizontalAlignment: HorizontalAlignment
    private let verticalAlignment: VerticalAlignment
    
    init(horizontalAlignment: HorizontalAlignment, verticalAlignment: VerticalAlignment) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: layoutAttribute.indexPath)?.frame {
                    layoutAttribute.frame = newFrame
                }
            }
        }
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
              let collectionView = collectionView else {
            return nil
        }
        
        let sectionInset = evaluatedSectionInset(for: indexPath.section)
        let isFirstItemInSection = indexPath.item == 0
        let layoutWidth = collectionView.frame.width - sectionInset.left - sectionInset.right
        let layoutHeight = collectionView.frame.height - sectionInset.top - sectionInset.bottom
        
        if isFirstItemInSection {
            attributes.frame.origin.x = sectionInset.left
            attributes.frame.origin.y = sectionInset.top
            return attributes
        }
        
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame ?? .zero
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width + evaluatedMinimumInteritemSpacing(for: indexPath.section)
        let previousFrameBottomPoint = previousFrame.origin.y + previousFrame.size.height + evaluatedMinimumLineSpacing(for: indexPath.section)
        
        var currentFrame = attributes.frame
        
        switch horizontalAlignment {
        case .left:
            currentFrame.origin.x = sectionInset.left
        case .center:
            currentFrame.origin.x = (layoutWidth - currentFrame.size.width) / 2
        case .right:
            currentFrame.origin.x = layoutWidth - currentFrame.size.width - sectionInset.right
        }
        
        switch verticalAlignment {
        case .top:
            currentFrame.origin.y = sectionInset.top
        case .center:
            currentFrame.origin.y = (layoutHeight - currentFrame.size.height) / 2
        case .bottom:
            currentFrame.origin.y = layoutHeight - currentFrame.size.height - sectionInset.bottom
        }
        
        let isFirstItemInRow = !previousFrame.intersects(CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height))
        
        if isFirstItemInRow {
            currentFrame.origin.x = sectionInset.left
        } else {
            currentFrame.origin.x = previousFrameRightPoint
        }
        
        if currentFrame.origin.x + currentFrame.size.width > layoutWidth {
            currentFrame.origin.x = sectionInset.left
            currentFrame.origin.y = previousFrameBottomPoint
        }
        
        attributes.frame = currentFrame
        return attributes
    }
    
    private func evaluatedSectionInset(for section: Int) -> UIEdgeInsets {
        if let inset = (self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
            return inset
        } else {
            return self.sectionInset
        }
    }
    
    private func evaluatedMinimumInteritemSpacing(for section: Int) -> CGFloat {
        if let minimumInteritemSpacing = (self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section) {
            return minimumInteritemSpacing
        } else {
            return self.minimumInteritemSpacing
        }
    }
    
    private func evaluatedMinimumLineSpacing(for section: Int) -> CGFloat {
        if let minimumLineSpacing = (self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(self.collectionView!, layout: self, minimumLineSpacingForSectionAt: section) {
            return minimumLineSpacing
        } else {
            return self.minimumLineSpacing
        }
    }
}
