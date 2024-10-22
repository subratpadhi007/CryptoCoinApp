//
//  CryptoTableViewCell.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    let cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newTag")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Life Cycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(newImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            cryptoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cryptoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cryptoImageView.widthAnchor.constraint(equalToConstant: 30),
            cryptoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            newImageView.widthAnchor.constraint(equalToConstant: 20),
            newImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        newImageView.isHidden = true
        self.selectionStyle = .none
    }
    
    //MARK: - Public Methods
    func configure(with coin: CryptoCoin) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        newImageView.isHidden = !coin.isNew
        
        let cryptoImage = CryptoImage.forCoin(coin: coin)
        cryptoImageView.image = cryptoImage.image
    }
    
    func configureNewImage(isNew: Bool) {
        newImageView.isHidden = !isNew
    }
}
