//
//  SequisMiniAppMain.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/9/26.
//

import SwiftUI
import SwiftData

@main
struct SequisMiniAppMain: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ImageListView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }

    init() {
        do {
            container = try ModelContainer(for: ImageDetailItem.self)
        } catch {
            fatalError("Failed to create ModelContainer for Image Detail Item.")
        }
    }
}
