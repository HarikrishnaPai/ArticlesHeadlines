//
//  SourcesTableViewCell.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "SourcesTableViewCell"
    
    private lazy var sourceTitleLabel: UILabel = {
        let sourceTitleLabel = UILabel()
        sourceTitleLabel.font = .boldSystemFont(ofSize: 15)
        sourceTitleLabel.textAlignment = .left
        return sourceTitleLabel
    }()
    
    private lazy var sourceSelectionSwitch: UISwitch = {
        let sourceSelectionSwitch = UISwitch()
        sourceSelectionSwitch.setOn(false, animated: false)
        return sourceSelectionSwitch
    }()
    var source: Source?
    var sourcesViewModel: SourcesViewModel?
    
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
        sourceTitleLabel.text = nil
        sourceSelectionSwitch.setOn(false, animated: false)
    }
}

// MARK: - Public Methods
extension SourcesTableViewCell {
    func configure(with model: Source, viewModel: SourcesViewModel?) {
        source = model
        sourcesViewModel = viewModel
        sourceTitleLabel.text = model.name
        let isSourceSelected = sourcesViewModel?.isSourceSelected(model) ?? false
        sourceSelectionSwitch.setOn(isSourceSelected, animated: false)
    }
}

// MARK: - Private Methods
extension SourcesTableViewCell {
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(sourceTitleLabel)
        contentView.addSubview(sourceSelectionSwitch)
        sourceTitleLabel.anchor(top: topAnchor, left: leftAnchor,
                                bottom: bottomAnchor, right: nil,
                                paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 5,
                                width: 0, height: 0, enableInsets: false)
        sourceSelectionSwitch.anchor(top: topAnchor, left: sourceTitleLabel.rightAnchor,
                                     bottom: bottomAnchor, right: rightAnchor,
                                     paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 20,
                                     width: 0, height: 0, enableInsets: false)
        sourceSelectionSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
    }

    @objc private func switchChanged(_ sender : UISwitch!) {
        guard let source else { return }
        if sender.isOn {
            sourcesViewModel?.saveSource(source)
        } else {
            sourcesViewModel?.deleteSource(source)
        }
    }
}
