//
//  HeadlineDetailsViewController.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit
import WebKit

class HeadlineDetailsViewController: UIViewController {

    // MARK: - Variables
    lazy var headlineDetailsViewModel = {
        return HeadlineDetailsViewModel()
    }()
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Methods
extension HeadlineDetailsViewController {
    private func setupUI() {
        setupWebView()
        setupBarButtonItem()
        loadData()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        activityIndicator.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func loadData() {
        activityIndicator.isHidden = false
        guard let urlString = headlineDetailsViewModel.article?.url,
              let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "SaveIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(self.saveArticleSelected))
        resetBarButtonImage()
    }
    
    private func resetBarButtonImage() {
        let isSavedArticle = headlineDetailsViewModel.isSavedArticle()
        navigationItem.rightBarButtonItem?.image = isSavedArticle ? UIImage(named: "SaveIconSelected") : UIImage(named: "SaveIcon")
    }
    
    @objc private func saveArticleSelected() {
        headlineDetailsViewModel.addOrDeleteArticle()
        resetBarButtonImage()
    }
}

// MARK: - WKNavigationDelegate
extension HeadlineDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.isHidden = true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.isHidden = true
    }
}
