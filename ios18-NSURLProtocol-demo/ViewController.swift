//
//  ViewController.swift
//  ios18-NSURLProtocol-demo
//
//  Created by ByteDance on 7/24/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //新的WKURLSchemeHandler拦截方式，会走拦截方法
//        schemeHandlerMethod()
        
        //旧的URLProtocol拦截方式，需要在didFinishLaunchingWithOptions里面注册
        // 不会走拦截方法
        urlProtocolMethod()

    }
    
    func urlProtocolMethod(){
        // 创建 WKWebView 实例
        let configuration = WKWebViewConfiguration()

        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        self.view.addSubview(webView)
        
        // 加载一个测试 URL
//        if let url = URL(string: "https://www.baidu.com") {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
        

        // 加载本地文件
        if let pngPath = Bundle.main.path(forResource: "test", ofType: "png") {
            let url = URL(fileURLWithPath: pngPath)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func schemeHandlerMethod() {
        // 创建 WKWebViewConfiguration
        let configuration = WKWebViewConfiguration()
        
        // 注册自定义的 URL Scheme Handler
        let customHandler = CustomURLSchemeHandler()
        configuration.setURLSchemeHandler(customHandler, forURLScheme: "localfile")
        
        // 初始化 WKWebView
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        self.view.addSubview(webView)
        
        // 加载本地文件
        if let pngPath = Bundle.main.path(forResource: "test", ofType: "png") {
            let url = URL(string: "localfile://\(pngPath)")!
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }


}

