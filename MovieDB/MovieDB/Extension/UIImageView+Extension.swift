//
//  UIImageView+Extension.swift
//  MovieDB
//
//  Created by MacBook on 2.08.2023.
//

import SDWebImage

extension UIImageView {
    func loadImage(url: URL, placeHolderImage: UIImage?,_ completion: SDExternalCompletionBlock?) {
        self.sd_setImage(with: url, placeholderImage: placeHolderImage, options: [.refreshCached, .continueInBackground], completed: completion)
    }
}
