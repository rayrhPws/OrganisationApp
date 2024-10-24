//
//  SecondApproachTestVC.swift
//  OrganisationModule
//
//  Created by Arif on 21/10/2024.
//

import UIKit
import WebKit
import Alamofire

class secondApproachTestVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let network = NetworkManager()
    var detailArray = [ExpandedModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register cells
        collectionView.register(UINib(nibName: secondApproachTestVCCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: secondApproachTestVCCollCell.identifier)
        collectionView.register(UINib(nibName: SeparatorCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: SeparatorCollCell.identifier)
        collectionView.register(UINib(nibName: DynamicHeightCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: DynamicHeightCollCell.identifier)
        collectionView.register(UINib(nibName: HeaderCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: HeaderCollCell.identifier)

        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        getDetailFromServer()
    }

    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDetailFromServer() {
        network.request("",
                        encoding: JSONEncoding.default,
                        modelType: JsonModel.self) { result in
            if let response = result as? JsonModel {
                print(response.singleItem?.preamble as Any)
                
                if response.singleItem?.preamble != nil {
                    self.detailArray.append(ExpandedModel(title: response.singleItem?.bezeichnung ?? "", htmlStr: response.singleItem?.preamble ?? "", type: .webview))
                }
                if let formularArr = response.singleItem?.formulare, !formularArr.isEmpty {
                    var expandedModelArr = [ExpandedModel]()
                    for obj in formularArr {
                        expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: .dynamicheight))
                    }
                    self.detailArray.append(ExpandedModel(title: TitleConfig.formular.rawValue, htmlStr: "", type: .title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                }
                
                if let processArr = response.singleItem?.prozesse, !processArr.isEmpty {
                    var expandedModelArr = [ExpandedModel]()
                    for obj in processArr {
                        expandedModelArr.append(ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: .dynamicheight))
                    }
                    self.detailArray.append(ExpandedModel(title: TitleConfig.process.rawValue, htmlStr: "", type: .title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                }
                
                self.addSeparatorIfNeeded()
                
                if response.singleItem?.voraussetzungen != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title1.rawValue, htmlStr: response.singleItem?.voraussetzungen ?? "", type: .webview))
                }
                if response.singleItem?.verfahrensablauf != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title2.rawValue, htmlStr: response.singleItem?.verfahrensablauf ?? "", type: .webview))
                }
                if response.singleItem?.fristen != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title3.rawValue, htmlStr: response.singleItem?.fristen ?? "", type: .webview))
                }
                if response.singleItem?.unterlagen != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title4.rawValue, htmlStr: response.singleItem?.unterlagen ?? "", type: .webview))
                }
                if response.singleItem?.kosten != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title5.rawValue, htmlStr: response.singleItem?.kosten ?? "", type: .webview))
                }
                if response.singleItem?.sonstiges != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title6.rawValue, htmlStr: response.singleItem?.sonstiges ?? "", type: .webview))
                }
                if response.singleItem?.rechtsgrundlage != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title7.rawValue, htmlStr: response.singleItem?.rechtsgrundlage ?? "", type: .webview))
                }
                if response.singleItem?.bearbeitungsdauer != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title8.rawValue, htmlStr: response.singleItem?.bearbeitungsdauer ?? "", type: .webview))
                }
                if response.singleItem?.zustaendigkeit != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title9.rawValue, htmlStr: response.singleItem?.zustaendigkeit ?? "", type: .webview))
                }
                if response.singleItem?.vertiefende_informationen != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title10.rawValue, htmlStr: response.singleItem?.vertiefende_informationen ?? "", type: .webview))
                }
                if response.singleItem?.freigabevermerk != nil {
                    self.detailArray.append(ExpandedModel(title: TitleConfig.title11.rawValue, htmlStr: response.singleItem?.freigabevermerk ?? "", type: .webview))
                }
                
                self.collectionView.reloadData()
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
        }
    }
    
    func addSeparatorIfNeeded() {
        let contains = self.detailArray.contains { $0.htmlStr == "" }
        if contains {
            self.detailArray.append(ExpandedModel(title: TitleConfig.separtor.rawValue, htmlStr: "", type: .separator))
        }
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension secondApproachTestVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.detailArray[indexPath.row]
        
        switch item.type {
        case .dynamicheight:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicHeightCollCell.identifier, for: indexPath) as! DynamicHeightCollCell
            cell.lblTitle.text = item.title
            return cell
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollCell", for: indexPath) as! HeaderCollCell
            cell.lblTitle.text = item.title
            return cell
        case .webview:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondApproachTestVCCollCell.identifier, for: indexPath) as! secondApproachTestVCCollCell
            cell.delegate = self
            cell.configure(with: item)
            return cell
        case .separator:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeparatorCollCell.identifier, for: indexPath) as! SeparatorCollCell
            return cell
        }
    }
}

// MARK: - SecondApproachTestVCCollCellDelegate

extension secondApproachTestVC: SecondApproachTestVCCollCellDelegate {
    func webViewDidFinishLoading(_ cell: secondApproachTestVCCollCell,height: CGFloat) {
        if let indexPath = collectionView.indexPath(for: cell) {
            var item = detailArray[indexPath.row]
            item.height = height
            item.isLoaded = true
            detailArray[indexPath.row] = item
            collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
    
    func didTapTitleLabel(_ cell: secondApproachTestVCCollCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            var item = detailArray[indexPath.row]
            item.isExpanded = !item.isExpanded
            detailArray[indexPath.row] = item
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

