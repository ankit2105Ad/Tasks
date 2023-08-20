//
//  AppModels.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import Foundation


public struct LoginResponse : Decodable {
    public var status : Bool?
}

public struct VerifyOtp : Decodable {
    public var token : String?
}


struct Notes : Codable {
    let invites : Invites?
    let likes : Likes?
}

struct Drinking_v1 : Codable {
    let id : Int?
    let name : String?
    let name_alias : String?
}

struct Experience_v1 : Codable {
    let id : Int?
    let name : String?
    let name_alias : String?
}

struct Faith : Codable {
    let id : Int?
    let name : String?
}

struct Field_of_study_v1 : Codable {
    let id : Int?
    let name : String?
}

struct General_information : Codable {
    let date_of_birth : String?
    let date_of_birth_v1 : String?
    let location : Location?
    let drinking_v1 : Drinking_v1?
    let first_name : String?
    let gender : String?
    let marital_status_v1 : Marital_status_v1?
    let ref_id : String?
    let smoking_v1 : Smoking_v1?
    let sun_sign_v1 : Sun_sign_v1?
    let mother_tongue : Mother_tongue?
    let faith : Faith?
    let height : Int?
    let cast : String?
    let kid : String?
    let diet : String?
    let politics : String?
    let pet : String?
    let settle : String?
    let mbti : String?
    let age : Int?
}

struct Highest_qualification_v1 : Codable {
    let id : Int?
    let name : String?
    let preference_only : Bool?
}

struct Industry_v1 : Codable {
    let id : Int?
    let name : String?
    let preference_only : Bool?
}

struct Invites : Codable {
    
    let profilesUser : [Profiles]?
    let totalPages : Int?
    let pending_invitations_count : Int?
    
    enum CodingKeys: String, CodingKey {

        case profilesUser = "profiles"
        case totalPages = "totalPages"
        case pending_invitations_count = "pending_invitations_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profilesUser = try values.decodeIfPresent([Profiles].self, forKey: .profilesUser)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        pending_invitations_count = try values.decodeIfPresent(Int.self, forKey: .pending_invitations_count)
    }
}

struct Likes : Codable {
    let profiles : [ProfilesLikes]?
    let can_see_profile : Bool?
    let likes_received_count : Int?
}

struct Location : Codable {
    let summary : String?
    let full : String?
}

struct Marital_status_v1 : Codable {
    let id : Int?
    let name : String?
    let preference_only : Bool?
}

struct Mother_tongue : Codable {
    let id : Int?
    let name : String?
}

struct Photos : Codable {
    let photo : String?
    let photo_id : Int?
    let selected : Bool?
    let status : String?
}

struct Preference_question : Codable {
    let first_choice : String?
    let second_choice : String?
}

struct Preferences : Codable {
    let answer_id : Int?
    let answer : String?
    let first_choice : String?
    let second_choice : String?
}

struct Profile_data_list : Codable {
    let question : String?
    let preferences : [Preferences]?
    let invitation_type : String?
}

struct ProfilesLikes : Codable {
    let first_name : String?
    let avatar : String?
}

struct Profiles : Codable {
    let general_information : General_information?
    let approved_time : Double?
    let disapproved_time : Double?
    let photos : [Photos]?
    let user_interests : [String]?
    let work : Work?
    let preferences : [Preferences]?
    let instagram_images : String?
    let last_seen_window : String?
    let is_facebook_data_fetched : Bool?
    let icebreakers : String?
    let story : String?
    let meetup : String?
    let verification_status : String?
    let has_active_subscription : Bool?
    let show_concierge_badge : Bool?
    let lat : Double?
    let lng : Double?
    let last_seen : String?
    let online_code : Int?
    let profile_data_list : [Profile_data_list]?

    enum CodingKeys: String, CodingKey {

        case general_information = "general_information"
        case approved_time = "approved_time"
        case disapproved_time = "disapproved_time"
        case photos = "photos"
        case user_interests = "user_interests"
        case work = "work"
        case preferences = "preferences"
        case instagram_images = "instagram_images"
        case last_seen_window = "last_seen_window"
        case is_facebook_data_fetched = "is_facebook_data_fetched"
        case icebreakers = "icebreakers"
        case story = "story"
        case meetup = "meetup"
        case verification_status = "verification_status"
        case has_active_subscription = "has_active_subscription"
        case show_concierge_badge = "show_concierge_badge"
        case lat = "lat"
        case lng = "lng"
        case last_seen = "last_seen"
        case online_code = "online_code"
        case profile_data_list = "profile_data_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        general_information = try values.decodeIfPresent(General_information.self, forKey: .general_information)
        approved_time = try values.decodeIfPresent(Double.self, forKey: .approved_time)
        disapproved_time = try values.decodeIfPresent(Double.self, forKey: .disapproved_time)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
        user_interests = try values.decodeIfPresent([String].self, forKey: .user_interests)
        work = try values.decodeIfPresent(Work.self, forKey: .work)
        preferences = try values.decodeIfPresent([Preferences].self, forKey: .preferences)
        instagram_images = try values.decodeIfPresent(String.self, forKey: .instagram_images)
        last_seen_window = try values.decodeIfPresent(String.self, forKey: .last_seen_window)
        is_facebook_data_fetched = try values.decodeIfPresent(Bool.self, forKey: .is_facebook_data_fetched)
        icebreakers = try values.decodeIfPresent(String.self, forKey: .icebreakers)
        story = try values.decodeIfPresent(String.self, forKey: .story)
        meetup = try values.decodeIfPresent(String.self, forKey: .meetup)
        verification_status = try values.decodeIfPresent(String.self, forKey: .verification_status)
        has_active_subscription = try values.decodeIfPresent(Bool.self, forKey: .has_active_subscription)
        show_concierge_badge = try values.decodeIfPresent(Bool.self, forKey: .show_concierge_badge)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
        last_seen = try values.decodeIfPresent(String.self, forKey: .last_seen)
        online_code = try values.decodeIfPresent(Int.self, forKey: .online_code)
        profile_data_list = try values.decodeIfPresent([Profile_data_list].self, forKey: .profile_data_list)
    }

}

struct PhotosUser : Codable {
    let photo: String?
    let photo_id: String?
    let selected: Bool?
    let status: String?
}

struct Smoking_v1 : Codable {
    let id : Int?
    let name : String?
    let name_alias : String?
}

struct Sun_sign_v1 : Codable {
    let id : Int?
    let name : String?
}

struct Work : Codable {
    let industry_v1 : Industry_v1?
    let monthly_income_v1 : String?
    let experience_v1 : Experience_v1?
    let highest_qualification_v1 : Highest_qualification_v1?
    let field_of_study_v1 : Field_of_study_v1?
}
