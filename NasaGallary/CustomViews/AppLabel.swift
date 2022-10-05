//
//  AppLabel.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import UIKit


@IBDesignable
public class AppLabel: UILabel {

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }

    func configureLabel() {
        font = UIFont(name: "Nasa", size: self.font.pointSize)
    }

}
