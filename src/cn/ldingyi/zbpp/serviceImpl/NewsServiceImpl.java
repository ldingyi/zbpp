package cn.ldingyi.zbpp.serviceImpl;

import cn.ldingyi.zbpp.DAO.NewsDAO;
import cn.ldingyi.zbpp.Entity.News;
import cn.ldingyi.zbpp.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;
@Service("newService")
public class NewsServiceImpl implements NewsService {
    @Autowired
    NewsDAO newsDAO;


    @Override
    public List<News> listNotice() {
        return newsDAO.queryNoticeTop5ByDateAndKindIs1();
    }

    @Override
    public List<News> listDynamic() {
        return newsDAO.queryDynamicTop5ByDateAndKindIs0();
    }

    @Override
    public News newDetails(int id) {
        return newsDAO.findOne(id);
    }

    @Override
    public void addNews(News news) {
        newsDAO.save(news);
    }

    @Override
    public Page<News> listNewsManager(Integer kind,int currentPage) {
        Sort sort = new Sort(Sort.Direction.DESC,"date");
        int size=20;
        Pageable pageable = new PageRequest(currentPage,size,sort);
        Specification<News> specification = new Specification<News>() {
            @Override
            public Predicate toPredicate(Root<News> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {

                if (kind!=null){
                   Predicate predicate = criteriaBuilder.equal(root.get("kind"),kind);
                    return predicate;
                }else {
                    return null;
                }

            }
        };

        Page<News> page = newsDAO.findAll(specification,pageable);
        return page;

    }

    @Override
    public void deleteNews(int[] ids) {
        List<News> news = newsDAO.findByIdIn(ids);
        newsDAO.deleteInBatch(news);
    }
}
