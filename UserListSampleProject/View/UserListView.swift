//
//  UserListView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/16.
//

import SwiftUI

struct UserListView: View {
    
//    @StateObject private var state: UserListViewState = .init()
    
//    @EnvironmentObject var userStore: UserStore
    
    @Environment(UserStore.self) var userStore
    
    var users: [User] {
            userStore.values.values.sorted(by: { $0.id.rawValue < $1.id.rawValue })
        }
    
    func load() async {
        do {
            try await userStore.loadAllValue()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        List(users) { user in
            NavigationLink {
                UserView(id: user.id)
            } label: {
                Text(user.name)
            }
        }
        .task {
            await load()
        }
                
    }
}

#Preview {
    NavigationStack {  //  navigationStackをつけないと、遷移が機能しない。NavigationLinkを使用しているから？
        UserListView()
    }
    .environment(UserStore.shared)
}
