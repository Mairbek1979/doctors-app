//
//  DoctorDetailViewModel.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.
//

import Combine
import Foundation

class DoctorDetailViewModel: ObservableObject {
    @Published var doctor: Doctor

    init(doctor: Doctor) {
        self.doctor = doctor
    }

    var specializationTitle: String {
        doctor.specialization.first?.name ?? "Специальность не указана"
    }

    var lastNameTitle: String {
        doctor.lastName
    }

    var nameAndPatronymic: String {
        "\(doctor.firstName) \(doctor.patronymic ?? "")"
    }

    var degreeTitle: String? {
        doctor.scientificDegreeLabel
    }

    var university: String? {
        doctor.higherEducation?.first?.university
    }

    var organization: String? {
        doctor.workExperience?.first?.organization
    }
}
