//
//  MusicNetworkManger.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Alamofire

class MusicNetworkManger: RequestInterceptor {
    static let shared  = MusicNetworkManger()
    private init() {}
    typealias NetworkComplertion = (Result<[Music], NetworkError>) -> Void
    
     func fetchMusic(searchTerm: String, completion : @escaping NetworkComplertion) {
         let urlString  = "\(Constant.ITUNNES_URL)\(Constant.mediaParam)&term=\(searchTerm)"
        debugPrint(urlString)
        performRequest(with: urlString) { result in
            completion(result)
            
        }
    }
    //MARK:  - 네트워크 request를 받는 함수
    
    private func performRequest(with urlString: String, completion: @escaping NetworkComplertion) {
        guard let url = URL(string: urlString) else {return}
        var session = AF.session
        session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error )in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.networkingError))
                return
            }
            guard let safeData = data else  {
                completion(.failure(.dataError))
                return
            }
            
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(musics))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    //MARK: - JSON으로 파싱 하는 함수
    private func parseJSON(_ musicData: Data) -> [Music]? {
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
            // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
