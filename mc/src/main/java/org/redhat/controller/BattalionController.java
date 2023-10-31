package org.redhat.controller;

import javax.inject.Inject;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import org.redhat.services.BattalionService;
import org.redhat.model.Battalion;


@Path("/battalion")
public class BattalionController {
    
    @Inject
    BattalionService service;
    
    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion[] battalis() {
        return service.getAll();
    }

    @GET
    @Path("/status/{status}")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion[] getByStatus(@PathParam String status) {
        return service.getByStatus(status);
    }

    @POST
    @Path("/status")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion setStatus(Battalion battalion) {
        return service.setStatus(battalion);
    }
    

}   
