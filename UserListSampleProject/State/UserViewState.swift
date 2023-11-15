//
//  UserViewState.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/12.
//

//import Foundation
import Combine
//import SwiftUI

@MainActor
final class UserViewState: ObservableObject {
    let id: User.ID
    
    @Published private(set) var user: User?
    
    init(id: User.ID) {
        self.id = id
    }
    
    //  state側に、user情報の更新を任せる。
    func load() async {
        do {
            user = try await UserRepository.fetchValue(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
