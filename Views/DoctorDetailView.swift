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
        _viewModel = StateObject(wrappedValue: DoctorDetailViewModel(doctor: doctor))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                
                Text(viewModel.doctor.specialization.first?.name ?? "Специальность не указана")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, -44)
                
                HStack(alignment: .top, spacing: 12) {
                    AsyncImage(url: URL(string: viewModel.doctor.avatar ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
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
                        Text(viewModel.doctor.lastName)
                            .font(.headline)
                        
                        Text("\(viewModel.doctor.firstName) \(viewModel.doctor.patronymic ?? "")")
                            .font(.headline)
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    let seniority = viewModel.doctor.seniority ?? 0
                    let work = viewModel.doctor.workExperience?.first
                    let years = seniority > 0 ? seniority : {
                        guard let start = work?.startDate else { return 0 }
                        let end = work?.endDate ?? Int(Date().timeIntervalSince1970)
                        let startDate = Date(timeIntervalSince1970: TimeInterval(start))
                        let endDate = Date(timeIntervalSince1970: TimeInterval(end))
                        return Calendar.current.dateComponents([.year], from: startDate, to: endDate).year ?? 0
                    }()
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text("Опыт работы: \(years) лет")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    if let degree = viewModel.doctor.scientificDegreeLabel, !degree.isEmpty {
                        HStack(spacing: 8) {
                            Image(systemName: "graduationcap")
                                .foregroundColor(.gray)
                            Text(degree)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    if let university = viewModel.doctor.higherEducation?.first?.university, !university.isEmpty {
                        HStack(spacing: 8) {
                            Image(systemName: "building.columns")
                                .foregroundColor(.gray)
                            Text(university)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    if let workOrgan = viewModel.doctor.workExperience?.first?.organization, !workOrgan.isEmpty {
                        HStack(spacing: 8) {
                            Image(systemName: "cross.case")
                                .foregroundColor(.gray)
                            Text(workOrgan)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.bottom, 24)
            
            let prices = [
                viewModel.doctor.textChatPrice ?? Int.max,
                viewModel.doctor.videoChatPrice ?? Int.max,
                viewModel.doctor.hospitalPrice ?? Int.max
            ]
            let minPrice = prices.min() ?? 0
            
            HStack {
                Text("Стоимость услуг")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("от \(minPrice) ₽")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 1)
            .padding(.horizontal)
            
            Spacer(minLength: 120)
            
            Button("Записаться") { }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.pink)
                .cornerRadius(18)
                .padding(.horizontal, 24)
                .padding(.bottom, 60)
        }
        .padding(.bottom, 24)
        
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
    
    
}




