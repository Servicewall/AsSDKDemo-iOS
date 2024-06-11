//
//  ViewController.swift
//  AsSDKDemo
//
//  Created by Carl Chen on 2024/4/19.
//

import UIKit
import Toast_Swift
import SwSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var apiTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiTextField.text = UserDefaults().string(forKey: "lastInput")
    }

    @IBAction func sendBtnClicked(_ sender: Any) {
        apiTextField.resignFirstResponder()
        let api = apiTextField.text.flatMap({ urlString in
            if !urlString.hasPrefix("http") {
                return nil
            }
            return urlString
        }).flatMap({ url in
            return URL(string: url)
        })
        if api == nil {
            self.view.makeToast("不合法的 URL 地址")
            return
        }
        
//        let swSDK = SwSDKManager.shared()
        UserDefaults().set(api?.absoluteString, forKey: "lastInput")
        UserDefaults().synchronize()
        
        let request = api.map { url in
            return URLRequest(url: url)
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        sendBtn.isEnabled = false
        let task = session.dataTask(with: request!) { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.sendBtn.isEnabled = true
            }
            if error != nil {
                return
            }
            guard response is HTTPURLResponse else {
                return
            }
            
//            if swSDK.checkCaptcha(with: httpResponse) {
//                swSDK.startCaptcha { headers in
//                    print("captcha success")
//                } failure: { err in
//                    print("captcha failed")
//                }
//                
//                return
//            }
            DispatchQueue.main.async {
                self.view.makeToast("接口请求发送成功")
            }
            print("Got API response")
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}

