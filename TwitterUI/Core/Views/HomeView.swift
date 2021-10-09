//
//  HomeView.swift
//  TwitterUI
//
//  Created by Enrique Sotomayor on 10/9/21.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image("Pic")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                    Spacer()
                    
                    // nav link
                    NavigationLink {
                        Text("Timeline View")
                            .navigationTitle("Timeline")
                    } label: {
                        Image("Sparkles")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                Divider()
            }
            .overlay(
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            )
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMenu: Binding.constant(true))
    }
}
