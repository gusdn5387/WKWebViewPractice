//
//  ViewController.swift
//  WKWebViewPractice
//
//  Created by Byapps on 2022/02/08.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: UIViewController {
    private lazy var presenter = WebViewPresenter(viewController: self)
    
    private let webView = WKWebView()
    private var subWebView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension WebViewController: WebViewProtocol {
    func setupLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupWebView() {
        // webView configuration
        webView.configuration.userContentController = WKUserContentController()
        webView.configuration.websiteDataStore = WKWebsiteDataStore.default()
//        webView.configuration.applicationNameForUserAgent = "";
        
        // webView preferences
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        webView.configuration.defaultWebpagePreferences = preferences
        
        webView.uiDelegate = self
        webView.navigationDelegate = presenter
        
        // 화면 비율
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 뒤로가기 / 앞으로가기 제스쳐
        webView.allowsBackForwardNavigationGestures = true
        
        let linkURL = URL(string: "https://m.likepick.co.kr")!
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        subWebView = WKWebView(frame: .zero, configuration: configuration)
        subWebView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subWebView?.uiDelegate = self
        
        view.addSubview(subWebView!)
        
        subWebView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return subWebView
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        if webView == subWebView {
            subWebView?.removeFromSuperview()
            subWebView = nil
        }
    }
}

