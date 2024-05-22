package org.redhat.model;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.NamedQuery;
import javax.persistence.QueryHint;
import javax.persistence.Table;
import javax.persistence.OneToMany;
import javax.persistence.FetchType;
import javax.persistence.CascadeType;
import java.util.Set;
import io.quarkus.hibernate.orm.panache.PanacheEntity;
import java.util.Map;
import java.util.HashMap;

@Entity
@Table(name="Battalion")
@NamedQuery(name = "Battalion.findAll", query = "SELECT t FROM Battalion t", hints = @QueryHint(name = "org.hibernate.cacheable", value = "true"))
@NamedQuery(name = "Battalion.findByStatus", query = "SELECT b FROM Battalion b where status=:status", hints = @QueryHint(name = "org.hibernate.cacheable", value = "true"))
@NamedQuery(name = "Battalion.findSystemStatusByIds", query = "SELECT b FROM Battalion b where id in(:ids)", hints = @QueryHint(name = "org.hibernate.cacheable", value = "true"))

@Cacheable
public class Battalion extends PanacheEntity {
    public static String STATIC = "static";
    public static String DEPLOYED = "deployed";
    public static String MOBILE = "mobile";
    public static String DISMOUNT = "dismount";

    private String name;
    private String description;
    private String status;  // static, deployed, mobile. dismount

    private String systemStatus="off";
    private String systemMode="auto";

    private double altitude;
    private double longitude;
    private double latitude;

    private Boolean azure;

    public void setAzure(Boolean azure) {
        this.azure = azure;
    }

    public Boolean isAzure() {
        return azure;
    }

    public static Battalion findByDescription(String description){
        return find("description", description).firstResult();
    }

    public static Battalion findById(long id){
        return find("id", id).firstResult();
    }

    public String getSystemStatus() {
        return systemStatus;
    }
    public void setSystemStatus(String systemStatus) {
        this.systemStatus = systemStatus;
    }
    public String getSystemMode() {
        return systemMode;
    }
    public void setSystemMode(String systemMode) {
        this.systemMode = systemMode;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    @OneToMany(mappedBy = "team", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    //@JsonbTransient 
    private Set<Member> members;

    @OneToMany(mappedBy = "battalion", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private Set<Equipment> equipments;


    public Set<Member> getMembers() {
        return members;
    }
    public Set<Equipment> getEquipments() {
        return equipments;
    }
    public void setMembers(Set<Member> members) {
        this.members = members;
    }
    public void setEquipments(Set<Equipment> equipments) {
        this.equipments = equipments;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Map<String,Integer> getEquipmentMap(){
        Map<String,Integer> map = new HashMap<String,Integer>();
        for (Equipment equipment : equipments) {
            Integer counter = map.get(equipment.getType())!=null?map.get(equipment.getType()):0;
            map.put(equipment.getType(),++counter);
        }
        return map;
    }
    public Map<String,String> getEquipmenStatusMap(){
        Map<String,String> map = new HashMap<String,String>();
        for (Equipment equipment : equipments) {
            map.put(equipment.getType(),equipment.getStatus());
        }
        return map;
    }
}
