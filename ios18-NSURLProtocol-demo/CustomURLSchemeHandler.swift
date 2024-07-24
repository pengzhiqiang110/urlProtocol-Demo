//
//  CustomURLSchemeHandler.swift
//  ios18-NSURLProtocol-demo
//
//  Created by ByteDance on 7/24/24.
//

import WebKit

class CustomURLSchemeHandler: NSObject, WKURLSchemeHandler {
    
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        print("stopLoading")

        guard let url = urlSchemeTask.request.url else {
            return
        }
        
        if url.scheme == "localfile" {
            // 获取本地文件路径
            let filePath = url.path
            let fileURL = URL(fileURLWithPath: filePath)
            
            do {
                let fileData = try Data(contentsOf: fileURL)
                let mimeType = "text/html" // 根据文件类型设置 MIME 类型
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": mimeType])
                
                urlSchemeTask.didReceive(response!)
                urlSchemeTask.didReceive(fileData)
                urlSchemeTask.didFinish()
            } catch {
                urlSchemeTask.didFailWithError(error)
            }
        }
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        // 处理请求停止的情况
        print("stopLoading")

    }
}

