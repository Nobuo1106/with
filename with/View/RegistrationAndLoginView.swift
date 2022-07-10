//
//  RegistrationAndLoginView.swift
//  with
//
//  Created by user on 2022/07/02.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

extension View {
    func toAnyView() -> AnyView{
        AnyView(self)
    }
}

struct RegistrationAndLoginView: View {
    @State private var isActiveWebView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("RegistrationAndLogin")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                    .overlay(
                        VStack {
                            Button {
                                
                            } label: {
                                Text("新規登録の方はこちら")
                                    .font(.caption)
                                    .fontWeight(.black)
                            }
                            .frame(width: 300, height: 40)
                            .background(Color(red: 0.915, green: 0.447, blue: 0.445))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .offset(y:140)
                            
                            Button {
                                
                            } label: {
                                Text("ログイン")
                                    .font(.caption)
                                    .fontWeight(.black)
                                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(red: 0.915, green: 0.447, blue: 0.445), lineWidth: 2)
                                )
                            }
                            .frame(width: 300, height: 40)
                            .background(.white)
                            .foregroundColor(Color(red: 0.915, green: 0.447, blue: 0.445))
                            .cornerRadius(25)
                            .offset(y:150)
                            
                            Button {
                                isActiveWebView.toggle()
                            } label: {
                                Text("**新規登録・ログインでお困りの方へ**")
                            }
                            .foregroundColor(.white)
                            .font(.caption)
                            .offset(y: 170)
                            .fullScreenCover(isPresented: $isActiveWebView){
                                FullScreenModalView()
                            }
                        }
                    )
            }
        }
        .onAppear(perform: self.requestPermission)
    }
    
    func requestPermission() {
        if #available(iOS 15.0, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("Authorized")
                case .denied:
                    print("Denied")
                case .notDetermined:
                    print("Not Determined")
                case .restricted:
                    print("Restricted ")
                @unknown default: break
                }
            })
        }
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = WebViewModel(url: "https://support.with.is/hc/ja/sections/4417368870681-%E7%99%BB%E9%8C%B2%E3%81%A8%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6")
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                LazyVStack {
                    Text("登録とログインについて ー with")
                        .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.384))
                        .font(.headline)
                        .fontWeight(.bold)
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 0.25)
                }
               
            }
            Button("✖️") {
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.body)
            .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.384))
            .padding()
            .offset(y:-6);
        }
        
        ZStack {
            LoadingView(isLoading: self.$model.isLoading) {
                       UrlWebView(viewModel: self.model, isLoading: self.$model.isLoading)
            }
        }
    }
}

struct RegistrationAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationAndLoginView()
    }
}

