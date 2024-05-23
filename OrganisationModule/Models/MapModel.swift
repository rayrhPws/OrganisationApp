

import Foundation
import Alamofire

// MARK: - MapModel
struct MapModel: Codable {
    var items: [Marker]?
    var status: String?
}


// MARK: - Item
struct Marker: Codable {
    var title, detail : String?
    var id: Int?
    var image: ImageData?
    var category: [Icon]?
    var iconInfo: Icon?
    var markerData: DataClass?
    var imagesList: [ImageData?]?
    var bottomSheetUrl: String?

    enum CodingKeys: String, CodingKey {
        case title = "bezeichnung"
        case detail = "beschreibung"
        case iconInfo = "icon"
        case markerData = "data"
        case image = "bild"
        case imagesList = "bilder"
        case category = "kategorien"
        case id
        case bottomSheetUrl = "urlDetails"
        
    }
}


// MARK: - DataClass
struct DataClass: Codable {
    var type: String?
    var coords: [Coord]?
    var options: Options?
}

struct ImageData: Codable {
    var title: String?
    var id: Int?
    var imgUrl : String?
    enum CodingKeys: String, CodingKey {
        case title = "bezeichnung"
        case id
        case imgUrl = "url"
    }
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
    var iconName, iconStyle, iconColor, iconType: String?

    enum CodingKeys: String, CodingKey {
        
        case id
        case iconName = "icon"
        case title = "bezeichnung"
        case iconColor = "farbe"
        case iconStyle = "icon_style"
        case iconType = "form"
    }
}


struct MarkerDetailModel: Codable {
    var singleItem: Marker?
}
