package org.redhat;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.jboss.logging.Logger;

import io.quarkus.security.identity.SecurityIdentity;

@Path("/api")
public class GpsResource {

    @Inject
    Logger logger;

    @Inject
    Coordinates coordinates;

    @Inject
    GpsReporter gpsReporter;

    @Inject
    SecurityIdentity securityIdentity;

    @GET
    @Path("/location")
    @Produces(MediaType.APPLICATION_JSON)
    public Coordinates coordinates() {

        return coordinates;

    }

}