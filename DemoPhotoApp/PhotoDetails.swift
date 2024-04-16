
import Foundation

struct Photo: Codable {
    let id: String
    let slug: String
    let alternativeSlugs: [String: String]?
    let createdAt: String?
    let updatedAt: String?
    let promotedAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: Links?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: String?
    let topicSubmissions: [String: TopicSubmission]?
    let assetType: String?
    let user: User?
    
    private enum CodingKeys: String, CodingKey {
        case id, slug, createdAt = "created_at", updatedAt = "updated_at", promotedAt = "promoted_at", width, height, color, blurHash = "blur_hash", description, altDescription = "alt_description", urls, links, likes, likedByUser = "liked_by_user", currentUserCollections = "current_user_collections", sponsorship, topicSubmissions = "topic_submissions", assetType = "asset_type", user
        case alternativeSlugs = "alternative_slugs"
    }
}

struct Urls: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    let smallS3: String?
}

struct Links: Codable {
    let selfLink: String?
    let html: String?
    let download: String?
    let downloadLocation: String?
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, download, downloadLocation = "download_location"
    }
}

struct TopicSubmission: Codable {
    let status: String?
    let approvedOn: String?
}

struct User: Codable {
    let id: String?
    let updatedAt: String?
    let username: String?
    let name: String?
    let firstName: String?
    let lastName: String?
    let twitterUsername: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let links: UserLinks?
    let profileImage: UserProfileImage?
    let instagramUsername: String?
    let totalCollections: Int?
    let totalLikes: Int?
    let totalPhotos: Int?
    let totalPromotedPhotos: Int?
    let totalIllustrations: Int?
    let totalPromotedIllustrations: Int?
    let acceptedTos: Bool?
    let forHire: Bool?
    let social: Social?
    
    private enum CodingKeys: String, CodingKey {
        case id, updatedAt = "updated_at", username, name, firstName = "first_name", lastName = "last_name", twitterUsername = "twitter_username", portfolioUrl = "portfolio_url", bio, location, links, profileImage = "profile_image", instagramUsername = "instagram_username", totalCollections = "total_collections", totalLikes = "total_likes", totalPhotos = "total_photos", totalPromotedPhotos = "total_promoted_photos", totalIllustrations = "total_illustrations", totalPromotedIllustrations = "total_promoted_illustrations", acceptedTos = "accepted_tos", forHire = "for_hire", social
    }
}

struct UserLinks: Codable {
    let selfLink: String?
    let html: String?
    let photos: String?
    let likes: String?
    let portfolio: String?
    let following: String?
    let followers: String?
    
    private enum CodingKeys: String, CodingKey {
        case selfLink = "self", html, photos, likes, portfolio, following, followers
    }
}

struct UserProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}

struct Social: Codable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?
    let paypalEmail: String?
    
    private enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username", portfolioUrl = "portfolio_url", twitterUsername = "twitter_username", paypalEmail = "paypal_email"
    }
}
