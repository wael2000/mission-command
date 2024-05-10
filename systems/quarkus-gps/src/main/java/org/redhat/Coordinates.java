package org.redhat;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class Coordinates {

    private double altitude, latitude, longitude;

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public Coordinates copyOf() {

        synchronized(this) {

            Coordinates copy = new Coordinates();
            copy.setAltitude(getAltitude());
            copy.setLatitude(getLatitude());
            copy.setLongitude(getLongitude());

            return copy;
        }

    }
    
}
