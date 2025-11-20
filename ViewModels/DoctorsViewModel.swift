//
//  DoctorsViewModel.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 4.11.2025.
//

import Combine
import Foundation

final class DoctorsViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    @Published var sortOption: String? = nil
    @Published var sortAscending: Bool = true
    @Published var searchDoctor: String = ""

    func changeSort(to option: String) {
        if sortOption == option {
            sortAscending.toggle()
        } else {
            sortOption = option
            sortAscending = true
        }
        sortDoctor()
    }

    var filteredDoctors: [Doctor] {
        let q = searchDoctor.trimmingCharacters(in: .whitespacesAndNewlines)
        var list = doctors

        if !q.isEmpty {
            list = list.filter { doc in
                let specs = doc.specialization ?? []
                return specs.contains { spec in
                    (spec.name ?? "").localizedCaseInsensitiveContains(q)
                }
            }
        }
        return list
    }

    func sortDoctor() {
        switch sortOption {
        case "price":
            doctors.sort {
                sortAscending
                    ? ($0.minPrice < $1.minPrice) : ($0.minPrice > $1.minPrice)
            }

        case "experience":
            doctors.sort {
                sortAscending
                    ? ($0.experience < $1.experience)
                    : ($0.experience > $1.experience)
            }

        case "rating":
            doctors.sort {
                sortAscending
                    ? ($0.rating ?? 0) < ($1.rating ?? 0)
                    : ($0.rating ?? 0) > ($1.rating ?? 0)
            }

        default:
            break
        }
    }

    func loadDoctors() {
        guard
            let url = Bundle.main.url(
                forResource: "test",
                withExtension: "json"
            )
        else {
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
