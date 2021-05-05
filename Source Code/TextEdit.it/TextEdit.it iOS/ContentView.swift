//
//  ContentView.swift
//  TextEdit.it iOS
//
//  Created by Mark Howard on 03/05/2021.
//

import SwiftUI
import CodeMirror_SwiftUI

struct ContentView: View {
    @Binding var document: TextEdit_it_iOSDocument
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var editor = EditorSettings()
    @State var themes = ThemesSettings()
    @State var showNoURLWarning = false
    @State var fileURL: URL
    @State var showingSettings = false
    var body: some View {
        if horizontalSizeClass == .regular {
            GeometryReader { reader in
              ScrollView {
                CodeView(theme: themes.theme,
                        code: $document.text,
                        mode: themes.syntax.mode(),
                         fontSize: editor.fontSize,
                         showInvisibleCharacters: editor.showInvisibleCharacters,
                         lineWrapping: editor.lineWrapping)
                  .onLoadSuccess {
                    print("Loaded")
                  }
                    .onContentChange { newCodeBlock in
                        if fileURL == URL(string: "/") {
                            self.showNoURLWarning = true
                        } else {
                            self.showNoURLWarning = false
                        }
                    }
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
              }.frame(height: reader.size.height)
            }
        } else {
            NavigationView {
            GeometryReader { reader in
              ScrollView {
                CodeView(theme: themes.theme,
                        code: $document.text,
                        mode: themes.syntax.mode(),
                         fontSize: editor.fontSize,
                         showInvisibleCharacters: editor.showInvisibleCharacters,
                         lineWrapping: editor.lineWrapping)
                  .onLoadSuccess {
                    print("Loaded")
                  }
                    .onContentChange { newCodeBlock in
                        if fileURL == URL(string: "/") {
                            self.showNoURLWarning = true
                        } else {
                            self.showNoURLWarning = false
                        }
                    }
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
              }.frame(height: reader.size.height)
            }
        }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                        Button(action: {self.showingSettings = true
                            if showingSettings == true {
                                print("Settings Is True")
                            }
                        }) {
                            Label("Settings", systemImage: "gearshape")
                        }
                        .sheet(isPresented: $showingSettings) {
                            NavigationView {
                                Text("Text")
                                .navigationTitle("Settings")
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {self.showingSettings = false
                                            if showingSettings == false {
                                                print("false")
                                            }
                                        }) {
                                            Text("Done")
                                        }
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}
