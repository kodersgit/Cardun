//
//  serviceInfo.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/20/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class serviceInfo: UIViewController, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate{

    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "", "id": "", "tip": ""] as [String : Any]
    
    @IBOutlet weak var imageView: UIImageView!    
    @IBOutlet weak var descript: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var tip: UILabel!
    @IBOutlet weak var deleteImage: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteImage.isHidden = true
        if let description = serviceDictionary["descript"]{
            descript.text = description as? String
        }
        
        imageView.contentMode = .scaleAspectFit
        if let encodedImageData = serviceDictionary["imageString"]{
            let imageData = NSData(base64Encoded: encodedImageData as! String, options: .ignoreUnknownCharacters)!
            let imageSer = UIImage(data: imageData as Data)
            imageView.image = imageSer
        }
        
        tip.text = serviceDictionary["tip"] as? String
        
        imagePicker.delegate = self
        address.text = serviceDictionary["address"] as? String
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        deleteImage.isHidden = false
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = selectedImage
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "finalize") as? finalizeReq
            
            //create image instance
            //with image name from bundle
            let imageData = selectedImage.pngData()
            let base64String = imageData!.base64EncodedString()
            serviceDictionary["imageString"] = base64String
            nextViewController!.serviceDictionary = serviceDictionary
        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = selectedImage
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "finalize") as? finalizeReq
            
            //create image instance
            //with image name from bundle
            let imageData = selectedImage.pngData()
            let base64String = imageData!.base64EncodedString()
            serviceDictionary["imageString"] = base64String
            nextViewController!.serviceDictionary = serviceDictionary
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    

    @IBOutlet weak var infoEmpty: UITextField!
    @IBOutlet weak var addressEmpty: UITextField!
    @IBAction func infoCompletion(_ sender: Any) {
        
        if descript.text == "" {
            infoEmpty.isHidden = false
        }
        if address.text == "" {
            addressEmpty.isHidden = false
        }
        
        if descript.text != "" && address.text != "" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "finalize") as? finalizeReq
            serviceDictionary["address"] = address.text
            serviceDictionary["descript"] = descript.text
        
            nextViewController!.serviceDictionary = serviceDictionary
        
        
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    @IBAction func serviceImage(_ sender: Any) {
        

        let alert = UIAlertController(title: "گزینه موردنظر را انتخاب کنید.", message: "" , preferredStyle: .actionSheet);
        let myString  = "گزینه موردنظر را انتخاب کنید."
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "IRANSans", size: 18.0)!])
        alert.setValue(myMutableString, forKey: "attributedTitle")
        
        let photos = UIAlertAction(title : "دوربین", style: .default , handler: { (alert: UIAlertAction ) in
            
            self.openCamera()
            
        })
        
        let videos = UIAlertAction(title : "گالری" , style: .default , handler: { (alert: UIAlertAction ) in
            
            self.openGallery()
            
        })
        
        
        
        let cancel = UIAlertAction(title : "لغو" , style: .default , handler: nil)
        
        alert.addAction(photos)
        
        alert.addAction(videos)
        
        alert.addAction(cancel)
        
        present(alert, animated: true , completion: nil)

    }
    
    func openCamera () {
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            imagePicker.delegate = self
            
            imagePicker.sourceType = .camera;
            
            imagePicker.allowsEditing = true
            
            imagePicker.mediaTypes = ["public.image"]
            
            
            
            self.present(imagePicker, animated: true, completion: nil)
            
            
            
        }else{
            
            print("Camera not available")
            
        }
        
    }
    
    
    
    func openGallery() {
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            
            imagePicker.sourceType = .savedPhotosAlbum;
            
            imagePicker.allowsEditing = true
            
            imagePicker.mediaTypes = ["public.image","public.movie"]
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController6 {
            vc.serviceDictionary = serviceDictionary
        }
    }
    
    @IBAction func descriptEdit(_ sender: Any) {
        self.infoEmpty.isHidden = true
    }
    
    @IBAction func addressEdit(_ sender: Any) {
        self.addressEmpty.isHidden = true
    }
    @IBAction func pr(_ sender: Any) {
        imageView.image = UIImage()
        serviceDictionary["imageString"] = ""
        self.deleteImage.isHidden = true
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
