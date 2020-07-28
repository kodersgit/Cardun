//
//  searchServices.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 4/24/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class searchServices: UIViewController {
    
    var data2: Dictionary<String,Any> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
    }

    

    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if (segue.identifier == "searchSegue") {
    //        let secondViewController = segue.destination as! TableViewSearchServices

    //        print(self.data2)
    //        secondViewController.data = self.data2
    //    }
    //}

    @IBAction func back(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
        self.present(mainViewController!, animated: true, completion: nil)
    }
}
