//
//  CustomCircularView.swift
//  OrganisationModule
//
//  Created by Arif ww on 30/04/2024.
//

import Foundation
import UIKit
import MapKit
// MARK: - Custom Circle View

class CustomCircleView: MKAnnotationView {

  private var imageView: UIImageView?

  // Define a property for image size adjustment
  private var imageSizeRatio: CGFloat = 0.5 // Adjust this value between 0 and 1

  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    canShowCallout = true // Allow callout bubble
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(backgroundColor: UIColor, size: CGFloat, image: UIImage?, imageSizeRatio: CGFloat) {
    self.imageSizeRatio = imageSizeRatio // Update imageSizeRatio based on parameter

    let circlePath = UIBezierPath(arcCenter: CGPoint(x: size / 2, y: size / 2),
                                 radius: size / 2,
                                 startAngle: 0.0,
                                 endAngle: CGFloat.pi * 2.0,
                                 clockwise: true)

    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = backgroundColor.cgColor

    layer.addSublayer(shapeLayer)

    if let image = image {
      let imageSize = size * imageSizeRatio // Calculate image size based on ratio
      imageView = UIImageView(frame: CGRect(x: (size - imageSize) / 2,
                                            y: (size - imageSize) / 2,
                                            width: imageSize,
                                            height: imageSize))
      imageView?.image = image
      imageView?.contentMode = .scaleAspectFit
      addSubview(imageView!)
    }
  }
}
