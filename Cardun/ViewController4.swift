//
//  ViewController4.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 2/14/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController4: UIViewController {

    var service: Array<Any> = Array()
    
    @IBOutlet weak var service1Text: UILabel!
    @IBOutlet weak var service2Text: UILabel!
    @IBOutlet weak var service3Text: UILabel!
    @IBOutlet weak var service4Text: UILabel!
    @IBOutlet weak var service5Text: UILabel!
    @IBOutlet weak var service6Text: UILabel!
    
    @IBOutlet weak var service1Pic: UIImageView!
    @IBOutlet weak var service2Pic: UIImageView!
    @IBOutlet weak var service3Pic: UIImageView!
    @IBOutlet weak var service4Pic: UIImageView!
    @IBOutlet weak var service5Pic: UIImageView!
    @IBOutlet weak var service6Pic: UIImageView!
    

    @IBOutlet weak var service1Description: UILabel!
    @IBOutlet weak var service2Description: UILabel!
    @IBOutlet weak var service3Description: UILabel!
    @IBOutlet weak var service4Description: UILabel!
    @IBOutlet weak var service5Description: UILabel!
    @IBOutlet weak var service6Description: UILabel!
    

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
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
        
        
        
        
        
/*
        DispatchQueue.global(qos: .default).async {
            
            if let tempToken = UserDefaults.standard.object(forKey: "token"){
                let token = tempToken as! String
                //let eventSource: EventSource = EventSource(url: URL(string:"http://cardun.ir/cardun/sse/sse_connect.php" as String)!, headers: ["Content-Type": "application/json", "token" : token])
                
                //eventSource.onOpen {
                    // When opened
                //    print("open")
                //}
                
                //eventSource.onMessage { (id, event, data) in
                    // Here you get an event without event name!
                    //print("message")
                //}
                
                //eventSource.addEventListener("test") { (id, event, data) in
                    // Here you get an event 'event-name'
                    //if let tempOldData = UserDefaults.standard.object(forKey: "userData"){
                        //let oldData = tempOldData as! Dictionary<String,Any>
                    
                        //let params = [token]
                        //let webService = webServ(name: "getUserData", params: params)
                        //let request1 = webService.POST(name: webService.name, params: webService.params)
                        //let session1 = URLSession.shared
                        //let dataTask1 = session1.dataTask(with: request1 as URLRequest,completionHandler: { (data, response, error) -> Void in
                            //if (error != nil) {
                            
                            //} else {
                            
                                //if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                
                                    //var dict = webService.convertToDictionary(text: dataString)!
                                
                                    //if let result: Int32 = dict["result"] as? Int32 {
                                    
                                        //if result == 1000 {
                                        
                                        
                                            //if let tempNewData = dict["data"]{
                                                //let newData = tempNewData  as! Dictionary<String,Any>
                                                //UserDefaults.standard.set(newData, forKey: "userData")
                                                //if let tempOrders = newData["orders"]{
                                                //print(tempOrders)
                                                    //let newOrders = tempOrders as! [[String:Any]]
                                                        //if let tempOldOrders = oldData["orders"] {
                                                            //let oldOrders = tempOldOrders as! [[String:Any]]
                                                            //print(oldOrders.count,newOrders.count)
                                                            //for newOrder in newOrders {
                                                                //for oldOrder in oldOrders {
                                                                    //if let currentOrderID = (newOrder["id"] as? NSString)?.doubleValue  {
                                                                        //if let prevOrderID = (oldOrder["id"] as? NSString)?.doubleValue  {
                                                                            //if currentOrderID == prevOrderID {
                                                                                //if let newStatus = (newOrder["status"] as? NSString)?.doubleValue  {
                                                                                    //if let oldStatus = (oldOrder["status"] as? NSString)?.doubleValue {
                                                                                        //if newStatus != oldStatus {
                                                                                            
                                                                                            //print(currentOrderID,prevOrderID,newStatus,oldStatus)
                                                                                            //if newStatus == 1.0 {
                                                                        
                                                                                
                                                                                                //print(newOrder)
                                                                                                //let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUP") as! popUP
                                                                                
                                                                                
                                                                                                //if let templocation_lat = newOrder["location_lat"]{
                                                                                                    //let location_lat = (templocation_lat as! NSString).doubleValue
                                                                                                    //newViewController.location_lat = location_lat
                                                                                                //}
                                                                                
                                                                                                //if let templocation_lng = newOrder["location_lng"]{
                                                                                                    //let location_lng = (templocation_lng as! NSString).doubleValue
                                                                                                    //newViewController.location_lng = location_lng
                                                                                                //}
                                                                                            
                                                                                                //if let tempService = newOrder["service"]{
                                                                                                    //let service = tempService as! [String: Any]
                                                                                                    //if let tempService = service["name"]{
                                                                                                        //let service = tempService as! String
                                                                                                        //newViewController.serviceName = service
                                                                                                    //}
                                                                                                //}
                                                                                
                                                                                
                                                                                                //if let tempProvider = newOrder["provider"]{
                                                                                                    //let provider = tempProvider as! [String: Any]
                                                                                    
                                                                                                    //if let tempProviderRating = provider["rating"]{
                                                                                                        //let providerRating = tempProviderRating as! Double
                                                                                                        //newViewController.providerRating = providerRating
                                                                                                    //}
                                                                                    
                                                                                                    //if let tempProviderPhone = provider["phone_number"]{
                                                                                                        //let providerPhone = tempProviderPhone as! String
                                                                                                        //newViewController.providerPhone = providerPhone
                                                                                                    //}
                                                                                    
                                                                                                    //if let tempProviderImage = provider["image"]{
                                                                                                        //let providerImage = tempProviderImage as! String
                                                                                                        //newViewController.providerIm = providerImage
                                                                                                    //}
                                                                                    
                                                                                                    //if let tempProviderDescription = provider["description"]{
                                                                                                        //let providerDescription = tempProviderDescription as! String
                                                                                                        //newViewController.providerDescription = providerDescription
                                                                                                    //}
                                                                                                    //if let tempProviderFirstName = provider["first_name"] {
                                                                                                        //var providerFirstName = " "
                                                                                                        //providerFirstName = tempProviderFirstName as! String
                                                                                                        //if let tempProviderLastNamne = provider["last_name"] {
                                                                                                            //var providerLastNamne = " "
                                                                                                            //providerLastNamne = tempProviderLastNamne as! String
                                                                                                            //newViewController.providerName = providerFirstName + " " + providerLastNamne
                                                                                                        //}
                                                                                        
                                                                                                    //}
                                                                                                //}
                                                                                                //newViewController.token = token
                                                                                                //newViewController.id = String(currentOrderID)
                                                                                                //UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
                                                                                            //}
                                                                                            
                                                                                            //else if newStatus == 2.0 {
                                                                                                //let alert = UIAlertController(title: "توجه", message: " سرویس شما به شماره" + String(Int(currentOrderID)) + "تعیین قیمت شد." , preferredStyle: UIAlertController.Style.alert)
                                                                                                //let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                                                                                                //let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                                                                                                //let titAttrString = NSMutableAttributedString(string: "توجه", attributes: titFont)
                                                                                                //let msgAttrString = NSMutableAttributedString(string: "سرویس شما به شماره " + String(currentOrderID) + " تعیین قیمت شد." , attributes: msgFont)
                                                                                                
                                                                                                //alert.setValue(titAttrString, forKey: "attributedTitle")
                                                                                                //alert.setValue(msgAttrString, forKey: "attributedMessage")
                                                                                                
                                                                                                //alert.addAction(UIAlertAction(title: "تأیید", style: UIAlertAction.Style.default, handler: { action in
                                                                                                    //switch action.style{
                                                                                                    //case .default:
                                                                                                        //let thisViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainUI") as! SWRevealViewController
                                                                                                        //UIApplication.topViewController()?.present(thisViewController, animated: true, completion: nil)
                                                                                                    //case .cancel:
                                                                                                        //print("cancel")
                                                                                                    //case .destructive:
                                                                                                        //print("destructive")
                                                                                                    //@unknown default:
                                                                                                        //print("destructive1")
                                                                                                    //}
                                                                                                //}))
                                                                                                //alert.addAction(UIAlertAction(title: "جزئیات بیشتر", style: UIAlertAction.Style.default, handler: { action in
                                                                                                    //switch action.style{
                                                                                                    //case .default:
                                                                                                        //let thisViewController = UIStoryboard(name: "proforma", bundle: nil).instantiateViewController(withIdentifier: "mainUI") as! proforma
                                                                                                        
                                                                                                        //if let templocation_lat = newOrder["location_lat"]{
                                                                                                            //let location_lat = (templocation_lat as! NSString).doubleValue
                                                                                                            //thisViewController.location_lat = location_lat
                                                                                                        //}
                                                                                                        
                                                                                                        //if let templocation_lng = newOrder["location_lng"]{
                                                                                                            //let location_lng = (templocation_lng as! NSString).doubleValue
                                                                                                        //    thisViewController.location_lng = location_lng
                                                                                                        //}
                                                                                                        
                                                                                                        //if let tempService = newOrder["service"]{
                                                                                                            //let service = tempService as! [String: Any]
                                                                                                            //if let tempService = service["name"]{
                                                                                                                //let service = tempService as! String
                                                                                                                //thisViewController.serviceName = service
                                                                                                            //}
                                                                                                        //}
                                                                                                        //if let tempProvider = newOrder["provider"]{
                                                                                                            //let provider = tempProvider as! [String: Any]
                                                                                                            
//                                                                                                            if let tempProviderRating = provider["rating"]{
  //                                                                                                              let providerRating = tempProviderRating as! Double
    //                                                                                                            thisViewController.providerRating = providerRating
      //                                                                                                      }
                                                                                                            
        //                                                                                                    if let tempProviderPhone = provider["phone_number"]{
          //                                                                                                      let providerPhone = tempProviderPhone as! String
            //                                                                                                    thisViewController.providerPhone = providerPhone
              //                                                                                              }
                                                                                                            
                //                                                                                            if let tempProviderImage = provider["image"]{
                  //                                                                                              let providerImage = tempProviderImage as! String
                    //                                                                                            thisViewController.providerIm = providerImage
                      //                                                                                      }
                                                                                                            
                        //                                                                                    if let tempProviderDescription = provider["description"]{
                          //                                                                                      let providerDescription = tempProviderDescription as! String
                            //                                                                                    thisViewController.providerDescription = providerDescription
                              //                                                                              }
                                //                                                                            if let tempProviderFirstName = provider["first_name"] {
                                  //                                                                              var providerFirstName = " "
                                    //                                                                            providerFirstName = tempProviderFirstName as! String
                                      //                                                                          if let tempProviderLastNamne = provider["last_name"] {
                                        //                                                                            var providerLastNamne = " "
                                          //                                                                          providerLastNamne = tempProviderLastNamne as! String
                                            //                                                                        thisViewController.providerName = providerFirstName + " " + providerLastNamne
                                              //                                                                  }
                                                                                                                
                                                //                                                            }
                                                  //                                                      }
                                                                                                        
                                                    //                                                    thisViewController.token = token
                                                      //                                                  thisViewController.id = String(currentOrderID)
                                                        //                                                UIApplication.topViewController()?.present(thisViewController, animated: true, completion: nil)
                                                          //                                          case .cancel:
                                                            //                                            print("cancel")
                                                              //                                      case .destructive:
                                                                //                                        print("destructive")
                                                                  //                                  @unknown default:
                                                                    //                                    print("destructive1")
                                                                      //                              }
                                                                        //                        }))
                                                                          //                      UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                                                                            //                }

                                                                              //          }
                                                                                //    }
//                                                                                }
  //                                                                          }
    //                                                                    }
      //                                                              }
        //                                                        }
          //                                                  }
            
            //                                            }
              //                                      }
                //                                }
                                        
                  //                          }
                                        
                                        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        //let nextViewController = storyboard.instantiateViewController(withIdentifier: "mainUI")
                                        //self.present(nextViewController, animated: false, completion: nil)
                                        
                    //                    } else {
                      //                      let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                        //                    let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
                          //                  let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                            //                let titAttrString = NSMutableAttributedString(string: "خطا", attributes: titFont)
                              //              let msgAttrString = NSMutableAttributedString(string: "خطایی رخ داده است. لطفاّ مجدد امتحان کنید.", attributes: msgFont)
                                        
                                //            alert.setValue(titAttrString, forKey: "attributedTitle")
                                  //          alert.setValue(msgAttrString, forKey: "attributedMessage")
                
                                    //        alert.setValue(titAttrString, forKey: "attributedTitle")
                                      //      alert.setValue(msgAttrString, forKey: "attributedMessage")
                                        
                                        //    alert.addAction(UIAlertAction(title: "ادامه", style: UIAlertAction.Style.default, handler: { action in
                                          //      switch action.style{
                                            //    case .default:
                                              //      let thisViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
                                                //    self.present(thisViewController!, animated: true, completion: nil)
//                                                case .cancel:
  //                                                  print("cancel")
    //                                            case .destructive:
      //                                              print("destructive")
        //                                        @unknown default:
          //                                          print("destructive1")
            //                                    }
              //                              }))
                //                            UIApplication.topViewController()?.self.present(alert, animated: true, completion: nil)
                  //                      }
                
                    //                }
                                
                      //          }
                            
                        //    })
                        
                          //  dataTask1.resume()
                        
//                        }
                    
  //              }
                
                //eventSource.close()
            }
        }
        */
        
        
        sidemenus()
        customizeNavBar()
        
        let barImage = #imageLiteral(resourceName: "titre.jpg").stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
        self.navigationController?.navigationBar.setBackgroundImage(barImage, for: .default)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        
        let params = [0]
        let webService = webServ(name: "getServices", params: params as Array<Any>)
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
                        
                        var dict = webService.convertToDictionary(text: dataString)!
                        
                        //UserDefaults.standard.s
                                if let tempService = dict["services"]{
                                    self.service = tempService as! Array<Any>
                                    
                                    for superService in self.service{
                                        let serv = superService as! Dictionary<String,Any>
                                        if let tempParent = serv["parent"]{
                                            let parent = (tempParent as? NSString)?.doubleValue
                                            if parent == nil{
                                                if let tempID = serv["id"]{
                                                    let ID = (tempID as? NSString)?.doubleValue
                                                    
                                                    DispatchQueue.main.async {
                                                    switch ID {
                                                    case 1:
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service1Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service1Text.layer.cornerRadius = 10
                                                            //self.service1Text.clipsToBounds = true
                                                            
                                                            self.service1Text.text = Name
                                                            //self.service1Text.sizeToFit()
                                                        }
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service1Description.text = description
                                                            self.service1Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service1Pic.image = image
                                                                                self.service1Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service1Pic.layer.cornerRadius = (self.service1Pic.frame.size.width ) / 2
                                                                                self.service1Pic.clipsToBounds = true
                                                                                self.service1Pic.layer.borderWidth = 3.0
                                                                                self.service1Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
                                                                                //self.Service1.layer.borderColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
                                                                                //self.Service1.layer.borderWidth = 2
                                                                                
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
                                                    case 2:
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service2Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service2Text.layer.cornerRadius = 10
                                                            //self.service2Text.clipsToBounds = true
                                                            self.service2Text.text = Name
                                                            //self.service2Text.sizeToFit()
                                                        }
                                                        
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service2Description.text = description
                                                            self.service2Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading cat picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service2Pic.image = image
                                                                                self.service2Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service2Pic.layer.cornerRadius = (self.service2Pic.frame.size.width ) / 2
                                                                                self.service2Pic.clipsToBounds = true
                                                                                self.service2Pic.layer.borderWidth = 3.0
                                                                                self.service2Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
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
                                                    case 3:
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service3Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service3Text.layer.cornerRadius = 10
                                                            //self.service3Text.clipsToBounds = true
                                                            self.service3Text.text = Name
                                                            //self.service3Text.sizeToFit()
                                                        }
                                                        
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service3Description.text = description
                                                            self.service3Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading cat picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service3Pic.image = image
                                                                                self.service3Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service3Pic.layer.cornerRadius = (self.service3Pic.frame.size.width ) / 2
                                                                                self.service3Pic.clipsToBounds = true
                                                                                self.service3Pic.layer.borderWidth = 3.0
                                                                                self.service3Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
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
                                                    case 4:
                                                        
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service4Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service4Text.layer.cornerRadius = 10
                                                            //self.service4Text.clipsToBounds = true
                                                            self.service4Text.text = Name
                                                            //self.service4Text.sizeToFit()
                                                        }
                                                        
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service4Description.text = description
                                                            self.service4Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading cat picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service4Pic.image = image
                                                                                self.service4Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service4Pic.layer.cornerRadius = (self.service4Pic.frame.size.width ) / 2
                                                                                self.service4Pic.clipsToBounds = true
                                                                                self.service4Pic.layer.borderWidth = 3.0
                                                                                self.service4Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
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
                                                    case 5:
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service5Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service5Text.layer.cornerRadius = 10
                                                            //self.service5Text.clipsToBounds = true
                                                            self.service5Text.text = Name
                                                            //self.service5Text.sizeToFit()
                                                        }
                                                        
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service5Description.text = description
                                                            self.service5Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading cat picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service5Pic.image = image
                                                                                self.service5Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service5Pic.layer.cornerRadius = (self.service5Pic.frame.size.width ) / 2
                                                                                self.service5Pic.clipsToBounds = true
                                                                                self.service5Pic.layer.borderWidth = 3.0
                                                                                self.service5Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
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
                                                    default:
                                                        
                                                        if let tempName = serv["name"]{
                                                            let Name = tempName as! String
                                                            
                                                            //self.service6Text.backgroundColor = UIColor(white: 1, alpha: 0.7)
                                                            //self.service6Text.layer.cornerRadius = 10
                                                            //self.service6Text.clipsToBounds = true
                                                            self.service6Text.text = Name
                                                            //self.service6Text.sizeToFit()
                                                        }
                                                        
                                                        
                                                        if let tempDescription = serv["description"]{
                                                            let description = tempDescription as! String
                                                            self.service6Description.text = description
                                                            self.service6Description.numberOfLines = 3
                                                        }
                                                        
                                                        if let tempURL = serv["image"]{
                                                            let URLImage = tempURL as! String
                                                            let catPictureURL = URL(string: URLImage)!
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                                if error != nil {
                                                                    //print("Error downloading cat picture: \(e)")
                                                                } else {
                                                                    if (response as? HTTPURLResponse) != nil {
                                                                        //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                        if let imageData = data {
                                                                            
                                                                            DispatchQueue.main.async { // Correct
                                                                                let image = UIImage(data: imageData)
                                                                                self.service6Pic.image = image
                                                                                self.service6Pic.contentMode = UIView.ContentMode.scaleToFill
                                                                                
                                                                                self.service6Pic.layer.cornerRadius = (self.service6Pic.frame.size.width ) / 2
                                                                                self.service6Pic.clipsToBounds = true
                                                                                self.service6Pic.layer.borderWidth = 3.0
                                                                                self.service6Pic.layer.borderColor = UIColor.white.cgColor
                                                                                
                                                                                
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
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            
                            
                            
                            
                        
                    }
                    
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
    
    
    @IBAction func serv1(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController?.service = 1
            nextViewController?.services = self.service
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func serv2(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController?.service = 3
            nextViewController?.services = self.service
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func serv3(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController?.service = 2
            nextViewController?.services = self.service
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func serv4(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController?.service = 4
            nextViewController?.services = self.service
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func serv5(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MAP") as? ViewController6
            nextViewController!.serviceDictionary["name"] = self.service6Text.text
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func serv6(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController?.service = 5
            nextViewController?.services = self.service
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
    func sidemenus() {
        if revealViewController() != nil {
            //HOW TO CREATE A SIDE MENU / SIDE BAR IN SWIFT on youtube
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController()?.rightViewRevealWidth = 230
           
            
            view.addGestureRecognizer((self.revealViewController().panGestureRecognizer())!)
        }
    }
    
    @IBAction func search(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchService")
        self.present(secondViewController!, animated: true, completion: nil)
    }
    
    func customizeNavBar() {
        
        if #available(iOS 10.0, *) {
            navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255, green: 87, blue: 35, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
}


func initNotificationSetupCheck() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
    { (success, error) in
        if success {
            print("Permission Granted")
        } else {
            print("There was a problem!")
        }
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
