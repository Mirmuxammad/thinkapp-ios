//
//  AdventureMapOverlay.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 01.09.2022.
//

import Foundation
import MapKit

class AdventureMapOverlay: MKTileOverlay {
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let tilePath = Bundle.main.url(
          forResource: "\(path.y)",
          withExtension: "png",
          subdirectory: "tiles/\(path.z)/\(path.x)",
          localization: nil)
        
        if let tile = tilePath {
          return tile
        } else {
          return Bundle.main.url(
            forResource: "parchment",
            withExtension: "png",
            subdirectory: "tiles",
            localization: nil)!
        }
    }
    
    
}
