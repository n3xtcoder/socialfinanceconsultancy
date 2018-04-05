import Vapor
import HTTP

/// Here we have a controller that helps facilitate
/// creating typical REST patterns
final class HelloController: ResourceRepresentable {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    /// GET /hello
    func index(_ req: Request) throws -> ResponseRepresentable {
        
        return try view.make("questions.html")
    }
    
    /// When consumers call 'POST'
    
    
    private func getTags(answers: Content) -> [String] {
        
        let ans1 = answers["values_0_0"]?.int ?? 0
        let ans2 = answers["values_0_1"]?.int ?? 0
        let ans3 = answers["values_0_2"]?.int ?? 0
        
        var tags = [String]()
        
        if ans1 == 0 {
            tags.append("learn about the problem")
        }
        
        if ans1 == 0 || ans1 == 1 || ans1 == 2 {
            tags.append("theory of change root cause")
            tags.append("impact guidelines")
        }
        
        if ans1 == 3 || ans1 == 1 {
            tags.append("Impact report example")
        }
        
        if ans2 == 0 {
            tags.append("Understanding impact")
        }
        
        if ans2 == 1 || ans2 == 2 {
            tags.append("Understanding impact 2.0")
        }
        
        if ans3 == 0 || ans3 == 1 || ans3 == 2 {
            tags.append("Solution delivery shortfalls")
        }
        
        return tags
    }
    
    private func getRecommendations(tags: [String]) -> [String] {
        
        var recommendations = [String]()
        
        if tags.contains("learn about the problem") {
            recommendations.append("Hey, it seems that you are lacking the basics! No worries, we are there to help! But first, you should engage with your beneficiaries and try to understand the root causes of their problem.")
        }
        
        if tags.contains("theory of change root cause") {
            recommendations.append("Video unit 3: Measuring social impact")
            recommendations.append("Infographic unit 3: Measuring social impact")
            recommendations.append("Worksheet unit 3: Impact measurement")
        }
        
        if tags.contains("Impact Guidelines") {
            recommendations.append("http://www.socialvalueuk.org/app/uploads/2017/10/MaximiseYourImpact.24.10.17.pdf")
        }
        
        if tags.contains("Impact report example") {
            recommendations.append("""
                        If you want to effectively communicate about your impact you can have a look at these examples:
                        Vocational training and employment: Samasource https://www.samasource.org/methodology
                        Energy: Acumen https://acumen.org/wp-content/uploads/2018/02/Acumen-Energy-Impact-Report.pdf
                        Community Development: Village Enterprise http://villageenterprise.org/wp-content/uploads/2017/03/Village-Impact-Report-3_20Dec17.pdf
                        """)
        }
        
        if tags.contains("Understanding impact") {
            recommendations.append("http://www.impactmanagementproject.com/understand-impact/")
        }
        
        if tags.contains("Understanding impact 2.0") {
            recommendations.append("""
            Here’s for you a ready-to-fill worksheet to help you define the problem you want to tackle.
            http://diytoolkit.org/tools/problem-definition-2/
            """)
        }
        
        if tags.contains("Solution delivery shortfalls") {
            recommendations.append("""
When it comes to understanding the shortfalls in serving your target population, it is important to understand your specific sector. This sector report can be useful:
            https://www.povertyactionlab.org/evaluation/impacts-community-driven-development-sierra-leone
""")
        }
        
        return recommendations
    }
    
    
    func store(_ req: Request) throws -> ResponseRepresentable {
        
        let answers = req.data
        let tags = self.getTags(answers: answers)
        let recommendations = self.getRecommendations(tags: tags)
        
        
        return try view.make("recommendation", [
            "name": "John",
            "recommendations": recommendations.makeNode(in: nil)
            ], for: req)
    }
    
    /// GET /hello/:string
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        return try view.make("hello", [
            "name": string
            ], for: req)
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(
            index: index,
            store: store,
            show: show
        )
    }
}
