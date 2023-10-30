//
//  HeadlinesTableViewCell.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import UIKit

class HeadlinesTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "HeadlinesTableViewCell"
    
    private lazy var articleTitleLabel: UILabel = {
        let articleTitleLabel = UILabel()
        articleTitleLabel.font = .boldSystemFont(ofSize: 15)
        articleTitleLabel.textAlignment = .left
        articleTitleLabel.numberOfLines = 3
        return articleTitleLabel
    }()
    
    private lazy var articleDescriptionLabel: UILabel = {
        let articleDescriptionLabel = UILabel()
        articleDescriptionLabel.font = .systemFont(ofSize: 11)
        articleDescriptionLabel.textAlignment = .left
        articleDescriptionLabel.numberOfLines = 4
        return articleDescriptionLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .boldSystemFont(ofSize: 10)
        authorLabel.textAlignment = .left
        authorLabel.textColor = .lightGray
        return authorLabel
    }()
    
    private lazy var articleImageView: UIImageView = {
        let articleImageView = UIImageView()
        articleImageView.layer.cornerRadius = 5
        articleImageView.layer.masksToBounds = true
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleToFill
        articleImageView.backgroundColor = .lightGray
        return articleImageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        articleTitleLabel.text = nil
        articleDescriptionLabel.text = nil
        authorLabel.text = nil
        articleImageView.image = nil
    }
}

// MARK: - Public Methods
extension HeadlinesTableViewCell {
    func configure(with model: Article) {
        articleTitleLabel.text = model.title
        articleDescriptionLabel.text = model.description
        authorLabel.text = model.author
        Task { [weak self] in
            guard let articleImage = model.urlToImage else { return }
            self?.articleImageView.image = try? await ImageDownloader.shared.downloadImage(from: articleImage)
        }
    }
}

// MARK: - Private Methods
extension HeadlinesTableViewCell {
    func setupUI() {
        selectionStyle = .none
        contentView.addSubview(articleImageView)
        contentView.addSubview(articleTitleLabel)
        contentView.addSubview(articleDescriptionLabel)
        contentView.addSubview(authorLabel)
        
        articleTitleLabel.anchor(top: topAnchor, left: leftAnchor,
                                 bottom: nil, right: articleImageView.leftAnchor,
                                 paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 5)
        articleDescriptionLabel.anchor(top: articleTitleLabel.bottomAnchor, left: leftAnchor,
                                       bottom: nil, right: articleImageView.leftAnchor,
                                       paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 5)
        authorLabel.anchor(top: nil, left: leftAnchor,
                           bottom: bottomAnchor, right: articleImageView.leftAnchor,
                           paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 5,
                           width: 0, height: 13)
        articleImageView.anchor(top: topAnchor, left: nil,
                                bottom: bottomAnchor, right: rightAnchor,
                                paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 10,
                                width: frame.size.width/2)
        articleTitleLabel.setContentHuggingPriority(.defaultHigh, for:.vertical)
        articleDescriptionLabel.setContentHuggingPriority(.defaultLow, for:.vertical)
        articleTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        articleDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        articleDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: authorLabel.topAnchor, constant: 5).isActive = true
    }
}
