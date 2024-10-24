import UIKit
import WebKit

protocol SecondApproachTestVCCollCellDelegate: AnyObject {
    func webViewDidFinishLoading(_ cell: secondApproachTestVCCollCell, height: CGFloat)
    func didTapTitleLabel(_ cell: secondApproachTestVCCollCell)
}

class secondApproachTestVCCollCell: UICollectionViewCell, WKNavigationDelegate {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var webkitHeight: NSLayoutConstraint!
    @IBOutlet weak var viewWK: WKWebView!
    
    weak var delegate: SecondApproachTestVCCollCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewWK.navigationDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelTapped))
        lbl1.isUserInteractionEnabled = true
        lbl1.addGestureRecognizer(tapGesture)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewWK.navigationDelegate = self
        viewWK.stopLoading()
        viewWK.loadHTMLString("", baseURL: nil)
        webkitHeight.constant = 0
    }
    
    @objc func titleLabelTapped() {
        delegate?.didTapTitleLabel(self)
    }
    
    func configure(with item: ExpandedModel) {
        lbl1.text = item.title
        viewWK.scrollView.isScrollEnabled = false
        viewWK.scrollView.bounces = false
        viewWK.isUserInteractionEnabled = true
        viewWK.contentMode = .scaleToFill
        let headString = Constants.shared.constHeaderStringForWebView

        if item.htmlStr != "" {
            if item.isExpanded {
                imgArrow.image = UIImage(named: "up")
                viewWK.loadHTMLString(headString + item.htmlStr, baseURL: nil)
                if item.isLoaded {
                    webkitHeight.constant = item.height
                }
            } else {
                imgArrow.image = UIImage(named: "down")
                webkitHeight.constant = 0
                viewWK.loadHTMLString("", baseURL: nil)
            }
        } else {
            viewWK.loadHTMLString("", baseURL: nil)
            webkitHeight.constant = 0
        }
    }
    
    // MARK: - WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState") { [weak self] (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] (height, error) in
                    if let self = self, let height = height as? CGFloat {
                        self.webkitHeight.constant = height
                        self.delegate?.webViewDidFinishLoading(self, height: height)
                    }
                }
            }
        }
    }
}

