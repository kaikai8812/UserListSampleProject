//
//  sampleView.swift
//  UserListSampleProject
//
//  Created by 青山凱 on 2023/11/14.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

class DataModel: ObservableObject {
    
    init(name: String = "Some Name", isEnabled: Bool = false) {
        self.name = name
        self.isEnabled = isEnabled
    }
    
    @Published var name = "Some Name"
    @Published var isEnabled = false
    
}

struct MyView: View {
    @StateObject private var model = DataModel() // Create the state object.
    
    
    var body: some View {
        Text(model.name) // Updates when the data model changes.
        MySubView()
            .environmentObject(model)
    }
}

struct MySubView: View {
    @EnvironmentObject var model: DataModel
    
    
    var body: some View {
        Toggle("Enabled", isOn: $model.isEnabled)
    }
}

struct MyInitializableView: View {
    @StateObject private var model: DataModel
    
    
    init(name: String) {
        // SwiftUI ensures that the following initialization uses the
        // closure only once during the lifetime of the view, so
        // later changes to the view's name input have no effect.
        _model = StateObject(wrappedValue: DataModel(name: name))
    }
    
    var hash: Int {
        var hasher = Hasher()
        hasher.combine(model.name)
        hasher.combine(model.isEnabled)
        return hasher.finalize()
    }
    
    var body: some View {
        VStack {
            Text("Name: \(model.name)")
                .id(hash)
            Button(action: {model.name = "tte"}, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
    }
}



#Preview {
    VStack {
        MyInitializableView(name: "Ravi")
        MyInitializableView(name: "Maria")
    }
}
