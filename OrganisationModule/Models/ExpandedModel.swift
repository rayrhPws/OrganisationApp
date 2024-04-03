//
//  ExpandedModel.swift
//  OrganisationModule
//
//  Created by Arif ww on 31/03/2024.
//

import Foundation
struct ExpandedModel {
    var title: String
    var htmlStr: String
    var nestedArray: [ExpandedModel]?
    var isExpanded: Bool = false
    
}

