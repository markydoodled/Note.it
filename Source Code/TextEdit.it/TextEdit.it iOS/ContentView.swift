//
//  ContentView.swift
//  TextEdit.it iOS
//
//  Created by Mark Howard on 03/05/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import UniformTypeIdentifiers

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
    @State var showingExport = false
    @State var contentTypeSelection = UTType.plainText
    @State var pickerExportSelection = 1
    var body: some View {
        if horizontalSizeClass == .regular {
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
                                            Button(action: {getDirList()
                                                    getAttributes()}) {
                                                Text("Update")
                                            }
                                        }
                                    }
                            }
                        case .export:
                            NavigationView {
                                VStack {
                                Text("Please Select A File Type To Export To: ")
                                    .bold()
                                    .padding()
                                Picker(selection: $pickerExportSelection, label: Text("Export Type")) {
                                    PickerList1()
                                    PickerList2()
                                    PickerList3()
                                }
                                .pickerStyle(InlinePickerStyle())
                                .padding()
                            }
                                .fileExporter(isPresented: $showingExport, document: document, contentType: contentTypeSelection) { result in
                                    switch result {
                                    case .success(let url):
                                        print("Saved to \(url)")
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                            }
                                .navigationTitle("Export")
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {activeSheet = nil}) {
                                            Text("Done")
                                        }
                                    }
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            if pickerExportSelection == 1 {
                                                contentTypeSelection = .swiftSource
                                            } else if pickerExportSelection == 2 {
                                                contentTypeSelection = .plainText
                                            } else if pickerExportSelection == 3 {
                                                contentTypeSelection = .utf8PlainText
                                            } else if pickerExportSelection == 4 {
                                                contentTypeSelection = .utf16PlainText
                                            } else if pickerExportSelection == 5 {
                                                contentTypeSelection = .utf16ExternalPlainText
                                            } else if pickerExportSelection == 6 {
                                                contentTypeSelection = .utf8TabSeparatedText
                                            } else if pickerExportSelection == 7 {
                                                contentTypeSelection = .xml
                                            } else if pickerExportSelection == 8 {
                                                contentTypeSelection = .yaml
                                            } else if pickerExportSelection == 9 {
                                                contentTypeSelection = .json
                                            } else if pickerExportSelection == 10 {
                                                contentTypeSelection = .html
                                            } else if pickerExportSelection == 11 {
                                                contentTypeSelection = .assemblyLanguageSource
                                            } else if pickerExportSelection == 12 {
                                                contentTypeSelection = .cHeader
                                            } else if pickerExportSelection == 13 {
                                                contentTypeSelection = .cSource
                                            } else if pickerExportSelection == 14 {
                                                contentTypeSelection = .cPlusPlusHeader
                                            } else if pickerExportSelection == 15 {
                                                contentTypeSelection = .cPlusPlusSource
                                            } else if pickerExportSelection == 16 {
                                                contentTypeSelection = .objectiveCPlusPlusSource
                                            } else if pickerExportSelection == 17 {
                                                contentTypeSelection = .objectiveCSource
                                            } else if pickerExportSelection == 18 {
                                                contentTypeSelection = .appleScript
                                            } else if pickerExportSelection == 19 {
                                                contentTypeSelection = .javaScript
                                            } else if pickerExportSelection == 20 {
                                                contentTypeSelection = .shellScript
                                            } else if pickerExportSelection == 21 {
                                                contentTypeSelection = .pythonScript
                                            } else if pickerExportSelection == 22 {
                                                contentTypeSelection = .rubyScript
                                            } else if pickerExportSelection == 23 {
                                                contentTypeSelection = .perlScript
                                            } else if pickerExportSelection == 24 {
                                                contentTypeSelection = .phpScript
                                            } else {
                                                print("Unreconised Export")
                                            }
                                                self.showingExport = true
                                        }) {
                                            Text("Export")
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
                    Button(action: {undoManager?.undo()}) {
                        Image(systemName: "arrow.uturn.backward")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {undoManager?.redo()}) {
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
                    Button(action: {activeSheet = .export}) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        } else {
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
                    Button(action: {undoManager?.undo()}) {
                        Image(systemName: "arrow.uturn.backward")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {undoManager?.redo()}) {
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
                    Button(action: {activeSheet = .export}) {
                        Image(systemName: "square.and.arrow.up")
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
                                            Button(action: {getDirList()
                                                getAttributes()}) {
                                                Text("Update")
                                            }
                                        }
                                    }
                            }
                        case .export:
                            NavigationView {
                                VStack {
                                Text("Please Select A File Type To Export To: ")
                                    .bold()
                                    .padding()
                                Picker(selection: $pickerExportSelection, label: Text("Export Type")) {
                                    PickerList1()
                                    PickerList2()
                                    PickerList3()
                                }
                                .pickerStyle(InlinePickerStyle())
                                .padding()
                            }
                                .fileExporter(isPresented: $showingExport, document: document, contentType: contentTypeSelection) { result in
                                    switch result {
                                    case .success(let url):
                                        print("Saved to \(url)")
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                            }
                                .navigationTitle("Export")
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {activeSheet = nil}) {
                                            Text("Done")
                                        }
                                    }
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            if pickerExportSelection == 1 {
                                                contentTypeSelection = .swiftSource
                                            } else if pickerExportSelection == 2 {
                                                contentTypeSelection = .plainText
                                            } else if pickerExportSelection == 3 {
                                                contentTypeSelection = .utf8PlainText
                                            } else if pickerExportSelection == 4 {
                                                contentTypeSelection = .utf16PlainText
                                            } else if pickerExportSelection == 5 {
                                                contentTypeSelection = .utf16ExternalPlainText
                                            } else if pickerExportSelection == 6 {
                                                contentTypeSelection = .utf8TabSeparatedText
                                            } else if pickerExportSelection == 7 {
                                                contentTypeSelection = .xml
                                            } else if pickerExportSelection == 8 {
                                                contentTypeSelection = .yaml
                                            } else if pickerExportSelection == 9 {
                                                contentTypeSelection = .json
                                            } else if pickerExportSelection == 10 {
                                                contentTypeSelection = .html
                                            } else if pickerExportSelection == 11 {
                                                contentTypeSelection = .assemblyLanguageSource
                                            } else if pickerExportSelection == 12 {
                                                contentTypeSelection = .cHeader
                                            } else if pickerExportSelection == 13 {
                                                contentTypeSelection = .cSource
                                            } else if pickerExportSelection == 14 {
                                                contentTypeSelection = .cPlusPlusHeader
                                            } else if pickerExportSelection == 15 {
                                                contentTypeSelection = .cPlusPlusSource
                                            } else if pickerExportSelection == 16 {
                                                contentTypeSelection = .objectiveCPlusPlusSource
                                            } else if pickerExportSelection == 17 {
                                                contentTypeSelection = .objectiveCSource
                                            } else if pickerExportSelection == 18 {
                                                contentTypeSelection = .appleScript
                                            } else if pickerExportSelection == 19 {
                                                contentTypeSelection = .javaScript
                                            } else if pickerExportSelection == 20 {
                                                contentTypeSelection = .shellScript
                                            } else if pickerExportSelection == 21 {
                                                contentTypeSelection = .pythonScript
                                            } else if pickerExportSelection == 22 {
                                                contentTypeSelection = .rubyScript
                                            } else if pickerExportSelection == 23 {
                                                contentTypeSelection = .perlScript
                                            } else if pickerExportSelection == 24 {
                                                contentTypeSelection = .phpScript
                                            } else {
                                                print("Unreconised Export")
                                            }
                                                self.showingExport = true
                                        }) {
                                            Text("Export")
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
    func getDirList() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let directoryURL = URL(string: paths.path) else {return}
        do {
           let contents = try
           FileManager.default.contentsOfDirectory(at: directoryURL,
                  includingPropertiesForKeys:[.contentAccessDateKey],
                  options: [.skipsHiddenFiles])
               .sorted(by: {
                let date0 = try $0.promisedItemResourceValues(forKeys:[.contentAccessDateKey]).contentAccessDate!
                let date1 = try $1.promisedItemResourceValues(forKeys:[.contentAccessDateKey]).contentAccessDate!
                   return date0.compare(date1) == .orderedAscending
                })
          
            for item in contents {
                guard let t = try? item.promisedItemResourceValues(forKeys:[.contentAccessDateKey]).contentAccessDate
                    else {return}
                print ("\(t)   \(item.lastPathComponent)")
                fileURL = item
            }
        } catch {
            print (error)
        }
}
}

