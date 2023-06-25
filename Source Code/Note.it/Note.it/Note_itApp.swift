//
//  Note_itApp.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI

@main
struct Note_itApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Note_itDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
