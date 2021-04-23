//
//  ManagerConnections.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    /* Función para obtener una página de las cartas */
    func getCardList(page: Int) -> Observable<[Card]>{
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.listCard + "?page=" + String(page) + "&pageSize=20")!)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("X-Api-Key", forHTTPHeaderField: Endpoints.apiKey)
            
            session.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        
                        let decoder = JSONDecoder()
                        let cards = try decoder.decode(Cards.self, from: data)
                        print(cards.cards)
                        observer.onNext(cards.cards)
                        
                    } catch let error {
                        
                        observer.onError(error)
                        print("Ha ocurrido un error: \(error.localizedDescription)")
                    }
                }
                else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
            
        }
    }
    
    /* Función para obtener el detalle de una carta */
    func getCardDetail(idCard: String) -> Observable<Card> {
        
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.detailCard + idCard)!)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("X-Api-Key", forHTTPHeaderField: Endpoints.apiKey)
            
            session.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        
                        let decoder = JSONDecoder()
                        let card = try decoder.decode(CardDetail.self, from: data)
                        observer.onNext(card.card)
                        
                    } catch let error {
                        
                        observer.onError(error)
                        print("Ha ocurrido un error: \(error.localizedDescription)")
                    }
                }
                else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
            
        }
    }
}
