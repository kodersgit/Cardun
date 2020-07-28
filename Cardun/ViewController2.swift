//
//  ViewController2.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 2/1/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import Foundation

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Android Mobile – 1.png")
        //backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }
    


    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func login(_ sender: Any) {
        
        
        let params = [phoneNumber.text]
        let webService = webServ(name: "loginRecipient", params: params as Array<Any>)
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
                    
                    DispatchQueue.main.async {
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "verification") as? ViewController3
                        nextViewController?.phoneNumber = params[0]!
                        self.present(nextViewController!, animated: true, completion: nil)
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
                        let msgAttrString = NSMutableAttributedString(string: "لطفآ شماره را درست وارد نمایید.", attributes: msgFont)
                    
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
    
    @IBAction func Rules(_ sender: Any) {
        
        if let url = URL(string: "http://www.cardun.ir/%D9%82%D9%88%D8%A7%D9%86%DB%8C%D9%86-%D9%88-%D9%85%D9%82%D8%B1%D8%A7%D8%B1%D8%AA/"){
            
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
