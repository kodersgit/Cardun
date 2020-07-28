//
//  popUP.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 6/12/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import Cosmos

class popUP: UIViewController {
    
    
    
    var providerName = ""
    var providerDescription = ""
    var providerRating = 0.0
    var providerPhone = ""
    var providerIm = ""
    var serviceName = ""
    var location_lat = 0.0
    var location_lng = 0.0
    var token = ""
    var id = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.providerImage.layer.cornerRadius = (self.providerImage.frame.size.width ) / 2
        self.providerImage.clipsToBounds = true
        
        
        self.providerNameLabel.text = providerName
        self.providerDescriptionLabel.text = providerDescription
        cosmos.rating = providerRating
        self.providerPhoneLabel.text = providerPhone
        
        if let providerPictureURL = URL(string: self.providerIm){
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
        
        downloadPicTask.resume()
        }
    }
    
    @IBAction func B1(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerDescriptionLabel: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var providerPhoneLabel: UILabel!
    
    @IBAction func call(_ sender: Any) {
        if let url = NSURL(string: "tel://\(providerPhone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? serviceDetails {
            vc.providerName = self.providerName
            vc.providerDescription = self.providerDescription
            vc.providerPhone = self.providerPhone
            vc.serviceName = self.serviceName
            vc.location_lat = self.location_lat
            vc.location_lng = self.location_lng
            vc.providerIm = self.providerIm
            vc.token = self.token
            vc.id = self.id
        }
    }
    
}
