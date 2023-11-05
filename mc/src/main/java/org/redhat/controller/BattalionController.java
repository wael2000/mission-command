package org.redhat.controller;

import java.util.Map;
import java.util.HashMap;

import javax.inject.Inject;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.rest.client.inject.RestClient;

import org.jboss.resteasy.annotations.jaxrs.PathParam;

import org.redhat.services.BattalionService;
import org.redhat.services.PipelineProxyService;
import org.redhat.model.Battalion;


@Path("/battalion")
public class BattalionController {
    
    @Inject
    BattalionService service;

    @Inject
    @RestClient
    PipelineProxyService pipelineProxyService;
    
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
        Battalion bat = service.setStatus(battalion);
        // trigger the pipeline
        if(Battalion.DEPLOYED.equals( bat.getStatus())){
            System.out.println(pipelineProxyService);
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription());
            Object result = pipelineProxyService.deploy(payload);
            System.out.println(result);
        }
        return bat;
    }

    @POST
    @Path("/system")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion setSystemMode(Battalion battalion) {
        return service.setSystemStatus(battalion);
    }
    

}   
