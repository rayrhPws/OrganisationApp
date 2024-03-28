
//  Helper.swift
//  OrganisationModule
//  Created by Arif ww on 21/03/2024.

import Foundation
class Helper{
 static func convertToDictionary(_ text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("Error converting JSON to dictionary: \(error.localizedDescription)")
            return nil
        }
    }
}
