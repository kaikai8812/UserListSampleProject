//
//  UserRepository.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/09.
//

import Foundation

enum UserRepository {
    private static let values: [User.ID: User] = {
        let values: [User] = [
            .init(id: "A", name: "UserA"),
            .init(id: "B", name: "UserB"),
            .init(id: "C", name: "UserC")
        ]
        
        //  辞書型の型を先に指定して、一定のvalueから、直接辞書型を作成することができる。
        return .init(uniqueKeysWithValues: values.map({ user in
            (user.id, user)
        }))
    }()
    
    static func fetchValue(id: User.ID) async throws -> User? {
        try await Task.sleep(nanoseconds: UInt64(1 * 1_000_000_000))
        return values[id]
    }
}
