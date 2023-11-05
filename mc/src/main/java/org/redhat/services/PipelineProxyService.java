package org.redhat.services;


import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import java.util.List;
import java.util.Map;
import javax.ws.rs.QueryParam;
import javax.ws.rs.PathParam;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/")
@RegisterRestClient
public interface PipelineProxyService {
   
    /**
     * 
     * @param battalion
     * @return
     */
    @POST
    @Path("/")
    @Produces("application/json")
    @Consumes("application/json")
    Object deploy(Object battalion);


}
