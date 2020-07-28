//
//  ViewController5.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/6/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {

    var service = 0
    var services: Array<Any> = Array()
    


    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
  
        
                for tempServ in services{
                    let serv = tempServ as! Dictionary<String,Any>
                    if let tempID = serv["id"]{
                        let ID = (tempID as? NSString)?.doubleValue
                        if let id = ID{
                            if Int(id) == service {
                                if let tempName = serv["name"]{
                                    let Name = tempName as! String
                                    pageTitle.text = Name
                                }
                            }
                        }
                    }
                }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewSubServices {
            vc.Parent = service
            vc.services = services
        }
    }
    

    @IBAction func Back(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
        self.present(mainViewController!, animated: true, completion: nil)
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
