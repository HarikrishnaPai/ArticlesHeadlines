//
//  SourcesViewController.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import RxSwift
import RxCocoa

class SourcesViewController: UIViewController {

    // MARK: - Variables
    private lazy var sourcesViewModel = {
        return SourcesViewModel()
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SourcesTableViewCell.self, forCellReuseIdentifier: SourcesTableViewCell.identifier)
        return tableView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = String(localized: "sources.errorlabel.title")
        errorLabel.font = .systemFont(ofSize: 15)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        return errorLabel
    }()
    private var disposeBag = DisposeBag()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Methods
extension SourcesViewController {
    private func setupUI() {
        setupTableView()
        bindTableData()
    }
    
    func loadData() {
        activityIndicator.isHidden = false
        tableView.isHidden = true
        errorLabel.isHidden = true
        sourcesViewModel.getSources()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        errorLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                          paddingLeft: 15, paddingRight: 15)
        activityIndicator.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func bindTableData() {
        sourcesViewModel.sources.bind(
            to: tableView.rx.items(
                cellIdentifier: SourcesTableViewCell.identifier,
                cellType: SourcesTableViewCell.self
            )
        ) { [weak self] row, model, cell in
            cell.configure(with: model, viewModel: self?.sourcesViewModel)
        }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        sourcesViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(title: String(localized: "alert.title.error"),
                                message: error.localizedDescription)
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = true
                self?.errorLabel.isHidden = false
            })
            .disposed(by: disposeBag)
        
        sourcesViewModel.sources
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = false
                self?.errorLabel.isHidden = true
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension SourcesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
