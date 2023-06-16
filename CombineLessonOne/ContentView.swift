//
//  ContentView.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import SwiftUI
import Observation

struct ContentView: View {
    @Environment(DownloadViewModel.self) private var vm
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title).bold()
                    Text(post.body)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(DownloadViewModel())
    }
}
