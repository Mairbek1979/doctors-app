//  DoctorListView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.

import SwiftUI

struct DoctorListView: View {
    @StateObject private var viewModel = DoctorsViewModel()
    
    private let H: CGFloat = 17
    
    @State private var sortOption: String? = nil
    @State private var searchDoctor: String = ""
    @State private var goToSearchResults = false
    
    private var filteredDoctors: [Doctor] {
        let q = searchDoctor.trimmingCharacters(in: .whitespacesAndNewlines)
        var list = viewModel.doctors
        
        if !q.isEmpty {
            list = list.filter { doc in
                let specs = doc.specialization ?? []
                return specs.contains { spec in
                    (spec.name ?? "").localizedCaseInsensitiveContains(q)
                }
            }
        }
        
        switch sortOption {
        case "price":
            return list.sorted {
                let prices1 = [
                    $0.textChatPrice ?? Int.max,
                    $0.videoChatPrice ?? Int.max,
                    $0.homePrice ?? Int.max,
                    $0.hospitalPrice ?? Int.max
                ]
                
                let prices2 = [
                    $1.textChatPrice ?? Int.max,
                    $1.videoChatPrice ?? Int.max,
                    $1.homePrice ?? Int.max,
                    $1.hospitalPrice ?? Int.max
                ]
                
                return (prices1.min() ?? 0) < (prices2.min() ?? 0)
            }
            
        case "experience":
            return list.sorted { a, b in
                func experience(_ d: Doctor) -> Int {
                    if let s = d.seniority, s > 0 { return s }
                    let start = d.workExperience?.first?.startDate ?? 0
                    let end   = d.workExperience?.first?.endDate ?? Int(Date().timeIntervalSince1970)
                    let startDate = Date(timeIntervalSince1970: TimeInterval(abs(start)))
                    let endDate   = Date(timeIntervalSince1970: TimeInterval(abs(end)))
                    let years = Calendar.current.dateComponents([.year], from: startDate, to: endDate).year ?? 0
                    return max(0, min(years, 90))
                }
                
                return experience(a) > experience(b)
            }
            
        case "rating":
            return list.sorted {
                ($0.rating ?? 0) > ($1.rating ?? 0)
            }
            
        default:
            return list
        }
    }
    
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
                            
                            TextField("Поиск", text: $searchDoctor)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .submitLabel(.search)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        if !searchDoctor.isEmpty {
                                            Button(action: {
                                                searchDoctor = ""
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(Color(hex: "B4B4B4"))
                                                    .font(.system(size: 18))
                                                    .padding(.trailing, 8)
                                            }
                                        }
                                    }
                                )
                                .onSubmit {
                                    if !searchDoctor.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
                        
                        NavigationLink(
                            destination: SearchResultsView(
                                searchText: searchDoctor,
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
                                        .stroke(Color(hex: "EBEBEB"), lineWidth: 1)
                                )
                            
                            HStack(spacing: 0) {
                                Button {
                                    sortOption = (sortOption == "price") ? nil : "price"
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(sortOption == "price" ? Color(hex: "FF537C"): .white)
                                            .frame(width: 113, height: 32)
                                        
                                        HStack(spacing: 4) {
                                            Text("По цене")
                                                .font(.custom("SFProDisplay-Semibold", size: 14))
                                                .foregroundColor(
                                                    sortOption == "price"
                                                    ? .white
                                                    : Color(hex: "858585")
                                                )
                                            
                                            Image("arrow_down")
                                        }
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color(hex: "EBEBEB"))
                                    .frame(width: 1, height: 32)
                                
                                Button {
                                    sortOption = (sortOption == "experience") ? nil : "experience"
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(sortOption == "experience" ? Color(hex: "FF537C") : .white)
                                            .frame(width: 115, height: 32)
                                        
                                        Text("По стажу")
                                            .font(.custom("SFProDisplay-Regular", size: 14))
                                            .foregroundColor(
                                                sortOption == "experience"
                                                ? .white
                                                : Color(hex: "858585")
                                            )
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color(hex: "EBEBEB"))
                                    .frame(width: 1, height: 32)
                                
                                Button {
                                    sortOption = (sortOption == "rating") ? nil : "rating"
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(sortOption == "rating" ? Color(hex: "FF537C") : .white)
                                            .frame(width: 113, height: 32)
                                        
                                        Text("По рейтингу")
                                            .font(.custom("SFProDisplay-Regular", size: 14))
                                            .foregroundColor(
                                                sortOption == "rating"
                                                ? .white
                                                : Color(hex: "858585")
                                            )
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(filteredDoctors) { doctor in
                                NavigationLink(destination: DoctorDetailView(doctor: doctor)) {
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
                                                        Image(systemName: index < Int(doctor.rating ?? 0) ? "star.fill" : "star")
                                                            .resizable()
                                                            .frame(width: 12, height: 12)
                                                            .foregroundColor(Color(hex: "FF537C"))
                                                    }
                                                }
                                                
                                                let seniority = doctor.seniority ?? 0
                                                
                                                let work = doctor.workExperience?.first
                                                let years = seniority > 0
                                                ? seniority
                                                : {
                                                    let start = work?.startDate ?? 0
                                                    let end = work?.endDate ?? Int(Date().timeIntervalSince1970)
                                                    
                                                    let startDate = Date(timeIntervalSince1970: TimeInterval(abs(start)))
                                                    let endDate = Date(timeIntervalSince1970: TimeInterval(abs(end)))
                                                    
                                                    return Calendar.current.dateComponents([.year], from: startDate, to: endDate).year ?? 0
                                                }()
                                                
                                                Text("\(doctor.specialization.first?.name ?? "") • стаж \(years) лет")
                                                    .font(.custom("SFProDisplay-Regular", size: 14))
                                                    .foregroundColor(Color(hex: "858585"))
                                                
                                                let prices = [
                                                    doctor.textChatPrice ?? Int.max,
                                                    doctor.videoChatPrice ?? Int.max,
                                                    doctor.homePrice ?? Int.max,
                                                    doctor.hospitalPrice ?? Int.max
                                                ]
                                                
                                                let minPrice = prices.min() ?? 0
                                                
                                                Text("от \(minPrice) ₽")
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

#Preview {
    MainTabView()
}
