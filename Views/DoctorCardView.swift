//
//  DoctorCardView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 20.11.2025.
//

import SwiftUI

struct DoctorCardView: View {
    let doctor: Doctor

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: doctor.avatar ?? "")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(doctor.lastName)
                        .font(.custom("SFProDisplay-Semibold", size: 16))
                        .foregroundColor(Color(hex: "212121"))

                    Text("\(doctor.firstName) \(doctor.patronymic ?? "")")
                        .font(.custom("SFProDisplay-Semibold", size: 16))
                        .foregroundColor(Color(hex: "212121"))

                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(
                                systemName: index < Int(doctor.rating ?? 0)
                                    ? "star.fill" : "star"
                            )
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(hex: "FF537C"))
                        }
                    }

                    Text(
                        "\(doctor.specialization.first?.name ?? "") • стаж \(doctor.experience) лет"
                    )
                    .font(.custom("SFProDisplay-Regular", size: 14))
                    .foregroundColor(Color(hex: "858585"))

                    Text("от \(doctor.minPrice) ₽")
                        .font(.custom("SFProDisplay-Semibold", size: 16))
                        .foregroundColor(Color(hex: "212121"))
                }

                Spacer()

                Image(systemName: "heart")
                    .font(.system(size: 18))
                    .foregroundColor(Color(hex: "B4B4B4"))
            }

            Button {
            } label: {
                Text("Записаться")
                    .font(.custom("SFProDisplay-Semibold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(hex: "FF537C"))
                    .cornerRadius(8)
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "EBEBEB"), lineWidth: 1)
        )
    }
}

#Preview {
    MainTabView()
}
