package cn.ldingyi.zbpp.service;

import cn.ldingyi.zbpp.Entity.Activity;
import cn.ldingyi.zbpp.Entity.News;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface NewsService {
    public List<News> listNotice();
    public List<News> listDynamic();
    public News newDetails(int id);
    public void addNews(News news);
    public Page<News> listNewsManager(Integer kind,int currentPage);
    public void deleteNews(int[] ids);

}
