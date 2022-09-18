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
    FavUseCase.Response == [DetailRestaurantDomainModel]
{
    
    private let disposeBag = DisposeBag()
    private let _detailUseCase: DetailRestoUseCase
    private let _favUseCase: FavUseCase
    
    @Published public var list: DetailRestaurantDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isSaved: Bool = false
    
    public init(detailUseCase: DetailRestoUseCase, favUseCase: FavUseCase) {
        _detailUseCase = detailUseCase
        _favUseCase = favUseCase
    }
    
    // get detail
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
    
    // update favourite
    public func updateFavouriteList(request: FavUseCase.Request) {
        isLoading = true
        _favUseCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
//                self.isSaved = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
}
