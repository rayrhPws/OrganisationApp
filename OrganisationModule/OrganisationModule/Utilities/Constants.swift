//
//  Constants.swift

//

import Foundation
import UIKit


class Constants {
    static let shared: Constants = Constants()
    var languageBool: Bool = false
    let baseUrl = "https://www.welzheim.de/app-connection-stadt/app-connection-buergerserviceportal?action=getSBWLeistungenDetails&baseColor=006B23&baseFontSize=16&singleItemId=478"
//    var titlesArray = ["Expanded item one", "Expanded item two","Expanded item three","Expanded item four","Expanded item five","Expanded item six","Expanded item seven","Expanded item eight","Expanded item nine","Expanded item ten","Expanded item eleven","Expanded item twelve","Expanded item thirteen","Expanded item fourteen","Expanded item fifteen","Expanded item sixteen","Expanded item seventeen","Expanded item eighteen"]
    
    var constHeaderStringForWebView = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
    var constDocReadyState = "document.readyState"
    var constDocScrollHeight = "document.body.scrollHeight"
}

enum TitleConfig: String {
    case formular = "Formulare"
    case process = "prozesse"
    case separtor = "separator"
    case title1 = "Expanded item 1"
    case title2 = "Expanded item 2"
    case title3 = "Expanded item 3"
    case title4 = "Expanded item 4"
    case title5 = "Expanded item 5"
    case title6 = "Expanded item 6"
    case title7 = "Expanded item 7"
    case title8 = "Expanded item 8"
    case title9 = "Expanded item 9"
    case title10 = "Expanded item 10"
    case title11 = "Expanded item 11"
    case title12 = "Expanded item 12"
    case title13 = "Expanded item 13"
    case title14 = "Expanded item 14"
    
}

struct Storyboards {
    static let Main =  "Main"
}






