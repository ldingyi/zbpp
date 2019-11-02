package cn.ldingyi.zbpp.util;

import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.View.ViewModel;
import com.google.gson.Gson;
import org.springframework.data.domain.Page;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class Util<T> {
    /*
     * 有page转成成JSON并输出
     */
    public void pageToJSON(Page<T> page,HttpServletResponse response) throws Exception{
        Gson gson = new Gson();
        pageToJSON(page,response,gson);
    }
    //得到的对象有闭环，自己得到gson对象
   public void pageToJSON(Page<T> page,HttpServletResponse response,Gson gson) throws Exception{
       int totalPages = page.getTotalPages();
       int totalList = (int)page.getTotalElements();
       List<T> iterable = page.getContent();
       Object result[]={iterable,totalPages,totalList};
       String resultJSON = gson.toJson(result);
       response.setCharacterEncoding("UTF-8");
       response.getWriter().print(resultJSON);
   }
   public void pageToJSON(Page<T> page , HttpServletResponse response, List<ViewModel> content, Gson gson) throws Exception{
       int totalPages = page.getTotalPages();
       int totalList = (int)page.getTotalElements();
       Object result[]={content,totalPages,totalList};
       String resultJSON = gson.toJson(result);
       response.setCharacterEncoding("UTF-8");
       response.getWriter().print(resultJSON);

   }
    public void pageToJSON(Page<T> page , HttpServletResponse response, List<ViewModel> content) throws Exception{
        Gson gson = new Gson();
        pageToJSON(page,response,content,gson);
    }

    public void more(Page page, Model model,String more){
        int total = (int)page.getTotalElements();
        int pages= page.getTotalPages();
        List<T> content = page.getContent();
        model.addAttribute("total",total);
        model.addAttribute("pages",pages);
        model.addAttribute(more,content);
    }



}
