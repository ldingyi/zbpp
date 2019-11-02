package cn.ldingyi.zbpp.controller;

import cn.ldingyi.zbpp.DAO.ActivityDAO;
import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.News;
import cn.ldingyi.zbpp.service.ActivityService;
import cn.ldingyi.zbpp.service.NewsService;
import cn.ldingyi.zbpp.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import cn.ldingyi.zbpp.service.MemberService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@Controller

public class Home {
    @Autowired
    MemberService memberService;
    @Autowired
    ActivityService activityService;
    @Autowired
    NewsService newsService;


    @RequestMapping("home")
    public String home(Model model){
        model.addAttribute("activity",activityService.homeListActivity());
        model.addAttribute("notice",newsService.listNotice());
        model.addAttribute("dynamic",newsService.listDynamic());
        return "Home";
    }

    @RequestMapping(value = "lg",method = RequestMethod.POST)
    public void login(HttpServletResponse response, HttpSession session,String sno,String password,int remember) throws Exception{
        Member member= memberService.login(sno, password);
        boolean result;
        if (member!=null){
            session.setAttribute("member",member);
            if (remember==1){

                Cookie cookieSno = new Cookie("zbppSno",sno);
                Cookie cookiePassword = new Cookie("zbppPassword",password);
                cookieSno.setMaxAge(60*60*24*30*12);
                cookieSno.setPath("/");
                cookiePassword.setMaxAge(60*60*24*30*12);
                cookiePassword.setPath("/");
                response.addCookie(cookieSno);
                response.addCookie(cookiePassword);
            }
           result=true;

        }else {

            result=false;

        }
        response.getWriter().print(result);


    }


    @RequestMapping("socialManager")
    public String socialManager(String catalog,Model model){
        model.addAttribute("catalog",catalog);
        return "manager";
    }
    @RequestMapping("myPersonalInformation")
    public String myPersonalInformation(HttpSession session, Model model){
        Member member = (Member) session.getAttribute("member");
        model.addAttribute("member",member);
        return "personal";
    }
    @RequestMapping("signSys")
    public void signSys(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String flag = (String)request.getServletContext().getAttribute("openSign");
        if (flag=="ok"){
           response.getWriter().print("ok");
        }else {

            response.getWriter().print("no");

        }

    }

    @RequestMapping("gotoSignSys")
    public  String gotoSignSys(){
        return "forward:/sign.jsp";
    }


    @RequestMapping("signActivityPage")
    public String signActivityPage(int id,Model model){
        model.addAttribute("activity",activityService.lookActivityDetail(id));
        return "activitySign";
    }

    @RequestMapping("more")
    public String more(String more,Model model,int currentPage){
        if (more.equals("match")){
            Page<Activity> page = activityService.moreActivity(1,currentPage-1);
            new Util<Activity>().more(page,model,"activity");
        }
        if (more.equals("activity")){
            Page<Activity> page =activityService.moreActivity(0,currentPage-1);
            new Util<Activity>().more(page,model,"activity");
        }
        if (more.equals("notice")){
            Page<News> page = newsService.listNewsManager(1,currentPage-1);
            new Util<News>().more(page,model,"news");

        }
        if (more.equals("dynamic")){
           Page<News> page = newsService.listNewsManager(0,currentPage-1);
           new Util<News>().more(page,model,"news");
        }

        model.addAttribute("more",more);
        return "more";

    }


    @RequestMapping(value = "gotoManager",method = RequestMethod.POST)
    public void gotoManager(HttpServletResponse response,HttpSession session) throws Exception{
        if (session.getAttribute("member")!=null){
            Member member = (Member)session.getAttribute("member");

            if (member.getRole().getId()!=1&&member.getRole().getId()!=2){
                response.getWriter().print("noPower");
            }

            if (member.getRole().getId()==1||member.getRole().getId()==2){
                response.getWriter().print("ok");
            }

        }else {
            response.getWriter().print("noLogin");
        }






    }




    @RequestMapping(value = "openSign",method = RequestMethod.POST)
    public  void openSign(HttpServletResponse response, HttpServletRequest request,int flag) throws Exception{

        if (flag==0){
            request.getServletContext().setAttribute("openSign","no");
            response.getWriter().print("hadClosed");
        }else {
            request.getServletContext().setAttribute("openSign","ok");
            response.getWriter().print("hadOpen");
        }

    }


    @RequestMapping("shengmign")
    public String shengming(){
        return"shengming";
    }





}
