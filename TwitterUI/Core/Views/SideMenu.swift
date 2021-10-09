//
//  SideMenu.swift
//  TwitterUI
//
//  Created by Enrique Sotomayor on 10/9/21.
//

import SwiftUI

struct SideMenu: View {
    
    
    @Binding var showMenu: Bool
    
    var body: some View {
        // side bar vStack
        VStack(alignment: .leading, spacing: 0) {
            
            // content vStack
            VStack(alignment: .leading, spacing: 14) {
                
                // profile pic
                Image("Pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                // name
                Text("iJustine")
                    .font(.title2.bold())
                
                // username
                Text("@iJustine")
                    .font(.callout)
                
                HStack(spacing: 12) {
                    Button {} label: {
                        Label{
                            Text("Followers")
                            .font(.system(size: 16, weight: .light, design: .default))
                        } icon: {
                            Text("4.2M")
                                .fontWeight(.bold)
                        }
                    }
                    //
                    Button {} label: {
                        Label{
                            Text("Following")
                            .font(.system(size: 16, weight: .light, design: .default))
                            
                        } icon: {
                                Text("189")
                                    .fontWeight(.bold)
                        }
                    }
                    
                }
                .foregroundColor(.primary)
       
                
            }
            .padding()
            .padding(.leading)
            .padding(.bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading, spacing: 45) {
                        // side bar buttons
                        TabButton(title: "Profile", image: "Profile")
                        TabButton(title: "Lists", image: "Lists")
                        TabButton(title: "Topics", image: "Topics")
                        TabButton(title: "Bookmarks", image: "Bookmarks")
                        TabButton(title: "Moments", image: "Profile")
                        TabButton(title: "Purchases", image: "Purchases")
                        TabButton(title: "Monetization", image: "Monetization")


                    }
                    .padding()
                    .padding(.leading)
                    .padding(.top, 45)
                    
                    Divider()
                    
                    TabButton(title: "Twitter Ads", image: "Ads")
                        .padding()
                        .padding(.leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 30) {
                        Button("Settings And Privacy") {
                            
                        }
                        Button("Help Center") {
                            
                        }
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)

                }
                
            }
            
            VStack(spacing: 0) {
                Divider()
                
                HStack {
                    Button {} label: {
                         Image("Light")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                        
                    }
                    Spacer()
                    Button {} label: {
                         Image("QR")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                        
                    }
                }
                .padding([.horizontal, .top], 15)
                .foregroundColor(.primary)
            }
            
        }
        .padding(.top)
        .frame(maxWidth: .infinity, alignment: .leading)
        // Max Width...
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(
        
            Color.primary
                .opacity(0.04)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // For navigation simple replace button with navigationLink
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        NavigationLink {
            Text("\(title) view")
                .navigationTitle(title)
        } label: {
            HStack(spacing: 13) {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(showMenu: .constant(false))
            .previewDevice("iPhone 13")
    }
}

// extend vidwe toe get screen rect
extension View {
    func getRect()-> CGRect{
        UIScreen.main.bounds
    }
    
    func safeArea() -> UIEdgeInsets{
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return null
        }
        
        return safeArea
    }
}
