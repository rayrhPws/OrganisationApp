//
//  MapVc.swift
//  OrganisationModule
//
//  Created by Arif ww on 23/04/2024.
//

import UIKit
import MapKit
import Alamofire
import FontAwesome_swift
import FontAwesomeKit_Swift

class MapVc: UIViewController, MKMapViewDelegate {
    let network = NetworkManager()
    var markers = [marker]()
    @IBOutlet weak var lblTest: UILabel!
    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var viewMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewMap.delegate = self
        
        self.getDataFromServer()
        Utilities.configuringLabelForAewsomeFont(label: self.lblTest, iconName: "bus-school")
        
        imgTest.image = imgTest.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imgTest.tintColor = UIColor.red
        
        
    }
    
    
    
}
//Mark:-
//map part
extension MapVc{
    func getDataFromServer(){
        network.request(baseUrlType.mapBaseUrl.rawValue,
                        encoding: JSONEncoding.default,
                        modelType: MapModel.self
        ) { result in
            if let response = result as? MapModel{
                
                self.markers = response.items ?? [marker]()
                self.addAnnotationForAddingMarkersToMap()
                
            }
        } failure: { error in
            print(error?.localizedDescription as Any)
        }
        
    }
    func addAnnotationForAddingMarkersToMap(){
        
        var annotationArray = [PrimaryAnnotation]()
        for item in markers{
            if let data = item.data, let iconInfor = item.iconInfo{
                let objAnnotation =  PrimaryAnnotation(coordinate: CLLocationCoordinate2D(latitude: data.coords?[0].lat ?? 0.0, longitude: data.coords?[0].lng ?? 0.0), title: item.title, subtitle: "subtitle",  iconString: Utilities.removeFaPrefix(from: iconInfor.iconName ?? "parking"), color: UIColor.named(iconInfor.iconColor ?? "red") ?? .red)
                annotationArray.append(objAnnotation)
                
            }
            
        }
        viewMap.addAnnotations(annotationArray)
        viewMap.showAnnotations(viewMap.annotations, animated: true)
        
    }
    
    //     Optional: Customize the annotation view
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
      // Check if it's a custom annotation
        guard annotation is PrimaryAnnotation else {
            return nil
        }
      
      // Reuse existing annotation view if possible
      let reuseIdentifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
      if annotationView == nil {
        // Create a new annotation view if needed
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
          
      }else{
          annotationView?.annotation = annotation
      }

      annotationView?.canShowCallout = true // Allow callout bubble
        
        annotationView?.image = createViewAsImage( image: (UIImage(named: "marker1")?.imageWithColor(color1: (annotation as? PrimaryAnnotation)?.color ?? .red))!, fontIconStr: (annotation as? PrimaryAnnotation)?.iconString ?? "parking")
        
        
        
        
      return annotationView
    }
    

    
    func createViewAsImage(image: UIImage, fontIconStr: String) -> UIImage? {
      let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        containerView.backgroundColor = .clear

      let imageView = UIImageView(image: image)
      imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
      imageView.contentMode = .scaleAspectFit

      let label = UILabel()
      
      Utilities.configuringLabelForAewsomeFont(label: label, iconName: fontIconStr)
        
      // Center the label horizontally within the container view
      
      label.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        label.frame.origin.x = 15
        label.frame.origin.y = 8

      containerView.addSubview(imageView)
      containerView.addSubview(label)

      // Render the container view into an image
      UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, false, UIScreen.main.scale)
      containerView.layer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return image
    }

}
extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
