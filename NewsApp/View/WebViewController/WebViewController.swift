//
//  WebViewController.swift
//  NewsApp
//
//  Created by Marta Korol on 10.08.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    
    var webUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
    
    func setupWebView() {
        webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    func loadWebView() {
        guard let url = webUrl else { return }
        // "Must be used from main thread only" but causes warnings "This method should not be called on the main thread as it may lead to UI unresponsiveness."
        // Seems it is Apple's/Xcode's bug for iOS 16
        webView.load(URLRequest(url: url))
    }
}
