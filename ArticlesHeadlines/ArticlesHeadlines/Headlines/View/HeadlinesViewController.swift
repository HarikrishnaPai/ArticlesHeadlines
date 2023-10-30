//
//  HeadlinesViewController.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HeadlinesViewController: UIViewController {

    // MARK: - Variables
    private lazy var headlinesViewModel = {
        return HeadlinesViewModel()
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HeadlinesTableViewCell.self, forCellReuseIdentifier: HeadlinesTableViewCell.identifier)
        return tableView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = String(localized: "headlines.errorlabel.title")
        errorLabel.font = .systemFont(ofSize: 15)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        return errorLabel
    }()
    private var disposeBag = DisposeBag()
    weak var coordinator: HeadlinesCoordinator?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Methods
extension HeadlinesViewController {
    private func setupUI() {
        setupTableView()
        bindTableData()
        loadData()
    }
    
    func loadData() {
        activityIndicator.isHidden = false
        tableView.isHidden = true
        errorLabel.isHidden = true
        headlinesViewModel.getTopHeadlines()
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
        headlinesViewModel.articles.bind(
            to: tableView.rx.items(
                cellIdentifier: HeadlinesTableViewCell.identifier,
                cellType: HeadlinesTableViewCell.self
            )
        ) { row, model, cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Article.self).bind { [weak self] article in
            self?.coordinator?.displayHeadlineDetails(article: article)
        }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        headlinesViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(title: String(localized: "alert.title.error"),
                                message: error.localizedDescription)
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = true
                self?.errorLabel.isHidden = false
            })
            .disposed(by: disposeBag)
        
        headlinesViewModel.articles
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
extension HeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 3
    }
}
