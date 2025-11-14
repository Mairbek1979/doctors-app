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
        VStack(spacing: 0) {
            
            Text(viewModel.doctor.specialization.first?.name ?? "Специальность не указана")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color(hex: "#212121"))
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .padding(.top, 44)
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        
                        AsyncImage(url: URL(string: viewModel.doctor.avatar ?? "")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.doctor.lastName)
                                .font(.headline)
                            
                            Text("\(viewModel.doctor.firstName) \(viewModel.doctor.patronymic ?? "")")
                                .font(.headline)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
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
                            Image("time")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("Опыт работы: \(years) лет")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#858585"))
                                .lineSpacing(10)
                        }
                        
                        if let degree = viewModel.doctor.scientificDegreeLabel, !degree.isEmpty {
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
                        
                        if let university = viewModel.doctor.higherEducation?.first?.university,
                           !university.isEmpty {
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
                        
                        if let workOrgan = viewModel.doctor.workExperience?.first?.organization,
                           !workOrgan.isEmpty {
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
                    
                    let prices = [
                        viewModel.doctor.textChatPrice ?? Int.max,
                        viewModel.doctor.videoChatPrice ?? Int.max,
                        viewModel.doctor.hospitalPrice ?? Int.max
                    ]
                    
                    let minPrice = prices.min() ?? 0
                    
                    NavigationLink {
                        PriceView(doctor: viewModel.doctor)
                    } label: {
                        HStack {
                            Text("Стоимость услуг")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#212121"))
                                .frame(height: 24)
                            
                            Spacer()
                            
                            Text("от \(minPrice) ₽")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(hex: "#212121"))
                                .frame(height: 24)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 18)
                        .frame(maxWidth: 343)
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
