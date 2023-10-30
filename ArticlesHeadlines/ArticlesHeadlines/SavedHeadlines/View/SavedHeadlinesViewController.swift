//
//  SavedHeadlinesViewController.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import RxSwift
import RxCocoa

class SavedHeadlinesViewController: UIViewController {

    // MARK: - Variables
    private lazy var savedHeadlinesViewModel = {
        return SavedHeadlinesViewModel()
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
        errorLabel.text = String(localized: "saved.errorlabel.title")
        errorLabel.font = .systemFont(ofSize: 15)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        return errorLabel
    }()
    private var disposeBag = DisposeBag()
    weak var coordinator: SavedHeadlinesCoordinator?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
}

// MARK: - Private Methods
extension SavedHeadlinesViewController {
    private func setupUI() {
        setupTableView()
        bindTableData()
    }
    
    func loadData() {
        activityIndicator.isHidden = false
        tableView.isHidden = true
        errorLabel.isHidden = true
        savedHeadlinesViewModel.getSavedHeadlines()
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
        savedHeadlinesViewModel.articles.bind(
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
        
        savedHeadlinesViewModel.articles
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] articles in
                let showError = articles.count <= 0
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = showError
                self?.errorLabel.isHidden = !showError
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension SavedHeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 3
    }
}
