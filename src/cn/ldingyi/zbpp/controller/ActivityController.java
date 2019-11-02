package cn.ldingyi.zbpp.controller;

import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.Tourist;
import cn.ldingyi.zbpp.View.ActivityModel;
import cn.ldingyi.zbpp.View.ViewModel;
import cn.ldingyi.zbpp.util.ActivityCondition;
import com.google.gson.Gson;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import cn.ldingyi.zbpp.service.ActivityService;
import cn.ldingyi.zbpp.util.Condition;
import cn.ldingyi.zbpp.util.MemberCondition;
import cn.ldingyi.zbpp.util.Util;
import org.springframework.web.servlet.View;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class ActivityController {
    @Autowired
    ActivityService activityService;


    @RequestMapping(value = "listActivity",method = RequestMethod.POST)
    public void listActivity(HttpServletResponse response,String conditionJSON,String currentPageJSON) throws Exception{
        Gson gson = new Gson();
        Condition condition = gson.fromJson(conditionJSON, ActivityCondition.class);
        int currentPage = gson.fromJson(currentPageJSON,int.class);
        Page<Activity> page = activityService.listActivities(condition,currentPage-1);
        List<Activity> activities = page.getContent();
        List<ViewModel> activityModels = new ArrayList<>();
        for (Activity activity : activities) {
            ActivityModel activityModel = new ActivityModel();
            activityModel.setId(activity.getId());
            activityModel.setName(activity.getName());
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String signEnd = formatter.format(activity.getSe());
            String activityStart = formatter.format(activity.getAt());
            String activityEnd = formatter.format(activity.getAe());
            activityModel.setSignEnd(signEnd);
            activityModel.setActivityStart(activityStart);
            activityModel.setActivityEnd(activityEnd);
            activityModel.setKind(activity.getKind());
            activityModel.setIspub(activity.getIspub());
            activityModels.add(activityModel);
        }
        new Util<Activity>().pageToJSON(page,response,activityModels);
    }


    @RequestMapping(value = "signActivity")
    public String signActivity(int aid, Model model, HttpSession session){


            Member member = (Member) session.getAttribute("member");
            boolean flag = activityService.signActivity(aid, member);
            model.addAttribute("activity",activityService.lookActivityDetail(aid));
            if (flag==true){
                model.addAttribute("flag","ok");
                return "activitySign";
            }else {
                model.addAttribute("flag","false");
                return "activitySign";
            }



    }

    @RequestMapping(value = "deleteActivity",method = RequestMethod.POST)
    public void deleteActivity(HttpServletResponse response,int isAll,String idsJSON,String conditionJSON) throws Exception{
        Gson gson = new Gson();
        int[] ids = gson.fromJson(idsJSON,int[].class);
        Condition condition = gson.fromJson(conditionJSON, ActivityCondition.class);
        activityService.deleteActivity(ids,isAll,condition);
        response.getWriter().print(true);
    }

    @RequestMapping("addActivity")
    public String addActivity(Activity activity){
        activityService.addActivity(activity);
        return "redirect:intoAddActivity?flag=ok";
    }

    @RequestMapping("intoAddActivity")
    public String intoAddActivity(String flag,Model model,Integer id){
        if (id!=null){
            model.addAttribute("activity",activityService.lookActivityDetail(id));
        }
        if (flag!=null&flag!=""){
            model.addAttribute("flag","ok");
        }
        return "addActivity";
    }

    @RequestMapping("checkActivityDetail")
    public String checkActivityDetail(Model model,int id){
        Activity activity = activityService.lookActivityDetail(id);
        model.addAttribute("activity",activity);
        return "activityDetail";
    }

    @RequestMapping("activityMember")
    public String activityMember(Model model,int id){
        Activity activity = activityService.lookActivityDetail(id);
        model.addAttribute("activity",activity);
        return "activityMember";
    }

    @RequestMapping("joinActivityPage")
    public String gotoSign(int id ,Model model){
        model.addAttribute("activity",activityService.lookActivityDetail(id));
        return "forward:/joinActivity.jsp";
    }


    @RequestMapping("joinActivity")
    public String joinActivity(Tourist tourist,int aid){
        boolean flag = activityService.touristJoinActivity(aid,tourist);
        if (flag==true){
            return "redirect:/joinActivity.jsp?flag=ok";
        }else {
            return "redirect:/joinActivity.jsp?flag=false";
        }
    }




    

}
