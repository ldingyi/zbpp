package cn.ldingyi.zbpp.service;

import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.Tourist;
import org.springframework.data.domain.Page;
import cn.ldingyi.zbpp.util.Condition;

import java.util.List;

public interface ActivityService extends BaseService<Activity> {
    public Page<Activity> listActivities(Condition activityCondition, int currentPage);//列出所有的活动以及赛事
    public boolean signActivity(int activityId , Member member);//队员报名活动，可直接点击报名，获得session中的member对象进行插入
    public boolean touristJoinActivity(int activityId, Tourist tourist);//外部人员报名
    public void addActivity(Activity activity);//添加活动
    public void deleteActivity(int[] ids, int isAll, Condition activityCondition);//删除活动
    public List<Activity> listMyActivities(Member member);//队员查看自己报名的活动
    public List<Activity> touristLisyMyActivities(String phone);//暂不实现
    public Activity lookActivityDetail(int id);
    public List<Activity> homeListActivity();
    public Page<Activity> moreActivity(Integer kind,int currentPage);



}
