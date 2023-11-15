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
                .redacted(reason: state.user == nil ? .placeholder: [])
                .font(.title)
        }
        .task {
            await state.load()
        }
    }
}

#Preview {
    UserView(id: "B")
}
