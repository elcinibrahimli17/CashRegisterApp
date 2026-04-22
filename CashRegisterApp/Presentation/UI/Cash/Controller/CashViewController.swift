//
//  ViewController.swift
//  CashRegister
//
//  Created by Elchın on 26.03.26.
//

import UIKit

class CashViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CashCell.self, forCellReuseIdentifier: CashCell.description())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var kasaCard: KasaCardView = {
       let view = KasaCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewModel: CashViewModel = {
        let vm = CashViewModel(repo: .init())
        vm.delegate = self
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapShow))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkCashBalance()
    }
    
    private func checkCashBalance() {
        guard UserDefaults.standard.checkCashInfo == false else {
            viewModel.loadData()
            return
        }
        
        showStartingPage()
    }
    
    private func setupUIConstraints() {
        view.addSubview(kasaCard)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            kasaCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            kasaCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            kasaCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: kasaCard.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func didTapShow() {
        let vc = AddTransactionViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.dataSource = self
        show(vc, sender: self)
    }
}

extension CashViewController {
    private func showStartingPage() {
        let vc = StartSafeViewController()
        vc.viewModel.dataSource = self
        present(vc, animated: true)
    }
}

extension CashViewController: StartSafeDataSource {
    func updateStartCashAmount(totalAmount: Double) {
        viewModel.updateCashData(amount: totalAmount)
        dismiss(animated: true)
    }
}

extension CashViewController: CashViewModelDelegate {
    func didReceive(item: CardDataModel) {
        kasaCard.update(item: item)
        
        tableView.reloadData()
    }
        
    func didReceive(error: any Error) {
        print(error.localizedDescription)
    }
}

extension CashViewController: AddTransactionViewModelDataSource {
    func createItem(model: TransactionModel) {
        viewModel.createItemTransaction(model: model)
    }
}

extension CashViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CashCell.description(), for: indexPath) as? CashCell {
            let item = viewModel.items[indexPath.row]
            cell.cellConfig(item: item)
            return cell
        }
        return UITableViewCell()
    }
}
