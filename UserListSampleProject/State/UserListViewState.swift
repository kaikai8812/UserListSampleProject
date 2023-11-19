////
////  UserListViewState.swift
////  UserListSampleProject
////
////  Created by 青山凱 on 2023/11/16.
////
//
//import Combine
//
//@MainActor
//final class UserListViewState: ObservableObject {
//    
//    let userStore: UserStore = .shared
//    
//    @Published private(set) var users: [User] = []
//    
//    init() {
//        //  stateがinitされる時点で、userStoreが持っているvaluesを、stateのusersにアサインしておく。
//        // そうすることで、storeの値が更新されると、stateのusersも自動的に更新がされていく。
//        userStore.$values
//            .map { values in
//                values.values.sorted { user1, user2 in
//                    user1.id.rawValue > user2.id.rawValue
//                }
//            }
//            .assign(to: &$users)
//    }
//    
//    //  更新をする際は、いろんな箇所から参照している、store自体を更新することで、他のViewでも苦心が反映されるようになる。
//    func load() async {
//        do {
//            try await userStore.loadAllValue()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
