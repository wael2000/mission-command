package org.acme;


import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class BubbleResourceTest {
    @Test
    public void testHelloWorld() {
        given()
          .when().get("/bubble/helloworld")
          .then()
             .statusCode(200)
             .body(is("Hello World"));
    }

    @Test
    public void testHelloCountry() {
        given()
          .when().get("/bubble/hellocountry")
          .then()
             .statusCode(200)
             .body(is("Hello Country"));
    }

    @Test
    public void testHelloCity() {
        given()
          .when().get("/bubble/hellocity")
          .then()
             .statusCode(200)
             .body(is("Hello City"));
    }

}
