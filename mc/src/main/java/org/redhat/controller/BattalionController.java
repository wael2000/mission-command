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
import org.redhat.services.PipelineProxyService;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
        System.out.print("======== pipelineEnabled ========= ");
        System.out.println(pipelineEnabled);
        if(pipelineEnabled && Battalion.DEPLOYED.equals( bat.getStatus()) && bat.getSystemMode().equals("auto")){
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription());
            payload.put("battalion_id",bat.id.toString());
            payload.put("action","deploy");
            pipelineProxyService.deploy(payload);
        }
        return bat;
    }

    @POST
    @Path("/deploy")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion deploy(Battalion battalion) {
        Battalion bat = Battalion.findById(battalion.id);
        // trigger the pipeline
        if(Battalion.DEPLOYED.equals( bat.getStatus()) && bat.getSystemMode().equals("manual")){
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription());
            payload.put("battalion_id",bat.id.toString());
            payload.put("action","deploy");
            pipelineProxyService.deploy(payload);
        }
        return bat;
    }

    @POST
    @Path("/remove")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion remove(Battalion battalion) {
        Battalion bat = service.setSystemStatus(battalion);
        // trigger the pipeline
        if(Battalion.DEPLOYED.equals( bat.getStatus()) && bat.getSystemMode().equals("manual")){
            Map<String,String> payload = new HashMap<>();
            payload.put("battalion",bat.getDescription());
            payload.put("battalion_id",bat.id.toString());
            payload.put("action","remove");
            pipelineProxyService.deploy(payload);
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
    @Path("/system")
    @Produces(MediaType.APPLICATION_JSON)
    public Battalion setSystemMode(Battalion battalion) {
        return service.setSystemStatus(battalion);
    }

    @POST
    @Path("/onboard")
    @Produces(MediaType.TEXT_PLAIN)
    @Consumes(MediaType.TEXT_PLAIN)
    public String onboard(String body) {
        System.out.println("==========================");
        System.out.println(body);
        Map<String, String> paramMap = parseQueryString(body);
        System.out.println("==========================");
        //String team = paramMap.get("text").replaceAll("[\\p{Cntrl}&&[^\r\n\t]]", "");
        String team = paramMap.get("text");
        for (int i = 0; i < team.length(); i++) {
            char currentChar = team.charAt(i);
            System.out.print(i  + "=" + currentChar + " ");
        }
        System.out.println("==========================");

        Battalion bat = service.getByName(team);
        System.out.println(bat);
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
            //try {
                //String key = URLDecoder.decode(pair.substring(0, idx), "UTF-8");
                //String value = URLDecoder.decode(pair.substring(idx + 1), "UTF-8");
                String key = pair.substring(0, idx);
                String value = pair.substring(idx + 1,pair.length()-1);
                paramMap.put(key, value);
            //} catch (UnsupportedEncodingException e) {
                //e.printStackTrace(); // Handle the exception according to your needs
            //}
        }

        return paramMap;
    }

}   
