//
//  WebVC.swift
//  ios-articles
//
//  Created by Galileo Guzman on 02/11/20.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://apple.com/")
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true
    }
}
