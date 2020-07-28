//
//  TableViewReceivedServices.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 5/14/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

struct headlineOrders {
    
    var idOrder: Double
    var locationLat: Double
    var locationLng: Double
    var description: String
    var address: String
    var status: String
    var registerTime: String
    var orderImage: String
    var orderPrice: Double
    var onlinePayment: Double
    var title : String
    var image : UIImage
    var id: Double
}

class HeadlineTableViewCel3: UITableViewCell {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceProviderName: UILabel!
    @IBOutlet weak var serviceStatus: UILabel!
    
    
}

class TableViewReceivedServices: UITableViewController {

    var headlines : [headlineOrders]  = [headlineOrders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let tempToken = UserDefaults.standard.object(forKey: "token"){
            
            let token = tempToken as! String
            
            let params = [token]
            let webService = webServ(name: "getOrdersRecipient", params: params as Array<Any>)
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
                            if let tempOrders = dict["orders"]{
                                
                                let orders = tempOrders as! Array<Any>
                                print(orders)
                                for tempOrder in orders{
                                    let order = tempOrder as! Dictionary<String,Any>
                                    if let tempID = order["id"]{
                                        let ID = (tempID as? NSString)?.doubleValue
                                        if let tempLocationLat = order["location_lat"]{
                                            let locationLat = (tempLocationLat as? NSString)?.doubleValue
                                            if let tempLocationLng = order["location_lng"]{
                                                let locationLng = (tempLocationLng as? NSString)?.doubleValue
                                                if let tempDescription = order["description"]{
                                                    let description = tempDescription as! String
                                                    if let tempAddress = order["address"]{
                                                        let address = tempAddress as! String
                                                        if let tempStatus = order["status"]{
                                                            let status = tempStatus as! String
                                                            if let tempRegisterTime = order["register_time"]{
                                                                let registerTime = tempRegisterTime as! String
                                                                if let tempImage = order["image"]{
                                                                    let image = tempImage as! String
                                                                    if let tempPrice = order["price"]{
                                                                        let price = (tempPrice as? NSString)?.doubleValue
                                                                        if let tempPayedOnline = order["payed_online"]{
                                                                            let payedOnline = (tempPayedOnline as? NSString)?.doubleValue
                                                                            if let tempService = order["service"]{
                                                                                let service = tempService as! Dictionary<String,Any>
                                                                                if let tempID2 = service["id"]{
                                                                                    let ID2 = (tempID2 as? NSString)?.doubleValue
                                                                                    if let tempName = service["name"]{
                                                                                        let name = tempName as! String
                                                                                        if let tempURL = service["image"]{
                                                                                            let URLImage = tempURL as! String
                                                                                            if let catPictureURL = URL(string: URLImage){
                                                                                                let session = URLSession(configuration: .default)
                                                                                                let downloadPicTask = session.dataTask(with: catPictureURL) { (imData, imResponse, imError) in
                                                                                                    if imError != nil {
                                                                                                        //print("Error downloading cat picture: \(e)")
                                                                                                    } else {
                                                                                                        if (imResponse as? HTTPURLResponse) != nil {
                                                                                                            //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                                                            if let imageData = imData {
                                                                                                                let imageToShow = UIImage(data: imageData)
                                                                                                                self.headlines.append(headlineOrders(idOrder: ID2!, locationLat: locationLat!, locationLng: locationLng!, description: description, address: address, status: status, registerTime: registerTime, orderImage: image, orderPrice: price!, onlinePayment: payedOnline!, title: name, image: imageToShow!,id: ID!))
                                                                                                                
                                                                                                                DispatchQueue.main.async {
                                                                                                                    self.tableView.delegate = self
                                                                                                                    self.tableView.dataSource = self
                                                                                                                    self.tableView.reloadData() // reload your table view
                                                                                                                }
                                                                                                                
                                                                                                            } else {
                                                                                                                print("Couldn't get image: Image is nil")
                                                                                                            }
                                                                                                        } else {
                                                                                                            print("Couldn't get response code for some reason")
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
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            as! HeadlineTableViewCel3
        
        let headline = headlines[indexPath.row]
        cell.serviceName?.text = headline.title
        cell.serviceName?.font = UIFont(name:"IRANSans", size: 20.0)
        cell.serviceProviderName?.text = ""
        cell.serviceProviderName?.font = UIFont(name:"IRANSans", size: 16.0)
        cell.serviceImage?.image = headline.image
        cell.serviceImage?.contentMode = UIView.ContentMode.scaleToFill
        cell.serviceImage?.layer.cornerRadius = ((cell.serviceImage?.frame.size.width)! ) / 2
        cell.serviceImage?.clipsToBounds = true
        switch headline.status {
        case "accepted":
            cell.serviceStatus?.text = "تأییدشده"
            break
        case "completed":
            cell.serviceStatus?.text = "تکمیل‌شده"
            break
        case "expired":
            cell.serviceStatus?.text = "منقضی‌شده"
            break
        case "pending":
            cell.serviceStatus?.text = "درحال‌ تعلیق"
            break
        case "priced":
            cell.serviceStatus?.text = "قیمت‌گذاری‌شده"
            break
        case "provider_canceled":
            cell.serviceStatus?.text = "لغوشده توسط سرویس‌دهنده"
            break
        case "recipient_canceled":
            cell.serviceStatus?.text = "لغوشده توسط سرویس‌گیرنده"
            break
        case "searching":
            cell.serviceStatus?.text = "درحال جستجو"
            break
        default:
            
            break
            
        }
        cell.serviceStatus?.font = UIFont(name:"IRANSans", size: 12.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    /*    let serviceID = headlines[indexPath.row].id
        
        var isParent = false
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            if let tempService = data["availableServices"]{
                let services = tempService as! Array<Any>
                for tempServ in services{
                    let serv = tempServ as! Dictionary<String,Any>
                    if let tempParent = serv["parent"]{
                        let PARENT = (tempParent as? NSString)?.doubleValue
                        if let parent = PARENT{
                            if serviceID == Int(parent){
                                isParent = true
                                break
                            }
                        }
                    }
                }
            }
        }
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if isParent{
            let nextViewController2 = storyBoard.instantiateViewController(withIdentifier: "subServices") as? ViewController5
            nextViewController2?.service = serviceID
            self.present(nextViewController2!, animated: true, completion: nil)
        } else{
            serviceDictionary["name"] = headlines[indexPath.row].title as String
            serviceDictionary["id"] = String(headlines[indexPath.row].id) as String
            serviceDictionary["tip"] = headlines[indexPath.row].tooltip as String
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MAP") as? ViewController6
            nextViewController?.serviceDictionary = serviceDictionary
            self.present(nextViewController!, animated: true, completion: nil)
        }
 */
    }

}
