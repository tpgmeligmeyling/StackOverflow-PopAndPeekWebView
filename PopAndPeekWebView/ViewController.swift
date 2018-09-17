//
//  ViewController.swift
//  PopAndPeekWebView
//
//  Created by Thomas Gmelig Meyling on 17/09/2018.
//  Copyright © 2018 jackpotsvr. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private lazy var webViewConfiguration: WKWebViewConfiguration = {
        
        let controller = WKUserContentController()
        
        if let fullScreenScriptFilePath = Bundle.main.path(forResource: "ImageFullScreen", ofType: "js"),
            let fullScreenScriptContents = try? String(contentsOfFile: fullScreenScriptFilePath) {
            let fullScreenScript = WKUserScript(source: fullScreenScriptContents, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            controller.addUserScript(fullScreenScript)
        }
        
        let config = WKWebViewConfiguration()
        
        config.userContentController = controller
        
        return config
    }()
    
    
    private lazy var webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 10), configuration: self.webViewConfiguration)
    
    private let uiDelegate = LinkPreviewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        webView.uiDelegate = uiDelegate
        
        setupExampleWebPage()
    }
    
    func setupExampleWebPage() {
        if let indexHtmlFilePath = Bundle.main.path(forResource: "index", ofType: "html"),
            let indexHtmlString = try? String(contentsOfFile: indexHtmlFilePath) {
            webView.loadHTMLString(indexHtmlString, baseURL: nil)
        }
    }
}

class LinkPreviewDelegate: NSObject, WKUIDelegate {
    
    var provideViewController: (() -> (UIViewController))?
    
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return elementInfo.linkURL?.absoluteString.contains("base64") == true
    }
    
    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        guard let base64StringWithType = elementInfo.linkURL?.absoluteString else { return nil }
        return UIViewController()
    }
    
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        provideViewController?().present(previewingViewController, animated: true)
    }
}
