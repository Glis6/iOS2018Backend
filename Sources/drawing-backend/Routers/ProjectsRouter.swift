import Foundation
import Kitura
import KituraContracts
import LoggerAPI
import MongoKitten

private let drawings = database["drawings"]

func configureProjectsRouter(on router: Router) {
    router.get("/drawings", handler: getAllDrawings)
    router.post("/drawing/add", handler: addDrawing)
}

private func getAllDrawings(completion: ([Drawing]?, RequestError?) -> Void) {
    do {
        let results = try drawings.find().flatMap(Drawing.init)
        completion(results, nil)
    } catch {
        Log.error(error.localizedDescription)
        completion(nil, .internalServerError)
    }
}

private func addDrawing(drawing: Drawing, completion: (Drawing?, RequestError?) -> Void) {
    do {
        try drawings.insert(drawing.toBSON())
        completion(drawing, nil)
    } catch {
        Log.error(error.localizedDescription)
        completion(nil, .internalServerError)
    }
}
