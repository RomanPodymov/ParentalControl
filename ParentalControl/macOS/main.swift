//
//  main.swift
//  ParentalControl
//
//  Created by Roman Podymov on 14/12/2023.
//  Copyright © 2023 ParentalControl. All rights reserved.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
