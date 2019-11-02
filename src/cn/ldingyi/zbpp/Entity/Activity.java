package cn.ldingyi.zbpp.Entity;

import org.hibernate.annotations.Cascade;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "activity")
public class Activity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date se;//sign end
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date at;//activity start
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ae;//activity end
    private int kind;
    private int ispub;
    private String ad;
    @ManyToMany(fetch = FetchType.EAGER)
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    @JoinTable(name = "ma",joinColumns = {@JoinColumn(name = "ma_aid")},inverseJoinColumns = {@JoinColumn(name = "ma_mid")})
    private Set<Member> activityMembers = new HashSet<Member>();
    @ManyToMany(fetch = FetchType.EAGER)
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    @JoinTable(name = "ta",joinColumns ={@JoinColumn(name = "ta_aid")},inverseJoinColumns = {@JoinColumn(name = "ta_tid")})
    private Set<Tourist> activityTourist = new HashSet<Tourist>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getSe() {
        return se;
    }

    public void setSe(Date se) {
        this.se = se;
    }

    public Date getAt() {
        return at;
    }

    public void setAt(Date at) {
        this.at = at;
    }

    public Date getAe() {
        return ae;
    }

    public void setAe(Date ae) {
        this.ae = ae;
    }

    public int getKind() {
        return kind;
    }

    public void setKind(int kind) {
        this.kind = kind;
    }

    public String getAd() {
        return ad;
    }

    public void setAd(String ad) {
        this.ad = ad;
    }

    public int getIspub() {
        return ispub;
    }

    public void setIspub(int ispub) {
        this.ispub = ispub;
    }

    public Set<Member> getActivityMembers() {
        return activityMembers;
    }

    public void setActivityMembers(Set<Member> activityMembers) {
        this.activityMembers = activityMembers;
    }

    public Set<Tourist> getActivityTourist() {
        return activityTourist;
    }

    public void setActivityTourist(Set<Tourist> activityTourist) {
        this.activityTourist = activityTourist;
    }
}
