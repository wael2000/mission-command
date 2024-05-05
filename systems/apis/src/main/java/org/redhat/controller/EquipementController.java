package org.redhat.controller;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import java.util.List;
import org.redhat.model.Equipment;

@Path("/equipment")
public class EquipementController {
    @ConfigProperty(name = "battalion" , defaultValue="0" )
    Long battalion;


    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Equipment> battalion() {
        return Equipment.list("battalionId",battalion);
    }

  
}
