//
//  ContentView.swift
//  Note.it iOS
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers
import SwiftUIPrint
import CodeMirror_SwiftUI

struct ContentView: View {
    @Binding var document: Note_it_iOSDocument
    
    @Environment(\.undoManager) var undoManager
    
    @State var editor = EditorSettings()
    @State var themes = ThemesSettings()
    
    @State var fileURL: URL
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
    
    @State var activeSheet: ActiveSheet?
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    
    @State var isShowingSwiftSourceExport = false
    @State var isShowingPlainTextExport = false
    @State var isShowingXMLExport = false
    @State var isShowingYAMLExport = false
    @State var isShowingJSONExport = false
    @State var isShowingHTMLExport = false
    @State var isShowingAssemblyExport = false
    @State var isShowingCHeaderExport = false
    @State var isShowingCSourceExport = false
    @State var isShowingCPlusPlusHeaderExport = false
    @State var isShowingCPlusPlusSourceExport = false
    @State var isShowingObjectiveCPlusPlusSourceExport = false
    @State var isShowingObjectiveCSourceExport = false
    @State var isShowingAppleScriptExport = false
    @State var isShowingJavaScriptExport = false
    @State var isShowingShellScriptExport = false
    @State var isShowingPythonScriptExport = false
    @State var isShowingRubyScriptExport = false
    @State var isShowingPerlScriptExport = false
    @State var isShowingPHPScriptExport = false
    var body: some View {
        CodeView(theme: themes.theme, code: $document.text, mode: themes.syntax.mode(), fontSize: editor.fontSize, showInvisibleCharacters: editor.showInvisibleCharacters, lineWrapping: editor.lineWrapping)
            .onLoadSuccess {
                getAttributes()
            }
            .onLoadFail { error in
                print("Load Failed: \(error.localizedDescription)")
            }
            .onContentChange { change in
                getAttributes()
            }
            .onAppear {
                if selectedAppearance == 1 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
                } else if selectedAppearance == 2 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
                } else {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
                }
            }
            .onChange(of: selectedAppearance) { app in
                if selectedAppearance == 1 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
                } else if selectedAppearance == 2 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
                } else {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
                }
            }
        .toolbar(id: "quick-actions") {
            ToolbarItem(id: "settings", placement: .primaryAction) {
                Button(action: {activeSheet = .settings}) {
                    Label("Settings", systemImage: "gearshape")
                }
                .help("Settings")
                .keyboardShortcut(",")
            }
            ToolbarItem(id: "metadata", placement: .primaryAction) {
                Button(action: {activeSheet = .metadata}) {
                    Label("Metadata", systemImage: "info.circle")
                }
                .help("Metadata")
                .keyboardShortcut("i")
            }
            ToolbarItem(id: "export", placement: .primaryAction) {
                Button(action: {activeSheet = .export}) {
                    Label("Export", systemImage: "square.and.arrow.up.on.square")
                }
                .help("Export")
                .keyboardShortcut("e")
            }
            ToolbarItem(id: "undo", placement: .secondaryAction) {
                Button(action: {undoManager?.undo()}) {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                }
                .help("Undo")
            }
            ToolbarItem(id: "redo", placement: .secondaryAction) {
                Button(action: {undoManager?.redo()}) {
                    Label("Redo", systemImage: "arrow.uturn.forward")
                }
                .help("Redo")
            }
            ToolbarItem(id: "change-appearance", placement: .secondaryAction) {
                Menu {
                    Button(action: {selectedAppearance = 1}) {
                        Text("Light")
                    }
                    Button(action: {selectedAppearance = 2}) {
                        Text("Dark")
                    }
                    Button(action: {selectedAppearance = 3}) {
                        Text("System")
                    }
                } label: {
                    Label("Appearance", systemImage: "cloud.sun")
                }
                .help("Change Appearance")
            }
            ToolbarItem(id: "copy-doc", placement: .secondaryAction) {
                Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                    Label("Copy", systemImage: "text.badge.plus")
                }
                .help("Copy Text")
                .keyboardShortcut("c", modifiers: [.command, .shift])
            }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .settings:
                NavigationStack {
                    SettingsView()
                }
            case .metadata:
                NavigationStack {
                    metadata
                }
            case .export:
                NavigationStack {
                    export
                }
            }
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
    }
    var metadata: some View {
        Form {
            Section {
                Label("Title - \(fileNameAttribute)", systemImage: "textformat")
                Label("Extension - \(fileExtensionAttribute)", systemImage: "square.grid.3x1.folder.badge.plus")
                Label("Size - \(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))", systemImage: "externaldrive")
                Label("Path - \(filePathAttribute)", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                Label("Owner - \(fileOwnerAttribute)", systemImage: "person")
                Label("Created - \(fileCreatedAttribute.formatted(.dateTime))", systemImage: "calendar.badge.plus")
                Label("Modified - \(fileModifiedAttribute.formatted(.dateTime))", systemImage: "calendar.badge.clock")
                Label("File Type - \(fileTypeAttribute)", systemImage: "doc")
            } footer: {
                Text("Metadata Generated From Last Time The File Was Opened")
            }
        }
        .navigationTitle("Metadata")
    }
    var export: some View {
        Form {
            Group {
                Button(action: {isShowingSwiftSourceExport.toggle()}) {
                    Text("Swift")
                }
                .fileExporter(isPresented: $isShowingSwiftSourceExport, document: document, contentType: .swiftSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPlainTextExport.toggle()}) {
                    Text("Plain Text")
                }
                .fileExporter(isPresented: $isShowingPlainTextExport, document: document, contentType: .plainText, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingXMLExport.toggle()}) {
                    Text("XML")
                }
                .fileExporter(isPresented: $isShowingXMLExport, document: document, contentType: .xml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingYAMLExport.toggle()}) {
                    Text("YAML")
                }
                .fileExporter(isPresented: $isShowingYAMLExport, document: document, contentType: .yaml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJSONExport.toggle()}) {
                    Text("JSON")
                }
                .fileExporter(isPresented: $isShowingJSONExport, document: document, contentType: .json, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingHTMLExport.toggle()}) {
                    Text("HTML")
                }
                .fileExporter(isPresented: $isShowingHTMLExport, document: document, contentType: .html, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAssemblyExport.toggle()}) {
                    Text("Assembly")
                }
                .fileExporter(isPresented: $isShowingAssemblyExport, document: document, contentType: .assemblyLanguageSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCHeaderExport.toggle()}) {
                    Text("C Header")
                }
                .fileExporter(isPresented: $isShowingCHeaderExport, document: document, contentType: .cHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCSourceExport.toggle()}) {
                    Text("C Source")
                }
                .fileExporter(isPresented: $isShowingCSourceExport, document: document, contentType: .cSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCPlusPlusHeaderExport.toggle()}) {
                    Text("C++ Header")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusHeaderExport, document: document, contentType: .cPlusPlusHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            Group {
                Button(action: {isShowingCPlusPlusSourceExport.toggle()}) {
                    Text("C++ Source")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusSourceExport, document: document, contentType: .cPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCPlusPlusSourceExport.toggle()}) {
                    Text("Objective C++")
                }
                .fileExporter(isPresented: $isShowingObjectiveCPlusPlusSourceExport, document: document, contentType: .objectiveCPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCSourceExport.toggle()}) {
                    Text("Objective C")
                }
                .fileExporter(isPresented: $isShowingObjectiveCSourceExport, document: document, contentType: .objectiveCSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAppleScriptExport.toggle()}) {
                    Text("AppleScript")
                }
                .fileExporter(isPresented: $isShowingAppleScriptExport, document: document, contentType: .appleScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJavaScriptExport.toggle()}) {
                    Text("JavaScript")
                }
                .fileExporter(isPresented: $isShowingJavaScriptExport, document: document, contentType: .javaScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingShellScriptExport.toggle()}) {
                    Text("Shell Script")
                }
                .fileExporter(isPresented: $isShowingShellScriptExport, document: document, contentType: .shellScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPythonScriptExport.toggle()}) {
                    Text("Python")
                }
                .fileExporter(isPresented: $isShowingPythonScriptExport, document: document, contentType: .pythonScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingRubyScriptExport.toggle()}) {
                    Text("Ruby")
                }
                .fileExporter(isPresented: $isShowingRubyScriptExport, document: document, contentType: .rubyScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPerlScriptExport.toggle()}) {
                    Text("Perl")
                }
                .fileExporter(isPresented: $isShowingPerlScriptExport, document: document, contentType: .perlScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPHPScriptExport.toggle()}) {
                    Text("PHP")
                }
                .fileExporter(isPresented: $isShowingPHPScriptExport, document: document, contentType: .phpScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationTitle("Export")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PrintSetup(page:
                        VStack {
                            HStack {
                                Text(document.text)
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                )
                .help("Print")
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
        let fileName = fileURL.deletingPathExtension().lastPathComponent
        
        fileNameAttribute = fileName
        filePathAttribute = filePath
        fileExtensionAttribute = fileextension
        fileSizeAttribute = Int64(size)
        fileOwnerAttribute = owner
        fileTypeAttribute = type
        fileModifiedAttribute = modificationDate!
        fileCreatedAttribute = creationDate!
    }
    private func copyToClipBoard(textToCopy: String) {
        let paste = UIPasteboard.general
        paste.string = textToCopy
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Note_it_iOSDocument()), fileURL: URL(string: "/")!, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", fileNameAttribute: "", filePathAttribute: "")
    }
}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute Error: \(error)")
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

enum ActiveSheet: Identifiable {
    case settings, metadata, export
    
    var id: Int {
        hashValue
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

struct PrintSetup<Page>: View where Page: View {
    let page: Page
    var body: some View {
        Button(action: {presentPrintInteractionController(page: page)}) {
            Image(systemName: "printer")
        }
    }
}
