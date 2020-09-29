//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Christian Hansen on 9/29/20.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    var viewModel: Home.Data.Response.Character! {
        didSet {
            updateViewModel(viewModel: viewModel)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .blue
        }
    }
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.textColor = .red
        }
    }
    @IBOutlet weak var speciesLabel: UILabel! {
        didSet {
            nameLabel.textColor = .black
        }
    }
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = 5.0
            characterImageView.clipsToBounds = true
        }
    }
    
    func updateViewModel(viewModel: Home.Data.Response.Character) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        speciesLabel.text = viewModel.species
        characterImageView.image = UIImage(named: "get image from url..")
    }
}


