//
//  TabBarViewController.swift
//  InvadersCountdown
//
//  Created by Julia Semyzhenko on 7/24/22.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
           NotificationCenter.default.addObserver(self, selector: #selector(self.TabbarNoitifuntionCall), name: NSNotification.Name(rawValue: "CallTabBarNotificationsCenter"), object: nil) // this code will call when ever you update your value in view controller
       }

       //MARK:- Private Functions
       @objc func TabbarNoitifuntionCall(_ notification: Notification) {
           self.viewControllers![0].title = "ViewController" + String(notification.object as! Int)
           self.viewControllers![1].title = "PersonnelViewController" + String(notification.object as! Int)
          }

       }
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


