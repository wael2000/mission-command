package org.redhat.model;

import jakarta.persistence.Cacheable;
import jakarta.persistence.Table;
import jakarta.persistence.Entity;
import jakarta.persistence.Column;
import io.quarkus.hibernate.orm.panache.PanacheEntity;


 @Entity
 @Table(name="Equipment")
 @Cacheable
public class Equipment extends PanacheEntity {
    
    private String name;
    private String type;
    private String code;
    private String status;
    
    @Column(name="battalion_id")
    private Integer battalionId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getBattalionId() {
        return battalionId;
    }

    public void setBattalionId(Integer battalionId) {
        this.battalionId = battalionId;
    }
    
}
