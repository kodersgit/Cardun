//
//  user.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 5/8/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class user: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var prompt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            if let tempUser = data["user"]{
                let user = tempUser as! Dictionary<String,Any>
                if let tempName = user["first_name"]{
                    let nameUser = tempName as! String
                    name.text = nameUser
                }
                if let tempLastName = user["last_name"]{
                    let lastNameUser = tempLastName as! String
                    self.lastName.text = lastNameUser
                }
                if let tempUserName = user["username"]{
                    let nameUser = tempUserName as! String
                    userName.text = nameUser
                }
                if let tempPhoneNumber = user["phone_number"]{
                    let phoneNumber = tempPhoneNumber as! String
                    number.text = phoneNumber + " (غیر قابل تغییر)"
                }
                if let tempAddressUser = user["address"]{
                    let addressUser = tempAddressUser as! String
                    address.text = addressUser
                }
            }
        }
        
    }
    

/*    @IBAction func edit(_ sender: Any) {
        
        if let tempToken = UserDefaults.standard.object(forKey: "token"){
            let token = tempToken as! String
            var params = [token,name.text!,lastName.text!,userName.text!,address.text as Any]
            var webService = webServ(name: "UpdateProfile", params: params)
            let request1 = webService.POST(name: webService.name, params: webService.params)
            
            let session1 = URLSession.shared
            let dataTask1 = session1.dataTask(with: request1 as URLRequest,completionHandler: { (data1, response1, error1) -> Void in
                if (error1 != nil) {
                    DispatchQueue.main.async{
                    let alert = UIAlertController(title: "خطا", message: "اتصال به اینترنت را بررسی نمایید.", preferredStyle: UIAlertController.Style.alert)
                    let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                    let msgAttrString = NSMutableAttributedString(string: "اتصال به اینترنت را بررسی نمایید.", attributes: msgFont)
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.addAction(UIAlertAction(title: "صفحه اصلی", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            let thisViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
                            self.present(thisViewController!, animated: true, completion: nil)
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("destructive1")
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "تلاش مجدد", style: UIAlertAction.Style.default, handler: { action in
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
                } else {
                    DispatchQueue.main.async {
                        self.prompt.isHidden = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.prompt.isHidden = true
                    }
                    
                    
                    params = [token]
                    webService = webServ(name: "getUserData", params: params)
                    let request2 = webService.POST(name: webService.name, params: webService.params)
                    let session2 = URLSession.shared
                    let dataTask2 = session2.dataTask(with: request2 as URLRequest,completionHandler: { (data2, response2, error2) -> Void in
                        if (error2 != nil) {
                            DispatchQueue.main.async {
                            let alert2 = UIAlertController(title: "خطا", message: "اتصال به اینترنت را بررسی نمایید.", preferredStyle: UIAlertController.Style.alert)
                            let titFont2 = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                            let msgFont2 = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                            let titAttrString2 = NSMutableAttributedString(string: "خطا", attributes: titFont2)
                            let msgAttrString2 = NSMutableAttributedString(string: "اتصال به اینترنت را بررسی نمایید.", attributes: msgFont2)
                            
                            alert2.setValue(titAttrString2, forKey: "attributedTitle")
                            alert2.setValue(msgAttrString2, forKey: "attributedMessage")
                            
                            alert2.addAction(UIAlertAction(title: "صفحه اصلی", style: UIAlertAction.Style.default, handler: { action in
                                switch action.style{
                                case .default:
                                    let thisViewController2 = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
                                    self.present(thisViewController2!, animated: true, completion: nil)
                                case .cancel:
                                    print("cancel")
                                case .destructive:
                                    print("destructive")
                                @unknown default:
                                    print("destructive1")
                                }
                            }))
                            alert2.addAction(UIAlertAction(title: "تلاش مجدد", style: UIAlertAction.Style.default, handler: { action in
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
                            self.present(alert2, animated: true, completion: nil)
                            }
                        } else {
                            //if let httpResponse = response as? HTTPURLResponse{
                            
                            
                            //}
                            if let data2 = data2, let dataString = String(data: data2, encoding: .utf8) {
                                
                                var dict = webService.convertToDictionary(text: dataString)!
                                
                                if let result: Int32 = dict["result"] as? Int32 {
                                    
                                    if result == 1000 {
                                        
                                        
                                        if let data = dict["data"]{
                                            UserDefaults.standard.set(data, forKey: "userData")
                                        }
                                        
                                        
                                    } else {
                                        DispatchQueue.main.async {
                                        let alert3 = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                                        let titFont3 = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                                        let msgFont3 = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                                        let titAttrString3 = NSMutableAttributedString(string: "خطا", attributes: titFont3)
                                        let msgAttrString3 = NSMutableAttributedString(string: "خطایی رخ داده است. لطفاّ مجدد امتحان کنید.", attributes: msgFont3)
                                        
                                        alert3.setValue(titAttrString3, forKey: "attributedTitle")
                                        alert3.setValue(msgAttrString3, forKey: "attributedMessage")
                                        
                                        alert3.setValue(titAttrString3, forKey: "attributedTitle")
                                        alert3.setValue(msgAttrString3, forKey: "attributedMessage")
                                        
                                        alert3.addAction(UIAlertAction(title: "ادامه", style: UIAlertAction.Style.default, handler: { action in
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
                                        
                                        
                                        self.present(alert3, animated: true, completion: nil)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    })
                    dataTask2.resume()
                    
                    
                }
            })
            dataTask1.resume()
        }
        
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
