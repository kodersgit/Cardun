//
//  Intro5.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 2/16/1399 AP.
//  Copyright © 1399 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit

class Intro5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func start(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainUI")
            self.present(secondViewController!, animated: true, completion: nil)
        }else{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
            self.present(secondViewController!, animated: true, completion: nil)
            
        }
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
