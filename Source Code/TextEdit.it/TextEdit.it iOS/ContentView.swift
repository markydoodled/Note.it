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
    @State var fileURL: URL
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    @State var activeSheet: ActiveSheet?
    @State var fileTypeAttribute: String
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var fileNameAttribute: String
    @State var filePathAttribute: String
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
    @Environment(\.undoManager) var undoManager
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
                                EditorSettings()
                                ThemesSettings()
                                MiscSettings()
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
                                    Label("Title: \(fileNameAttribute)", systemImage: "textformat.alt")
                                        Label("File Extension: \(fileExtensionAttribute)", systemImage: "square.grid.3x1.folder.badge.plus")
                                        Label("Size: \(fileSizeAttribute)", systemImage: "externaldrive")
                                        Label("File Path: \(filePathAttribute)", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                                        Label("Owner: \(fileOwnerAttribute)", systemImage: "person")
                                        Label("Created: \(fileCreatedAttribute)", systemImage: "calendar.badge.plus")
                                        Label("Modified: \(fileModifiedAttribute)", systemImage: "calendar.badge.clock")
                                        Label("File Type: \(fileTypeAttribute)", systemImage: "doc")
                                }
                                    .navigationTitle("Metadata")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
                                                Text("Done")
                                            }
                                        }
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {fileURL = URL(string: "/")!
                                                    getAttributes()}) {
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
                    Button(action: {}) {
                        Image(systemName: "arrow.uturn.forward")
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
                    Button(action: {}) {
                        Image(systemName: "arrow.uturn.backward")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.uturn.forward")
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
            .sheet(item: $activeSheet) { item in
                        switch item {
                        case .settings:
                            NavigationView {
                                Form {
                                EditorSettings()
                                ThemesSettings()
                                MiscSettings()
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
                                        Label("Title: \(fileNameAttribute)", systemImage: "textformat.alt")
                                            Label("File Extension: \(fileExtensionAttribute)", systemImage: "square.grid.3x1.folder.badge.plus")
                                            Label("Size: \(fileSizeAttribute)", systemImage: "externaldrive")
                                            Label("File Path: \(filePathAttribute)", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                                            Label("Owner: \(fileOwnerAttribute)", systemImage: "person")
                                            Label("Created: \(fileCreatedAttribute)", systemImage: "calendar.badge.plus")
                                            Label("Modified: \(fileModifiedAttribute)", systemImage: "calendar.badge.clock")
                                            Label("File Type: \(fileTypeAttribute)", systemImage: "doc")
                                    }
                                    .navigationTitle("Metadata")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button(action: {activeSheet = nil}) {
                                                Text("Done")
                                            }
                                        }
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button(action: {fileURL = URL(string: "/")!
                                                getAttributes()}) {
                                                Text("Update")
                                            }
                                        }
                                    }
                            }
                        }
                    }
        }
    }
    func getAttributes() {
        let creationDate = fileURL.creationDate
        let modificationDate = fileURL.modificationDate
        let type = fileURL.fileType
        let owner = fileURL.fileOwner
        let size = fileURL.fileSize
        let fileextension = fileURL.pathExtension
        let filePath = fileURL.path
        let fileName = fileURL.lastPathComponent
        fileNameAttribute = fileName
        filePathAttribute = filePath
        fileExtensionAttribute = fileextension
        fileSizeAttribute = Int64(size)
        fileOwnerAttribute = owner
        fileTypeAttribute = type
        fileModifiedAttribute = modificationDate!
        fileCreatedAttribute = creationDate!
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
    
    var fileType: String {
        return attributes?[.type] as? String ?? ""
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    var fileOwner: String {
        return attributes?[.ownerAccountName] as? String ?? ""
    }
}
