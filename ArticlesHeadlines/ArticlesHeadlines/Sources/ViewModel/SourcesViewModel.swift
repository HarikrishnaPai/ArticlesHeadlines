//
//  SourcesViewModel.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import Foundation
import RxSwift
import Networking

class SourcesViewModel: NSObject {
    
    // MARK: - Variables
    var networkManager: NetworkManagerProtocol!
    var sources = PublishSubject<[Source]>()
    let error = PublishSubject<Error>()
    var userPreference: UserPreference!

    // MARK: - Initialization
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         userPreference: UserPreference = UserPreference(defaults: UserDefaults.standard)) {
        super.init()
        self.networkManager = networkManager
        self.userPreference = userPreference
    }
}

// MARK: - Public Methods
extension SourcesViewModel {
    func getSources() {
        Task { [weak self] in
            do {
                let endpoint = NewsAPIEndpoints.Sources.all
                let response = try await self?.networkManager.performRequest(for: endpoint, responseModel: Sources.self)
                if let sources = response?.sources {
                    self?.sources.onNext(sources)
                }
            } catch {
                self?.error.onNext(error)
            }
        }
    }
    
    func isSourceSelected(_ source: Source) -> Bool {
        let isSourceSelected = userPreference.selectedSources?.contains { $0 == source.sourceId } ?? false
        return isSourceSelected
    }

    func saveSource(_ source: Source) {
        // Save the source to User Preference
        guard !isSourceSelected(source) else { return }
        guard let sourceId = source.sourceId else { return }
        guard let selectedSources = userPreference.selectedSources else {
            userPreference.selectedSources = [ sourceId ]
            return
        }
        userPreference.selectedSources = selectedSources + [ sourceId ]
    }
    
    func deleteSource(_ source: Source) {
        // Delete the source from User Preference
        userPreference.selectedSources = userPreference.selectedSources?.filter { $0 != source.sourceId }
    }
}
