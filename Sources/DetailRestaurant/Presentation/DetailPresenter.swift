//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import SwiftUI
import RxSwift
import Core

public class DetailPresenter<DetailRestoUseCase: UseCase, UpdateFavUseCase: UseCase>: ObservableObject
where
    DetailRestoUseCase.Request == String,
    DetailRestoUseCase.Response == DetailRestaurantDomainModel,
    UpdateFavUseCase.Request == DetailRestaurantDomainModel,
    UpdateFavUseCase.Response == Bool
{
    
    private let disposeBag = DisposeBag()
    private let _detailUseCase: DetailRestoUseCase
    private let _favUseCase: UpdateFavUseCase
    private let _keyStoreFavoriteResto: String = "FavoriteResto"
    @Published public var favoriteResto: [Int] = []
    @Published public var lists: [DetailRestaurantDomainModel] = []
    @Published public var list: DetailRestaurantDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isSaved: Bool = false
    
    public init(detailUseCase: DetailRestoUseCase, favUseCase: UpdateFavUseCase) {
        _detailUseCase = detailUseCase
        _favUseCase = favUseCase
        getFavoriteToUD()
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
    public func updateFavouriteList(request: UpdateFavUseCase.Request) {
        isLoading = true
        _favUseCase.execute(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isSaved = result
                if result {
                    favoriteResto.append(request.id)
                }else{
                    let index = favoriteResto.firstIndex(of: request.id)
                    favoriteResto.remove(at: index)
                }
                updateFavoriteToUD()
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    public func getFavoriteToUD() {
        favoriteResto = UserDefaults.standard.object(forKey: self._keyStoreFavoriteResto) as? [Int] ?? [0]
        print("data user default", lists)
    }
    
    public func updateFavoriteToUD() {
        UserDefaults.standard.set(self.favoriteResto, forKey: self._keyStoreFavoriteResto)
    }
}
