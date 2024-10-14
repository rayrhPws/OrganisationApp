//
//  secondApproachTestVC.swift
//  OrganisationModule
//
//  Created by Arif on 19/09/2024.
//

import UIKit
import WebKit
import Alamofire
struct dummyObjecttt {
    var title : String
    var des:String
    var htmlString: String
    
}




class secondApproachTestVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var tblView: UITableView!
    
    let network = NetworkManager()
    var detailArray = [ExpandedModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
        
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        tblView.register(secondApproachTestVCTableViewCell.nib(), forCellReuseIdentifier: secondApproachTestVCTableViewCell.identifier)
        tblView.register(SeparatorTblCell.nib(), forCellReuseIdentifier: SeparatorTblCell.identifier)
        tblView.register(DynamicHeightCell.nib(), forCellReuseIdentifier: DynamicHeightCell.identifier)
        tblView.register(HeaderCell.nib(), forCellReuseIdentifier: HeaderCell.identifier)
        
        self.getDetailFromServer()
    }
    
    @IBAction func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func getDetailFromServer(){
        network.request("",
                        encoding: JSONEncoding.default,
                        modelType: JsonModel.self
        ) { result in
            if let response = result as? JsonModel{
                print(response.singleItem?.preamble as Any)
                
                if response.singleItem?.preamble != nil{
                    self.detailArray.append(ExpandedModel(title: response.singleItem?.bezeichnung ?? "", htmlStr: response.singleItem?.preamble ?? "", type: ExpandedModelType.webview))
                }
                
                if response.singleItem?.formulare != nil && response.singleItem?.formulare?.count ?? 0 > 0{
                    var expandedModelArr = [ExpandedModel]()
                    if let formularArr = response.singleItem?.formulare{
                        for obj in formularArr{
                            expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: ExpandedModelType.dynamicheight))
                        }
                    }
                    
                    self.detailArray.append(ExpandedModel(title: TitleConfig.formular.rawValue, htmlStr: "", type: ExpandedModelType.title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                    
                }
                
                if response.singleItem?.prozesse != nil && response.singleItem?.prozesse?.count ?? 0 > 0{
                    var expandedModelArr = [ExpandedModel]()
                    if let formularArr = response.singleItem?.prozesse{
                        for obj in formularArr{
                            expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: ExpandedModelType.dynamicheight))
                        }
                    }
                    
                    self.detailArray.append(ExpandedModel(title: TitleConfig.process.rawValue, htmlStr: "", type: ExpandedModelType.title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                    
                }
                
                self.addSeparatorIfNeeded()
                
                if response.singleItem?.voraussetzungen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title1.rawValue, htmlStr: response.singleItem?.voraussetzungen ?? "", type: ExpandedModelType.webview))
                }
                
                if response.singleItem?.verfahrensablauf != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title2.rawValue, htmlStr: response.singleItem?.verfahrensablauf ?? "", type: ExpandedModelType.webview))
                    
                }
                if response.singleItem?.fristen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title3.rawValue, htmlStr: response.singleItem?.fristen ?? "", type: ExpandedModelType.webview))
                    
                }
                if response.singleItem?.unterlagen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title4.rawValue, htmlStr: response.singleItem?.unterlagen ?? "", type: ExpandedModelType.webview))
                    
                }
                if response.singleItem?.kosten != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title5.rawValue, htmlStr: response.singleItem?.kosten ?? "", type: ExpandedModelType.webview))
                }
                if response.singleItem?.sonstiges != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title6.rawValue, htmlStr: response.singleItem?.sonstiges ?? "", type: ExpandedModelType.webview))
                }
                if response.singleItem?.rechtsgrundlage != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title7.rawValue, htmlStr: response.singleItem?.rechtsgrundlage ?? "", type: ExpandedModelType.webview))
                }
                if response.singleItem?.bearbeitungsdauer != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title8.rawValue, htmlStr: response.singleItem?.bearbeitungsdauer ?? "", type: ExpandedModelType.webview))
                }
                if response.singleItem?.zustaendigkeit != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title9.rawValue, htmlStr: response.singleItem?.zustaendigkeit ?? "", type: ExpandedModelType.webview))
                }
                if response.singleItem?.vertiefende_informationen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title10.rawValue, htmlStr: response.singleItem?.vertiefende_informationen ?? "", type: ExpandedModelType.webview))
                }
                
                if response.singleItem?.freigabevermerk != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title11.rawValue, htmlStr: response.singleItem?.freigabevermerk ?? "", type: ExpandedModelType.webview))
                }
                

                self.tblView.reloadData()
