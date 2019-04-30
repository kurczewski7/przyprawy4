//
//  ShareViewController.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 14/02/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import MessageUI
protocol ShareViewControllerDelegate {
    
}
class ShareViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    var htmlText = ""
    var smsText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendSMS(with: smsText)
        //sendEmail(with: htmlText)
        
    }
    @IBAction func ShareSms(_ sender: Any) {
        sendSMS(with: smsText)
    }
    @IBAction func ShareButton(_ sender: Any) {
        sendEmail(with: htmlText)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case .sent:
            print("OK")
        case .cancelled:
            print("cancel")
        case .failed:
            print("error")
        default:
            break
        }
        controller.dismiss(animated: true)
    }
    func sendSMS(with text: String) {
        if MFMessageComposeViewController.canSendText() {
            let messageSms = MFMessageComposeViewController()
            messageSms.messageComposeDelegate = self
            messageSms.body = text
            messageSms.recipients=["512589528","515914171"]
            present(messageSms, animated: true, completion: nil)
        }
    }
//    func sendSMS(with text: String) {
//        if MFMessageComposeViewController.canSendText() {
//            let messageComposeViewController = MFMessageComposeViewController()
//            messageComposeViewController.body = text
//            //messageComposeViewController.addAttachmentURL("www.coogle.com", withAlternateFilename: "http://www.gogle.com")
//            present(messageComposeViewController, animated: true, completion: nil)
//        }
//    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
             print("OK")
        case .cancelled:
             print("cancel")
        case .failed:
             print("error")
        case .saved:
             print("saved")
        default: break
        }
        controller.dismiss(animated: true)
    }
    func sendEmail(with html: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kurczewski7@gmail.com","slawomir.kurczewski@gmail.com"])
            mail.setSubject("setSubject: Przyprawy")
            mail.setMessageBody(html, isHTML: true)
            present(mail, animated: true)
        } else {
           print("Error")
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
