//
//  SettingsView.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI
import CodeMirror_SwiftUI

struct SettingsView: View {
    @State var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            EditorSettings()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Editor")
                }
                .tag(1)
            ThemeSettings()
                .tabItem {
                    Image(systemName: "moon")
                    Text("Themes")
                }
                .tag(2)
            misc
                .tabItem {
                    Image(systemName: "ellipsis.circle")
                    Text("Misc.")
                }
                .tag(3)
        }
    }
    var misc: some View {
        Form {
            GroupBox(label: Label("Info", systemImage: "info.circle")) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Version - 2.0")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Build - 5")
                        Spacer()
                    }
                }
            }
            GroupBox(label: Label("Feedback", systemImage: "questionmark.bubble")) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Want To Send Some Feedback About The App?")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action: {SendEmail.send()}) {
                            Text("Send Feedback")
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.all)
    }
}

struct ThemeSettings: View {
    @AppStorage("selectedSyntax") var selectedSyntax = 51
    @AppStorage("selectedTheme") var selectedTheme = 80
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    @AppStorage("theme") var theme: CodeViewTheme = CodeViewTheme.zenburnesque
    var body: some View {
        Form {
            CodeView(theme: theme, code: .constant("Hello World"), mode: syntax.mode(), fontSize: 12, showInvisibleCharacters: false, lineWrapping: false)
                .padding(.bottom)
            Picker(selection: $selectedTheme, label: Text("Theme")) {
                Group {
                    Group {
                        Button(action: {}) {
                            Text("BB Edit")
                        }
                        .tag(1)
                        Button(action: {}) {
                            Text("All Hallow Eve")
                        }
                        .tag(2)
                        Button(action: {}) {
                            Text("Idle Fingers")
                        }
                        .tag(3)
                        Button(action: {}) {
                            Text("Space Cadet")
                        }
                        .tag(4)
                        Button(action: {}) {
                            Text("Idle")
                        }
                        .tag(5)
                        Button(action: {}) {
                            Text("Oceanic")
                        }
                        .tag(6)
                        Button(action: {}) {
                            Text("Clouds")
                        }
                        .tag(7)
                        Button(action: {}) {
                            Text("GitHub")
                        }
                        .tag(8)
                        Button(action: {}) {
                            Text("Ryan Light")
                        }
                        .tag(9)
                        Button(action: {}) {
                            Text("Black Pearl")
                        }
                        .tag(10)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Mono Industrial")
                        }
                        .tag(11)
                        Button(action: {}) {
                            Text("Happy Happy Joy Joy 2")
                        }
                        .tag(12)
                        Button(action: {}) {
                            Text("Cube 2 Media")
                        }
                        .tag(13)
                        Button(action: {}) {
                            Text("Friendship Bracelet")
                        }
                        .tag(14)
                        Button(action: {}) {
                            Text("Classic Modififed")
                        }
                        .tag(15)
                        Button(action: {}) {
                            Text("Amy")
                        }
                        .tag(16)
                        Button(action: {}) {
                            Text("Demo")
                        }
                        .tag(17)
                        Button(action: {}) {
                            Text("R Dark")
                        }
                        .tag(18)
                        Button(action: {}) {
                            Text("Espresso")
                        }
                        .tag(19)
                        Button(action: {}) {
                            Text("Sunburst")
                        }
                        .tag(20)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Made Of Code")
                        }
                        .tag(21)
                        Button(action: {}) {
                            Text("Arona")
                        }
                        .tag(22)
                        Button(action: {}) {
                            Text("Putty")
                        }
                        .tag(23)
                        Button(action: {}) {
                            Text("Night Lion")
                        }
                        .tag(24)
                        Button(action: {}) {
                            Text("Sidewalk Chalk")
                        }
                        .tag(25)
                        Button(action: {}) {
                            Text("Swyphs II")
                        }
                        .tag(26)
                        Button(action: {}) {
                            Text("I Plastic")
                        }
                        .tag(27)
                        Button(action: {}) {
                            Text("Solarized (Light)")
                        }
                        .tag(28)
                        Button(action: {}) {
                            Text("Mac Classic")
                        }
                        .tag(29)
                        Button(action: {}) {
                            Text("Pastels On Dark")
                        }
                        .tag(30)
                    }
                    Group {
                        Button(action: {}) {
                            Text("IR Black")
                        }
                        .tag(31)
                        Button(action: {}) {
                            Text("Material")
                        }
                        .tag(32)
                        Button(action: {}) {
                            Text("Monokai Fannon Edition")
                        }
                        .tag(33)
                        Button(action: {}) {
                            Text("Monokai Bright")
                        }
                        .tag(34)
                        Button(action: {}) {
                            Text("Eiffel")
                        }
                        .tag(35)
                        Button(action: {}) {
                            Text("Base 16 Light")
                        }
                        .tag(36)
                        Button(action: {}) {
                            Text("Oceanic Muted")
                        }
                        .tag(37)
                        Button(action: {}) {
                            Text("Summer Fruit")
                        }
                        .tag(38)
                        Button(action: {}) {
                            Text("Espresso Libre")
                        }
                        .tag(39)
                        Button(action: {}) {
                            Text("KR Theme")
                        }
                        .tag(40)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Mreq")
                        }
                        .tag(41)
                        Button(action: {}) {
                            Text("Chanfle")
                        }
                        .tag(42)
                        Button(action: {}) {
                            Text("Venom")
                        }
                        .tag(43)
                        Button(action: {}) {
                            Text("Juicy")
                        }
                        .tag(44)
                        Button(action: {}) {
                            Text("Coda")
                        }
                        .tag(45)
                        Button(action: {}) {
                            Text("Fluid Vision")
                        }
                        .tag(46)
                        Button(action: {}) {
                            Text("Tomorrow Night Blue")
                        }
                        .tag(47)
                        Button(action: {}) {
                            Text("Migucwb (Amiga)")
                        }
                        .tag(48)
                        Button(action: {}) {
                            Text("Twilight")
                        }
                        .tag(49)
                        Button(action: {}) {
                            Text("Vibrant Ink")
                        }
                        .tag(50)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Summer Sun")
                        }
                        .tag(51)
                        Button(action: {}) {
                            Text("Monokai")
                        }
                        .tag(52)
                        Button(action: {}) {
                            Text("Rails Envy")
                        }
                        .tag(53)
                        Button(action: {}) {
                            Text("Merbivore")
                        }
                        .tag(54)
                        Button(action: {}) {
                            Text("Dracula")
                        }
                        .tag(55)
                        Button(action: {}) {
                            Text("Pastie")
                        }
                        .tag(56)
                        Button(action: {}) {
                            Text("Low Light")
                        }
                        .tag(57)
                        Button(action: {}) {
                            Text("Spectacular")
                        }
                        .tag(58)
                        Button(action: {}) {
                            Text("Smoothy")
                        }
                        .tag(59)
                        Button(action: {}) {
                            Text("Vibrant Fin")
                        }
                        .tag(60)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Blackboard")
                        }
                        .tag(61)
                        Button(action: {}) {
                            Text("Slush & Poppies")
                        }
                        .tag(62)
                        Button(action: {}) {
                            Text("Freckle")
                        }
                        .tag(63)
                        Button(action: {}) {
                            Text("Fantasy Script")
                        }
                        .tag(64)
                        Button(action: {}) {
                            Text("Tomorrow Night Eighties")
                        }
                        .tag(65)
                        Button(action: {}) {
                            Text("Rhuk")
                        }
                        .tag(66)
                        Button(action: {}) {
                            Text("Toy Chest")
                        }
                        .tag(67)
                        Button(action: {}) {
                            Text("Fake")
                        }
                        .tag(68)
                        Button(action: {}) {
                            Text("Emacs Strict")
                        }
                        .tag(69)
                        Button(action: {}) {
                            Text("Merbivore Soft")
                        }
                        .tag(70)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Fade To Grey")
                        }
                        .tag(71)
                        Button(action: {}) {
                            Text("Monokai Sublime")
                        }
                        .tag(72)
                        Button(action: {}) {
                            Text("Johnny")
                        }
                        .tag(73)
                        Button(action: {}) {
                            Text("Railscasts")
                        }
                        .tag(74)
                        Button(action: {}) {
                            Text("Argonaut")
                        }
                        .tag(75)
                        Button(action: {}) {
                            Text("Tomorrow Night Bright")
                        }
                        .tag(76)
                        Button(action: {}) {
                            Text("Lazy")
                        }
                        .tag(77)
                        Button(action: {}) {
                            Text("Tomorrow Night")
                        }
                        .tag(78)
                        Button(action: {}) {
                            Text("Bongzilla")
                        }
                        .tag(79)
                        Button(action: {}) {
                            Text("Zenburnesque")
                        }
                        .tag(80)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Notebook")
                        }
                        .tag(81)
                        Button(action: {}) {
                            Text("Django (Smoothy)")
                        }
                        .tag(82)
                        Button(action: {}) {
                            Text("Blackboard Black")
                        }
                        .tag(83)
                        Button(action: {}) {
                            Text("Black Pearl II")
                        }
                        .tag(84)
                        Button(action: {}) {
                            Text("Kuroir")
                        }
                        .tag(85)
                        Button(action: {}) {
                            Text("Cobalt")
                        }
                        .tag(86)
                        Button(action: {}) {
                            Text("Ayu-Mirage")
                        }
                        .tag(87)
                        Button(action: {}) {
                            Text("Chrome DevTools")
                        }
                        .tag(88)
                        Button(action: {}) {
                            Text("Prospettiva")
                        }
                        .tag(89)
                        Button(action: {}) {
                            Text("Espresso Soda")
                        }
                        .tag(90)
                    }
                    Group {
                        Button(action: {}) {
                            Text("Birds Of Paradise")
                        }
                        .tag(91)
                        Button(action: {}) {
                            Text("Text Ex Machina")
                        }
                        .tag(92)
                        Button(action: {}) {
                            Text("Django")
                        }
                        .tag(93)
                        Button(action: {}) {
                            Text("Tomorrow")
                        }
                        .tag(94)
                        Button(action: {}) {
                            Text("Solarized (Dark)")
                        }
                        .tag(95)
                        Button(action: {}) {
                            Text("Plastic Code Wrap")
                        }
                        .tag(96)
                        Button(action: {}) {
                            Text("Material Palenight")
                        }
                        .tag(97)
                        Button(action: {}) {
                            Text("Bespin")
                        }
                        .tag(98)
                        Button(action: {}) {
                            Text("Espresso Tutti")
                        }
                        .tag(99)
                        Button(action: {}) {
                            Text("Vibrant Tango")
                        }
                        .tag(100)
                    }
                }
                Group {
                    Button(action: {}) {
                        Text("Tubster")
                    }
                    .tag(101)
                    Button(action: {}) {
                        Text("Dark Pastel")
                    }
                    .tag(102)
                    Button(action: {}) {
                        Text("Dawn")
                    }
                    .tag(103)
                    Button(action: {}) {
                        Text("Tango")
                    }
                    .tag(104)
                    Button(action: {}) {
                        Text("Clouds Midnight")
                    }
                    .tag(105)
                    Button(action: {}) {
                        Text("Glitterbomb")
                    }
                    .tag(106)
                    Button(action: {}) {
                        Text("IR White")
                    }
                    .tag(107)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedTheme) { themeValue in
                if themeValue == 1 {
                    self.theme = CodeViewTheme.bbedit
                }
                if themeValue == 2 {
                    self.theme = CodeViewTheme.allHallowEve
                }
                if themeValue == 3 {
                    self.theme = CodeViewTheme.idleFingers
                }
                if themeValue == 4 {
                    self.theme = CodeViewTheme.spaceCadet
                }
                if themeValue == 5 {
                    self.theme = CodeViewTheme.idle
                }
                if themeValue == 6 {
                    self.theme = CodeViewTheme.oceanic
                }
                if themeValue == 7 {
                    self.theme = CodeViewTheme.clouds
                }
                if themeValue == 8 {
                    self.theme = CodeViewTheme.github
                }
                if themeValue == 9 {
                    self.theme = CodeViewTheme.ryanLight
                }
                if themeValue == 10 {
                    self.theme = CodeViewTheme.blackPearl
                }
                if themeValue == 11 {
                    self.theme = CodeViewTheme.monoIndustrial
                }
                if themeValue == 12 {
                    self.theme = CodeViewTheme.happyHappyJoyJoy2
                }
                if themeValue == 13 {
                    self.theme = CodeViewTheme.cube2Media
                }
                if themeValue == 14 {
                    self.theme = CodeViewTheme.friendshipBracelet
                }
                if themeValue == 15 {
                    self.theme = CodeViewTheme.classicModified
                }
                if themeValue == 16 {
                    self.theme = CodeViewTheme.amy
                }
                if themeValue == 17 {
                    self.theme = CodeViewTheme.default
                }
                if themeValue == 18 {
                    self.theme = CodeViewTheme.rdrak
                }
                if themeValue == 19 {
                    self.theme = CodeViewTheme.espresso
                }
                if themeValue == 20 {
                    self.theme = CodeViewTheme.sunburst
                }
                if themeValue == 21 {
                    self.theme = CodeViewTheme.madeOfCode
                }
                if themeValue == 22 {
                    self.theme = CodeViewTheme.arona
                }
                if themeValue == 23 {
                    self.theme = CodeViewTheme.putty
                }
                if themeValue == 24 {
                    self.theme = CodeViewTheme.nightlion
                }
                if themeValue == 25 {
                    self.theme = CodeViewTheme.sidewalkchalk
                }
                if themeValue == 26 {
                    self.theme = CodeViewTheme.swyphsii
                }
                if themeValue == 27 {
                    self.theme = CodeViewTheme.iplastic
                }
                if themeValue == 28 {
                    self.theme = CodeViewTheme.solarizedLight
                }
                if themeValue == 29 {
                    self.theme = CodeViewTheme.macClassic
                }
                if themeValue == 30 {
                    self.theme = CodeViewTheme.pastelsOnDark
                }
                if themeValue == 31 {
                    self.theme = CodeViewTheme.irBlack
                }
                if themeValue == 32 {
                    self.theme = CodeViewTheme.material
                }
                if themeValue == 33 {
                    self.theme = CodeViewTheme.monokaiFannonedition
                }
                if themeValue == 34 {
                    self.theme = CodeViewTheme.monokaiBright
                }
                if themeValue == 35 {
                    self.theme = CodeViewTheme.eiffel
                }
                if themeValue == 36 {
                    self.theme = CodeViewTheme.base16Light
                }
                if themeValue == 37 {
                    self.theme = CodeViewTheme.oceanicMuted
                }
                if themeValue == 38 {
                    self.theme = CodeViewTheme.summerfruit
                }
                if themeValue == 39 {
                    self.theme = CodeViewTheme.espressoLibre
                }
                if themeValue == 40 {
                    self.theme = CodeViewTheme.krtheme
                }
                if themeValue == 41 {
                    self.theme = CodeViewTheme.mreq
                }
                if themeValue == 42 {
                    self.theme = CodeViewTheme.chanfle
                }
                if themeValue == 43 {
                    self.theme = CodeViewTheme.venom
                }
                if themeValue == 44 {
                    self.theme = CodeViewTheme.juicy
                }
                if themeValue == 45 {
                    self.theme = CodeViewTheme.coda
                }
                if themeValue == 46 {
                    self.theme = CodeViewTheme.fluidvision
                }
                if themeValue == 47 {
                    self.theme = CodeViewTheme.tomorrowNightBlue
                }
                if themeValue == 48 {
                    self.theme = CodeViewTheme.magicwbAmiga
                }
                if themeValue == 49 {
                    self.theme = CodeViewTheme.twilight
                }
                if themeValue == 50 {
                    self.theme = CodeViewTheme.vibrantInk
                }
                if themeValue == 51 {
                    self.theme = CodeViewTheme.summerSun
                }
                if themeValue == 52 {
                    self.theme = CodeViewTheme.monokai
                }
                if themeValue == 53 {
                    self.theme = CodeViewTheme.railsEnvy
                }
                if themeValue == 54 {
                    self.theme = CodeViewTheme.merbivore
                }
                if themeValue == 55 {
                    self.theme = CodeViewTheme.dracula
                }
                if themeValue == 56 {
                    self.theme = CodeViewTheme.pastie
                }
                if themeValue == 57 {
                    self.theme = CodeViewTheme.lowlight
                }
                if themeValue == 58 {
                    self.theme = CodeViewTheme.spectacular
                }
                if themeValue == 59 {
                    self.theme = CodeViewTheme.smoothy
                }
                if themeValue == 60 {
                    self.theme = CodeViewTheme.vibrantFin
                }
                if themeValue == 61 {
                    self.theme = CodeViewTheme.blackboard
                }
                if themeValue == 62 {
                    self.theme = CodeViewTheme.slushPoppies
                }
                if themeValue == 63 {
                    self.theme = CodeViewTheme.freckle
                }
                if themeValue == 64 {
                    self.theme = CodeViewTheme.fantasyscript
                }
                if themeValue == 65 {
                    self.theme = CodeViewTheme.tomorrowNightEighties
                }
                if themeValue == 66 {
                    self.theme = CodeViewTheme.rhuk
                }
                if themeValue == 67 {
                    self.theme = CodeViewTheme.toyChest
                }
                if themeValue == 68 {
                    self.theme = CodeViewTheme.fake
                }
                if themeValue == 69 {
                    self.theme = CodeViewTheme.emacsStrict
                }
                if themeValue == 70 {
                    self.theme = CodeViewTheme.merbivoreSoft
                }
                if themeValue == 71 {
                    self.theme = CodeViewTheme.fadeToGrey
                }
                if themeValue == 72 {
                    self.theme = CodeViewTheme.monokaiSublime
                }
                if themeValue == 73 {
                    self.theme = CodeViewTheme.johnny
                }
                if themeValue == 74 {
                    self.theme = CodeViewTheme.railscasts
                }
                if themeValue == 75 {
                    self.theme = CodeViewTheme.argonaut
                }
                if themeValue == 76 {
                    self.theme = CodeViewTheme.tomorrowNightBright
                }
                if themeValue == 77 {
                    self.theme = CodeViewTheme.lazy
                }
                if themeValue == 78 {
                    self.theme = CodeViewTheme.tomorrowNight
                }
                if themeValue == 79 {
                    self.theme = CodeViewTheme.bongzilla
                }
                if themeValue == 80 {
                    self.theme = CodeViewTheme.zenburnesque
                }
                if themeValue == 81 {
                    self.theme = CodeViewTheme.notebook
                }
                if themeValue == 82 {
                    self.theme = CodeViewTheme.djangoSmoothy
                }
                if themeValue == 83 {
                    self.theme = CodeViewTheme.blackboardBlack
                }
                if themeValue == 84 {
                    self.theme = CodeViewTheme.blackPearlii
                }
                if themeValue == 85 {
                    self.theme = CodeViewTheme.kuroir
                }
                if themeValue == 86 {
                    self.theme = CodeViewTheme.cobalt
                }
                if themeValue == 87 {
                    self.theme = CodeViewTheme.ayuMirage
                }
                if themeValue == 88 {
                    self.theme = CodeViewTheme.chromeDevtools
                }
                if themeValue == 89 {
                    self.theme = CodeViewTheme.prospettiva
                }
                if themeValue == 90 {
                    self.theme = CodeViewTheme.espressoSoda
                }
                if themeValue == 91 {
                    self.theme = CodeViewTheme.birdsOfParadise
                }
                if themeValue == 92 {
                    self.theme = CodeViewTheme.textExMachina
                }
                if themeValue == 93 {
                    self.theme = CodeViewTheme.django
                }
                if themeValue == 94 {
                    self.theme = CodeViewTheme.tomorrow
                }
                if themeValue == 95 {
                    self.theme = CodeViewTheme.solarizedDark
                }
                if themeValue == 96 {
                    self.theme = CodeViewTheme.plasticcodewrap
                }
                if themeValue == 97 {
                    self.theme = CodeViewTheme.materialPalenight
                }
                if themeValue == 98 {
                    self.theme = CodeViewTheme.bespin
                }
                if themeValue == 99 {
                    self.theme = CodeViewTheme.espressoTutti
                }
                if themeValue == 100 {
                    self.theme = CodeViewTheme.vibrantTango
                }
                if themeValue == 101 {
                    self.theme = CodeViewTheme.tubster
                }
                if themeValue == 102 {
                    self.theme = CodeViewTheme.darkpastel
                }
                if themeValue == 103 {
                    self.theme = CodeViewTheme.dawn
                }
                if themeValue == 104 {
                    self.theme = CodeViewTheme.tango
                }
                if themeValue == 105 {
                    self.theme = CodeViewTheme.cloudsMidnight
                }
                if themeValue == 106 {
                    self.theme = CodeViewTheme.glitterbomb
                }
                if themeValue == 107 {
                    self.theme = CodeViewTheme.irWhite
                }
            }
            Picker(selection: $selectedSyntax, label: Text("Syntax")) {
                Group {
                    Button(action: {}) {
                        Text("APL")
                    }
                    .tag(1)
                    Button(action: {}) {
                        Text("PGP")
                    }
                    .tag(2)
                    Button(action: {}) {
                        Text("ASN")
                    }
                    .tag(3)
                    Button(action: {}) {
                        Text("C Make")
                    }
                    .tag(4)
                    Button(action: {}) {
                        Text("C")
                    }
                    .tag(5)
                    Button(action: {}) {
                        Text("C++")
                    }
                    .tag(6)
                    Button(action: {}) {
                        Text("Objective C")
                    }
                    .tag(7)
                    Button(action: {}) {
                        Text("Kotlin")
                    }
                    .tag(8)
                    Button(action: {}) {
                        Text("Scala")
                    }
                    .tag(9)
                    Button(action: {}) {
                        Text("C#")
                    }
                    .tag(10)
                }
                Group {
                    Button(action: {}) {
                        Text("Java")
                    }
                    .tag(11)
                    Button(action: {}) {
                        Text("Cobol")
                    }
                    .tag(12)
                    Button(action: {}) {
                        Text("Coffee Script")
                    }
                    .tag(13)
                    Button(action: {}) {
                        Text("Lisp")
                    }
                    .tag(14)
                    Button(action: {}) {
                        Text("CSS")
                    }
                    .tag(15)
                    Button(action: {}) {
                        Text("Django")
                    }
                    .tag(16)
                    Button(action: {}) {
                        Text("Docker File")
                    }
                    .tag(17)
                    Button(action: {}) {
                        Text("ERLang")
                    }
                    .tag(18)
                    Button(action: {}) {
                        Text("Fortran")
                    }
                    .tag(19)
                    Button(action: {}) {
                        Text("Go")
                    }
                    .tag(20)
                }
                Group {
                    Button(action: {}) {
                        Text("Groovy")
                    }
                    .tag(21)
                    Button(action: {}) {
                        Text("Haskell")
                    }
                    .tag(22)
                    Button(action: {}) {
                        Text("HTML")
                    }
                    .tag(23)
                    Button(action: {}) {
                        Text("HTTP")
                    }
                    .tag(24)
                    Button(action: {}) {
                        Text("Javascript")
                    }
                    .tag(25)
                    Button(action: {}) {
                        Text("Typescript")
                    }
                    .tag(26)
                    Button(action: {}) {
                        Text("JSON")
                    }
                    .tag(27)
                    Button(action: {}) {
                        Text("Ecma")
                    }
                    .tag(28)
                    Button(action: {}) {
                        Text("Jinja")
                    }
                    .tag(29)
                    Button(action: {}) {
                        Text("Lua")
                    }
                    .tag(30)
                }
                Group {
                    Button(action: {}) {
                        Text("Markdown")
                    }
                    .tag(31)
                    Button(action: {}) {
                        Text("Maths")
                    }
                    .tag(32)
                    Button(action: {}) {
                        Text("Pascal")
                    }
                    .tag(33)
                    Button(action: {}) {
                        Text("Perl")
                    }
                    .tag(34)
                    Button(action: {}) {
                        Text("PHP")
                    }
                    .tag(35)
                    Button(action: {}) {
                        Text("Powershell")
                    }
                    .tag(36)
                    Button(action: {}) {
                        Text("Properties")
                    }
                    .tag(37)
                    Button(action: {}) {
                        Text("protobuf")
                    }
                    .tag(38)
                    Button(action: {}) {
                        Text("Python")
                    }
                    .tag(39)
                    Button(action: {}) {
                        Text("R")
                    }
                    .tag(40)
                }
                Group {
                    Button(action: {}) {
                        Text("Ruby")
                    }
                    .tag(41)
                    Button(action: {}) {
                        Text("Rust")
                    }
                    .tag(42)
                    Button(action: {}) {
                        Text("Sass")
                    }
                    .tag(43)
                    Button(action: {}) {
                        Text("Scheme")
                    }
                    .tag(44)
                    Button(action: {}) {
                        Text("Shell")
                    }
                    .tag(45)
                    Button(action: {}) {
                        Text("SQL")
                    }
                    .tag(46)
                    Button(action: {}) {
                        Text("SQLite")
                    }
                    .tag(47)
                    Button(action: {}) {
                        Text("MySQL")
                    }
                    .tag(48)
                    Button(action: {}) {
                        Text("Latex")
                    }
                    .tag(49)
                    Button(action: {}) {
                        Text("Swift")
                    }
                    .tag(50)
                }
                Group {
                    Button(action: {}) {
                        Text("Text")
                    }
                    .tag(51)
                    Button(action: {}) {
                        Text("Toml")
                    }
                    .tag(52)
                    Button(action: {}) {
                        Text("VB")
                    }
                    .tag(53)
                    Button(action: {}) {
                        Text("Vue")
                    }
                    .tag(54)
                    Button(action: {}) {
                        Text("XML")
                    }
                    .tag(55)
                    Button(action: {}) {
                        Text("YAML")
                    }
                    .tag(56)
                    Button(action: {}) {
                        Text("Dart")
                    }
                    .tag(57)
                    Button(action: {}) {
                        Text("Ntriples")
                    }
                    .tag(58)
                    Button(action: {}) {
                        Text("Sparql")
                    }
                    .tag(59)
                    Button(action: {}) {
                        Text("Turtle")
                    }
                    .tag(60)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedSyntax) { syntax in
                if syntax == 1 {
                    self.syntax = CodeMode.apl
                }
                if syntax == 2 {
                    self.syntax = CodeMode.pgp
                }
                if syntax == 3 {
                    self.syntax = CodeMode.asn
                }
                if syntax == 4 {
                    self.syntax = CodeMode.cmake
                }
                if syntax == 5 {
                    self.syntax = CodeMode.c
                }
                if syntax == 6 {
                    self.syntax = CodeMode.cplus
                }
                if syntax == 7 {
                    self.syntax = CodeMode.objc
                }
                if syntax == 8 {
                    self.syntax = CodeMode.kotlin
                }
                if syntax == 9 {
                    self.syntax = CodeMode.scala
                }
                if syntax == 10 {
                    self.syntax = CodeMode.csharp
                }
                if syntax == 11 {
                    self.syntax = CodeMode.java
                }
                if syntax == 12 {
                    self.syntax = CodeMode.cobol
                }
                if syntax == 13 {
                    self.syntax = CodeMode.coffeescript
                }
                if syntax == 14 {
                    self.syntax = CodeMode.lisp
                }
                if syntax == 15 {
                    self.syntax = CodeMode.css
                }
                if syntax == 16 {
                    self.syntax = CodeMode.django
                }
                if syntax == 17 {
                    self.syntax = CodeMode.dockerfile
                }
                if syntax == 18 {
                    self.syntax = CodeMode.erlang
                }
                if syntax == 19 {
                    self.syntax = CodeMode.fortran
                }
                if syntax == 20 {
                    self.syntax = CodeMode.go
                }
                if syntax == 21 {
                    self.syntax = CodeMode.groovy
                }
                if syntax == 22 {
                    self.syntax = CodeMode.haskell
                }
                if syntax == 23 {
                    self.syntax = CodeMode.html
                }
                if syntax == 24 {
                    self.syntax = CodeMode.http
                }
                if syntax == 25 {
                    self.syntax = CodeMode.javascript
                }
                if syntax == 26 {
                    self.syntax = CodeMode.typescript
                }
                if syntax == 27 {
                    self.syntax = CodeMode.json
                }
                if syntax == 28 {
                    self.syntax = CodeMode.ecma
                }
                if syntax == 29 {
                    self.syntax = CodeMode.jinja
                }
                if syntax == 30 {
                    self.syntax = CodeMode.lua
                }
                if syntax == 31 {
                    self.syntax = CodeMode.markdown
                }
                if syntax == 32 {
                    self.syntax = CodeMode.maths
                }
                if syntax == 33 {
                    self.syntax = CodeMode.pascal
                }
                if syntax == 34 {
                    self.syntax = CodeMode.perl
                }
                if syntax == 35 {
                    self.syntax = CodeMode.php
                }
                if syntax == 36 {
                    self.syntax = CodeMode.powershell
                }
                if syntax == 37 {
                    self.syntax = CodeMode.properties
                }
                if syntax == 38 {
                    self.syntax = CodeMode.protobuf
                }
                if syntax == 39 {
                    self.syntax = CodeMode.python
                }
                if syntax == 40 {
                    self.syntax = CodeMode.r
                }
                if syntax == 41 {
                    self.syntax = CodeMode.ruby
                }
                if syntax == 42 {
                    self.syntax = CodeMode.rust
                }
                if syntax == 43 {
                    self.syntax = CodeMode.sass
                }
                if syntax == 44 {
                    self.syntax = CodeMode.scheme
                }
                if syntax == 45 {
                    self.syntax = CodeMode.shell
                }
                if syntax == 46 {
                    self.syntax = CodeMode.sql
                }
                if syntax == 47 {
                    self.syntax = CodeMode.sqllite
                }
                if syntax == 48 {
                    self.syntax = CodeMode.mysql
                }
                if syntax == 49 {
                    self.syntax = CodeMode.latex
                }
                if syntax == 50 {
                    self.syntax = CodeMode.swift
                }
                if syntax == 51 {
                    self.syntax = CodeMode.text
                }
                if syntax == 52 {
                    self.syntax = CodeMode.toml
                }
                if syntax == 53 {
                    self.syntax = CodeMode.vb
                }
                if syntax == 54 {
                    self.syntax = CodeMode.vue
                }
                if syntax == 55 {
                    self.syntax = CodeMode.xml
                }
                if syntax == 56 {
                    self.syntax = CodeMode.yaml
                }
                if syntax == 57 {
                    self.syntax = CodeMode.dart
                }
                if syntax == 58 {
                    self.syntax = CodeMode.ntriples
                }
                if syntax == 59 {
                    self.syntax = CodeMode.sparql
                }
                if syntax == 60 {
                    self.syntax = CodeMode.turtle
                }
            }
        }
        .padding(.all)
    }
}

struct EditorSettings: View {
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    var body: some View {
        Form {
            GroupBox(label: Label("Options", systemImage: "slider.horizontal.3")) {
                VStack {
                    HStack {
                        Spacer()
                        Stepper("Font Size - \(fontSize)", value: $fontSize, in: 1...120)
                        Spacer()
                    }
                    Toggle(isOn: $lineWrapping) {
                        Text("Line Wrapping")
                    }
                    .toggleStyle(.switch)
                    Toggle(isOn: $showInvisibleCharacters) {
                        Text("Show Invisible Characters")
                    }
                    .toggleStyle(.switch)
                }
            }
        }
        .padding(.all)
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
        service.subject = "Note.it Feedback"
        service.perform(withItems: ["Please Fill Out All Relevant Sections:", "Report A Bug - ", "Rate The App - ", "Suggest An Improvment - "])
    }
}
