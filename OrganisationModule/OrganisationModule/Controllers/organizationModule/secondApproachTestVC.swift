//
//  secondApproachTestVC.swift
//  OrganisationModule
//
//  Created by Arif on 19/09/2024.
//

import UIKit
import WebKit
struct dummyObjecttt {
    var title : String
    var des:String
    var htmlString: String
    
}




class secondApproachTestVC: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var tblView: UITableView!
    var dumylist = [dummyObjecttt]()
    var html1 = ""
    var html2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 100
        
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        tblView.register(secondApproachTestVCTableViewCell.nib(), forCellReuseIdentifier: secondApproachTestVCTableViewCell.identifier)
        configureData()
    }
    func configureData(){
        var obj = dummyObjecttt(title: "title", des: "des", htmlString: self.html1)
        var obj2 = dummyObjecttt(title: "title2", des: "des", htmlString: self.html2)
        self.dumylist.append(obj)
        self.dumylist.append(obj2)
        self.dumylist.append(obj)
        
    }
    @IBAction func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension secondApproachTestVC:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dumylist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: secondApproachTestVCTableViewCell.identifier) as! secondApproachTestVCTableViewCell
        let item = self.dumylist[indexPath.row]
        cell.lbl1.text = item.title
        cell.lbl2.text = "des"
        
        cell.selectionStyle = .none
        cell.viewWK.scrollView.isScrollEnabled = false
        cell.viewWK.navigationDelegate = self
        cell.viewWK.scrollView.bounces = false
        cell.viewWK.isUserInteractionEnabled = true
        cell.viewWK.contentMode = .scaleToFill
        let headString = Constants.shared.constHeaderStringForWebView
        
        
        
        if item.htmlString != "" {
            // Set tag to identify which row's webView is loading
            cell.viewWK.tag = indexPath.row
            cell.viewWK.loadHTMLString(headString + self.dumylist[indexPath.row].htmlString, baseURL: nil)
        } else {
            cell.viewWK.loadHTMLString("", baseURL: nil)
            cell.webkitHeight.constant = 0
        }
        
        
        
        return cell
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let des = self.dumylist[indexPath.row].des
        if des == "des" {
            self.dumylist[indexPath.row].des = "Dynamic content loaded..."
            self.dumylist[indexPath.row].htmlString = self.html1
        } else {
            self.dumylist[indexPath.row].des = "des"
            self.dumylist[indexPath.row].htmlString = ""
        }
        
        // Reload the specific row
        self.tblView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Get the row index of the webView that finished loading
        let row = webView.tag
        
        // Calculate the height of the web content dynamically
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] result, error in
            guard let self = self, let height = result as? CGFloat, error == nil else {
                return
            }
            
            // Update the corresponding dummy list item with the new height
            if row < self.dumylist.count {
                if let cell = self.tblView.cellForRow(at: IndexPath(row: row, section: 0)) as? secondApproachTestVCTableViewCell {
                    cell.webkitHeight.constant = height
                    UIView.animate(withDuration: 0.3) {
                        self.tblView.beginUpdates()
                        self.tblView.endUpdates()
                    }
                }
            }
        }
    }
    
    
    
    
    
}
