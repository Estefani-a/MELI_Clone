//
//  GenericListViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Antonella Brini Vago on 05/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class GenericListViewController: UIViewController {

    let items: [ListModel] = mockData
    let emptyView = EmptyListViewController()
    
    private lazy var searchBar: UISearchBar = .load() { element in
        element.delegate = self
        element.searchTextField.backgroundColor = .white
        element.placeholder = "Buscar en Favoritos"
        element.searchTextField.layer.cornerRadius = 18
        element.searchTextField.layer.masksToBounds = true
    }
    
    lazy var table: UITableView = .load() { element in
        element.register(GenericCustomViewCell.self, forCellReuseIdentifier: "\(GenericCustomViewCell.self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setUp()
        setupConstraints()
        table.layoutMargins = UIEdgeInsets.zero
        table.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.titleView = searchBar
    }
    
    private func setupNavBar() {
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: nil)
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
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension GenericListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GenericCustomViewCell.self)", for: indexPath) as? GenericCustomViewCell else {
            return UITableViewCell()
        }
        let body = items[indexPath.row]
        cell.updateCell(item: body)
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GenericDetailViewController()
        vc.updateView(item: items[indexPath.row])
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

