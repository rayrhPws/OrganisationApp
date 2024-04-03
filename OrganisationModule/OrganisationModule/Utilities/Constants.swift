//
//  Constants.swift

//

import Foundation
import UIKit


class Constants {
    static let shared: Constants = Constants()
    var languageBool: Bool = false
    let baseUrl = "https://www.welzheim.de/app-connection-stadt/app-connection-buergerserviceportal?action=getSBWLeistungenDetails&baseColor=006B23&baseFontSize=16&singleItemId=478"
    var titlesArray = ["Expanded item one", "Expanded item two","Expanded item three","Expanded item four","Expanded item five","Expanded item six","Expanded item seven","Expanded item eight","Expanded item nine","Expanded item ten"]
}

enum TitleConfig: String {
    case formularTitle = "Formulare"
    case processTitle = "prozesse"
    
}

struct Storyboards {
    static let Main =  "Main"
}






