
import Foundation

// MARK: - MusicVideoFeed
struct MusicVideoFeed: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [Result]
}

// MARK: - Author
struct Author: Codable {
    let name: String
    let url: String
}

// MARK: - Link
struct Link: Codable {
    let linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result
struct Result: Codable {
    let artistName, id, name, releaseDate: String
    let kind: Kind
    let artistID: String
    let artistURL: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: Name
}

enum Name: String, Codable {
    case kPop = "K-Pop"
    case 팝 = "팝"
}

enum Kind: String, Codable {
    case musicVideos = "music-videos"
}

