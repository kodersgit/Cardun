//
//  searchService.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/17/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class searchService: UIViewController {
    
    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "","id": ""] as [String : Any]
    
    
    var token = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(serviceDictionary)
        
        if let tempToken = UserDefaults.standard.object(forKey: "token"){
            token = tempToken as! String
            if let tempDescription = serviceDictionary["descript"]{
                let description = tempDescription as! String
                if let tempAddress = serviceDictionary["address"]{
                    let address = tempAddress as! String
                    if let tempImageString = serviceDictionary["imageString"]{
                        let imageString = tempImageString as! String
                        if let tempLatitude = serviceDictionary["latitude"]{
                            let latitude = tempLatitude as! Double
                            if let tempLongitude = serviceDictionary["longitude"]{
                                let longitude = tempLongitude as! Double
                                if let tempID = serviceDictionary["id"]{
                                    id = tempID as! String
                                    let notID = "1234567890"
                                    
                                    
                                    let params = [token,description,address,latitude,longitude,id,notID,imageString] as [Any]
                                   
                                    
                                    let webService = webServ(name: "newOrder", params: params)
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
                                            print(httpResponse.statusCode)
                                            switch httpResponse.statusCode{
                                                
                                            case 200:
                                                
                                                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUP") as! popUP
                                                
                                                
                                                
                                                newViewController.location_lat = 34.771804
                                                
                                                
                                                newViewController.location_lng = 48.515384
                                                
                                                
                                                newViewController.serviceName = "آشپز آقا"
                                                
                                                
                                                
                                                newViewController.providerRating = 3.5
                                                
                                                
                                                newViewController.providerPhone = "09188143481"
                                                
                                                
                                                newViewController.providerDescription = "best"
                                                newViewController.providerName = "شاهرخ جلوه فرد"
                                                newViewController.token = "GWF9TVn64ETuFkylrvJpFegms47wqfW1N42zJv2rCMFrRmrEfm3VRXbJlxfrJ4WBUPhKG3ovoZiqayyYKh69NVwpELyiqjvgL5Hb"
                                                newViewController.id = "123"
                                                
                                                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
                                                
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
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func reject(_ sender: Any) {
        
        
        let params = [token, id]
        print(params)
        let webService = webServ(name: "cancelOrderRecipient", params: params)
        
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
                print(httpResponse)
                switch httpResponse.statusCode{
                    
                case 200:
                    
                    let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let msgAttrString = NSMutableAttributedString(string: "درخواست شما با موفقیت لغو شد.", attributes: msgFont)
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    self.present(alert, animated: true, completion: nil)
                    
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainUI") as? SWRevealViewController
                        self.present(nextViewController!, animated: true, completion: nil)
                        
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
                    
                    let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
                    let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
                    let msgAttrString = NSMutableAttributedString(string: "درخواست شما با موفقیت لغو شد.", attributes: msgFont)
                    alert.setValue(msgAttrString, forKey: "attributedMessage")
                    self.present(alert, animated: true, completion: nil)
                    
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainUI") as? SWRevealViewController
                        self.present(nextViewController!, animated: true, completion: nil)
                        
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
