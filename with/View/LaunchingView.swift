//
//  ContentView.swift
//  with
//
//  Created by user on 2022/06/29.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = false
    @State private var count = 2
    @State private var isCountDown = true
    
    var body: some View {
        ZStack {
            if(self.isCountDown == true) {
                Image("LaunchScreenImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: loadInitialData)
                    Spacer()
                
                if (isLoading) {
                    ZStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .scaleEffect(1)
                            .offset(y: 80)
                        
                    }
                }
            } else {
                ProfileImageNotificationView()
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
                self.count -= 1
                if self.count == 0 {
                    timer.invalidate()
                    self.isCountDown = false
                }
            }
        }
        
    }
    
    func loadInitialData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            // APIから初期データを取ってきているはず。
            isLoading = false
        })
    }
}

struct ProfileImageNotificationView: View {
    @State private var hasTappedNextButton = false
    var body: some View {
        if(!hasTappedNextButton) {
            Image("ProfileImageNotification")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Button("次へ", role: .none, action: {
                        hasTappedNextButton = true
                    })
                        .buttonStyle(BoldButtonStyle())
                        .frame(width: 170, height: 50)
                        .background(Color("NextButtonColor"))
                        .foregroundColor(Color(red: 0.384, green: 0.384, blue: 0.384))
                        .cornerRadius(25)
                        .offset(y: 250)
                )
            Spacer()
        } else {
            RegistrationAndLoginView()
        }
    }
}

struct BoldButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.font(Font.body.bold())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
