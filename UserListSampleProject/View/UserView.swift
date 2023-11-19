//
//  UserView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/09.
//

import SwiftUI

struct UserView: View {
    //  idをviewが持つようになる
    let id: User.ID
    
    //  reloadボタンの状態管理も、持つようになる
    @State var isReloadButtonDisabled: Bool = false
    
    //  storeの状態を、直接持つようになる
    @EnvironmentObject var userStore: UserStore
    
    var user: User? {
        userStore.values[id]
    }
    
    func load() async {
        isReloadButtonDisabled = true
        defer { isReloadButtonDisabled = false}
        
        do {
            try await userStore.loadValue(for: id)
        } catch {
            // Error handling
            print(error)
        }
    }
    
    func reload() {
        isReloadButtonDisabled = true
        Task {
            await load()
        }
    }
    
    var body: some View {
        VStack {
            Text(user?.name ?? "User Name Place Holder")
                .redacted(reason: isReloadButtonDisabled ? .placeholder: [])
                .font(.title)
        }
        .task {
        await load()
        }
        
        Button("Reload") {
            reload()
        }
        .disabled(isReloadButtonDisabled)
        
        if isReloadButtonDisabled {
            Text("リロードなう")
        } else {
            Text("表示なう")
        }
    }
}

#Preview {
    UserView(id: "A")
        .environmentObject(UserStore.shared)
}
