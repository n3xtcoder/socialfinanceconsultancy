import Vapor

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }

    func build(_ builder: RouteBuilder) throws {
        /// GET /
        
        return builder.resource("", HelloController(view))
        

        // response to requests to /info domain
        // with a description of the request
        builder.get("info") { req in
            return req.description
        }

    }
}
