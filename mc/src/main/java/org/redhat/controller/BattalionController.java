package org.redhat.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.resteasy.annotations.jaxrs.PathParam;
import org.redhat.model.Battalion;
import org.redhat.model.Coordinates;
import org.redhat.services.BattalionService;
import org.redhat.services.BuildPipelineProxyService;
import org.redhat.services.OpsPipelineProxyService;
import org.redhat.services.PipelineProxyService;


import org.eclipse.microprofile.config.inject.ConfigProperty;


@Path("/battalion")
public class BattalionController {
    @ConfigProperty(name = "pipeline.enabled" , defaultValue="true" )
    boolean pipelineEnabled;

    @Inject
    BattalionService service;

    @Inject
    @RestClient
    PipelineProxyService pipelineProxyService;

    @Inject
    @RestClient
    OpsPipelineProxyService opsPipelineProxyService;

    
    @Inject
    @RestClient
    BuildPipelineProxyService builsPipelineProxyService;

    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion[] battalis() {
        return service.getAll();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion battalion(@PathParam long id) {
        return service.getById(id);
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
        if(pipelineEnabled && Battalion.DEPLOYED.equals( bat.getStatus())){
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription());
            payload.put("action","deploy");
            payload.put("location","dc");
            pipelineProxyService.deploy(payload);
        }
        return bat;
    }
  

    @POST
    @Path("/system")
    @Produces(MediaType.APPLICATION_JSON)
    /**
     * update Battalion infrastrucutre readiness (systemStatus = on/off)
     * @param battalion
     * @return
     */
    public Battalion setSystemStatus(Battalion battalion) {
        return service.setSystemStatus(battalion);
    }

    
    @POST
    @Path("/equipment")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)    
    public Battalion enablEequipment(Map<String,String> system) {
        Battalion bat = service.setEquipmentStatus(system);
        // trigger the equipment pipeline
        if(pipelineEnabled){
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription().toLowerCase());
            payload.put("app_name",system.get("equipment").toLowerCase());
            payload.put("action","deploy");
            payload.put("location","dc");
            opsPipelineProxyService.deploy(payload);
        }
        return bat;
    }






    @POST
    @Path("/build")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion build(Battalion battalion) {
        Battalion bat = Battalion.findById(battalion.id);
        Map<String,String> payload = new HashMap<>();
        payload.put("battalion",bat.getDescription());
        builsPipelineProxyService.build(payload);
        return bat;
    }



    @POST
    @Path("/onboard")
    @Produces(MediaType.TEXT_PLAIN)
    @Consumes(MediaType.TEXT_PLAIN)
    /**
     * Slack integration
     * @param body
     * @return
     */
    public String onboard(String body) {
        Map<String, String> paramMap = parseQueryString(body);
        String team = paramMap.get("text");
        Battalion bat = service.getByName(team);
        // trigger the pipeline
        Map<String,String> payload = new HashMap<>();
        payload.put("battalion",bat.getDescription());
        payload.put("battalion_id",bat.id.toString());
        payload.put("action","deploy");
        pipelineProxyService.deploy(payload);
        return "Success";
        
    }

    @POST
    @Path("/location/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public void updateBattalionLocation(@PathParam int id, Coordinates coordinates) {
        service.updateBattalionLocation(id, coordinates);

    }
    
    private static Map<String, String> parseQueryString(String query) {
        Map<String, String> paramMap = new HashMap<>();
        String[] pairs = query.split("&");
        for (String pair : pairs) {
            int idx = pair.indexOf("=");
            String key = pair.substring(0, idx);
            String value = pair.substring(idx + 1,pair.length()-1);
            paramMap.put(key, value);
        }
        return paramMap;
    }

}   
