package cn.ldingyi.zbpp.View;

public class ActivityModel extends ViewModel {
    private Integer id;
    private String name;
    private String signEnd;
    private String activityStart;
    private String activityEnd;
    private Integer kind;
    private Integer ispub;
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

    public String getSignEnd() {
        return signEnd;
    }

    public void setSignEnd(String signEnd) {
        this.signEnd = signEnd;
    }

    public String getActivityStart() {
        return activityStart;
    }

    public void setActivityStart(String activityStart) {
        this.activityStart = activityStart;
    }

    public String getActivityEnd() {
        return activityEnd;
    }

    public void setActivityEnd(String activityEnd) {
        this.activityEnd = activityEnd;
    }

    public Integer getKind() {
        return kind;
    }

    public void setKind(Integer kind) {
        this.kind = kind;
    }

    public Integer getIspub() {
        return ispub;
    }

    public void setIspub(Integer ispub) {
        this.ispub = ispub;
    }
}
