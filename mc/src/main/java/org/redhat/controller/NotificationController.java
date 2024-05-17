package org.redhat.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.jboss.logging.Logger;
import org.redhat.services.BattalionService;

import io.quarkus.scheduler.Scheduled;

@ServerEndpoint("/notify/{battalion}")         
@ApplicationScoped
public class NotificationController {
    
    private static final Logger LOG = Logger.getLogger(NotificationController.class);
    

    @Inject
    BattalionService service;

    Map<Long, Session> sessions = new ConcurrentHashMap<>();
    
    Map<Long, String> systems = new HashMap<>();
    Map<Long, Map<String,String>> equipments = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("battalion") Long battalion) {
        sessions.put(battalion, session);
        systems.put(battalion,"off");
    }

    @OnClose
    public void onClose(Session session, @PathParam("battalion") Long battalion) {
        sessions.remove(battalion);
    }

    @OnError
    public void onError(Session session, @PathParam("battalion") Long battalion, Throwable throwable) {
        sessions.remove(battalion);
        LOG.error("onError", throwable);
    }

    /* 
    @OnMessage
    public void onMessage(String message, @PathParam("battalion") String battalion) {
        broadcast();
    }*/

    
    @Scheduled(every="20s") 
    void broadcast() {
        // get System Status update
        Map<Long, String> updatedSystems = service.findSystemStatusByIds(sessions.keySet());
        updatedSystems.keySet().forEach( k -> {
            if(!updatedSystems.get(k).equals(systems.get(k))) {
                systems.put(k, updatedSystems.get(k));
                String message = "b," + k + "," + updatedSystems.get(k);
                sessions.get(k).getAsyncRemote().sendObject(message, result -> {
                if (result.getException() != null) {
                    System.out.println("Unable to send message: " + result.getException());
                }
                });
            }
            if( equipments.get(k)==null)
                equipments.put(k, service.getById(k).getEquipmenStatusMap());
            else {
                Map<String,String> dbequipmentMap = service.getById(k).getEquipmenStatusMap();
                Map<String,String> currentequipmentMap = equipments.get(k);
                dbequipmentMap.keySet().forEach(equipmentK -> {
                    if(!dbequipmentMap.get(equipmentK).equals(currentequipmentMap.get(equipmentK))){
                        String message = "e," + equipmentK + "," + dbequipmentMap.get(equipmentK);
                        sessions.get(k).getAsyncRemote().sendObject(message, result -> {
                            if (result.getException() != null) {
                                System.out.println("Unable to send message: " + result.getException());
                            }
                            });
                    }
                    
                });
                equipments.put(k, dbequipmentMap);
            }
        });
        systems.putAll(updatedSystems);
    }
}
