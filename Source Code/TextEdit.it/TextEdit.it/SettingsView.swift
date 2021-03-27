//
//  SettingsView.swift
//  TextEdit.it
//
//  Created by Mark Howard on 21/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    @AppStorage("tabSelection") var tabSelection = 1
    @AppStorage("appTheme") var appTheme: String = "system"
    @AppStorage("selectedSyntax") var selectedSyntax = 1
    @AppStorage("selectedTheme") var selectedTheme = 0
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    var themes = CodeViewTheme.allCases.sorted {
      return $0.rawValue < $1.rawValue
    }
    private let modesList = CodeMode.list()
    var body: some View {
        TabView(selection: $tabSelection) {
            Form {
                HStack {
                    VStack {
                VStack {
                    Text("New Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .newCommand)
                        Spacer()
                    }
                }
                VStack {
                    Text("Open Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .openCommand)
                        Spacer()
                    }
                }
                VStack {
                    Text("Save Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .saveCommand)
                        Spacer()
                    }
                }
                    }
                    VStack {
                        VStack {
                            Text("Copy Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .copyCommand)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Print Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .printCommand)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Duplicate Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .duplicateCommand)
                                Spacer()
                            }
                        }
                    }
                    VStack {
                        VStack {
                            Text("Move To... Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .moveToCommand)
                                Spacer()
                            }
                        }
                    }
            }
            }
            .padding(20)
            .frame(width: 600, height: 300)
            .tag(1)
            .tabItem {
                Label("Keyboard", systemImage: "keyboard")
            }
            Form {
                VStack {
                    HStack {
                        Spacer()
                        Stepper("Font Size: \(fontSize)", value: $fontSize, in: 1...120)
                        Spacer()
                    }
                    HStack {
                        Text("Appearance: ")
                        Button(action: {NSApp.appearance = NSAppearance(named: .aqua)
                            appTheme = "light"}) {
                        Text("Light")
                        }
                        .padding(.horizontal)
                        Button(action: {NSApp.appearance = NSAppearance(named: .darkAqua)
                            appTheme = "dark"}) {
                        Text("Dark")
                        }
                        .padding(.trailing)
                        Button(action: {NSApp.appearance = nil
                            appTheme = "system"}) {
                        Text("System")
                        }
                        .padding(.trailing)
                    }
                    Toggle(isOn: $lineWrapping) {
                        Text("Line Wrapping")
                    }
                    .toggleStyle(SwitchToggleStyle())
                    Toggle(isOn: $showInvisibleCharacters) {
                        Text("Show Invisible Characters")
                    }
                    .toggleStyle(SwitchToggleStyle())
                }
            }
            .padding(20)
            .frame(width: 400, height: 150)
            .tag(2)
            .tabItem {
                Label("Editor", systemImage: "note.text")
            }
            Form {
                Picker(selection: $selectedTheme, label: Text("Theme: ")) {
                  ForEach(0 ..< themes.count) {
                    Text(self.themes[$0].rawValue)
                  }
                }
                Picker(selection: $selectedSyntax, label: Text("Syntax Highlighting: ")) {
                    Group {
                    Button(action: {}) {
                        Text("apl")
                    }
                    .tag(1)
                    Button(action: {}) {
                        Text("pgp")
                    }
                    .tag(2)
                    Button(action: {}) {
                        Text("asn")
                    }
                    .tag(3)
                    Button(action: {}) {
                        Text("cmake")
                    }
                    .tag(4)
                    Button(action: {}) {
                        Text("c")
                    }
                    .tag(5)
                    Button(action: {}) {
                        Text("cplus")
                    }
                    .tag(6)
                    Button(action: {}) {
                        Text("objc")
                    }
                    .tag(7)
                    Button(action: {}) {
                        Text("kotlin")
                    }
                    .tag(8)
                    Button(action: {}) {
                        Text("scala")
                    }
                    .tag(9)
                    Button(action: {}) {
                        Text("csharp")
                    }
                    .tag(10)
                    }
                    Group {
                    Button(action: {}) {
                        Text("java")
                    }
                    .tag(11)
                    Button(action: {}) {
                        Text("cobol")
                    }
                    .tag(12)
                    Button(action: {}) {
                        Text("coffeescript")
                    }
                    .tag(13)
                    Button(action: {}) {
                        Text("lisp")
                    }
                    .tag(14)
                    Button(action: {}) {
                        Text("css")
                    }
                    .tag(15)
                    Button(action: {}) {
                        Text("django")
                    }
                    .tag(16)
                    Button(action: {}) {
                        Text("dockerfile")
                    }
                    .tag(17)
                    Button(action: {}) {
                        Text("erlang")
                    }
                    .tag(18)
                    Button(action: {}) {
                        Text("fortran")
                    }
                    .tag(19)
                    Button(action: {}) {
                        Text("go")
                    }
                    .tag(20)
                    }
                    Group {
                    Button(action: {}) {
                        Text("groovy")
                    }
                    .tag(21)
                    Button(action: {}) {
                        Text("haskell")
                    }
                    .tag(22)
                    Button(action: {}) {
                        Text("html")
                    }
                    .tag(23)
                        Button(action: {}) {
                            Text("http")
                        }
                        .tag(24)
                    Button(action: {}) {
                        Text("javascript")
                    }
                    .tag(25)
                    Button(action: {}) {
                        Text("typescript")
                    }
                    .tag(26)
                    Button(action: {}) {
                        Text("json")
                    }
                    .tag(27)
                    Button(action: {}) {
                        Text("ecma")
                    }
                    .tag(28)
                    Button(action: {}) {
                        Text("jinja")
                    }
                    .tag(29)
                    Button(action: {}) {
                        Text("lua")
                    }
                    .tag(30)
                    }
                    Button(action: {}) {
                        Text("markdown")
                    }
                    .tag(31)
                    Group {
                    Button(action: {}) {
                        Text("maths")
                    }
                    .tag(32)
                    Button(action: {}) {
                        Text("pascal")
                    }
                    .tag(33)
                    Button(action: {}) {
                        Text("perl")
                    }
                    .tag(34)
                    Button(action: {}) {
                        Text("php")
                    }
                    .tag(35)
                    Button(action: {}) {
                        Text("powershell")
                    }
                    .tag(36)
                    Button(action: {}) {
                        Text("properties")
                    }
                    .tag(37)
                    Button(action: {}) {
                        Text("protobuf")
                    }
                    .tag(38)
                    Button(action: {}) {
                        Text("python")
                    }
                    .tag(39)
                    Button(action: {}) {
                        Text("r")
                    }
                    .tag(40)
                    Button(action: {}) {
                        Text("ruby")
                    }
                    .tag(41)
                    }
                    Group {
                    Button(action: {}) {
                        Text("rust")
                    }
                    .tag(42)
                    Button(action: {}) {
                        Text("sass")
                    }
                    .tag(43)
                    Button(action: {}) {
                        Text("scheme")
                    }
                    .tag(44)
                    Button(action: {}) {
                        Text("shell")
                    }
                    .tag(45)
                    Button(action: {}) {
                        Text("sql")
                    }
                    .tag(46)
                    Button(action: {}) {
                        Text("sqllite")
                    }
                    .tag(47)
                    Button(action: {}) {
                        Text("mysql")
                    }
                    .tag(48)
                    Button(action: {}) {
                        Text("latex")
                    }
                    .tag(49)
                    Button(action: {}) {
                        Text("swift")
                    }
                    .tag(50)
                    Button(action: {}) {
                        Text("text")
                    }
                    .tag(51)
                    }
                    Group {
                    Button(action: {}) {
                        Text("toml")
                    }
                    .tag(52)
                    Button(action: {}) {
                        Text("vb")
                    }
                    .tag(53)
                    Button(action: {}) {
                        Text("vue")
                    }
                    .tag(54)
                    Button(action: {}) {
                        Text("xml")
                    }
                    .tag(55)
                    Button(action: {}) {
                        Text("yaml")
                    }
                    .tag(56)
                    }
                }
                .onChange(of: selectedSyntax, perform: { value in
                    print("Syntax: \(value)")
                    if value == 1 {
                        self.syntax = CodeMode.apl
                    }
                    if value == 2 {
                        self.syntax = CodeMode.pgp
                    }
                    if value == 3 {
                        self.syntax = CodeMode.asn
                    }
                    if value == 4 {
                        self.syntax = CodeMode.cmake
                    }
                    if value == 5 {
                        self.syntax = CodeMode.c
                    }
                    if value == 6 {
                        self.syntax = CodeMode.cplus
                    }
                    if value == 7 {
                        self.syntax = CodeMode.objc
                    }
                    if value == 8 {
                        self.syntax = CodeMode.kotlin
                    }
                    if value == 9 {
                        self.syntax = CodeMode.scala
                    }
                    if value == 10 {
                        self.syntax = CodeMode.csharp
                    }
                    if value == 11 {
                        self.syntax = CodeMode.java
                    }
                    if value == 12 {
                        self.syntax = CodeMode.cobol
                    }
                    if value == 13 {
                        self.syntax = CodeMode.coffeescript
                    }
                    if value == 14 {
                        self.syntax = CodeMode.lisp
                    }
                    if value == 15 {
                        self.syntax = CodeMode.css
                    }
                    if value == 16 {
                        self.syntax = CodeMode.django
                    }
                    if value == 17 {
                        self.syntax = CodeMode.dockerfile
                    }
                    if value == 18 {
                        self.syntax = CodeMode.erlang
                    }
                    if value == 19 {
                        self.syntax = CodeMode.fortran
                    }
                    if value == 20 {
                        self.syntax = CodeMode.go
                    }
                    if value == 21 {
                        self.syntax = CodeMode.groovy
                    }
                    if value == 22 {
                        self.syntax = CodeMode.haskell
                    }
                    if value == 23 {
                        self.syntax = CodeMode.html
                    }
                    if value == 24 {
                        self.syntax = CodeMode.http
                    }
                    if value == 25 {
                        self.syntax = CodeMode.javascript
                    }
                    if value == 26 {
                        self.syntax = CodeMode.typescript
                    }
                    if value == 27 {
                        self.syntax = CodeMode.json
                    }
                    if value == 28 {
                        self.syntax = CodeMode.ecma
                    }
                    if value == 29 {
                        self.syntax = CodeMode.jinja
                    }
                    if value == 30 {
                        self.syntax = CodeMode.lua
                    }
                    if value == 31 {
                        self.syntax = CodeMode.markdown
                    }
                    if value == 32 {
                        self.syntax = CodeMode.maths
                    }
                    if value == 33 {
                        self.syntax = CodeMode.pascal
                    }
                    if value == 34 {
                        self.syntax = CodeMode.perl
                    }
                    if value == 35 {
                        self.syntax = CodeMode.php
                    }
                    if value == 36 {
                        self.syntax = CodeMode.powershell
                    }
                    if value == 37 {
                        self.syntax = CodeMode.properties
                    }
                    if value == 38 {
                        self.syntax = CodeMode.protobuf
                    }
                    if value == 39 {
                        self.syntax = CodeMode.python
                    }
                    if value == 40 {
                        self.syntax = CodeMode.r
                    }
                    if value == 41 {
                        self.syntax = CodeMode.ruby
                    }
                    if value == 42 {
                        self.syntax = CodeMode.rust
                    }
                    if value == 43 {
                        self.syntax = CodeMode.sass
                    }
                    if value == 44 {
                        self.syntax = CodeMode.scheme
                    }
                    if value == 45 {
                        self.syntax = CodeMode.shell
                    }
                    if value == 46 {
                        self.syntax = CodeMode.sql
                    }
                    if value == 47 {
                        self.syntax = CodeMode.sqllite
                    }
                    if value == 48 {
                        self.syntax = CodeMode.mysql
                    }
                    if value == 49 {
                        self.syntax = CodeMode.latex
                    }
                    if value == 50 {
                        self.syntax = CodeMode.swift
                    }
                    if value == 51 {
                        self.syntax = CodeMode.text
                    }
                    if value == 52 {
                        self.syntax = CodeMode.toml
                    }
                    if value == 53 {
                        self.syntax = CodeMode.vb
                    }
                    if value == 54 {
                        self.syntax = CodeMode.vue
                    }
                    if value == 55 {
                        self.syntax = CodeMode.xml
                    }
                    if value == 56 {
                        self.syntax = CodeMode.yaml
                    }
                })
            }
            .padding(20)
            .frame(width: 350, height: 150)
            .tag(3)
            .tabItem {
                Label("Themes", systemImage: "paintbrush")
            }
        Form {
            GroupBox(label: Label("Info", systemImage: "info.circle")) {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
            Text("Version: 1.0")
            Text("Build: 1")
                        }
                        Spacer()
                    }
                }
            }
            GroupBox(label: Label("Misc.", systemImage: "ellipsis.circle")) {
                VStack {
                    HStack {
                        Spacer()
                    Button(action: {SendEmail.send()}) {
                        Text("Send Some Feedback")
                    }
                        Spacer()
                    }
                }
            }
        }
                .padding(20)
                .frame(width: 350, height: 150)
        .tag(4)
        .tabItem {
            Label("Misc.", systemImage: "ellipsis.circle")
        }
    }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

class SendEmail: NSObject {
    static func send() {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
        service.recipients = ["markhoward2005@gmail.com"]
        service.subject = "TextEdit.it Feedback"

        service.perform(withItems: ["Please Fill Out All Necessary Sections:", "Report A Bug - ", "Rate The App - ", "Suggest An Improvment - "])
    }
}

extension KeyboardShortcuts.Name {
    static let newCommand = Self("newCommand", default: .init(.n, modifiers: [.command]))
    static let openCommand = Self("openCommand", default: .init(.o, modifiers: [.command]))
    static let saveCommand = Self("saveCommand", default: .init(.s, modifiers: [.command]))
    static let copyCommand = Self("copyCommand", default: .init(.c, modifiers: [.command]))
    static let printCommand = Self("printCommand", default: .init(.p, modifiers: [.command]))
    static let duplicateCommand = Self("duplicateCommand", default: .init(.s, modifiers: [.command, .shift]))
    static let moveToCommand = Self("moveToCommand")
}
