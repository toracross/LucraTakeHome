//
//  LucraTakeHomeApp.swift
//  LucraTakeHome
//
//  Created by Wellison Pereira on 1/19/24.
//

import SwiftUI

@main
struct LucraTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            GalleryView(viewModel: GalleryViewModel())
        }
    }
}
