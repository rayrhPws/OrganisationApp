//
//  markerDetailSheetVc.swift
//  OrganisationModule
//
//  Created by Arif ww on 08/05/2024.
//

import UIKit
import Alamofire
import AlignedCollectionViewFlowLayout
import SDWebImage
import WebKit

class markerDetailSheetVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , WKNavigationDelegate{
    let network = NetworkManager()
    var markerInfo: Marker!
    var imagesList = [ImageData?]()
    @IBOutlet weak var viewWK: WKWebView!
    
    var categoryList = [Icon]()
    
    @IBOutlet weak var collCategory: IntrinsicCollectionView!
    @IBOutlet weak var webViewHeightConstant : NSLayoutConstraint!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var collViewImage: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupWebView()
        self.setUpCollectionView()
    }
    
    func setUpCollectionView(){
        
        
        collCategory.dataSource = self
        collCategory.delegate = self
        collViewImage.dataSource = self
        collViewImage.delegate = self
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collCategory.collectionViewLayout = alignedFlowLayout
    }
    
    func setupWebView(){
        
        self.viewWK.scrollView.isScrollEnabled = false
        self.viewWK.navigationDelegate = self
        self.viewWK.scrollView.bounces = false
        self.viewWK.isUserInteractionEnabled = true
        self.viewWK.contentMode = .scaleToFill
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let marker = markerInfo{
            self.lblTitle.text = marker.title
            self.getMarkerDetailAndOpenDetailSheet(url: marker.bottomSheetUrl ?? "")
        }
        
    }
    
    
    //    "https://www.schaeferlauf-markgroeningen.de/app-connection-v3-nativ?action=getGeomap2Details&kategorieIds=5&singleItemId=33&cHash=174955d5592826c9e8d1477ba81ca6a6"
    func getMarkerDetailAndOpenDetailSheet(url: String){
        LoaderManager.shared.showLoader(on: self.view)
        network.request(baseUrlType.endPointAsUrl.rawValue,
                        urlFromRequest: url,
                        encoding: JSONEncoding.default,
                        modelType: MarkerDetailModel.self
        ) { result in
            if let response = result as? MarkerDetailModel{
                DispatchQueue.main.async {
                    LoaderManager.shared.hideLoader()
                    self.setupUI(markerinfo: response)
                }
                print(response)
                
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
            DispatchQueue.main.async {
                LoaderManager.shared.hideLoader()
            }
        }
        
    }
    
    func setupUI(markerinfo: MarkerDetailModel){
        if let markerDetail = markerinfo.singleItem{
            if let title = markerDetail.title{
                self.lblTitle.text = title
            }
            
            if let detail = markerDetail.detail{
                let headString = Constants.shared.constHeaderStringForWebView
                self.viewWK.loadHTMLString(headString + detail, baseURL: nil)
                
            }
            if let categoryList = markerDetail.category{
                self.categoryList = categoryList
                self.collCategory.reloadData()
            }
            if let imagesList = markerDetail.imagesList{
                self.imagesList = imagesList
                self.collViewImage.reloadData()
            }
            
        }
        
    }
    
    
}
extension markerDetailSheetVc{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collCategory{
            return self.categoryList.count
        }
        return self.imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollCell.reuseIdentifier, for: indexPath) as! CategoryCollCell
            if  let title = self.categoryList[indexPath.item].title {
                let attributedString = NSAttributedString(string: title, attributes: [
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ])
                
                cell.lblTitle.attributedText = attributedString
            }
            
            
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollCellMarkerDetailImages.reuseIdentifier, for: indexPath) as! CollCellMarkerDetailImages
            
            
            cell.imgMarker.sd_setImage(with: URL(string: self.imagesList[indexPath.item]?.imgUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            
            cell.lblDesc.text = self.imagesList[indexPath.item]?.title
            return cell
        }
        
        
    }
    
    // UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView ==  collCategory{
            if let text = self.categoryList[indexPath.item].title{
                let  width = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]).width + 16
                return CGSize(width: width, height: 44)
            }
            return CGSize(width: 100, height: 44)
        }else{
            return CGSize(width: self.view.frame.width * 0.8, height: 200)
        }
        
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("web view loaded")
        
        
        // Calculate the height of the cell based on the content size of the WKWebView
        webView.evaluateJavaScript(Constants.shared.constDocReadyState, completionHandler: { (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript(Constants.shared.constDocScrollHeight, completionHandler: { [self] (height, error) in
                    print(height as! CGFloat)
                    let height = (height as? CGFloat ?? 0.0) + 40.0
                    //                    assign height to collection view constant
                    webViewHeightConstant.constant = height
                })
            }
            
        })
        
        
        
        
    }
    
    
}
