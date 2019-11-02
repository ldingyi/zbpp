package cn.ldingyi.zbpp.Test;

import cn.ldingyi.zbpp.DAO.ActivityDAO;
import cn.ldingyi.zbpp.DAO.MemberDAO;
import cn.ldingyi.zbpp.DAO.RoleDAO;
import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.Role;
import cn.ldingyi.zbpp.Entity.Tourist;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import cn.ldingyi.zbpp.service.MemberService;
import cn.ldingyi.zbpp.util.Condition;
import cn.ldingyi.zbpp.util.MemberCondition;


import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MemberDAOTest {
    @Autowired
    MemberDAO memberDAO;
    @Autowired
    MemberService memberService;
    @Autowired
    ActivityDAO activityDAO;
    @Autowired
    RoleDAO roleDAO;


private void cs(HttpServletRequest request) throws Exception{
    String filePath = request.getServletContext().getRealPath("/")+"up/personalPhoto";
    System.out.println(filePath);
}


    @Test
    public void testInsert(){
        MemberCondition condition = new MemberCondition();
        Page<Member> page = memberService.memberList(condition,0);
        List<Member> members = page.getContent();
        for (Member member : members) {
            //System.out.println(member.getRole().getMembers());
        }

    }


    @Test
    public void testDelete(){
        Set<Integer> set = new HashSet<>();
        set.add(1);
        set.add(2);
        Integer[] a = new Integer[set.size()];
        set.toArray(a);
        int[] b = Arrays.stream(a).mapToInt(Integer::intValue).toArray();
        System.out.println(Arrays.toString(b));

    }
    @Test
    public void testQuery(){
        int[] a={1,2,3};
        List<Member> members=memberDAO.findByIdIn(a);
        for (Member member : members) {
            System.out.println(member.getName());
        }
    }
    @Test
    public void testSet(){
        Set<Integer> set1 = new HashSet<>();
        Set<Integer> set2 = new HashSet<>();
        Set<Integer> set3 = new HashSet<>();
        set2.add(1);
        set2.add(2);
        set2.add(3);
        set3.add(1);
        set1.addAll(set2);
        set1.removeAll(set3);
        Integer[] cs = new Integer[set1.size()];
        set1.toArray(cs);
        int[] cs2 = Arrays.stream(cs).mapToInt(Integer::intValue).toArray();
        System.out.println(Arrays.toString(cs2));
    }

    @Test
    public void test3(){
       Activity activity = activityDAO.findOne(1);
       Member member = memberDAO.findOne(22);
       activity.getActivityMembers().add(member);
       activityDAO.save(activity);



    }

    @Test
    public void test4(){

        try {
            Member member = memberDAO.findOne(1);
            Activity activity = activityDAO.findOne(9);
            activity.getActivityMembers().add(member);
            activityDAO.save(activity);
            System.out.println("saf");
        }catch (Exception e){
            System.out.println(e);

        }
    }

    @Test
    public void test5(){
        Activity activity = activityDAO.findOne(1);
        Tourist tourist = new Tourist();
        tourist.setName("游客测试");
        tourist.setSex(0);
        tourist.setPhone("13507646228");
        activity.getActivityTourist().add(tourist);
        activityDAO.save(activity);
    }
    @Test
    public void test(){
        List<Activity> activities = activityDAO.findByActivityMembersIdIs(1);
        for (Activity activity : activities) {
            System.out.println(activity.getName());
        }
    }

    @Test
    public void test6(){
        Condition condition = new MemberCondition();
        System.out.println(MemberCondition.class==condition.getClass());
    }
    @Test
    public void test7(){
        List<Activity> activities = activityDAO.queryActivityTop5ByAtAndKindIs0();
        for (Activity activity : activities) {
            System.out.println(activity.getName()+" " +activity.getAt());
        }
    }
    @Test
    public void testUp(){
        Member member = memberDAO.findOne(1);
        Role role = roleDAO.findOne(1);


        member.setRole(role);
        memberDAO.save(member);




    }


}