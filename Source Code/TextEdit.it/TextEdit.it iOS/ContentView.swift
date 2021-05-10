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
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var filePathAttribute: String
    @State var fileCommentsAttribute: String
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
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
                                Form {
                                   MetadataView()
                                }
                                    .navigationTitle("Metadata")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
                                                Text("Done")
                                            }
                                        }
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {}) {
                                                Text("Update")
                                            }
                                        }
                                    }
                            }
                        }
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
                    Button(action: {}) {
                        Image(systemName: "arrow.uturn.backward")
                    }
                }
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
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {activeSheet = .metadata}) {
                        Image(systemName: "info.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.down")
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
                                Form {
                                   MetadataView()
                                }
                                    .navigationTitle("Metadata")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
                                                Text("Done")
                                            }
                                        }
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {}) {
                                                Text("Update")
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

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    var fileOwner: String {
        return attributes?[.ownerAccountName] as? String ?? ""
    }
}

struct MetadataView: View {
    var body: some View {
        List {
            HStack {
                Image(systemName: "textformat.alt")
                    .foregroundColor(.accentColor)
                Text(" Title")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
                Image(systemName: "square.grid.3x1.folder.badge.plus")
                    .foregroundColor(.accentColor)
                Text(" File Extension")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
                Image(systemName: "externaldrive")
                    .foregroundColor(.accentColor)
                Text(" Size")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
               Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                .foregroundColor(.accentColor)
                Text(" File Path")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.accentColor)
                Text(" Owner")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
               Image(systemName: "calendar.badge.plus")
                .foregroundColor(.accentColor)
                Text(" Created")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(.accentColor)
                Text(" Modified")
                Spacer()
                Text("Text")
            }
            .padding(.horizontal)
        }
    }
}
