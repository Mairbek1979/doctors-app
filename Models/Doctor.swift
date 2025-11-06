//
//  Doctor.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 4.11.2025.
//

import Foundation

struct Doctor: Codable, Identifiable {
    let id: String
    let firstName: String
    let patronymic: String?
    let lastName: String
    let specialization: [Specialization]
    let rating: Double?
    let seniority: Int?
    let textChatPrice: Int?
    let videoChatPrice: Int?
    let hospitalPrice: Int?
    let avatar: String?
    let higherEducation: [Education]?
    let workExperience: [WorkExperience]?
    let scientificDegreeLabel: String?
    let isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case patronymic
            case lastName = "last_name"
            case specialization
            case rating = "ratings_rating"
            case seniority
            case textChatPrice = "text_chat_price"
            case videoChatPrice = "video_chat_price"
            case hospitalPrice = "hospital_price"
            case avatar
            case higherEducation = "higher_education"
            case workExperience = "work_expirience"
            case scientificDegreeLabel = "scientific_degree_label"
            case isFavorite = "is_favorite"
        }
}

// Специализация врача
struct Specialization: Codable {
    let id: Int?
    let name: String?
    let isModerated: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isModerated = "is_moderated"
    }
}

// Образование
struct Education: Codable {
    let id: Int?
    let university: String?
    let specialization: String?
    let qualification: String?
    let startDate: Int?
    let endDate: Int?
    let untilNow: Bool?
    let isModerated: Bool?

    enum CodingKeys: String, CodingKey {
        case id, university, specialization, qualification
        case startDate = "start_date"
        case endDate = "end_date"
        case untilNow = "until_now"
        case isModerated = "is_moderated"
    }
}

// Опыт работы
struct WorkExperience: Codable {
    let id: Int?
    let organization: String?
    let position: String?
    let startDate: Int?
    let endDate: Int?
    let untilNow: Bool?
    let isModerated: Bool?

    enum CodingKeys: String, CodingKey {
        case id, organization, position
        case startDate = "start_date"
        case endDate = "end_date"
        case untilNow = "until_now"
        case isModerated = "is_moderated"
    }
}
