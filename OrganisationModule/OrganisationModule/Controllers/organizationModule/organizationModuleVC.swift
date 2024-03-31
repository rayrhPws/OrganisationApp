//
//  organizationModuleVC.swift
//  OrganisationModule
//
//  Created by Arif ww on 18/03/2024.
//

import UIKit
import WebKit
import Alamofire
struct ExpandedModel {
    var title: String
    var htmlStr: String
    var isExpanded: Bool = false
    
}

class organizationModuleVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var lblTest: UILabel!
    var cellHeights: [IndexPath: CGFloat] = [:]
    var webViewDummyArry = [ExpandedModel]()
    
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
                    self.webViewDummyArry.append(ExpandedModel(title: response.singleItem?.bezeichnung ?? "", htmlStr: response.singleItem?.preamble ?? ""))
                }
                
                if response.singleItem?.voraussetzungen != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title 1", htmlStr: response.singleItem?.voraussetzungen ?? ""))
                }
                
                if response.singleItem?.verfahrensablauf != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title3", htmlStr: response.singleItem?.verfahrensablauf ?? ""))
                }
                if response.singleItem?.fristen != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title4", htmlStr: response.singleItem?.fristen ?? ""))
                }
                if response.singleItem?.unterlagen != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title5", htmlStr: response.singleItem?.unterlagen ?? ""))
                }
                if response.singleItem?.kosten != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title6", htmlStr: response.singleItem?.kosten ?? ""))
                }
                if response.singleItem?.sonstiges != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title7", htmlStr: response.singleItem?.sonstiges ?? ""))
                }
                if response.singleItem?.rechtsgrundlage != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title8", htmlStr: response.singleItem?.rechtsgrundlage ?? ""))
                }
                if response.singleItem?.bearbeitungsdauer != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title9", htmlStr: response.singleItem?.bearbeitungsdauer ?? ""))
                }
                if response.singleItem?.zustaendigkeit != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title10", htmlStr: response.singleItem?.zustaendigkeit ?? ""))
                }
                if response.singleItem?.vertiefende_informationen != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title11", htmlStr: response.singleItem?.vertiefende_informationen ?? ""))
                }
                
                if response.singleItem?.freigabevermerk != nil{
                    self.webViewDummyArry.append(ExpandedModel(title: "title12", htmlStr: response.singleItem?.freigabevermerk ?? ""))
                }
                
                
                
                
                self.tblView.reloadData()
                self.tblView.layoutIfNeeded()
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
        }
        
    }
    
    func registerXibs() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        tblView.register(UINib.init(nibName: "WebViewTblCell", bundle: nil), forCellReuseIdentifier: "WebViewTblCell")
        tblView.register(UINib.init(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        
        tblView.estimatedSectionHeaderHeight = 30
        tblView.sectionHeaderHeight = UITableView.automaticDimension
        

        self.tblView.layoutIfNeeded()
        
    }
    
    
}
extension organizationModuleVC:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebViewTblCell") as! WebViewTblCell
        cell.selectionStyle = .none
        cell.viewWK.scrollView.isScrollEnabled = false
        cell.viewWK.navigationDelegate = self
        
        cell.viewWK.scrollView.bounces = false
        cell.viewWK.isUserInteractionEnabled = false
        cell.viewWK.contentMode = .scaleToFill
        let headString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        
        cell.viewWK.loadHTMLString(headString + self.webViewDummyArry[indexPath.section].htmlStr, baseURL: nil)
        return cell
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("web view loaded")
        guard let indexPath = indexPathForWebView(webView) else { return }
        if !self.webViewDummyArry[indexPath.section].isExpanded{
            // Calculate the height of the cell based on the content size of the WKWebView
            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                if complete != nil {
                    webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
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
        
        if self.webViewDummyArry[indexPath.section].isExpanded{
            if let height = cellHeights[indexPath] {
                print("index path section  \(indexPath.section) and row is \(indexPath.row)")
                return height
            }
            return 20
        }
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.webViewDummyArry.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        print("section \(section) expended is \(webViewDummyArry[section].isExpanded)")
        if section == 0{
            headerCell.lblTitle.text = webViewDummyArry[section].title
        }else{
            headerCell.lblTitle.text = "section \(section)"
        }
        
        
        if webViewDummyArry[section].isExpanded{
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
    
    @objc func headerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let section = gestureRecognizer.view?.tag else { return }
        
        self.webViewDummyArry[section].isExpanded = !self.webViewDummyArry[section].isExpanded
        let indexPathsToRefresh = [IndexPath(row: 0, section: section), ]
        
//        tblView.reloadRows(at: indexPathsToRefresh, with: .automatic)
        tblView.reloadSections(IndexSet(integer: section), with: .automatic)
        
     
    }
}

