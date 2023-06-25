//
//  Note_it_iOSApp.swift
//  Note.it iOS
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI

@main
struct Note_it_iOSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Note_it_iOSDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
