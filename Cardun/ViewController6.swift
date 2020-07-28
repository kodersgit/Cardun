//
//  ViewController6.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/10/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController6: UIViewController, GMSMapViewDelegate{
    
    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "", "id": "", "tip": ""] as [String : Any]

    @IBOutlet weak var gps: UIButton!
    @IBOutlet weak var addressBar: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var address: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        let latitude = 35.6892
        let longitude = 51.3890
        serviceDictionary["latitude"] = latitude
        serviceDictionary["longitude"]  = longitude
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect(x: gps.frame.origin.x, y: gps.frame.origin.y, width: addressBar.bounds.width, height: addressBar.frame.midY - gps.frame.origin.y), camera: camera)
        
        
        mapView.mapType = .terrain
        mapView.isMyLocationEnabled = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: addressBar.frame.midY - gps.frame.origin.y - 80, right: addressBar.bounds.width - 80)
        mapView.settings.myLocationButton = true
//        mapView.center = self.view.center
        mapView.delegate = self
        
        self.view.addSubview(mapView)
//        self.view.bringSubviewToFront(gps)
        self.view.bringSubviewToFront(addressBar)
        self.view.bringSubviewToFront(logo)
        
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "serviceInfo") as! serviceInfo
        nextViewController.serviceDictionary = serviceDictionary
        
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 35.6892, longitude: 51.3890)
//        marker.map = mapView
//        marker.icon = #imageLiteral(resourceName: "cardun.png")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        serviceDictionary["latitude"] = latitude
        serviceDictionary["longitude"]  = longitude
        let centerMapCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(centerMapCoordinate, completionHandler: { (placemarks, error) in
            if error == nil {
                if let firstLocation = placemarks?[0]{
                    
                    var add = ""
                    // Location name
                    add = ""
                    if let country = firstLocation.country {
                        add = add + (country as String)
                    }
                    if let province = firstLocation.administrativeArea {
                        add = add + ", " + (province as String)
                    }
                    if let province2 = firstLocation.subAdministrativeArea{
                        add = add + ", " + (province2 as String)
                    }
                    if let city = firstLocation.locality{
                        add = add + ", " + (city as String)
                    }
                    if let city2 = firstLocation.subLocality{
                        add = add + ", " + (city2 as String)
                    }
                    if let street = firstLocation.thoroughfare{
                        add = add + ", " + (street as String)
                    }
                    if let street2 = firstLocation.subThoroughfare{
                        add = add + ", " + (street2 as String)
                    }
                    self.address.text = add
                    self.address.font = self.address.font.withSize(16)
                    self.serviceDictionary["address"] = add
                }
            }
            else {
                // An error occurred during geocoding.
                
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? serviceInfo {
            vc.serviceDictionary = serviceDictionary
        }
    }
    
    
}


