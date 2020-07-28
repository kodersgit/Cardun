//
//  ViewController.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 1/29/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let defaults = UserDefaults.standard
            
            if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
                if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
                    // user is already logged in
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
                                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                        self.present(secondViewController!, animated: true, completion: nil)
                                    }
                                    
                                    break
                                    
                                case 401:
                                    
                                    DispatchQueue.main.async {
                                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                        self.present(secondViewController!, animated: true, completion: nil)
                                    }
                                    
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
                    
                }else{
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
                    self.present(secondViewController!, animated: true, completion: nil)
                    
                }
            }else{
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Intro1")
                //the identifier above comes from storyboard
                self.navigationController!.pushViewController(secondViewController!, animated : true)
                
            }
                
            
            
        }
            
    }


    @IBAction func back(_ sender: Any) {
    }
}

