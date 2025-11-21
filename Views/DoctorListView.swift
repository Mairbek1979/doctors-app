//  DoctorListView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.

import SwiftUI

struct DoctorListView: View {
    @StateObject private var viewModel = DoctorsViewModel()

    private let H: CGFloat = 17

    @State private var goToSearchResults = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {

                        HStack {
                            Spacer()
                            Text("Doctor's List")
                                .font(.title3)
                                .bold()
                                .padding(.top)
                            Spacer()
                        }

                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: "B4B4B4"))
                                .font(.system(size: 16))
                                .padding(.leading, 8)

                            TextField("Поиск", text: $viewModel.searchDoctor)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .submitLabel(.search)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        if !viewModel.searchDoctor.isEmpty {
                                            Button(action: {
                                                viewModel.searchDoctor = ""
                                            }) {
                                                Image(
                                                    systemName:
                                                        "xmark.circle.fill"
                                                )
                                                .foregroundColor(
                                                    Color(hex: "B4B4B4")
                                                )
                                                .font(.system(size: 18))
                                                .padding(.trailing, 8)
                                            }
                                        }
                                    }
                                )
                                .onSubmit {
                                    if !viewModel.searchDoctor
                                        .trimmingCharacters(
                                            in: .whitespacesAndNewlines
                                        ).isEmpty
                                    {
                                        goToSearchResults = true
                                    }
                                }
                        }
                        .frame(height: 36)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "EBEBEB"), lineWidth: 1)
                        )
                        .padding(.horizontal, H)

                        NavigationLink(
                            destination: SearchResultsView(
                                searchText: viewModel.searchDoctor,
                                doctors: viewModel.doctors
                            ),
                            isActive: $goToSearchResults
                        ) {
                            EmptyView()
                        }
                        .hidden()

                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .frame(height: 32)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            Color(hex: "EBEBEB"),
                                            lineWidth: 1
                                        )
                                )

                            HStack(spacing: 0) {
                                Button {
                                    viewModel.changeSort(to: "price")
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                viewModel.sortOption == "price"
                                                    ? Color(hex: "FF537C")
                                                    : .white
                                            )
                                            .frame(
                                                maxWidth: .infinity,
                                                minHeight: 36
                                            )

                                        HStack(spacing: 4) {
                                            Text("По цене")
                                                .font(
                                                    .custom(
                                                        "SFProDisplay-Semibold",
                                                        size: 14
                                                    )
                                                )
                                                .foregroundColor(
                                                    viewModel.sortOption
                                                        == "price"
                                                        ? .white
                                                        : Color(hex: "858585")
                                                )

                                            Image("arrow_down")
                                                .rotationEffect(
                                                    viewModel.sortOption
                                                        == "price"
                                                        ? (viewModel
                                                            .sortAscending
                                                            ? .degrees(180)
                                                            : .degrees(0))
                                                        : .degrees(0)
                                                )
                                        }
                                    }
                                }

                                Rectangle()
                                    .fill(Color(hex: "EBEBEB"))
                                    .frame(width: 1, height: 32)

                                Button {
                                    viewModel.changeSort(to: "experience")
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                viewModel.sortOption
                                                    == "experience"
                                                    ? Color(hex: "FF537C")
                                                    : .white
                                            )
                                            .frame(
                                                maxWidth: .infinity,
                                                minHeight: 36
                                            )

                                        HStack(spacing: 4) {
                                            Text("По стажу")
                                                .font(
                                                    .custom(
                                                        "SFProDisplay-Regular",
                                                        size: 14
                                                    )
                                                )
                                                .foregroundColor(
                                                    viewModel.sortOption
                                                        == "experience"
                                                        ? .white
                                                        : Color(hex: "858585")
                                                )

                                            Image("arrow_down")
                                                .rotationEffect(
                                                    viewModel.sortOption
                                                        == "experience"
                                                        ? (viewModel
                                                            .sortAscending
                                                            ? .degrees(180)
                                                            : .degrees(0))
                                                        : .degrees(0)
                                                )
                                        }
                                    }
                                }

                                Rectangle()
                                    .fill(Color(hex: "EBEBEB"))
                                    .frame(width: 1, height: 32)

                                Button {
                                    viewModel.changeSort(to: "rating")
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                viewModel.sortOption == "rating"
                                                    ? Color(hex: "FF537C")
                                                    : .white
                                            )
                                            .frame(
                                                maxWidth: .infinity,
                                                minHeight: 36
                                            )

                                        HStack(spacing: 4) {
                                            Text("По рейтингу")
                                                .font(
                                                    .custom(
                                                        "SFProDisplay-Regular",
                                                        size: 14
                                                    )
                                                )
                                                .foregroundColor(
                                                    viewModel.sortOption
                                                        == "rating"
                                                        ? .white
                                                        : Color(hex: "858585")
                                                )

                                            Image("arrow_down")
                                                .rotationEffect(
                                                    viewModel.sortOption
                                                        == "rating"
                                                        ? (viewModel
                                                            .sortAscending
                                                            ? .degrees(180)
                                                            : .degrees(0))
                                                        : .degrees(0)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, H)

                        VStack(spacing: 16) {
                            ForEach(viewModel.filteredDoctors) { doctor in
                                NavigationLink(
                                    destination: DoctorDetailView(
                                        doctor: doctor
                                    )
                                ) {
                                    DoctorCardView(doctor: doctor)
                                }
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal, H)
                    }
                }
                .onAppear {
                    viewModel.loadDoctors()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
