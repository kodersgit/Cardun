//
//  serviceDetails.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 6/19/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import GoogleMaps
import MessageUI

class serviceDetails: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var gps: UIImageView!
    @IBOutlet weak var addressBar: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var providerView: UIView!
    
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerDescriptionLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var providerPhoneLabel: UILabel!
    
    var token = ""
    var id = ""
    var providerName = ""
    var providerDescription = ""
    var providerPhone = ""
    var providerIm = ""
    var serviceName = ""
    var location_lat = 0.0
    var location_lng = 0.0
    
    let messageComposer = MessageComposer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        providerNameLabel.text = providerName
        providerDescriptionLabel.text = providerDescription
        serviceNameLabel.text = "نوع سرویس: " + serviceName
        providerPhoneLabel.text = providerPhone
        
        if let providerPictureURL = URL(string: providerIm){
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: providerPictureURL) { (data, response, error) in
            if error != nil {
                //print("Error downloading picture: \(e)")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    //print("Downloaded picture with response code \(res.statusCode)")
                    if let imageData = data {
                        DispatchQueue.main.async { // Correct
                            let image = UIImage(data: imageData)
                            self.providerImage.image = image
                            self.providerImage.contentMode = UIView.ContentMode.scaleToFill
                            
                            self.providerImage.layer.cornerRadius = (self.providerImage.frame.size.width ) / 2
                            self.providerImage.clipsToBounds = true
                            //self.providerImage.layer.borderWidth = 3.0
                            //self.providerImage.layer.borderColor = UIColor.white.cgColor
                            
                        }
                    } else {
                        //print("Couldn't get image: Image is nil")
                    }
                } else {
                    //print("Couldn't get response code for some reason")
                }
            }
            
        }
            downloadPicTask.resume()}

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        let latitude = location_lat
        let longitude = location_lng
        print(latitude,longitude)
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16)
        let mapView = GMSMapView.map(withFrame: CGRect(x: gps.frame.origin.x, y: gps.frame.origin.y, width: addressBar.bounds.width, height: addressBar.frame.midY - gps.frame.origin.y), camera: camera)
        
        
        mapView.mapType = .terrain
        mapView.isIndoorEnabled = false;
        mapView.isUserInteractionEnabled = false;
        mapView.isMyLocationEnabled = false
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: addressBar.frame.midY - gps.frame.origin.y - 80, right: addressBar.bounds.width - 80)
        mapView.settings.myLocationButton = false
        //        mapView.center = self.view.center
        mapView.delegate = self
        
        self.view.addSubview(mapView)
        //        self.view.bringSubviewToFront(gps)
        self.view.bringSubviewToFront(reject)
        self.view.bringSubviewToFront(logo)
        self.view.bringSubviewToFront(providerView)
        
    }
    
    @IBAction func call(_ sender: Any) {
        
        if let url = NSURL(string: "tel://\(providerPhone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func sms(_ sender: Any) {
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(textMessageRecipients: [providerPhone])
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
            let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
            let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
            let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
            let msgAttrString = NSMutableAttributedString(string: "امکان ارسال پیام وجود ندارد.", attributes: msgFont)
            
            alert.setValue(titAttrString, forKey: "attributedTitle")
            alert.setValue(msgAttrString, forKey: "attributedMessage")
            
            alert.addAction(UIAlertAction(title: "ادامه", style: UIAlertAction.Style.default, handler: { action in
                switch action.style{
                case .default:
                    print("ok")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    print("destructive1")
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func reject(_ sender: Any) {
        let params = [token, id]
        let webService = webServ(name: "CancelRequest", params: params)
        let request1 = webService.POST(name: webService.name, params: webService.params)
        
        let session1 = URLSession.shared
        let dataTask1 = session1.dataTask(with: request1 as URLRequest,completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
            } else {
                //if let httpResponse = response as? HTTPURLResponse{
                
                //print(httpResponse.statusCode)
                
                //}
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                    var dict = webService.convertToDictionary(text: dataString)!
                    
                    if let result: Int32 = dict["result"] as? Int32 {
                        print(result)
                        if result == 1000 {
                            
                            DispatchQueue.main.async {
                                
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainUI") as? SWRevealViewController
                                self.present(nextViewController!, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        })
        dataTask1.resume()
    }
    
}

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }

    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(textMessageRecipients: [String]) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = textMessageRecipients
        messageComposeVC.body = "Hey friend - Just sending a text message in-app using Swift!"
        return messageComposeVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
