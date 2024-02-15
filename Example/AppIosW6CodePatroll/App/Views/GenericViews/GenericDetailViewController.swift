//
//  GenericDetailViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 19/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI
import MLLocalStorage

class GenericDetailViewController: UIViewController, ButtonsContainerDelegate {
    
    var data: Body?
    let servicer = FavoriteService()
    private let viewModel = DetailViewModel(remoteService: RemoteService(), localService: LocalService())
    
    private lazy var addressesHub: AddressesHub = .load()
    
    private lazy var spinner: UIActivityIndicatorView = .load() { element in
        element.style = .large
        element.color = UIColor.ml_mercadoLibreBlue()
        element.isHidden = true
        view.addSubview(element)
    }
    
    private lazy var scrollView: UIScrollView = .load() { element in
        element.showsVerticalScrollIndicator = false
        element.showsHorizontalScrollIndicator = false
    }
    
    private lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .vertical
    }
    
    private lazy var headerLabels: HeaderLabels = .load()
    
    private lazy var imageCarousel: ImageCarousel = .load()
        
    private lazy var priceLabel: PriceLabel = .load()
    
    private lazy var buttonsContainer: Buttons = .load() { element in
        element.delegate = self
    }
    
    private lazy var descriptionContainer: DescriptionContainer = .load()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
        addToLatest()
        setupSearchViewModelObserver()
        viewModel.getDescription(item: data?.id ?? "")
        viewModel.getImages(item: data?.id ?? "")
    }
    
    private func setupSearchViewModelObserver() {
        viewModel.description.bind { [weak self] description in
            DispatchQueue.main.async { self?.descriptionContainer.setupText(text: description ?? "") }
        }
        
        viewModel.pictures.bind { [weak self] pictures in
            DispatchQueue.main.async {
                self?.imageCarousel.banerPictures = pictures ?? ItemPicturesModel(pictures: [ItemPicture]())
                self?.imageCarousel.updateCarousel()
            }
        }
        
        viewModel.isSearching.bind { [weak self] isSearching in
            guard let isSearching = isSearching else { return }
            DispatchQueue.main.async {
                isSearching ? self?.spinner.show() : self?.spinner.dismiss()
            }
        }
        
        viewModel.error.bind { [weak self] error in
            guard let error = error else { return }
            DispatchQueue.main.async { [weak self] in
                self?.spinner.dismiss()
                let dialogMessage = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                dialogMessage.addAction(ok)
                self?.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    private func setupNavBar() {
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(addFavorite))
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        let cartButton = UIBarButtonItem(image: UIImage(named: "Shoppingcart"), style: .done, target: self, action: nil)
        heartButton.tintColor = .ml_meli_black()
        searchButton.tintColor = .ml_meli_black()
        cartButton.tintColor = .ml_meli_black()
        self.navigationItem.rightBarButtonItems = [cartButton, searchButton, heartButton]
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .ml_meli_black()
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let provider = MLSStorageProvider.shared
        let id = MLSPropertyId(data?.id ?? "")
        let team = MLSTeamId("CodePatrol")
        guard let result = try? provider.kvsTransaction(id: id,team:team).get().get(defaultValue: "NOID") else { return }
        switch result {
            case .success(let resultID):
                if resultID == data?.id {
                    self.navigationItem.rightBarButtonItems?[2].image = UIImage(systemName: "heart.fill")
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }

    @objc func addFavorite() {
        print("ADD FAVORITE")
        let provider = MLSStorageProvider.shared
        let id = MLSPropertyId(data?.id ?? "")
        let team = MLSTeamId("CodePatrol")
        guard let result = try? provider.kvsTransaction(id: id,team:team).get().get(defaultValue: "NOID") else { return }
        switch result {
            case .success(let resultID):
                if resultID == "NOID" {
                    guard (try? provider.kvsTransaction(id: id,team: team).get().put(value: data?.id ?? "NOID")) != nil else { return }
                    self.navigationItem.rightBarButtonItems?[2].image = UIImage(systemName: "heart.fill")
                    viewModel.addFavorite(item: data!)
                } else {
                    guard let deleteResult = try? provider.kvsTransaction(id: id, team: team).get().delete() else { return }
                    switch deleteResult {
                        case .success(_):
                            self.navigationItem.rightBarButtonItems?[2].image = UIImage(systemName: "heart")
                        viewModel.removeFavorite(id: data?.id ?? "")
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
    
    private func addToLatest() {
        guard let data = data else {
            return
        }
        let itemData = LatestData(category: nil, itemData: data)
        LatestManager.setLatestList(Latest: itemData)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(addressesHub)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(headerLabels)
        contentStackView.addArrangedSubview(imageCarousel)
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(buttonsContainer)
        contentStackView.addArrangedSubview(descriptionContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addressesHub.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressesHub.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressesHub.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: addressesHub.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func questionAction() {
        let vc = GenericQuestionViewController()
        vc.title = "Preguntale al vendedor"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func updateView(item: Body){
        headerLabels.descriptionLabel.text = item.title
        headerLabels.titleLabel.text = item.title
        priceLabel.priceLabel.amount = item.price
    }
}

