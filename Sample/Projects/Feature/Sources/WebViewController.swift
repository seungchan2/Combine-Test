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

infix operator ~>: LogicalDisjunctionPrecedence

public final class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    
    public override func loadView() {
        self.view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

private extension WebViewController {
    func setStyle() {
        self.view.backgroundColor = .white
        
   
    }
    
    func bind() {
        
    }
}
