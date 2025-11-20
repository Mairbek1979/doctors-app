//
//  PriceView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 13.11.2025.
//

import SwiftUI

struct PriceView: View {
    let doctor: Doctor

    var body: some View {
        ZStack {
            Color(hex: "#F5F5F5")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Видеоконсультация")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#212121"))

                        PriceRow(
                            title: "30 мин",
                            price: doctor.videoChatPrice ?? 0
                        )
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Чат с врачом")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#212121"))

                        PriceRow(
                            title: "30 мин",
                            price: doctor.textChatPrice ?? 0
                        )
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Приём в клинике")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#212121"))

                        PriceRow(
                            title: "В клинике",
                            price: doctor.hospitalPrice ?? 0
                        )
                    }

                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
            }
        }
        .navigationTitle("Стоимость услуг")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PriceRow: View {
    let title: String
    let price: Int

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(price) ₽")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#EBEBEB"), lineWidth: 1)
        )
    }
}

#Preview {
    MainTabView()
}
