//
//  MailViewController.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/01/29.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import Foundation
import MessageUI

class MailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendMail(){
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        let recipients = ["tadakazu1972@gmail.com"]
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("緊急連絡")
        mailViewController.setToRecipients(recipients)
        mailViewController.setMessageBody("メール本文", isHTML: false)
        
        self.presentViewController(mailViewController, animated:true, completion:nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result  {
        case .Cancelled:
            break
        case .Saved:
            break
        case .Sent:
            break
        case .Failed:
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //dataViewControllerのインスタンス生成
        let data:ViewController = ViewController()
        
        //navigationControllerのrootViewControllerにKokuminhogoViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        
        //画面遷移
        self.presentViewController(nav, animated: true, completion: nil)
    }
}