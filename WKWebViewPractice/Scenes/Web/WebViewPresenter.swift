//
//  WebViewPresenter.swift
//  WKWebViewPractice
//
//  Created by Byapps on 2022/02/08.
//

import UIKit
import WebKit

protocol WebViewProtocol {
    func setupLayout()
    func setupWebView()
}

final class WebViewPresenter: NSObject {
    private let viewController: WebViewProtocol?
    
    init(viewController: WebViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupLayout()
        viewController?.setupWebView()
    }
}

extension WebViewPresenter: WKNavigationDelegate {
    
}
