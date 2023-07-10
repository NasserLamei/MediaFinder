//
//  ImageCodableModel.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 6/4/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

struct CodableImage: Codable {
    let imageData: Data?
    func getImage()-> UIImage?{
        guard let imageData = self.imageData else{ return nil}
        let image = UIImage(data: imageData)
        return image
        
    }
    init (withImage image : UIImage){
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
}
