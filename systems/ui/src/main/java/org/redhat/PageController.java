package org.redhat;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.inject.Inject;
import io.quarkus.qute.TemplateInstance;
import io.quarkus.qute.Template;

@Path("/")
public class PageController {

    @ConfigProperty(name = "api.url")
    String api;

    @Inject
    Template home;

    @GET
    @Produces(MediaType.TEXT_HTML)
    @Path("")
    public TemplateInstance home() {
        return  home.data("api",api)
                    .data("view", "grid")
                    .data("username", "Kees")
                    .data("emp", "")
                    .data("email", "email");
    }

    /*@GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        return "Hello RESTEasy";
    }*/
}
