//
//  CombineLessonOneApp.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import SwiftUI

@main
struct CombineLessonOneApp: App {
    
    @State private var vm = DownloadViewModel()
    @State private var subscriberVM = SubscriberViewModel()
    
    var body: some Scene {
        WindowGroup {
            SubscriberView()
                .environment(vm)
                .environment(subscriberVM)
        }
    }
}

