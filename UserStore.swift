//
//  UserStore.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/17.
//

import Combine

//  Storeは、ユーザー情報がシングルソースとして、溜まっているところ、と理解すれば良さそう。
//  ここから、情報を取得することで、矛盾のない状態のデータを、それぞれのViewが取得することができる。

@MainActor
final class UserStore: ObservableObject {
    // 辞書型で、valuesを保持する。
    @Published private(set) var values: [User.ID: User] = [:]
    
    static let shared: UserStore = .init()
    
    func loadValue(for id: User.ID) async throws {
        if let value = try await UserRepository.fetchValue(id: id) {
            values[value.id] = value
        } else {
            values.removeValue(forKey: id)
        }
    }
    
    func loadAllValue() async throws {
        let values = try await UserRepository.fetchAllValue()
        self.values = .init(uniqueKeysWithValues: values.map { ($0.id, $0) })
    }
}
