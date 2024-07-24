//
//  CustomURLProtocol.swift
//  ios18-NSURLProtocol-demo
//
//  Created by ByteDance on 7/24/24.
//

import Foundation

class CustomURLProtocol: URLProtocol {
    
    // 检查请求是否应由此协议处理
    override class func canInit(with request: URLRequest) -> Bool {
        // 在这里可以添加更多的逻辑来决定是否处理此请求
        print("canInit with request: \(request)")

        return true
    }
    
    // 实现此方法来处理请求
    override func startLoading() {
        print("Start loading: \(String(describing: request.url))")


        guard let url = request.url else {
            return
        }
        
        // 创建一个新的 URL 请求
        let newRequest = URLRequest(url: url)
        
        // 使用 URLSession 执行请求
        let task = URLSession.shared.dataTask(with: newRequest) { [weak self] data, response, error in
            if let data = data {
                self?.client?.urlProtocol(self!, didReceive: response!, cacheStoragePolicy: .allowed)
                self?.client?.urlProtocol(self!, didLoad: data)
            }
            
            if let error = error {
                self?.client?.urlProtocol(self!, didFailWithError: error)
            }
            
            self?.client?.urlProtocolDidFinishLoading(self!)
        }
        
        task.resume()
    }
    
    // 实现此方法以停止加载
    override func stopLoading() {
        // 清理任何必要的资源
        print("stopLoading")

    }
}

