//
//  TableViewSearchServices.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 4/24/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit


class HeadlineTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
}

class TableViewSearchServices: UITableViewController {
    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "", "id": ""] as [String : Any]
    var headlines : [Headline]  = [Headline]()

    @IBOutlet weak var keyword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        //print(data)
    }

/*    @IBAction func change(_ sender: UITextField) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let params = ["1",sender.text!]
            let webService = webServ(name: "Search", params: params)
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
                                self.keyword.text = ""
                            case .cancel:
                                print("cancel")
                            case .destructive:
                                print("destructive")
                            @unknown default:
                                print("destructive1")
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                        self.headlines = [Headline]()
                    }
                    
                } else {
                    
                    self.headlines = [Headline]()
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        var dict = webService.convertToDictionary(text: dataString)!
                        
                        if let result: Int32 = dict["result"] as? Int32 {
                            if result == 1000 {
                                if let data1 = dict["data"]{
                                    let dataDic = data1 as! Dictionary<String,Any>
                                    if let tempService = dataDic["services"]{
                                        let services = tempService as! Array<Any>
                                        for tempServ in services{
                                            let serv = tempServ as! Dictionary<String,Any>
                                            if let tempName = serv["name"]{
                                                let Name = tempName as! String
                                                if let tempDescription = serv["description"]{
                                                    let description = tempDescription as! String
                                                    if let tempID = serv["id"]{
                                                        let ID = (tempID as? NSString)?.doubleValue
                                                        if let id = ID{
                                                            if let tempURL = serv["image"]{
                                                                let URLImage = tempURL as! String
                                                                if let catPictureURL = URL(string: URLImage){
                                                                    let session = URLSession(configuration: .default)
                                                                    let downloadPicTask = session.dataTask(with: catPictureURL) { (dataImage, response, error) in
                                                                        if error != nil {
                                                                            //print("Error downloading cat picture: \(e)")
                                                                        } else {
                                                                            if (response as? HTTPURLResponse) != nil {
                                                                                //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                                if let imageData = dataImage {
                                                                                    let imageToShow = UIImage(data: imageData)
                                                                                    self.headlines.append(Headline(id: Int(id), title: Name, text: description, image: imageToShow!))
                                                                                    
                                                         
                                                                                } else {
                                                                                    print("Couldn't get image: Image is nil")
                                                                                }
                                                                            } else {
                                                                                print("Couldn't get response code for some reason")
                                                                            }
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                self.tableView.reloadData()
                                                                                //print(sender.text!)
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
                            } else {
                                
                            }
                        }
                        
                    }
                }
            })
            dataTask1.resume()
        }
    }*/
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView:UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            as! HeadlineTableViewCell1

        let headline = headlines[indexPath.row]
        cell.headlineTitleLabel?.text = headline.title
        cell.headlineTitleLabel?.font = UIFont(name:"IRANSans", size: 20.0)
        cell.headlineTextLabel?.text = headline.text
        cell.headlineTextLabel?.font = UIFont(name:"IRANSans", size: 12.0)
        cell.headlineImageView?.image = headline.image
        cell.headlineImageView?.contentMode = UIView.ContentMode.scaleToFill
        cell.headlineImageView?.layer.cornerRadius = ((cell.headlineImageView?.frame.size.width)! ) / 2
        cell.headlineImageView?.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let serviceID = headlines[indexPath.row].id
        
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
            serviceDictionary["id"] = String(headlines[indexPath.row].id)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MAP") as? ViewController6
            nextViewController?.serviceDictionary = serviceDictionary
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
    
}
