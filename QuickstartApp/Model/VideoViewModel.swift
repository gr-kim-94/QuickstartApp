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
    var videoList: [VideoItem]? { get }
    init()
    func numberOfRowsInSection() -> Int
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
        let it1 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it2 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it3 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it4 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it5 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it6 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))
        let it7 = VideoItem.init(etag: "lh8IIPxZFUhtS4U6KmqTEzPxY6E", kind: "youtube#searchResult", id: ID.init(kind: "youtube#video", videoID: "6R_l5kFjVoc"), snippet: Snippet.init(thumbnails: Thumbnails.init(thumbnailsDefault: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), high: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90), medium: Default.init(url: "https://i.ytimg.com/vi/6R_l5kFjVoc/default.jpg", width: 120, height: 90)), channelID: "UCEjRQ7qrHalnvbC6fqEjprQ", publishTime: Date(), title: "ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ?", publishedAt: Date(), snippetDescription: "RohitSharma ICC Test Rankings : Rohit Sharma ने लगाई 6 पायदान की छलांग, देखिए किस नंबर पर पहुंचे ? For Documentary Films Contact ...", liveBroadcastContent: "none", channelTitle: "Sports Hour"))

        self.videoList = [it1, it2, it3, it4, it5, it6, it7]

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
            self.videoList?.removeAll()
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
//                      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//                      let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
//
//                print(prettyPrintedString)
                
                let result = try? JSONDecoder().decode(VideoInfo.self, from: data!)

//                let jsonArr = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers ) as? Dictionary<String, Any>
//                print(jsonArr as Any)
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
