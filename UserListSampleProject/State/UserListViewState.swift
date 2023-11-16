//
//  UserListViewState.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/16.
//

import Combine

@MainActor
final class UserListViewState: ObservableObject {
    
    @Published private(set) var users: [User] = []
    
    func load() async {
        do {
            users = try await UserRepository.fetchAllValue()
        } catch {
            print(error.localizedDescription)
        }
    }
}
