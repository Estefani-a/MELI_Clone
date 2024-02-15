//
//  GenericListViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 05/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class GenericListViewController: UIViewController {

    var isFavorites: Bool?
    var categoryId: String?
    
    let emptyView = EmptyListViewController()
    let viewModel = ListViewModel(remoteService: RemoteService(), localService: LocalService())
    
    private lazy var searchBar: UISearchBar = .load() { element in
        element.delegate = self
        element.searchTextField.backgroundColor = .white
        element.searchTextField.layer.cornerRadius = 18
        element.searchTextField.layer.masksToBounds = true
    }
    
    lazy var table: UITableView = .load() { element in
        element.register(GenericCustomViewCell.self, forCellReuseIdentifier: "\(GenericCustomViewCell.self)")
    }
    
    private lazy var spinner: UIActivityIndicatorView = .load() { element in
        element.style = .large
        element.color = UIColor.ml_mercadoLibreBlue()
        element.isHidden = true
        view.addSubview(element)
    }
    
    init(isFavorite: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isFavorites = isFavorite
    }

    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setUp()
        setupConstraints()
        setupSearchViewModelObserver()
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.titleView = searchBar
        isFavorites == true ? viewModel.getFavorites() : viewModel.getData(category: categoryId ?? "")
    }

    private func setupSearchViewModelObserver() {
        viewModel.items.bind { [weak self] _ in
            DispatchQueue.main.async { self?.table.reloadData() }
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
        
        if isFavorites == false {
            searchBar.placeholder = "Buscar en Mercado Libre"
        } else {
            searchBar.placeholder = "Buscar en Favoritos"
        }
        
        let cartButton = UIBarButtonItem(image: UIImage(named: "Shoppingcart"), style: .done, target: self, action: nil)
        cartButton.tintColor = .ml_meli_black()
        self.navigationItem.rightBarButtonItem = cartButton
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .ml_meli_black()
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setUp() {
        table.delegate = self
        table.dataSource = self
    }
    
    func setupEmptyListMessage() {
        table.isHidden = true
        view.addSubview(emptyView.view)
        emptyView.view.translatesAutoresizingMaskIntoConstraints = false
        emptyView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyView.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyView.emptyLabel.isHidden = true
    }
    
    private func setupView() {
        tabBarController?.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(table)
        table.separatorStyle = .singleLine
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension GenericListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GenericCustomViewCell.self)", for: indexPath) as? GenericCustomViewCell else {
            return UITableViewCell()
        }
        if let body = viewModel.items.value?.results[indexPath.row] {
            cell.updateCell(item: body)
        }
        cell.isFavorites = isFavorites
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GenericDetailViewController()
        if let body = viewModel.items.value?.results[indexPath.row] {
            vc.data = body
            vc.updateView(item: body)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension Metodos SearchBar
extension GenericListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let category = searchBar.searchTextField.text else { return }
        print(category)
    }
}

