//
//  UserList.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct UserList : Codable {
    let id : String?
    let created_at : String?
    let width : Int?
    let height : Int?
    let color : String?
    let likes : Int?
    let liked_by_user : Bool?
    let user : User?
    let current_user_collections : [String]?
    let urls : Urls?
    let categories : [Categories]?
    let links : Links?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case created_at = "created_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case likes = "likes"
        case liked_by_user = "liked_by_user"
        case user = "user"
        case current_user_collections = "current_user_collections"
        case urls = "urls"
        case categories = "categories"
        case links = "links"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
    
}


struct User : Codable {
    let id : String?
    let username : String?
    let name : String?
    let profile_image : Profile_image?
    let links : Links?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case username = "username"
        case name = "name"
        case profile_image = "profile_image"
        case links = "links"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(Profile_image.self, forKey: .profile_image)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
    
}


struct Urls : Codable {
    let raw : String?
    let full : String?
    let regular : String?
    let small : String?
    let thumb : String?
    
    enum CodingKeys: String, CodingKey {
        
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw = try values.decodeIfPresent(String.self, forKey: .raw)
        full = try values.decodeIfPresent(String.self, forKey: .full)
        regular = try values.decodeIfPresent(String.self, forKey: .regular)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }
    
}


struct Categories : Codable {
    let id : Int?
    let title : String?
    let photo_count : Int?
    let links : Links?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case photo_count = "photo_count"
        case links = "links"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        photo_count = try values.decodeIfPresent(Int.self, forKey: .photo_count)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
    
}


struct Links : Codable {
    let selfString : String?
    let html : String?
    let download : String?
    
    enum CodingKeys: String, CodingKey {
        
        case selfString = "self"
        case html = "html"
        case download = "download"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfString = try values.decodeIfPresent(String.self, forKey: .selfString)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        download = try values.decodeIfPresent(String.self, forKey: .download)
    }
    
}


struct Profile_image : Codable {
    let small : String?
    let medium : String?
    let large : String?
    
    enum CodingKeys: String, CodingKey {
        
        case small = "small"
        case medium = "medium"
        case large = "large"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        large = try values.decodeIfPresent(String.self, forKey: .large)
    }
    
}
