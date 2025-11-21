//  SearchResultsView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 12.11.2025.
//

import SwiftUI

struct SearchResultsView: View {
    let searchText: String
    let doctors: [Doctor]

    private var filtered: [Doctor] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        return doctors.filter { doc in
            let fullName = "\(doc.lastName) \(doc.firstName) \(doc.patronymic ?? "")"
                .lowercased()

            let matchesName = fullName.contains(q.lowercased())

            let matchesSpecialization = (doc.specialization ?? [])
                .compactMap { $0.name?.lowercased() }
                    .filter { !$0.isEmpty }
                    .contains { $0.contains(q.lowercased())
            }

            return matchesName || matchesSpecialization
        }
    }

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {

                    HStack {
                        Spacer()
                        Text(searchText.capitalized)
                            .font(.title3)
                            .bold()
                            .padding(.top)
                        Spacer()
                    }

                    ForEach(filtered) { doctor in
                        NavigationLink(
                            destination: DoctorDetailView(doctor: doctor)
                        ) {
                            VStack(alignment: .leading, spacing: 12) {

                                HStack(alignment: .top, spacing: 12) {

                                    AsyncImage(
                                        url: URL(string: doctor.avatar ?? "")
                                    ) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.2)
                                    }
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                    VStack(alignment: .leading, spacing: 4) {

                                        Text("\(doctor.lastName)")
                                            .font(
                                                .custom(
                                                    "SFProDisplay-Semibold",
                                                    size: 16
                                                )
                                            )
                                            .foregroundColor(
                                                Color(hex: "212121")
                                            )

                                        Text(
                                            "\(doctor.firstName) \(doctor.patronymic ?? "")"
                                        )
                                        .font(
                                            .custom(
                                                "SFProDisplay-Semibold",
                                                size: 16
                                            )
                                        )
                                        .foregroundColor(Color(hex: "212121"))

                                        HStack(spacing: 2) {
                                            ForEach(0..<5) { index in
                                                Image(
                                                    systemName: index
                                                        < Int(
                                                            doctor.rating ?? 0
                                                        ) ? "star.fill" : "star"
                                                )
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                                .foregroundColor(
                                                    Color(hex: "FF537C")
                                                )
                                            }
                                        }

                                        Text(
                                            "\(doctor.specialization.first?.name ?? "") • стаж \(doctor.experience) лет"
                                        )
                                        .font(
                                            .custom(
                                                "SFProDisplay-Regular",
                                                size: 14
                                            )
                                        )
                                        .foregroundColor(Color(hex: "858585"))

                                        Text("от \(doctor.minPrice) ₽")
                                            .font(
                                                .custom(
                                                    "SFProDisplay-Semibold",
                                                    size: 16
                                                )
                                            )
                                            .foregroundColor(
                                                Color(hex: "212121")
                                            )
                                    }

                                    Spacer()

                                    Image(systemName: "heart")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(hex: "B4B4B4"))
                                }

                                Button(action: {}) {
                                    Text("Записаться")
                                        .font(
                                            .custom(
                                                "SFProDisplay-Semibold",
                                                size: 16
                                            )
                                        )
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color(hex: "FF537C"))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.top, 28)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "EBEBEB"), lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal, 17)
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    MainTabView()
}
