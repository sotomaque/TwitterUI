//
//  BaseView.swift
//  TwitterUI
//
//  Created by Enrique Sotomayor on 10/9/21.
//

import SwiftUI

struct BaseView: View {
    
    @State private var showMenu: Bool = false
    
    // hiding native one
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var currentTab = "Home"
    
    // Offset for both drag gestures and showing menu
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0

    // Gesture Offset...
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        let sideBarWidth = getRect().width - 90
        
        NavigationView {
            HStack(spacing: 0) {
                // side menu
                SideMenu(showMenu: $showMenu)
                
                // main tab view
                VStack(spacing: 0) {
                    TabView(selection: $currentTab) {
                        HomeView(showMenu: $showMenu)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Home")
                        
                        Text("Search")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Search")
                        
                        Text("Notifications")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Notifications")
                        
                        Text("Messages")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Messages")
                    }
                    // custom tab bar
                    VStack(spacing: 0) {
                        Divider()
                        HStack(spacing: 0) {
                            // tab buttons
                            TabButton(image: "Home")
                            TabButton(image: "Search")
                            TabButton(image: "Notifications")
                            TabButton(image: "Message")
                        }
                        .padding([.top], 15)
                    }
                  
                }
                .frame(width: getRect().width)
                // BG when a menu is showing..
                .overlay(
                    Rectangle()
                        .fill(
                            Color.primary
                                .opacity(Double((offset / sideBarWidth) / 5))
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }
                )
                
            }
            // max size
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            // Gesture
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value: ))
            )
            // no nav bar title
            // hide nav bar items
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu) { newValue in
            if showMenu && offset == 0 {
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideBarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) { newValue in
            onChange()
        }
    }
    
    func onChange() {
        let sideBarWidth = getRect().width - 90

        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnd(value: DragGesture.Value) {
        let sideBarWidth = getRect().width - 90
        
        let translation = value.translation.width
        
        withAnimation {
            // checking ...
            if translation > 0 {
                if translation > (sideBarWidth / 2) {
                    // show menu
                    offset = sideBarWidth
                    showMenu = true
                } else {
                    
                    // extra case
                    if offset == sideBarWidth {
                        return
                    }
                    
                    offset = 0
                    showMenu = false
                }
            } else {
                if -translation > (sideBarWidth / 2) {
                    offset = 0
                    showMenu = false
                } else {
                    
                    // ignore vertical drags
                    if offset == 0 || !showMenu {
                        return
                    }
                    
                    offset = sideBarWidth
                    showMenu = true
                }
            }
        }
        
        // storing last offset
        lastStoredOffset = offset
        

    }
    
    @ViewBuilder
    func TabButton(image: String ) -> some View {
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .previewDevice("iPhone 13")
    }
}
