//
//  organizationModuleVC.swift
//  OrganisationModule
//
//  Created by Arif ww on 18/03/2024.
//

import UIKit
import WebKit
import Alamofire


class organizationModuleVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var lblTest: UILabel!
    var cellHeights: [IndexPath: CGFloat] = [:]
    var detailArray = [ExpandedModel]()
    var testhtml1 = ""
    var testhtml2 = ""
    
    @IBOutlet weak var tblView: IntrinsicallySizedTableView!
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerXibs()
        self.getDetailFromServer()

    }
    
    func getDetailFromServer(){
        network.request("",
                        encoding: JSONEncoding.default,
                        modelType: JsonModel.self
        ) { result in
            if let response = result as? JsonModel{
                print(response.singleItem?.preamble as Any)
                
                if response.singleItem?.preamble != nil{
                    self.detailArray.append(ExpandedModel(title: response.singleItem?.bezeichnung ?? "", htmlStr: response.singleItem?.preamble ?? ""))
                }
                
                if response.singleItem?.formulare != nil && response.singleItem?.formulare?.count ?? 0 > 0{
                    var expandedModelArr = [ExpandedModel]()
                    if let formularArr = response.singleItem?.formulare{
                        for obj in formularArr{
                            expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? ""))
                        }
                    }
                    
                    self.detailArray.append(ExpandedModel(title: TitleConfig.formular.rawValue, htmlStr: "", nestedArray: expandedModelArr))
                }
                
                if response.singleItem?.prozesse != nil && response.singleItem?.prozesse?.count ?? 0 > 0{
                    var expandedModelArr = [ExpandedModel]()
                    if let formularArr = response.singleItem?.prozesse{
                        for obj in formularArr{
                            expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? ""))
                        }
                    }
                    
                    self.detailArray.append(ExpandedModel(title: TitleConfig.process.rawValue, htmlStr: "", nestedArray: expandedModelArr))
                    
                }
                
                self.addSeparatorIfNeeded()
                
                if response.singleItem?.voraussetzungen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title1.rawValue, htmlStr: response.singleItem?.voraussetzungen ?? ""))
                }
                
                if response.singleItem?.verfahrensablauf != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title2.rawValue, htmlStr: response.singleItem?.verfahrensablauf ?? ""))
                    self.testhtml1 =  response.singleItem?.verfahrensablauf ?? ""
                }
                if response.singleItem?.fristen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title3.rawValue, htmlStr: response.singleItem?.fristen ?? ""))
                    self.testhtml2 =  response.singleItem?.fristen ?? ""
                }
                if response.singleItem?.unterlagen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title4.rawValue, htmlStr: response.singleItem?.unterlagen ?? ""))
                    
                }
                if response.singleItem?.kosten != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title5.rawValue, htmlStr: response.singleItem?.kosten ?? ""))
                }
                if response.singleItem?.sonstiges != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title6.rawValue, htmlStr: response.singleItem?.sonstiges ?? ""))
                }
                if response.singleItem?.rechtsgrundlage != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title7.rawValue, htmlStr: response.singleItem?.rechtsgrundlage ?? ""))
                }
                if response.singleItem?.bearbeitungsdauer != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title8.rawValue, htmlStr: response.singleItem?.bearbeitungsdauer ?? ""))
                }
                if response.singleItem?.zustaendigkeit != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title9.rawValue, htmlStr: response.singleItem?.zustaendigkeit ?? ""))
                }
                if response.singleItem?.vertiefende_informationen != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title10.rawValue, htmlStr: response.singleItem?.vertiefende_informationen ?? ""))
                }
                
                if response.singleItem?.freigabevermerk != nil{
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title11.rawValue, htmlStr: response.singleItem?.freigabevermerk ?? ""))
                }
                
                
                
                
                self.tblView.reloadData()
                self.tblView.layoutIfNeeded()
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
        }
        
    }
    
    func addSeparatorIfNeeded(){
        let contains = self.detailArray.contains { $0.htmlStr == "" }
        if contains{
            self.detailArray.append(ExpandedModel(title: TitleConfig.separtor.rawValue, htmlStr: ""))
        }
    }
    
    func registerXibs() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        tblView.register(WebViewTblCell.nib(), forCellReuseIdentifier: WebViewTblCell.identifier)
        tblView.register(DynamicHeightCell.nib(), forCellReuseIdentifier: DynamicHeightCell.identifier)
        tblView.register(HeaderCell.nib(), forCellReuseIdentifier: HeaderCell.identifier)
        tblView.register(SeparatorTblCell.nib(), forCellReuseIdentifier: SeparatorTblCell.identifier)
        
        tblView.estimatedSectionHeaderHeight = 30
        tblView.sectionHeaderHeight = UITableView.automaticDimension
        
        self.tblView.layoutIfNeeded()
        
    }
    @IBAction func testButon(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let secondVC = storyboard.instantiateViewController(withIdentifier: "secondApproachTestVC") as? secondApproachTestVC {
                    
                    
                    self.navigationController?.pushViewController(secondVC, animated: true)
                }
    }
    
}
extension organizationModuleVC:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.detailArray[section].htmlStr.elementsEqual(""){
            return self.detailArray[section].nestedArray?.count ?? 0
           
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.detailArray[indexPath.section].htmlStr.elementsEqual(""){
            let cell = tableView.dequeueReusableCell(withIdentifier: DynamicHeightCell.identifier) as! DynamicHeightCell
            cell.lblTitle.text = self.detailArray[indexPath.section].nestedArray?[indexPath.row].title
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: WebViewTblCell.identifier) as! WebViewTblCell
            cell.selectionStyle = .none
            cell.viewWK.scrollView.isScrollEnabled = false
            cell.viewWK.navigationDelegate = self
            cell.viewWK.scrollView.bounces = false
            cell.viewWK.isUserInteractionEnabled = true
            cell.viewWK.contentMode = .scaleToFill
            let headString = Constants.shared.constHeaderStringForWebView
            cell.viewWK.loadHTMLString(headString + self.detailArray[indexPath.section].htmlStr, baseURL: nil)
            return cell
        }
        
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("web view loaded")
        guard let indexPath = indexPathForWebView(webView) else { return }
        if self.detailArray[indexPath.section].htmlStr.elementsEqual(""){
           print("not a web view section")
        }else{
            if !self.detailArray[indexPath.section].isExpanded{
                // Calculate the height of the cell based on the content size of the WKWebView
                webView.evaluateJavaScript(Constants.shared.constDocReadyState, completionHandler: { (complete, error) in
                    if complete != nil {
                        webView.evaluateJavaScript(Constants.shared.constDocScrollHeight, completionHandler: { (height, error) in
                            print(height as! CGFloat)
                            self.cellHeights[indexPath] = (height as? CGFloat ?? 0.0) + 40.0
                            print(self.cellHeights)
                            print("")

                            // Reload the corresponding cell to update its height


                        })
                    }

                })
            }
        }


    }
    

    


    private func indexPathForWebView(_ webView: WKWebView) -> IndexPath? {
        
        let point = CGPoint(x: webView.bounds.midX, y: webView.bounds.midY)
        if let indexPath = tblView.indexPathForRow(at: webView.convert(point, to: tblView)) {
            print(indexPath.section)
            return indexPath
        }
        return nil
        
        
    }
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.detailArray[indexPath.section].htmlStr.elementsEqual(""){
           print("not a web view section")
            return UITableView.automaticDimension
        }else{
            if self.detailArray[indexPath.section].isExpanded{
                if let height = cellHeights[indexPath] {
                    print("index path section  \(indexPath.section) and row is \(indexPath.row)")
                    return height
                }
                return 20
            }
            return 20
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.detailArray[section].title.elementsEqual(TitleConfig.separtor.rawValue){
            return 50
        }
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.detailArray[section].title.elementsEqual(TitleConfig.separtor.rawValue){
            let headerCell = tableView.dequeueReusableCell(withIdentifier: SeparatorTblCell.identifier) as! SeparatorTblCell
            headerCell.contentView.tag = section
            return headerCell.contentView
        }else{
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            print("section \(section) expended is \(detailArray[section].isExpanded)")
            
            headerCell.lblTitle.text = detailArray[section].title
            
            if detailArray[section].isExpanded{
                headerCell.imgArrow.image = UIImage(named: "up")
            }else{
                headerCell.imgArrow.image = UIImage(named: "down")
            }

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
            headerCell.contentView.addGestureRecognizer(tapGestureRecognizer)
                
                // Set section as tag to identify which section header was tapped
            headerCell.contentView.tag = section
                
            return headerCell.contentView
        }
        
    }
    
    @objc func headerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else { return }
        if self.detailArray[section].htmlStr.elementsEqual(""){
            print("not tapable")
        }else{
            let contentOffset = tblView.contentOffset
            self.detailArray[section].isExpanded = !self.detailArray[section].isExpanded
            let indexPathsToRefresh = [IndexPath(row: 0, section: section), ]
            
    //      tblView.reloadRows(at: indexPathsToRefresh, with: .automatic)
            
            tblView.reloadSections(IndexSet(integer: section), with: .none)
//            tblView.reloadData()
//            tblView.scrollToRow(at: indexPathsToRefresh[0], at: .top, animated: true)
            
        }
        
        
        
     
    }
}


