//
//  UserView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/09.
//

import SwiftUI

struct UserView: View {
    
    @StateObject private var state: UserViewState
    
    init(id: User.ID) {
        //  StateObjectを更新するときは、_をつけて、更新する
        self._state = .init(wrappedValue: UserViewState(id: id))
    }
    
    var body: some View {
        VStack {
            Text(state.user?.name ?? "User Name Place Holder")
                .redacted(reason: state.isReloadButtonDisabled ? .placeholder: [])
                .font(.title)
        }
        .task {
            await state.load()
        }
        
        Button("Reload") {
            state.reload()
        }
        .disabled(state.isReloadButtonDisabled)
        
        if state.isReloadButtonDisabled {
            Text("リロードなう")
        } else {
            Text("表示なう")
        }
    }
}

#Preview {
    UserView(id: "B")
}
