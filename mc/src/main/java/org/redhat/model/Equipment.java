package org.redhat.model;

import javax.persistence.Cacheable;
 import javax.persistence.Entity;
 import javax.persistence.Table;
 import javax.persistence.ManyToOne;
 import io.quarkus.hibernate.orm.panache.PanacheEntity;
 import javax.json.bind.annotation.JsonbTransient;


 @Entity
 @Table(name="Equipment")
 @Cacheable
public class Equipment extends PanacheEntity {
    
    private String name;
    private String type;
    private String code;
    private String status;
    
    @ManyToOne
    @JsonbTransient 
    private Battalion battalion;

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

    public Battalion getBattalion() {
        return battalion;
    }

    public void setBattalion(Battalion battalion) {
        this.battalion = battalion;
    }


    
}
