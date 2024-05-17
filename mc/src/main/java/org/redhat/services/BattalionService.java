package org.redhat.services;



import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.redhat.model.Battalion;
import org.redhat.model.Coordinates;
import org.redhat.model.Equipment;

@ApplicationScoped
public class BattalionService {
    @Inject
    EntityManager em; 


    public Battalion[] getAll(){
        return em.createNamedQuery("Battalion.findAll", Battalion.class)
                .getResultList().toArray(new Battalion[0]);
    }

    @Transactional 
    public Battalion setStatus(Battalion battalion){
        Battalion bat = Battalion.findById(battalion.id);
        bat.setStatus(battalion.getStatus());
        /*if(battalion.getStatus().equals("deployed"))
            bat.setSystemStatus("on");*/
        em.persist(bat);
        return bat;
    }

    @Transactional 
    public Battalion setSystemStatus(Battalion battalion){
        Battalion bat = Battalion.findById(battalion.id);
        bat.setSystemStatus(battalion.getSystemStatus());
        em.persist(bat);
        return bat;
    }

    @Transactional 
    public Battalion setEquipmentStatus(Map<String,String> system){
        long battalionId = Long.parseLong(system.get("battalion"));
        String equipmentType = system.get("equipment");
        String status = system.get("status");
        Battalion bat = Battalion.findById(battalionId);
        for (Equipment equipment : bat.getEquipments()) {
            if(equipment.getType().equals(equipmentType)){
                equipment.setStatus(status);
            }
        }
        em.persist(bat);
        return bat;
    }

    public Battalion[] getByStatus(String status){
        return em.createNamedQuery("Battalion.findByStatus", Battalion.class)
                .setParameter("status",status)
                .getResultList().toArray(new Battalion[0]);
    }

    public Map<Long, String> findSystemStatusByIds(Set<Long> ids){
        Map<Long, String> systems = new HashMap<>();
        Battalion[] battalions = em.createNamedQuery("Battalion.findSystemStatusByIds", Battalion.class)
                .setParameter("ids",ids)
                .getResultList().toArray(new Battalion[0]);
        for (int i = 0; i < battalions.length; i++) {
            systems.put(battalions[i].id,battalions[i].getSystemStatus());
        }
        return systems ;
    }

    public Battalion getByName(String description){
        return Battalion.findByDescription(description);
    }

    public Battalion getById(long id){
        return Battalion.findById(id);
    }

    public void updateBattalionLocation(int id, Coordinates coordinates) {

        Battalion battalion = getById(id);

        battalion.setAltitude(coordinates.getAltitude());
        battalion.setLongitude(coordinates.getLongitude());
        battalion.setLatitude(coordinates.getLatitude());

    }
    
}