//                self.tblView.layoutIfNeeded()
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
        }
        
    }
    
    func addSeparatorIfNeeded(){
        let contains = self.detailArray.contains { $0.htmlStr == "" }
        if contains{
            self.detailArray.append(ExpandedModel(title: TitleConfig.separtor.rawValue, htmlStr: "", type: ExpandedModelType.separator))
        }
    }
    
}
extension secondApproachTestVC:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.detailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.detailArray[indexPath.row]
        switch item.type {
        case .dynamicheight:
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicHeightCell.identifier) as! DynamicHeightCell
            cell.lblTitle.text = item.title
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            cell.lblTitle.text = item.title
            return cell
        case .webview:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondApproachTestVCTableViewCell.identifier) as! secondApproachTestVCTableViewCell
         
            cell.lbl1.text = item.title
            
            
            cell.selectionStyle = .none
            cell.viewWK.scrollView.isScrollEnabled = false
            cell.viewWK.navigationDelegate = self
            cell.viewWK.scrollView.bounces = false
            cell.viewWK.isUserInteractionEnabled = true
            cell.viewWK.contentMode = .scaleToFill
            let headString = Constants.shared.constHeaderStringForWebView
            
            
            if item.htmlStr != "" {
                // Set tag to identify which row's webView is loading
                cell.viewWK.tag = indexPath.row
                
                if item.isExpanded{
                    cell.imgArrow.image = UIImage(named: "up")
                    cell.viewWK.loadHTMLString(headString + item.htmlStr, baseURL: nil)
                    if item.isLoaded{
                        cell.webkitHeight.constant = item.height
                    }
                    
                }else{
                    cell.imgArrow.image = UIImage(named: "down")
                    cell.webkitHeight.constant = 0
//                    cell.viewWK.loadHTMLString("", baseURL: nil)
                }
                
            } else {
//                cell.viewWK.loadHTMLString("", baseURL: nil)
                cell.webkitHeight.constant = 0
            }
            
            
            
            return cell
        case .separator:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: SeparatorTblCell.identifier) as! SeparatorTblCell
            return headerCell
        default:
            return UITableViewCell()
        }
        

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.detailArray[indexPath.row]
        switch item.type {
        case .dynamicheight:
            print("do nothing")
        case .title:
            print("do nothing")
        case .webview:
            detailArray[indexPath.row].isExpanded.toggle()
            if self.detailArray[indexPath.row].isLoaded{
                let cell = tableView.cellForRow(at: indexPath) as! secondApproachTestVCTableViewCell
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    if self.detailArray[indexPath.row].isExpanded {
                        cell.webkitHeight.constant = self.detailArray[indexPath.row].height
                        cell.imgArrow.image = UIImage(named: "up")
                    } else {
                        cell.webkitHeight.constant = 0
                        cell.imgArrow.image = UIImage(named: "down")
                    }
                    tableView.endUpdates()
                }
            }else{
                UIView.performWithoutAnimation {
                    print("index path is \(indexPath.row) and its expanded is \(detailArray[indexPath.row].isExpanded)")
                    self.tblView.reloadRows(at: [indexPath], with: .automatic)
                }
                
            }
            
            
            
           
            
            
        default:
            print("do nothing")
        }
        

        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let row = webView.tag

        // Inject CSS to ensure no margins or padding affect the height calculation
        let cssString = "body { margin: 0; padding: 0; }"
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        webView.evaluateJavaScript(jsString, completionHandler: nil)
        
        // Calculate the web content height dynamically using a more accurate JS
        let contentHeightJS = """
            Math.max(document.body.scrollHeight, document.documentElement.scrollHeight,
            document.body.offsetHeight, document.documentElement.offsetHeight,
            document.body.clientHeight, document.documentElement.clientHeight)
        """
        
        webView.evaluateJavaScript(contentHeightJS) { [weak self] result, error in
            guard let self = self, let height = result as? CGFloat, error == nil else {
                return
            }
            
            // Update the corresponding dummy list item with the new height
            if row < self.detailArray.count {
                if let cell = self.tblView.cellForRow(at: IndexPath(row: row, section: 0)) as? secondApproachTestVCTableViewCell {
                    
                    if !self.detailArray[row].isLoaded{
                        cell.webkitHeight.constant = height
                        self.detailArray[row].isLoaded = true
                        self.detailArray[row].height = height
//                        cell.layoutIfNeeded() // Ensure immediate application of height change
//                        
//                        // Animate the table view's layout update
//                        UIView.animate(withDuration: 0.3) {
//                            self.tblView.beginUpdates()
//                            self.tblView.endUpdates()
//                        }
                    }
                    
                    
                }
            }
        }
    }
    
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // Get the row index of the webView that finished loading
//        let row = webView.tag
//        
//        // Calculate the height of the web content dynamically
//        
//        
//        
//        
//        
//        webView.evaluateJavaScript(Constants.shared.constDocScrollHeight) { [weak self] result, error in
//            guard let self = self, let height = result as? CGFloat, error == nil else {
//                return
//            }
//            
//            // Update the corresponding dummy list item with the new height
//            if row < self.detailArray.count {
//                if let cell = self.tblView.cellForRow(at: IndexPath(row: row, section: 0)) as? secondApproachTestVCTableViewCell {
//                    cell.webkitHeight.constant = height
//                    cell.layoutIfNeeded()
//                    UIView.animate(withDuration: 0.3) {
//                        self.tblView.beginUpdates()
//                        self.tblView.endUpdates()
//                    }
//                }
//            }
//        }
//    }
    

    
    
    
    
    
}




