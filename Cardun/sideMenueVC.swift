//
//  sideMenueVC.swift
//  Cardun
//
//  Created by Shahrokh Jelveh on 3/3/1398 AP.
//  Copyright © 1398 Kom Dare Rayan Sarir. All rights reserved.
//

import UIKit
import Foundation

class sideMenueVC: UITableViewController {

    @IBOutlet weak var deposit: UILabel!
    @IBOutlet weak var supportCell: UIView!
    @IBOutlet weak var rulesCell: UIView!
    @IBOutlet weak var aboutCell: UIView!
    @IBOutlet weak var introCell: UIView!
    @IBOutlet weak var exitCell: UIView!
    @IBOutlet weak var moreLessImage: UIImageView!
    @IBOutlet weak var moreLessText: UIButton!
    var less = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreLessImage.image = UIImage(named: "xiajiantou.png")
        supportCell.isHidden = true
        rulesCell.isHidden = true
        aboutCell.isHidden = true
        exitCell.isHidden = true
        introCell.isHidden = true
        
        if let data1 = UserDefaults.standard.object(forKey: "userData"){
            let data = data1 as! Dictionary<String,Any>
            if let tempCredit = data["credit"]{
                let credit = tempCredit as! String
                deposit.text = "اعتبار شما: " + credit + " ریال"
            }
        }
        less = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func moreLess(_ sender: Any) {
        let rotatedImage = moreLessImage.image!.rotate(radians: .pi)
        moreLessImage.image = rotatedImage
        if less == true{
            supportCell.isHidden = false
            rulesCell.isHidden = false
            aboutCell.isHidden = false
            exitCell.isHidden = false
            introCell.isHidden = false
            moreLessText.setTitle("کمتر", for: .normal)
            less = false
        } else{
            supportCell.isHidden = true
            rulesCell.isHidden = true
            aboutCell.isHidden = true
            exitCell.isHidden = true
            introCell.isHidden = true
            moreLessText.setTitle("بیشتر", for: .normal)
            less = true
        }
    }
    
    @IBAction func Exit(_ sender: Any) {
        let alert = UIAlertController(title: "توجه", message: "آیا از خروج مطمئن هستید؟", preferredStyle: UIAlertController.Style.alert)
        let titFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 17.0)!]
        let msgFont = [NSAttributedString.Key.font: UIFont(name: "IRANSans", size: 13.0)!]
        let titAttrString = NSMutableAttributedString(string: "توجه", attributes: titFont)
        let msgAttrString = NSMutableAttributedString(string: "آیا از خروج مطمئن هستید؟", attributes: msgFont)
        
        alert.setValue(titAttrString, forKey: "attributedTitle")
        alert.setValue(msgAttrString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "خروج", style: UIAlertAction.Style.default, handler: { action in
            switch action.style{
            case .default:
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                self.Exit(0);
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("destructive1")
            }
        }))
        alert.addAction(UIAlertAction(title: "انصراف", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func about(_ sender: Any) {
        
        if let url = URL(string: "http://www.cardun.ir/%d8%af%d8%b1%d8%a8%d8%a7%d8%b1%d9%87-%d9%85%d8%a7/"){
            
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
    
    
    @IBAction func rules(_ sender: Any) {
        
        if let url = URL(string: "http://www.cardun.ir/%d9%82%d9%88%d8%a7%d9%86%db%8c%d9%86-%d9%88-%d9%85%d9%82%d8%b1%d8%a7%d8%b1%d8%aa/"){
            
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
    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 0
    //}

    //override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
    //}
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
