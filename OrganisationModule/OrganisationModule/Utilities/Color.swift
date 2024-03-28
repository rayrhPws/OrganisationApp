//
//  Color.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit

enum Color: String, CaseIterable {
    case Dark_blue = "Dark-blue"
    case dark_gray = "dark-gray"
    case light_blue = "light-blue"
    case ligth_gray = "ligth-gray"
    case Orange = "Orange"
    case pending = "pending"
    case approved = "approved"
    case text_color = "text-color"
    case dash_light = "dash_light"
    case theme = "theme"
    case red = "red"
    case green = "green"
    case pink = "pink"
    case blue = "blue"
    

    func color() -> UIColor {
        guard let color = UIColor(named: rawValue) else {
            fatalError("No such color found")
        }
        return color
    }
}


