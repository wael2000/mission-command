package org.redhat.services;



import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.redhat.model.Battalion;
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
        for (Equipment equipment : bat.getEquipments()) {
            equipment.setStatus(battalion.getStatus());
        }
        em.persist(bat);
        return bat;
    }

    public Battalion[] getByStatus(String status){
        return em.createNamedQuery("Battalion.findByStatus", Battalion.class)
                .setParameter("status",status)
                .getResultList().toArray(new Battalion[0]);
    }
}
