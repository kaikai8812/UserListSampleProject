//
//  UserListView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/16.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject private var state: UserListViewState = .init()
    
    var body: some View {
        List(state.users) { user in
            NavigationLink {
                UserView(id: user.id)
            } label: {
                Text(user.name)
            }
        }
        .task {
            await state.load()
        }
                
    }
}

#Preview {
    NavigationStack {  //  navigationStackをつけないと、遷移が機能しない。NavigationLinkを使用しているから？
        UserListView()
    }
}
