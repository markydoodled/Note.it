//
//  ContentView.swift
//  Note.it iOS
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Note_it_iOSDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Note_it_iOSDocument()))
    }
}
