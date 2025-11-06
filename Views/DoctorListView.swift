//
//  DoctorListView.swift
//  Doctors List
//
//  Created by Mairbek Gairbekov on 5.11.2025.
//

import SwiftUI

struct DoctorListView: View {
    @StateObject private var viewModel = DoctorsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text("Doctor's List")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                    
                    TextField("Поиск", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    HStack(spacing: 8) {
                        Button("По цене") { }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(8)
                        
                        Button("По стажу") { }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(8)
                        
                        Button("По рейтингу") { }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.pink.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .font(.subheadline)
                    .foregroundColor(.pink)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    
                    List(viewModel.doctors) { doctor in
                        NavigationLink(destination: DoctorDetailView(doctor: doctor)) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(alignment: .top, spacing: 16) {
                                    AsyncImage(url: URL(string: doctor.avatar ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    }
                                    placeholder: {
                                        ZStack {
                                            Color.gray.opacity(0.2)
                                            Text("No Foto")
                                                .font(.callout)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .frame(width: 70, height: 70)
                                    .clipShape(.circle)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(doctor.lastName)
                                                .font(.headline)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "heart")
                                                .font(.headline)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 8)
                                        
                                        Text("\(doctor.firstName) \(doctor.patronymic ?? "")")
                                            .font(.headline)
                                        
                                        Text(String(repeating: "⭐️", count: Int(doctor.rating ?? 0)))
                                        
                                        let seniority = doctor.seniority ?? 0
                                        let work = doctor.workExperience?.first
                                        
                                        let years = seniority > 0
                                        ? seniority
                                        : {
                                            guard let start = work?.startDate else { return 0 }
                                            let end = work?.endDate ?? Int(Date().timeIntervalSince1970)
                                            let startDate = Date(timeIntervalSince1970: TimeInterval(start))
                                            let endDate = Date(timeIntervalSince1970: TimeInterval(end))
                                            return Calendar.current.dateComponents([.year], from: startDate, to: endDate).year ?? 0
                                        }()
                                        
                                        HStack {
                                            Text(doctor.specialization.first?.name ?? "")
                                            Text("• стаж \(years) лет")
                                        }
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        
                                        let prices = [
                                            doctor.textChatPrice ?? Int.max,
                                            doctor.videoChatPrice ?? Int.max,
                                            doctor.hospitalPrice ?? Int.max
                                        ]
                                        let minPrice = prices.min() ?? 0
                                        
                                        Text("от \(minPrice) ₽")
                                            .padding(.bottom, 12)
                                        
                                        Button("Записаться") { }
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 14)
                                            .background(.pink)
                                            .cornerRadius(18)
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 1)
                            .padding(.vertical, 4)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
                Divider()
                    .padding(.bottom, 4)
                
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Главная")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "calendar")
                        Text("Приёмы")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "bubble.fill")
                        Text("Чат")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Профиль")
                            .font(.caption)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 6)
                .foregroundColor(.gray)
            }
        .onAppear {
            viewModel.loadDoctors()
        }
    }
}

#Preview {
    DoctorListView()
}



