//
//  VideoInfo.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import Foundation

// MARK: - VideoInfo
struct VideoInfo: Codable {
    let pageInfo: PageInfo?
    let etag, kind: String?
    let items: [VideoItem]?
    let nextPageToken, regionCode: String?
}

// MARK: - VideoItem
struct VideoItem: Codable {
    var etag, kind: String?
    var id: ID?
    let isMor: Bool
    let snippet: Snippet?
}

// MARK: - ID
struct ID: Codable {
    var kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let thumbnails: Thumbnails?
    let channelID: String?
    let publishTime: Date?
    let title: String?
    let publishedAt: Date?
    let snippetDescription, liveBroadcastContent, channelTitle: String?

    enum CodingKeys: String, CodingKey {
        case thumbnails
        case channelID = "channelId"
        case publishTime, title, publishedAt
        case snippetDescription = "description"
        case liveBroadcastContent, channelTitle
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, high, medium: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case high, medium
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let resultsPerPage, totalResults: Int?
}
