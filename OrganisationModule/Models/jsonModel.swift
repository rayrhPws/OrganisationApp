//
//  jsonModel.swift
//  OrganisationModule
//
//  Created by Arif ww on 19/03/2024.
//


import Foundation

// MARK: - Welcome
struct JsonModel: Codable {
    let singleItem: SingleItem?
    let status: String?
}

// MARK: - SingleItem
struct SingleItem: Codable {
    let preamble: String?
    let bezeichnung: String?
    let voraussetzungen: String?
    let verfahrensablauf: String?
    let fristen: String?
    let unterlagen: String?
    let kosten: String?
    let sonstiges: String?
    let rechtsgrundlage: String?
    let bearbeitungsdauer: String?
    
    let zustaendigkeit: String?
    let vertiefende_informationen: String?
    let freigabevermerk: String?
//    let id: Int?
//    let circumstances: [Circumstance]?
//    let contactPerson: [ContactPerson]?
//    let organisation: [Organisation]?
    let formulare, prozesse: [Formular]?
}

// MARK: - Circumstance
struct Circumstance: Codable {
    let title: String?
    let id: Int?
    let url, urlType: String?
}

// MARK: - ContactPerson
struct ContactPerson: Codable {
    let firstName, lastName, sex, title: String?
    let id: Int?
    let position, email, fax, telefon: String?
    let url, urlType: String?
    let image: String?
    let salutation: String?
}

// MARK: - Formular
struct Formular: Codable {
    let bezeichnung, url: String?
}

// MARK: - Organisation
struct Organisation: Codable {
    let title: String?
    let id: Int?
    let telefon, fax, email, street: String?
    let houseNumber, post, place, url: String?
    let urlType: String?
}
