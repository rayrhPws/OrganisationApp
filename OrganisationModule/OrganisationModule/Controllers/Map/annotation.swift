//
//  annotation.swift
//  OrganisationModule
//
//  Created by Arif ww on 23/04/2024.
//

import Foundation
import MapKit

class PrimaryAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var iconString: String?
  var color: UIColor

  init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, iconString: String?, color: UIColor) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    self.iconString = iconString
    self.color = color
  }
}

