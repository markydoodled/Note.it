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
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    @State var activeSheet: ActiveSheet?
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
            .onAppear {
                if selectedAppearance == 1 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light}
                } else if selectedAppearance == 2 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark}
                } else {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified}
                }
            }
            .onChange(of: selectedAppearance) { app in
                if selectedAppearance == 1 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light}
                } else if selectedAppearance == 2 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark}
                } else {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified}
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {self.selectedAppearance = 1}) {
                            Label("Light", systemImage: "sun.max.fill")
                        }
                        Button(action: {self.selectedAppearance = 2}) {
                            Label("Dark", systemImage: "moon.fill")
                        }
                        Button(action: {self.selectedAppearance = 3}) {
                            Label("System", systemImage: "laptopcomputer")
                        }
                    } label: {
                        Label("Appearance", systemImage: "cloud.sun").font(.title3)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        } else {
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
            .onAppear {
                if selectedAppearance == 1 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light}
                } else if selectedAppearance == 2 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark}
                } else {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified}
                }
            }
            .onChange(of: selectedAppearance) { app in
                if selectedAppearance == 1 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .light}
                } else if selectedAppearance == 2 {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark}
                } else {
                    UIApplication.shared.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified}
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {self.selectedAppearance = 1}) {
                            Label("Light", systemImage: "sun.max.fill")
                        }
                        Button(action: {self.selectedAppearance = 2}) {
                            Label("Dark", systemImage: "moon.fill")
                        }
                        Button(action: {self.selectedAppearance = 3}) {
                            Label("System", systemImage: "laptopcomputer")
                        }
                    } label: {
                        Label("Appearance", systemImage: "cloud.sun").font(.title3)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {activeSheet = .settings}) {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
                ToolbarItem(placement: .status) {
                    Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                        Image(systemName: "doc.on.doc")
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {activeSheet = .metadata}) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(item: $activeSheet) { item in
                        switch item {
                        case .settings:
                            NavigationView {
                                Form {
                                    Section(header: Label("Editor", systemImage: "note.text")) {
                                EditorSettings()
                                }
                                    Section(header: Label("Themes", systemImage: "paintbrush")) {
                                        ThemesSettings()
                                    }
                                    Section(header: Label("Misc.", systemImage: "ellipsis.circle")) {
                                        MiscSettings()
                                    }
                                }
                                .navigationTitle("Settings")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
                                                Text("Done")
                                            }
                                        }
                                    }
                            }
                        case .metadata:
                            NavigationView {
                                Text("Test")
                                    .navigationTitle("Metadata")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
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

private func copyToClipBoard(textToCopy: String) {
    let paste = UIPasteboard.general
    paste.string = textToCopy
}

enum ActiveSheet: Identifiable {
    case settings, metadata
    
    var id: Int {
        hashValue
    }
}
