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
    
    // MARK: - Configuration
    /// Set this to `true` to expand all cells by default, or `false` to keep them collapsed.
    let ExpandAllByDefault = false

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
                        modelType: JsonModel.self) { [weak self] result in
            guard let self = self else { return }
            if let response = result as? JsonModel {
                print(response.singleItem?.preamble as Any)
                
                if response.singleItem?.preamble != nil {
                    var model = ExpandedModel(title: response.singleItem?.bezeichnung ?? "", htmlStr: response.singleItem?.preamble ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if let formularArr = response.singleItem?.formulare, !formularArr.isEmpty {
                    var expandedModelArr = [ExpandedModel]()
                    for obj in formularArr {
                        var model = ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: .dynamicheight)
                        if self.ExpandAllByDefault {
                            model.isExpanded = true
                            model.isLoaded = true
                        }
                        expandedModelArr.append(model)
                    }
                    self.detailArray.append(ExpandedModel(title: TitleConfig.formular.rawValue, htmlStr: "", type: .title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                }
                
                if let processArr = response.singleItem?.prozesse, !processArr.isEmpty {
                    var expandedModelArr = [ExpandedModel]()
                    for obj in processArr {
                        var model = ExpandedModel(title: obj.bezeichnung ?? "", htmlStr: obj.url ?? "", type: .dynamicheight)
                        if self.ExpandAllByDefault {
                            model.isExpanded = true
                            model.isLoaded = true
                        }
                        expandedModelArr.append(model)
                    }
                    self.detailArray.append(ExpandedModel(title: TitleConfig.process.rawValue, htmlStr: "", type: .title))
                    self.detailArray.append(contentsOf: expandedModelArr)
                }
                
                self.addSeparatorIfNeeded()
                
                if response.singleItem?.voraussetzungen != nil {
                    var model = ExpandedModel(title: TitleConfig.title1.rawValue, htmlStr: response.singleItem?.voraussetzungen ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.verfahrensablauf != nil {
                    var model = ExpandedModel(title: TitleConfig.title2.rawValue, htmlStr: response.singleItem?.verfahrensablauf ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.fristen != nil {
                    var model = ExpandedModel(title: TitleConfig.title3.rawValue, htmlStr: response.singleItem?.fristen ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.unterlagen != nil {
                    var model = ExpandedModel(title: TitleConfig.title4.rawValue, htmlStr: response.singleItem?.unterlagen ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.kosten != nil {
                    var model = ExpandedModel(title: TitleConfig.title5.rawValue, htmlStr: response.singleItem?.kosten ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.sonstiges != nil {
                    var model = ExpandedModel(title: TitleConfig.title6.rawValue, htmlStr: response.singleItem?.sonstiges ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.rechtsgrundlage != nil {
                    var model = ExpandedModel(title: TitleConfig.title7.rawValue, htmlStr: response.singleItem?.rechtsgrundlage ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.bearbeitungsdauer != nil {
                    var model = ExpandedModel(title: TitleConfig.title8.rawValue, htmlStr: response.singleItem?.bearbeitungsdauer ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.zustaendigkeit != nil {
                    var model = ExpandedModel(title: TitleConfig.title9.rawValue, htmlStr: response.singleItem?.zustaendigkeit ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.vertiefende_informationen != nil {
                    var model = ExpandedModel(title: TitleConfig.title10.rawValue, htmlStr: response.singleItem?.vertiefende_informationen ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
                }
                if response.singleItem?.freigabevermerk != nil {
                    var model = ExpandedModel(title: TitleConfig.title11.rawValue, htmlStr: response.singleItem?.freigabevermerk ?? "", type: .webview)
                    if self.ExpandAllByDefault {
                        model.isExpanded = true
                        model.isLoaded = true
                    }
                    self.detailArray.append(model)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollCell.identifier, for: indexPath) as! HeaderCollCell
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
    func webViewDidFinishLoading(_ cell: secondApproachTestVCCollCell, height: CGFloat) {
           if let indexPath = collectionView.indexPath(for: cell) {
               var item = detailArray[indexPath.row]
               item.height = height
               item.isLoaded = true
               detailArray[indexPath.row] = item
               UIView.performWithoutAnimation {
                   collectionView.performBatchUpdates(nil, completion: nil)
               }
           }
       }
    
    func didTapTitleLabel(_ cell: secondApproachTestVCCollCell) {
            if let indexPath = collectionView.indexPath(for: cell) {
                var item = detailArray[indexPath.row]
                item.isExpanded = !item.isExpanded
                detailArray[indexPath.row] = item

                UIView.performWithoutAnimation {
                    collectionView.performBatchUpdates({
                        collectionView.reloadItems(at: [indexPath])
                    }, completion: nil)
                }
            }
        }
}

