//
//  ViewController.swift
//  Day25
//
//  Created by Muhammad Usman on 22/11/2019.
//  Copyright © 2019 Muhammad Usman. All rights reserved.
//


import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webKit: WKWebView!
    var progressView: UIProgressView!
    var site: String!
    var websites = [String]()
    
    
    override func loadView() {
        webKit = WKWebView()
        webKit.navigationDelegate = self
        view = webKit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        navigationItem.backBarButtonItem?.title = ""
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webKit, action: #selector(webKit.goForward))
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: webKit, action: #selector(webKit.goBack))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webKit, action: #selector(webKit.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [refresh,progressButton,spacer,back, forward]
        navigationController?.isToolbarHidden = false
        
        webKit.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + site)!
        webKit.load(URLRequest(url: url))
        webKit.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped(){
//        let ac = UIAlertController(title: "Open...", message: "", preferredStyle: .actionSheet)
//        for site in websites {
//            ac.addAction(UIAlertAction(title: site, style: .default, handler: openPage))
//        }
//        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(ac, animated: true)
    }
    
    @objc func openPage(action: UIAlertAction) {
        guard let title = action.title else {return}
        guard let url = URL(string: "https://" + title) else {return}
        webKit.load(URLRequest(url: url))
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        webKit.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webKit.estimatedProgress)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {return}
        
        if let host = url.host {
            for site in websites {
            if host.contains(site){
                decisionHandler(.allow)
                return
            }
            }
        }
        if url.absoluteString != "about:blank"{
            let ac = UIAlertController(title: "Alert", message: "This site is blocked: \(url.absoluteString)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                ac.dismiss(animated: true, completion: nil)
            }))
            present(ac, animated: true, completion: nil)
        }
        decisionHandler(.cancel)
    }

}


