//
//  HomeViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class HomeViewController: UIViewController {
        
    private lazy var searchBar: UISearchBar = .load() { element in
        element.delegate = self
        element.searchTextField.backgroundColor = .white
        element.placeholder = "Buscar en Mercado Libre"
        element.searchTextField.layer.cornerRadius = 18
        element.searchTextField.layer.masksToBounds = true
      }
    
    private lazy var addressesHub: AddressesHub = .load()
    
    private lazy var scrollView: UIScrollView = .load()
    
    private lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .vertical
    }
    
    private lazy var promoCarousel: CarouselBanner = .load()
    
    private lazy var shippingPromo: ShippingPromo = .load()
    
    public lazy var buttons: ButtonsContainer = .load()
    
    private lazy var bannerPromo: BannerPromo = .load()
    
    private lazy var recentCarousel: RecentCarousel = .load() { element in
        element.delegate = self
    }
    
    private var searchCase: SearchCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.ml_meli_background()
        setupSearchbar()
        setupViews()
        setButtonAction()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.titleView = searchBar
        
        recentCarousel.updateCarousel()
    }
    
    private func setupSearchbar() {
        tabBarController?.navigationItem.titleView = searchBar
        let rightButton = UIBarButtonItem(image: UIImage(named: "Shoppingcart"), style: .done, target: self, action: nil)
        rightButton.tintColor = .ml_meli_black()
        self.navigationItem.rightBarButtonItem = rightButton
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .ml_meli_black()
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setupViews() {
        view.addSubview(addressesHub)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(promoCarousel)
        contentStackView.addArrangedSubview(shippingPromo)
        contentStackView.addArrangedSubview(buttons)
        contentStackView.addArrangedSubview(bannerPromo)
        contentStackView.addArrangedSubview(recentCarousel)
    }
    
    private func setButtonAction() {
        buttons.cartButton.button.addTarget(self, action: #selector(openAutoList), for: .touchUpInside)
        buttons.motoButton.button.addTarget(self, action: #selector(openMotoList), for: .touchUpInside)
        buttons.truckButton.button.addTarget(self, action: #selector(openTruckList), for: .touchUpInside)
        buttons.houseButton.button.addTarget(self, action: #selector(openHouseList), for: .touchUpInside)
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            promoCarousel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            recentCarousel.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    @objc func openAutoList(sender: UIButton) {
        let vc = GenericListViewController(isFavorite: false)
        searchCase = .auto
        vc.categoryId = searchCase?.CategoryId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openMotoList(sender: UIButton) {
        let vc = GenericListViewController(isFavorite: false)
        searchCase = .moto
        vc.categoryId = searchCase?.CategoryId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openTruckList(sender: UIButton) {
        let vc = GenericListViewController(isFavorite: false)
        searchCase = .truck
        vc.categoryId = searchCase?.CategoryId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openHouseList(sender: UIButton) {
        let vc = GenericListViewController(isFavorite: false)
        searchCase = .estate
        vc.categoryId = searchCase?.CategoryId
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension Metodos
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let category = searchBar.searchTextField.text else { return }
        print(category)
    }
}

extension HomeViewController: RecentCarouselDelegate {
    func goToDetail() {
        let vc = GenericDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
