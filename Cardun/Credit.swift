//
//  Credit.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 5/7/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class Credit: UIViewController {

    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var gift: UITextField!
    @IBOutlet weak var giftError: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.giftError.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            if let tempCredit = data["credit"]{
                let Credit = tempCredit as! String
                credit.text = "اعتبار شما: " + Credit + " ریال"
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getGift(_ sender: Any) {
        
        if let tempToken = UserDefaults.standard.object(forKey: "token"){

            let token = tempToken as! String
            let params = [token, gift.text as Any]
            let webService = webServ(name: "depositGift", params: params as Array<Any>)
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
                            print("cancel1")
                        case .destructive:
                            print("destructive1")
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
                            print("cancel2")
                        case .destructive:
                            print("destructive2")
                        @unknown default:
                            print("destructive2")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                switch httpResponse.statusCode{
                case 200:
                    
                    
                    let params2 = [token]
                    let webService2 = webServ(name: "getRecipientData", params: params2 as Array<Any>)
                    let request2 = webService.POST(name: webService2.name, params: webService2.params)
                        
                    let session2 = URLSession.shared
                    let dataTask2 = session2.dataTask(with: request2 as URLRequest,completionHandler: { (data2, response2, error2) -> Void in
                            
                            
                    guard data2 != nil else {
                        
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
                            
                    if let httpResponse2 = response2 as? HTTPURLResponse {
                        switch httpResponse2.statusCode{
                                    
                        case 200:
                                    
                            if let data2 = data2, let dataString2 = String(data: data2, encoding: .utf8) {
                                        
                            let dict2 = webService2.convertToDictionary(text: dataString2)!
                                UserDefaults.standard.set(dict2, forKey: "userData")
                                if let tempCredit2 = dict2["credit"]{
                                    let Credit2 = tempCredit2 as! String
                                    self.credit.text = "اعتبار شما: " + Credit2 + " ریال"
                                }
                            }
                                    
                                    break
                                    
                                case 302:
                                    
                                    
                                    
                                    break
                                    
                                case 304:
                                    
                                    
                                    
                                    break
                                    
                                case 400:
                                    
                                    
                                    
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
                                    
                                    break
                                    
                                default:
                                    print("destructive1")
                                }
                                
                            }
                        })
                        
                        dataTask2.resume()
                        
                    
                    
                    
                    break
                    
                case 302:
                    
                    
                    
                    break
                    
                case 304:
                    
                    
                    
                    break
                    
                case 400:
                    
                    let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                    let msgAttrString = NSMutableAttributedString(string: "کد هدیه اشتباه است.", attributes: msgFont)
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.setValue(titAttrString, forKey: "attributedTitle")
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    
                    alert.addAction(UIAlertAction(title: "بازگشت", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let nextViewController = storyboard.instantiateViewController(withIdentifier: "mainUI")
                                
                                self.present(nextViewController, animated: true, completion: nil)
                            }
                        case .cancel:
                            print("cancel3")
                        case .destructive:
                            print("destructive3")
                        @unknown default:
                            print("destructive13")
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "تلاش مجدد", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            print("ok4")
                        case .cancel:
                            print("cancel4")
                        case .destructive:
                            print("destructive4")
                        @unknown default:
                            print("destructive4")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    break
                    
                case 401:
                    
                    
                    break
                    
                case 402:
                    
                    
                    
                    break
                    
                case 404:
                    
                    
                    
                    break
                    
                case 406:
                    
                    
                    
                    break
                
                case 460:
                    
                    DispatchQueue.main.async {
                        self.giftError.text = "کد هدیه صحیح نیست."
                        self.giftError.isHidden = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.giftError.isHidden = true
                    }
                    
                    break
                    
                case 461:
                    
                    DispatchQueue.main.async {
                        self.giftError.text = "کد هدیه مصرف شده است."
                        self.giftError.isHidden = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.giftError.isHidden = true
                    }
                    
                    break
                    
                case 462:
                    
                    DispatchQueue.main.async {
                        self.giftError.text = "کد هدیه منقضی شده است."
                        self.giftError.isHidden = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.giftError.isHidden = true
                    }
                    
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
                    
                    alert.addAction(UIAlertAction(title: "خروج", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            exit(0)
                        case .cancel:
                            print("cancel5")
                        case .destructive:
                            print("destructive5")
                        @unknown default:
                            print("destructive5")
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "تلاش مجدد", style: UIAlertAction.Style.default, handler: { action in
                        switch action.style{
                        case .default:
                            print("ok6")
                        case .cancel:
                            print("cancel6")
                        case .destructive:
                            print("destructive6")
                        @unknown default:
                            print("destructive6")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    break
                    
                default:
                    print("destructive7")
                }
                
            }
        })
        
        dataTask.resume()
        }
        
        
        /*if let tempToken = UserDefaults.standard.object(forKey: "token"){
            let token = tempToken as! String
            let params = [token,amount.text!]
            let webService = webServ(name: "DepositGift", params: params)
            let request1 = webService.POST(name: webService.name, params: webService.params)
            let session1 = URLSession.shared
        
            let dataTask1 = session1.dataTask(with: request1 as URLRequest,completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                
                    DispatchQueue.main.async {
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
                                print("default")
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
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        var dict = webService.convertToDictionary(text: dataString)!
                    
                        print(dict)
                        if let result: Int32 = dict["result"] as? Int32 {
                            if result == 1000 {
                                
                            } else {
                                DispatchQueue.main.async {
                                    self.giftError.isHidden = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    self.giftError.isHidden = true
                                }
                            }
                        }
                    }
                    
                }
            })
            dataTask1.resume()
        }*/
    }
    
    @IBAction func accIncrease(_ sender: Any) {
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            
            if let tempUser = data["user"]{
                let user = tempUser as! Dictionary<String,Any>
                if let tempID = user["id"]{
                    let id = tempID as! String
                    let link = "http://www.cardun.ir/pay/pay.php?amount=" + amount.text! + "&user=" + id
                    if let url = URL(string: link){
                    
                        if UIApplication.shared.canOpenURL(url) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                // Fallback on earlier versions
                            }
                            //If you want handle the completion block than
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                                //print("Open url : \(success)")
                                })
                            } else {
                            // Fallback on earlier versions
                        }
                    }
                    }
                }
            }
        }
        if let tempToken = UserDefaults.standard.object(forKey: "token"){
            
            let token = tempToken as! String
            
            let params = [token]
            let webService = webServ(name: "getRecipientData", params: params as Array<Any>)
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
                            
                            let dict = webService.convertToDictionary(text: dataString)!
                            UserDefaults.standard.set(dict, forKey: "userData")
                        }
                        
                        break
                        
                    case 302:
                        
                        
                        
                        break
                        
                    case 304:
                        
                        
                        
                        break
                        
                    case 400:
                        
                        
                        
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
                        
                        break
                        
                    default:
                        print("destructive1")
                    }
                    
                }
            })
            
            dataTask.resume()
            
            
        }
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            if let tempCredit = data["credit"]{
                let Credit = tempCredit as! String
                credit.text = "اعتبار شما: " + Credit + " ریال"
            }
        }
        
    }
    
    @IBAction func giftEntering(_ sender: Any) {
        DispatchQueue.main.async {
            self.giftError.isHidden = true
        }
    }
    
    @IBAction func creditEntering(_ sender: Any) {
        DispatchQueue.main.async {
            self.giftError.isHidden = true
        }
    }
    
}
