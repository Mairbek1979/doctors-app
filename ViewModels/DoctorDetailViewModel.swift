//
//  DoctorDetailViewModel.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.
//

import Foundation
import Combine

class DoctorDetailViewModel: ObservableObject {
    @Published var doctor: Doctor
    
    init(doctor: Doctor) {
        self.doctor = doctor
    }
}
