
 package org.redhat.model;

 import javax.persistence.Cacheable;
 import javax.persistence.Entity;
 import javax.persistence.NamedQuery;
 import javax.persistence.QueryHint;
 import javax.persistence.Table;
 import javax.persistence.ManyToOne;
 import io.quarkus.hibernate.orm.panache.PanacheEntity;
 import javax.json.bind.annotation.JsonbTransient;
 
 
 @Entity
 @Table(name="Member")
 @NamedQuery(name = "Members.findAll", query = "SELECT e FROM Member e", hints = @QueryHint(name = "org.hibernate.cacheable", value = "true"))
 @Cacheable
public class Member extends PanacheEntity {

    private String name;
    private String email;
    private String rank;

    @ManyToOne
    @JsonbTransient 
    public Battalion team;


    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public static Member findByEmail(String email) {
        return find("email", email).firstResult();
    }

    public void setRank(String rank) {
        this.rank = rank;
    }
    public String getRank() {
        return rank;
    }
    
}
