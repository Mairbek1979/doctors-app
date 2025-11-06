//
//  DoctorsViewModel.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 4.11.2025.
//

import Foundation
import Combine

final class DoctorsViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    
    func loadDoctors() {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
            print("Файл test.json не найден")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            let response = try decoder.decode(Response.self, from: data)
            
            self.doctors = response.data.users
            print("Загружено врачей: \(self.doctors.count)")
        } catch {
            print("Ошибка парсинга JSON: \(error)")
        }
    }
}

struct UserData: Codable {
    let users: [Doctor]
}

struct Response: Codable {
    let data: UserData
}
