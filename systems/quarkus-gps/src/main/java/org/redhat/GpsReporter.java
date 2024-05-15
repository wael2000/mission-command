package org.redhat;

import javax.inject.Inject;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.redhat.client.LocationService;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

/*
 * This class will run in a background thread and will read gps coordinates
 * and will issue an HTTP POST call to update coordinates on the backend
 */
@ApplicationScoped
public class GpsReporter implements Runnable {

    @Inject
    Coordinates coordinates;

    @RestClient
    LocationService locationService;

    @ConfigProperty(name = "battalionid")
    int battalionid;

    @ConfigProperty(name = "waittime")
    int waittime;

    @Inject
    Logger logger;
    
    public void run() {
        
        while (!Thread.interrupted()) {

            Coordinates copy = coordinates.copyOf();

            try {
                
                System.out.println(copy);
                System.out.println(battalionid);
                System.out.println("=================");
                locationService.updateBattalionLocation(battalionid, copy);

                
            } catch (Exception e) {
                
                logger.info("Exception during posting location", e);
                
            }

            try {

                Thread.sleep(waittime);

            } catch (InterruptedException e) {

                logger.info("Exception while waiting", e);
            
            }

        }
    }
}
