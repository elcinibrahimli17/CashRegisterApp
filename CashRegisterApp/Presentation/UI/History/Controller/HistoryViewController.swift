//
//  HistoryyViewController.swift
//  CashRegister
//
//  Created by Elchın on 26.03.26.
//

import UIKit
import AnchorKit

class HistoryViewController: UIViewController {

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gündəlik", "Həftəlik", "Aylıq", "İllik"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.description())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tarixçə"
    
        setupUIConstraints()
        viewModel.loadData()
        
        viewModel.filter(by: 0)
    }
    
    lazy var viewModel: HistoryViewModel = {
        let vm = HistoryViewModel(repo: .init())
        vm.delegate = self
        return vm
    }()
    
    private func setupUIConstraints() {
        
        view.anchor(view: segmentedControl) { kit in
            kit.top(safe: true)
            kit.leading(24)
            kit.trailing(24)
        }
        
        view.anchor(view: tableView) { kit in
            kit.top(segmentedControl.bottomAnchor, 20)
            kit.leading()
            kit.trailing()
            kit.bottom()
        }
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        viewModel.filter(by: sender.selectedSegmentIndex)
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.description(), for: indexPath) as? HistoryCell {
            let item = viewModel.allHistory[indexPath.row]
            cell.cellConfig(item: item)
            return cell
        }
        return UITableViewCell()
    }
}

extension HistoryViewController: HistoryViewModelDelegate {
   
    func didReceiveReloadData() {
        tableView.reloadData()
    }
    
    func didReceive(error: any Error) {
        print(error.localizedDescription)
    }
}
