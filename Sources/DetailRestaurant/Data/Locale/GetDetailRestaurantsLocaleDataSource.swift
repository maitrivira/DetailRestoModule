//
//  File.swift
//  
//
//  Created by Maitri Vira on 29/05/22.
//

import Core
import RxSwift
import RealmSwift
import Foundation

public struct GetDetailRestaurantsLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantDomainModel
    
    private let _realm: Realm?
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func getRestaurants() -> Observable<[DetailRestaurantDomainModel]> {
        return Observable<[DetailRestaurantDomainModel]>.create { observer in
            if let realm = self._realm {
                let detail: Results<DetailRestaurantDomainModel> = {
                    realm.objects(DetailRestaurantModuleEntity.self).sorted(byKeyPath: "id", ascending: true)
                }()
                observer.onNext(detail.toArray(ofType: DetailRestaurantDomainModel.self))
                observer.onCompleted()
            }else{
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    public func getRestaurant(request id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let localDatabase = self._realm {
            do {
              let getObjectById = localDatabase.objects(DetailRestaurantModuleEntity.self).filter("id == %@", id).first

              if getObjectById != nil {
                observer.onNext(true)
              } else {
                observer.onNext(false)
              }

              observer.onCompleted()
            }
          } else {
            observer.onError(DatabaseError.requestFailed)
            print(DatabaseError.requestFailed)
          }
          return Disposables.create()
        }
    }
    
    public func addRestaurant(entities: String) -> Observable<Bool> {
        fatalError()
    }
    
    public func removeRestaurant(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        realm.delete(realm.objects(DetailRestaurantModuleEntity.self).filter("id=%@", id))
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
}
