//
//  WebViewController.swift
//  Wins
//
//  Created by Александр Сетров on 04.06.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    var url: URL!
    var wKWebView: WKWebView!

    private var containerView = UIView()
    private var goBackButton = UIButton()
    private var bar: UIView!
    
    init(urlType: URLType) {
        switch urlType {
        case .privacy:
            self.url = URL(string: "http://winsbackend.us-east-2.elasticbeanstalk.com/privacy_policy.html")
        case .support:
            self.url = URL(string: "http://winsbackend.us-east-2.elasticbeanstalk.com/support")
        }
        super.init(nibName: nil, bundle: nil)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wKWebView = WKWebView(frame: createWKWebViewFrame(size: view.frame.size))
        self.wKWebView.navigationDelegate = self
        self.wKWebView.uiDelegate = self
        
        let request = URLRequest(url: url)
        self.wKWebView.load(request)
        
        self.wKWebView.allowsBackForwardNavigationGestures = true
    }

}

extension WebViewController {
    fileprivate func createWKWebViewFrame(size: CGSize) -> CGRect {
        let navigationHeight: CGFloat = 60
        let height = size.height - 2 * navigationHeight
        return CGRect(x: 0, y: 60, width: size.width, height: height)
    }
    
    func setupUI() {
        
        self.bar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        self.bar.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        self.view.addSubview(self.bar)
        
        self.bar.addSubview(goBackButton)
        
        self.goBackButton.translatesAutoresizingMaskIntoConstraints = false
        self.goBackButton.leftAnchor.constraint(equalTo: self.bar.leftAnchor, constant: 10).isActive = true
        self.goBackButton.centerYAnchor.constraint(equalTo: self.bar.centerYAnchor).isActive = true
        
        self.goBackButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        self.goBackButton.setTitle("Close", for: .normal)
        self.goBackButton.titleLabel?.textColor = .white
        self.goBackButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        self.view.addSubview(wKWebView)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

enum URLType {
    case support, privacy
}