private func copyToClipBoard(textToCopy: String) {
    let paste = UIPasteboard.general
    paste.string = textToCopy
}

enum ActiveSheet: Identifiable {
    case settings, metadata, export
    
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

struct PickerList1: View {
    var body: some View {
        Text("Swift").tag(1)
        Text("Plain Text").tag(2)
        Text("UTF8 Plain Text").tag(3)
        Text("UTF16 Plain Text").tag(4)
        Text("UTF16 External Plain Text").tag(5)
        Text("UTF8 Tab Separated Text").tag(6)
        Text("XML").tag(7)
        Text("YAML").tag(8)
        Text("JSON").tag(9)
        Text("HTML").tag(10)
    }
}

struct PickerList2: View {
    var body: some View {
        Text("Assembly Language").tag(11)
        Text("C Header").tag(12)
        Text("C Source").tag(13)
        Text("C++ Header").tag(14)
        Text("C++ Source").tag(15)
        Text("Objective C++ Source").tag(16)
        Text("Objective C Source").tag(17)
        Text("Apple Script").tag(18)
        Text("JavaScript").tag(19)
        Text("Shell Script").tag(20)
    }
}

struct PickerList3: View {
    var body: some View {
        Text("Python Script").tag(21)
        Text("Ruby Script").tag(22)
        Text("Perl Script").tag(23)
        Text("PHP Script").tag(24)
    }
}
