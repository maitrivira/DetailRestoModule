//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import SwiftUI
import RxSwift
import Core

public class DetailPresenter<DetailRestoUseCase: UseCase, FavUseCase: UseCase>: ObservableObject
where
    DetailRestoUseCase.Request == String,
    DetailRestoUseCase.Response == DetailRestaurantDomainModel,
    FavUseCase.Request == Any,
    FavUseCase.Response == [RestaurantDomainModel]
{
    
    private let disposeBag = DisposeBag()
    
    private let _detailUseCase: DetailRestoUseCase
    private let _favUseCase: FavUseCase
    
    @Published public var list: [RestaurantDomainModel] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isSaved: Bool = false
    
    public init(detailUseCase: DetailRestoUseCase, favUseCase: FavUseCase) {
        _detailUseCase = detailUseCase
        _favUseCase = favUseCase
    }
    
    public func getList(request: DetailRestoUseCase.Request) {
        isLoading = true
        _detailUseCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.list = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
//    func containsId(of id: String) -> Bool {
//
//        let data = list.contains { $0.id == id }
//        return data
//    }
}
