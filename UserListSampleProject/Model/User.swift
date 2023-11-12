//
//  User.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/06.
//

import SwiftID

struct User: Identifiable, Sendable {
    var id: ID
    var name: String
    
    struct ID: StringIDProtocol {
        var rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

public protocol StringIDProtocol: IDProtocol, ExpressibleByStringInterpolation where RawValue: StringProtocol {}

extension StringIDProtocol {
    public init(stringLiteral value: RawValue.StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: value))
    }

    public init(stringInterpolation: RawValue.StringInterpolation) {
        self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
    }
}
