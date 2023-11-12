//
//  UserView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/09.
//

import SwiftUI

struct UserView: View {
    
    let id: User.ID
    
    @State private var user: User?
    
    var body: some View {
        VStack {
            Text(user?.name ?? "User Name Place Holder")
                .redacted(reason: user == nil ? .placeholder: [])
                .font(.title)
        }
        .task {
            do {
                user = try await UserRepository.fetchValue(id: id)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    UserView(id: "A")
}
