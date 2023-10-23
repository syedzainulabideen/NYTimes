//
//  ArticleResponse.swift
//  NYTimes
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

// MARK: - ArticleResponse
struct ArticleResponse: Codable {
    var status, copyright: String?
    var numResults: Int?
    var results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
    
    // MARK: - Result
    struct Result: Codable {
        var uri: String?
        var url: String?
        var id, assetID: Int?
        var source, publishedDate, updated, section: String?
        var subsection, nytdsection, adxKeywords: String?
        var byline, type, title, abstract: String?
        var desFacet, orgFacet, perFacet, geoFacet: [String]?
        var media: [Media]?
        var etaID: Int?

        enum CodingKeys: String, CodingKey {
            case uri, url, id
            case assetID = "asset_id"
            case source
            case publishedDate = "published_date"
            case updated, section, subsection, nytdsection
            case adxKeywords = "adx_keywords"
            case byline, type, title, abstract
            case desFacet = "des_facet"
            case orgFacet = "org_facet"
            case perFacet = "per_facet"
            case geoFacet = "geo_facet"
            case media
            case etaID = "eta_id"
        }
    }

    // MARK: - Media
    struct Media: Codable {
        var type, subtype, caption, copyright: String?
        var approvedForSyndication: Int?
        var mediaMetadata: [MediaMetadatum]?

        enum CodingKeys: String, CodingKey {
            case type, subtype, caption, copyright
            case approvedForSyndication = "approved_for_syndication"
            case mediaMetadata = "media-metadata"
        }
    }

    // MARK: - MediaMetadatum
    struct MediaMetadatum: Codable {
        var url: String?
        var format: String?
        var height, width: Int?
    }

}

