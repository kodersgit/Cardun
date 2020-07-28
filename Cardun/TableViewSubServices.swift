//
//  TableViewSubServices.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/7/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : UIImage
    var tooltip : String
    
}

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
}


class TableViewSubServices: UITableViewController {
    var serviceDictionary = ["name": "", "latitude": 0.0 , "longitude": 0.0, "descript": "", "address": "", "imageString": "", "id": ""] as [String : Any]
    
    var Parent = 0
    var services: Array<Any> = Array()
    
    var headlines : [Headline]  = [Headline]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
                for tempServ in services{
                    let serv = tempServ as! Dictionary<String,Any>
                    if let tempParent = serv["parent"]{
                        let PARENT = (tempParent as? NSString)?.doubleValue
                        if let parent = PARENT{
                            if Int(parent) == Parent {
                                if let tempName = serv["name"]{
                                    let Name = tempName as! String
                                    if let tempDescription = serv["description"]{
                                        let description = tempDescription as! String
                                        if let tempID = serv["id"]{
                                            let ID = (tempID as? NSString)?.doubleValue
                                            if let id = ID{
                                                if let temptip = serv["tooltip"]{
                                                    let tip = temptip as! String
                                                    if let tempURL = serv["image"]{
                                                        let URLImage = tempURL as! String
                                                        if let catPictureURL = URL(string: URLImage){
                                                            let session = URLSession(configuration: .default)
                                                            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                                                            if error != nil {
                                                                //print("Error downloading cat picture: \(e)")
                                                            } else {
                                                                if (response as? HTTPURLResponse) != nil {
                                                                    //print("Downloaded cat picture with response code \(res.statusCode)")
                                                                    if let imageData = data {
                                                                        let imageToShow = UIImage(data: imageData)
                                                                        self.headlines.append(Headline(id: Int(id), title: Name, text: description, image: imageToShow!, tooltip: tip))
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
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(headlines.count)
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            as! HeadlineTableViewCell
                
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
            serviceDictionary["id"] = String(headlines[indexPath.row].id) as String
            serviceDictionary["tip"] = headlines[indexPath.row].tooltip as String
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MAP") as? ViewController6
            nextViewController?.serviceDictionary = serviceDictionary
            self.present(nextViewController!, animated: true, completion: nil)
        }
    }
        
}
