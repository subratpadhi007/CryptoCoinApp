//
//  MainViewController.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    private let cryptoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's Crypto", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        setupCryptoButton()
    }

    private func setupCryptoButton() {
        view.addSubview(cryptoButton)

        NSLayoutConstraint.activate([
            cryptoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cryptoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cryptoButton.widthAnchor.constraint(equalToConstant: 200),
            cryptoButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        cryptoButton.addTarget(self, action: #selector(didTapCryptoButton), for: .touchUpInside)
    }

    @objc private func didTapCryptoButton() {
        let cryptoListVC = CryptoListViewController()
        navigationController?.pushViewController(cryptoListVC, animated: true)
    }
}
