//
//  UserViewState.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/12.
//

import Combine

@MainActor
final class UserViewState: ObservableObject {
    let id: User.ID
    
    let userStore: UserStore = .shared
    
    @Published private(set) var user: User?
    @Published private(set) var isReloadButtonDisabled: Bool = false  //  リロードボタンの活性をview側で判断するためのメソッド
    
    init(id: User.ID) {
        self.id = id
        
        userStore.$values
            .map { values in
                values[id]  //  ここで、どのユーザーかは一意に特定できるっぽいかな
            }
            .assign(to: &$user)
            
    }
    
    //  state側に、user情報の更新を任せる。
    func load() async {
        isReloadButtonDisabled = true
        //  loadメソッドが完了したら、リロードボタンの活性化を復活する。
        defer { isReloadButtonDisabled = false }
        
        do {
            try await userStore.loadValue(for: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func reload() {
        isReloadButtonDisabled = true
        Task {
            await load()
        }
    }
}

//  storeの中の値を、常に参照するような形にする。
