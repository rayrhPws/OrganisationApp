

import Foundation
import Alamofire

// MARK: - MapModel
struct MapModel: Codable {
    var items: [marker]?
    var status: String?
}


// MARK: - Item
struct marker: Codable {
    var title, beschreibung: String?
//    var id: Int?
//    var kategorien: [Icon]?
    var iconInfo: Icon?
    var data: DataClass?
//    var urlPopUp, urlDetails: String?
//    var isDetailsWebsite: Bool?
    enum CodingKeys: String, CodingKey {
        case title = "bezeichnung"
        case iconInfo = "icon"
        case beschreibung
        case data
    }
}


// MARK: - DataClass
struct DataClass: Codable {
    var type: String?
    var coords: [Coord]?
    var options: Options?
}



// MARK: - Coord
struct Coord: Codable {
    var lat, lng: Double?
}



// MARK: - Options
struct Options: Codable {
    var color: String?
    var weight, mapID: Int?
    var type: String?
    var radius: Int?
    var fillOpacity: Double?
    var opacity: Int?
    var fill, stroke: Bool?

    enum CodingKeys: String, CodingKey {
        case color, weight
        case mapID = "mapId"
        case type, radius, fillOpacity, opacity, fill, stroke
    }
}



// MARK: - Icon
struct Icon: Codable {
    var title: String?
    var id: Int?
    var iconName, iconStyle, iconColor, form: String?

    enum CodingKeys: String, CodingKey {
        
        case id
        case iconName = "icon"
        case title = "bezeichnung"
        case iconColor = "farbe"
        case iconStyle = "icon_style"
        case form
    }
}
