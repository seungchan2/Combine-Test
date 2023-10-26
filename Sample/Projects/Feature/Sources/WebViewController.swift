//
//  WebViewController.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/07.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import UIKit
import WebKit

import Service

public struct WebURL {
    let URL: String
}

infix operator ~>: LogicalDisjunctionPrecedence

public final class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    
    public override func loadView() {
        self.view = webView
    }
    
    private var url: WebURL
    
    init(url: WebURL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        bind()
    }
}

private extension WebViewController {
    func setStyle() {
        self.view.backgroundColor = .white
    }
    
    func bind() {
        if let url = URL(string: url.URL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
