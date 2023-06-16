//
//  SubscriberView.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import SwiftUI
import Combine



struct SubscriberView: View {
    
    @Environment(SubscriberViewModel.self) private var subscriberVM
    @State var textFieldText: String = ""
    
    
    var body: some View {
        VStack {
            Text("\(subscriberVM.count)")
                .font(.largeTitle)
            Text(subscriberVM.textIsValid.description)
            TextField("Type something here", text: $textFieldText)
            Button(action: {
                subscriberVM.showButton.toggle()
            }, label: {
                Text("Button")
                    .opacity(subscriberVM.textIsValid ? 1.0 : 0.3)
                    .foregroundStyle(subscriberVM.showButton ? .blue : .green)
                    .disabled(subscriberVM.textIsValid)
            })
        }
        .onChange(of: textFieldText) {
            if $textFieldText.wrappedValue.count > 3 {
                subscriberVM.textIsValid = true
                print("\(subscriberVM.textIsValid)")
            } else {
                subscriberVM.textIsValid = false
            }
        }
    }
}

#Preview {
    SubscriberView()
        .environment(SubscriberViewModel())
}
