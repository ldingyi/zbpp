package cn.ldingyi.zbpp.controller;

import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.NewStudent;
import cn.ldingyi.zbpp.util.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sun.xml.internal.bind.v2.TODO;
import org.apache.catalina.startup.Tomcat;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import cn.ldingyi.zbpp.service.MemberService;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;

@Controller
public class MemberController {
    @Autowired
    MemberService memberService;

    @RequestMapping(value = "memberList",method = RequestMethod.POST)
    public void listMember(HttpServletResponse response,String conditionJSON,String currentPageJSON) throws Exception{

        GsonBuilder gb = new GsonBuilder();
        gb.setExclusionStrategies(new MemberExclusion());
        Gson gson = gb.create();
        Condition condition = gson.fromJson(conditionJSON, MemberCondition.class);
        int currentPage = gson.fromJson(currentPageJSON,int.class);
        Page<Member> page = memberService.memberList(condition,currentPage-1);
        new Util<Member>().pageToJSON(page,response,gson);


    }


    @RequestMapping(value ="addMember",method = RequestMethod.POST)
    public void addMember(HttpServletResponse response,String memberJSON) throws Exception{
        Gson gson = new Gson();
        Member member = gson.fromJson(memberJSON,Member.class);
        boolean result = memberService.addMember(member);
        response.getWriter().print(result);
    }


    @RequestMapping(value = "deleteMember",method = RequestMethod.POST)
    public void deleteMember(HttpServletResponse response,String idsJSON,int isAll,String conditionJSON) throws Exception{
        Gson gson = new Gson();
        int[] ids = gson.fromJson(idsJSON,int[].class);
        Condition condition = gson.fromJson(conditionJSON, MemberCondition.class);
        memberService.deleteMember(ids,isAll,condition);
        response.getWriter().print(true);
    }

    @RequestMapping("memberPersonalInformation")
    public String memberPersonalInformation(int id , Model model){
        model.addAttribute("member",memberService.memberPersonalInformation(id));
        return "personal";
    }
    @RequestMapping("sign")
    public String sign(NewStudent newStudent) {
        if(memberService.sign(newStudent)){
            return "redirect:/sign.jsp?flag=ok";
        }else {

            return "redirect:/sign.jsp?flag=false";
        }
    }

    @RequestMapping(value = "newMemberList",method = RequestMethod.POST)
    public void newMemberList(HttpServletResponse response,String conditionJSON,String currentPageJSON) throws Exception{
        Gson gson = new Gson();
        Condition newMemberCondition = gson.fromJson(conditionJSON, NewMemberCondition.class);
        int currentPage = gson.fromJson(currentPageJSON,int.class);
        Page<NewStudent> page = memberService.newMemberList(newMemberCondition,currentPage-1);
        new Util<NewStudent>().pageToJSON(page,response);
    }

    @RequestMapping(value = "accept",method = RequestMethod.POST)
    public void accept (HttpServletResponse response,String idsJSON,int isAll,String conditionJSON) throws Exception{
        Gson gson = new Gson();
        int[] ids = gson.fromJson(idsJSON,int[].class);
        Condition condition = gson.fromJson(conditionJSON,NewMemberCondition.class);
        memberService.accept(ids,isAll,condition);
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print("ok");
    }


    @RequestMapping(value = "deleteNewMember",method = RequestMethod.POST)
    public void deleteNewMember(HttpServletResponse response,String idsJSON,int isAll,String conditionJSON) throws Exception{
        Gson gson = new Gson();
        int[] ids = gson.fromJson(idsJSON,int[].class);
        Condition condition = gson.fromJson(conditionJSON, NewMemberCondition.class);
        memberService.deleteNewMember(ids,isAll,condition);
        response.getWriter().print(true);
    }

    @RequestMapping("updatePersonalInformation")
    public String updatePersonalInformation(MultipartFile file, Member member, HttpServletRequest request, Model model, @RequestParam(defaultValue = "3") String  rids, HttpSession session) throws Exception{
        int rid = Integer.parseInt(rids);
        Member self = (Member)session.getAttribute("member");
        String photo = "";
        if (self.getRole().getId()!=1){
            rid = self.getRole().getId();
        }
        if (file.getOriginalFilename()!=""&&file.getOriginalFilename()!=null){
            String fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf("."));
            String filePath =  "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\zbpp\\up\\personalPhoto";



            FileUtils.copyInputStreamToFile(file.getInputStream(),new File(filePath+"/"+member.getSno()+suffix));
            photo=member.getSno()+suffix;


        }

        int mid =memberService.updatePersonalInformation(member,rid,photo).getId();
        return "redirect:memberPersonalInformation?id="+mid;
    }




    @RequestMapping(value = "sendMessage",method = RequestMethod.POST)
    public void sendMessage(HttpServletResponse response,String idsJSON,int isAll,String conditionJSON) throws Exception{
        Gson gson = new Gson();
        int[] ids = gson.fromJson(idsJSON,int[].class);
        Condition condition = gson.fromJson(conditionJSON, NewMemberCondition.class);
        boolean b = memberService.sendMessage(ids,isAll,condition);
        response.getWriter().print(b);
    }

    @RequestMapping(value = "updatePassword",method = RequestMethod.POST)
    public void updatePassword(HttpSession session,HttpServletResponse response,String password) throws Exception{
        Member member = (Member) session.getAttribute("member");
        boolean result = memberService.updatePassword(member,password);
        response.getWriter().print(result);

    }





}
