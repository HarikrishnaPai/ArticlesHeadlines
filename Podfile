platform :ios, '16.0'

use_frameworks!

workspace 'ArticlesHeadlines'

#Networking Module
def networking_pods
end

target 'Networking' do
    project 'Networking/Networking.project'
    networking_pods
end

#Articles Headlines Module
def application_pods
    networking_pods
    pod 'RxSwift'
    pod 'RxCocoa'
end

target 'ArticlesHeadlines' do
    project 'ArticlesHeadlines/ArticlesHeadlines.project'
    application_pods
end
