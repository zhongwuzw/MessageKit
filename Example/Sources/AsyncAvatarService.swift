//
//  AsyncAvatarService.swift
//  ChatExample
//
//  Created by Steven on 9/29/17.
//  Copyright © 2017 MessageKit. All rights reserved.
//

import UIKit

final class AsyncAvatarService {

    typealias Section = Int

    static let shared = AsyncAvatarService()

    private init() {}

    private var cache: [Section: UIImage] = [:]

    func getAvatar(for indexPath: IndexPath, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            let sleepTimes = [1.0, 2.0, 3.0]
            let randomIndex = Int(arc4random_uniform(UInt32(sleepTimes.count)))
            Thread.sleep(forTimeInterval: sleepTimes[randomIndex])
            let image = indexPath.section % 2 == 0 ? #imageLiteral(resourceName: "Tim-Cook") : #imageLiteral(resourceName: "Steve-Jobs")
            self.cache[indexPath.section] = image
            completion()
        }
    }

    func cacheHasImageFor(section: Int) -> Bool {
        return cache[section] != nil
    }

    func imageFor(section: Int) -> UIImage {
        return cache[section]!
    }

    func clearCache() {
        cache.removeAll()
    }

}
