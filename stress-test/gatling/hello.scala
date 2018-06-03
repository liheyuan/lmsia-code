import io.gatling.core.Predef._ 
import io.gatling.http.Predef._
import scala.concurrent.duration._

class HelloSimulation extends Simulation {

  val httpConf = http 
    .baseURL("http://192.168.99.100:30888") 

  val scn = scenario("HelloSimulation").during(30) {
    exec(http("hello_1")
    .get("/lmsia-abc/api/"))
  }

  setUp(
    scn.inject(atOnceUsers(2000))
  ).protocols(httpConf)
}


