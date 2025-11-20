//
//  DoctorDetailView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.
//

import SwiftUI

struct DoctorDetailView: View {
    @StateObject private var viewModel: DoctorDetailViewModel

    init(doctor: Doctor) {
        _viewModel = StateObject(
            wrappedValue: DoctorDetailViewModel(doctor: doctor)
        )
    }

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(spacing: 16) {

                    HStack(alignment: .center, spacing: 16) {

                        AsyncImage(
                            url: URL(string: viewModel.doctor.avatar ?? "")
                        ) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.lastNameTitle)
                                .font(.headline)

                            Text(viewModel.nameAndPatronymic)
                                .font(.headline)
                        }

                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 12)

                    VStack(alignment: .leading, spacing: 10) {

                        HStack(spacing: 8) {
                            Image("time")
                                .resizable()
                                .frame(width: 24, height: 24)

                            Text("Опыт работы: \(viewModel.doctor.experience) лет")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#858585"))
                                .lineSpacing(10)
                        }

                        if let degree = viewModel.degreeTitle {
                            HStack(spacing: 8) {
                                Image("aid")
                                    .resizable()
                                    .frame(width: 24, height: 24)

                                Text(degree)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#858585"))
                                    .lineSpacing(10)
                            }
                        }

                        if let university = viewModel.university {
                            HStack(spacing: 8) {
                                Image("graduation_icon")
                                    .resizable()
                                    .frame(width: 24, height: 24)

                                Text(university)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#858585"))
                                    .lineSpacing(10)
                            }
                        }

                        if let workOrgan = viewModel.organization {
                            HStack(spacing: 8) {
                                Image("location_icon")
                                    .resizable()
                                    .frame(width: 24, height: 24)

                                Text(workOrgan)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#858585"))
                                    .lineSpacing(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    NavigationLink {
                        PriceView(doctor: viewModel.doctor)
                    } label: {
                        HStack {
                            Text("Стоимость услуг")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#212121"))
                                .frame(height: 24)

                            Spacer()

                            Text("от \(viewModel.doctor.minPrice) ₽")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#212121"))
                                .frame(height: 24)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        .frame(width: 375, height: 60)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "#EBEBEB"), lineWidth: 1)
                        )
                        .padding(.top, 0)
                    }
                    .padding(.bottom, 24)
                }
            }

            Button(action: {}) {
                Text("Записаться")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(hex: "#FF537C"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
            .padding(.bottom)
        }
        .navigationTitle(viewModel.specializationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Doctor {
    static var preview: Doctor {
        let url = Bundle.main.url(forResource: "test", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoded = try! JSONDecoder().decode(Response.self, from: data)
        return decoded.data.users.first!
    }
}

#Preview {
    MainTabView()
}
