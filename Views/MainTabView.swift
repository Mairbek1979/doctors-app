//
//  MainTabView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 9.11.2025.

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Главная", systemImage: "house.fill") {
                DoctorListView()
            }

            Tab("Приёмы", systemImage: "calendar") {
                Text("Приёмы")
            }

            Tab("Чат", systemImage: "message.fill") {
                Text("Чат")
            }
            .badge(1)

            Tab("Профиль", systemImage: "person.crop.circle") {
                Text("Профиль")
            }

        }
        .tint(Color(red: 1, green: 0.325, blue: 0.486))
    }
}

#Preview {
    MainTabView()
}
