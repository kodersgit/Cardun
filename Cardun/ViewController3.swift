//
//  ViewController3.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 2/6/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    var phoneNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Android Mobile – 1.png")
        //backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.resendButton.isHidden = false
        }
    }
    
    @IBOutlet weak var verificationCode: UITextField!
    @IBOutlet weak var resendButton: UIButton!
    
    
    @IBAction func verification(_ sender: Any) {
        
        self.resendButton.isHidden = true
        let notificationId = "1234567890"
        let params = [phoneNumber, verificationCode.text!, notificationId]
        let webService = webServ(name: "validateOtpRecipient", params: params as Array<Any>)
        let request1 = webService.POST(name: webService.name, params: webService.params)
        
        let session1 = URLSession.shared
        let dataTask = session1.dataTask(with: request1 as URLRequest,completionHandler: { (data, response, error) -> Void in
            
            guard data != nil else {
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "خطا", message: "اتصال به اینترنت را بررسی نمایید.", preferredStyle: UIAlertController.Style.alert)
                    let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                    let msgAttrString = NSMutableAttributedString(string: "اتصال به اینترنت را بررسی نمایید.", attributes: msgFont)
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.addAction(UIAlertAction(title: "خروج", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            exit(0)
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
                            let thisViewController = self.storyboard?.instantiateViewController(withIdentifier: "firstPage")
                            self.present(thisViewController!, animated: true, completion: nil)
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
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode{
                    
                case 200:
                    
                    
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        
                        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                        var dict = webService.convertToDictionary(text: dataString)!
                        print(type(of: dict))
                        UserDefaults.standard.set(dict, forKey: "userData")
                        
                        if let tempUser = dict["user"]{
                            let user = tempUser as! Dictionary<String,Any>
                            if let tempToken = user["token"]{
                                let token = tempToken as! String
                                UserDefaults.standard.set(token, forKey: "token")
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyboard.instantiateViewController(withIdentifier: "mainUI")
                        
                        self.present(nextViewController, animated: true, completion: nil)
                    }
                    
                    break
                    
                case 302:
                    
                    
                    
                    break
                    
                case 304:
                    
                    
                    
                    break
                    
                case 400:
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "خطا", message: "لطفآ شماره را درست وارد نمایید.", preferredStyle: UIAlertController.Style.alert)
                        let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                        let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                        let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                        let msgAttrString = NSMutableAttributedString(string: "کد واردشده صحیح نیست.", attributes: msgFont)
                        
                        alert.setValue(titAttrString, forKey: "attributedTitle")
                        alert.setValue(msgAttrString, forKey: "attributedMessage")
                        
                        alert.addAction(UIAlertAction(title: "خروج", style: UIAlertAction.Style.default, handler: { action in
                            switch action.style{
                            case .default:
                                exit(0)
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
                                let thisViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                self.present(thisViewController!, animated: true, completion: nil)
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
                    
                    break
                    
                case 401:
                    
                    
                    
                    break
                    
                case 402:
                    
                    
                    
                    break
                    
                case 404:
                    
                    
                    
                    break
                    
                case 406:
                    
                    
                    
                    break
                    
                case 500:
                    
                    let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                    let msgAttrString = NSMutableAttributedString(string: "خطایی رخ داده است. لطفاّ مجدد امتحان کنید.", attributes: msgFont)
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.addAction(UIAlertAction(title: "ادامه", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            let thisViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
                            self.present(thisViewController!, animated: true, completion: nil)
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("destructive1")
                        }
                    }))
                    
                    break
                    
                default:
                    print("destructive1")
                }
                
            }
        })
        
        dataTask.resume()
        
    }
    
    
    @IBAction func resend(_ sender: Any) {
        DispatchQueue.main.async {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
}
