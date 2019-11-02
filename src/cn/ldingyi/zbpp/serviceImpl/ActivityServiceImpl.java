package cn.ldingyi.zbpp.serviceImpl;

import cn.ldingyi.zbpp.DAO.ActivityDAO;
import cn.ldingyi.zbpp.DAO.MemberDAO;
import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.Tourist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import cn.ldingyi.zbpp.service.ActivityService;
import cn.ldingyi.zbpp.util.ActivityCondition;
import cn.ldingyi.zbpp.util.Condition;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

@Service("activityService")
public class ActivityServiceImpl extends BaseServiceImpl<Activity> implements ActivityService {

    @Autowired
    ActivityDAO activityDAO;
    @Autowired
    MemberDAO memberDAO;


    private Specification<Activity> getSpecification(Condition condition){
        ActivityCondition activityCondition = (ActivityCondition) condition;
        Specification<Activity> specification = new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> andList = new ArrayList<>();
                if (activityCondition.getName()!=null){
                    andList.add(criteriaBuilder.like(root.get("name"),"%"+activityCondition.getName()+"%"));
                }
                if (activityCondition.getIspub()!=null){
                    andList.add(criteriaBuilder.equal(root.get("ispub"),activityCondition.getIspub()));
                }
                if (activityCondition.getKind()!=null){
                    andList.add(criteriaBuilder.equal(root.get("kind"),activityCondition.getKind()));
                }
                if (activityCondition.getProgress()!=null){
                    if(activityCondition.getProgress()==0){
                        andList.add(criteriaBuilder.lessThan(root.get("at"),new Date()));
                    }
                    if(activityCondition.getProgress()==1){
                        andList.add(criteriaBuilder.greaterThanOrEqualTo(root.get("ae"),new Date()));
                    }
                }
                Predicate[] andArr = new Predicate[andList.size()];
                Predicate and = criteriaBuilder.and(andList.toArray(andArr));
                return and;
            }
        };
        return specification;
    }

    @Override
    public JpaRepository<Activity, Integer> getDAO() {
        return activityDAO;
    }



    @Override
    public Page<Activity> listActivities(Condition activityCondition, int currentPage) {
        Sort sort = new Sort(Sort.Direction.DESC,"at");
        int size =15;
        Pageable pageable = new PageRequest(currentPage,size,sort);
        Page<Activity> activitiesPage = activityDAO.findAll(getSpecification(activityCondition),pageable);

        return activitiesPage ;
    }

    @Override
    public boolean signActivity(int activityId, Member member) {
        try {

            Activity activity = activityDAO.findOne(activityId);
            activity.getActivityMembers().add(member);
            activityDAO.save(activity);
            return true;
        }catch (Exception e){

            return false;
        }
    }

    @Override
    public boolean touristJoinActivity(int activityId, Tourist tourist) {

        Activity activity = activityDAO.findOne(activityId);
        activity.getActivityTourist().add(tourist);
        try {
            activityDAO.save(activity);
            return true;
        }catch (Exception e){
            return false;
        }

    }

    @Override
    public void addActivity(Activity activity) {

        activityDAO.save(activity);
    }

    @Override
    public void deleteActivity(int[] ids, int isAll, Condition activityCondition) {
        List<Activity> allActivities = activityDAO.findAll(getSpecification(activityCondition));
        Set<Integer> allIds = new HashSet<>();
        for (Activity activity : allActivities) {
            allIds.add(activity.getId());
        }
        ids = getIds(ids,isAll,allIds);
        activityDAO.deleteInBatch(activityDAO.findByIdIn(ids));
    }

    @Override
    public List<Activity> listMyActivities(Member member) {
        int id = member.getId();
        List<Activity> activities = activityDAO.findByActivityMembersIdIs(id);
        return activities;
    }

    @Override
    public List<Activity> touristLisyMyActivities(String phone) {
        // 感觉这个东西不是会员的话没有必要去添加这个功能
        return null;
    }

    @Override
    public Activity lookActivityDetail(int id) {

        return activityDAO.findOne(id);
    }

    @Override
    public List<Activity> homeListActivity() {

        return activityDAO.queryActivityTop5ByAtAndKindIs0();
    }

    @Override
    public Page<Activity> moreActivity(Integer kind, int currentPage) {
        Sort sort = new Sort(Sort.Direction.DESC,"at");
        int size = 20;
        Pageable pageable = new PageRequest(currentPage,size,sort);
        Specification<Activity> specification = new Specification() {
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                if (kind!=null){
                    Predicate predicate = criteriaBuilder.equal(root.get("kind"),kind);
                    return predicate;
                }else {
                    return null;
                }

            }
        };
        Page<Activity> page = activityDAO.findAll(specification,pageable);
        return page;
    }


}
