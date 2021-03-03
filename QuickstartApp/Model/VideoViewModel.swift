//
//  VideoViewModel.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import Foundation

// MARK: Protocol
protocol VideoViewModelProtocol: class {
    var videoListDidChange: ((VideoViewModelProtocol) -> ())? { get set }
    var keyword: String? { get set }
    var nextPageToken: String? { get }
    var videoList: [VideoItem]? { get }
    init()
    func numberOfRowsInSection() -> Int
    func requestVideoList()
}

// MARK: ViewModel
class VideoViewModel: VideoViewModelProtocol{
    var videoListDidChange: ((VideoViewModelProtocol) -> ())?
    var nextPageToken: String?
    var videoList: [VideoItem]? {
        didSet {
            self.videoListDidChange?(self)
        }
    }
    var keyword: String? {
        didSet {
            self.requestVideoList()
        }
    }
    
    required init() {
    }
    
    func isMore() -> Bool {
        guard (self.nextPageToken?.isEmpty ?? false) else {
            return false
        }
        return true
    }
    
    func numberOfRowsInSection() -> Int {
        return self.videoList?.count ?? 0
    }
    
    func requestVideoList() {
        //        var value = String(data: self.keyword, encoding:.utf8)
        var urlQuery = [URLQueryItem]()
        urlQuery.append(URLQueryItem(name: "key", value: "AIzaSyDc2PiPjxiF0CVmGBez42wNnTGITb7qeN8"))
        urlQuery.append(URLQueryItem(name: "part", value: "snippet"))
        urlQuery.append(URLQueryItem(name: "q", value: self.keyword))
        urlQuery.append(URLQueryItem(name: "type", value: "video"))
        urlQuery.append(URLQueryItem(name: "videoSyndicated", value: "true"))
        urlQuery.append(URLQueryItem(name: "regionCode", value: "KR"))
        
        let isMore = (self.nextPageToken?.isEmpty == false)
        if isMore {
            // n 페이지
            urlQuery.append(URLQueryItem(name: "pageToken", value: self.nextPageToken))
        }
        else {
            // 첫 페이지
            // list 초기화
            self.videoList = []
        }
        
        var urlComps = URLComponents(string: "https://www.googleapis.com/youtube/v3/search")!
        urlComps.queryItems = urlQuery
        let callURL = urlComps.url!
        print(callURL)
        
        var request = URLRequest(url: callURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            do {
//                guard let object = try? JSONSerialization.jsonObject(with: data!, options: []),
//                      let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//                      let prettyPrintedString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) else { return }
//
//                print(prettyPrintedString)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try? decoder.decode(VideoInfo.self, from: data!)
//                print("result : " + result.debugDescription)

                self.nextPageToken = result?.nextPageToken
                self.videoList! += result?.items ?? []
            }
            catch let error {
                self.nextPageToken = nil
                print(error.localizedDescription)
            }
        }).resume()
        
    }
}
