package org.redhat.client;

import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;
import org.redhat.Coordinates;


@Path("/battalion")
@RegisterRestClient(configKey="location-api")
public interface LocationService {
    
    @POST
    @Path("/location/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public void updateBattalionLocation(@PathParam(value = "id") int id, Coordinates coordinates);

}
