//
//  HeartViewController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/24.
//

import UIKit
import SnapKit
import WebKit

class HeartViewController: BaseViewController {

    let htmlString = """
        <html>
        <body>
        <h1>Welcome to ChatGPT</h1>
        <p>This is an example of displaying HTML content in MLMKwebView.</p>
        <p>Here's a link to <a href="https://www.openai.com">OpenAI</a>.</p>
        </body>
        </html>
"""
    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
    
    
//MARK: - Properties
    let oneView: UIView = {
        $0.backgroundColor = .red
        return $0
    }(UIView())
    
    lazy var webView: WKWebView = {
        $0.backgroundColor = .lightGray
        $0.loadHTMLString(htmlString+headerString, baseURL: nil)
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return $0
    }(WKWebView())
    
//MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIandConstraints()
    }
    
//MARK: - set UI
    func setUIandConstraints() {
        view.addSubview(oneView)
        view.addSubview(webView)
        oneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    
    
    
}
