//
//  finalizeReq.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/17/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class finalizeReq: UIViewController {
    
    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "", "id": ""] as [String : Any]
    

    @IBOutlet weak var req: UILabel!
    @IBOutlet weak var add: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var im: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(serviceDictionary)
        
        req.text = serviceDictionary["name"] as? String
        im.contentMode = .scaleAspectFit
        
        if let encodedImageData = serviceDictionary["imageString"]{
            let imageData = NSData(base64Encoded: encodedImageData as! String, options: .ignoreUnknownCharacters)!
            let imageSer = UIImage(data: imageData as Data)
            im.image = imageSer
        }
        
        add.text = serviceDictionary["address"] as? String
        des.text = serviceDictionary["descript"] as? String
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func searchCardun(_ sender: Any) {
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "search") as! searchService
        nextViewController.serviceDictionary = serviceDictionary
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? serviceInfo {
            vc.serviceDictionary = serviceDictionary
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
