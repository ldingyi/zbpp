package cn.ldingyi.zbpp.controller;

import cn.ldingyi.zbpp.DAO.NewsDAO;
import cn.ldingyi.zbpp.Entity.News;
import cn.ldingyi.zbpp.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class NewsController {
    @Autowired
    NewsService newsService;

    @RequestMapping("intoAddNews")
    public String intoAddNews(Integer id,Model model,String flag){
        if (id!=null){
            model.addAttribute("news",newsService.newDetails(id));
        }
        if (flag!=null&flag!=""){
            model.addAttribute("flag","ok");
        }
        return "addNews";
    }


    @RequestMapping("addNews")
    public String addNews(News news , Model model){
        newsService.addNews(news);

        return "redirect:intoAddNews?flag=ok";
    }
    @RequestMapping("newsdetail")
    public String newsdetail(Model model ,int id){

        model.addAttribute("news",newsService.newDetails(id));
        return "newsDetail";
    }

    @RequestMapping("newsManager")
    public String newsManager(Integer kind,int currentPage,Model model){
        Page<News> newsPage = newsService.listNewsManager(kind, currentPage-1);
        int total = (int)newsPage.getTotalElements();
        int pages =  newsPage.getTotalPages();
        List<News> news = newsPage.getContent();
        model.addAttribute("total",total);
        model.addAttribute("pages",pages);
        model.addAttribute("news",news);
        return "forward:/WEB-INF/adManager.jsp?currentPage="+currentPage;
    }

    @RequestMapping("deleteNews")
    public String deleteNews(@RequestParam("ids") int[] ids){
        newsService.deleteNews(ids);
        return "redirect:newsManager?deleteFlag=ok&currentPage=1";
    }


}
