//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import Core
import RxSwift
import RealmSwift
import Foundation

public struct GetFavouriteLocaleDataSource: LocaleDataSource {
    
    public typealias Request = DetailRestaurantDomainModel
    public typealias Response = Bool
    
    private let _realm: Realm?
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func getRestaurants() -> Observable<[Bool]> {
        fatalError()
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
    
    public func addRestaurant(entities: DetailRestaurantDomainModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let localDatabase = self._realm {
            do {
                let getObjectById = localDatabase.objects(DetailRestaurantDomainModel.self).filter("id == %@", entities).first

              if getObjectById != nil {
                try localDatabase.write {
                  localDatabase.delete(getObjectById!)

                  observer.onNext(true)
                  observer.onCompleted()
                  print("data has beeen deleted to local DB")
                }
              } else {
                try localDatabase.write {
                  localDatabase.add(entities)

                  observer.onNext(true)
                  observer.onCompleted()
                  print("data has beeen saved to local DB")
                  print(entities)
                }
              }

            } catch {
              observer.onError(DatabaseError.requestFailed)
              print(DatabaseError.requestFailed)
            }
          } else {
            observer.onError(DatabaseError.requestFailed)
            print(DatabaseError.requestFailed)
          }
          return Disposables.create()
        }
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