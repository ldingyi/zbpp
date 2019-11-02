package cn.ldingyi.zbpp.DAO;

import cn.ldingyi.zbpp.Entity.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface NewsDAO extends JpaRepository<News,Integer> , JpaSpecificationExecutor<News> {
    @Query(value = "select * from news where kind = 1 order by date desc limit 5" ,nativeQuery = true)
    public List<News> queryNoticeTop5ByDateAndKindIs1();

    @Query(value = "select * from news where kind = 0 order by date desc limit 5" ,nativeQuery = true)
    public List<News> queryDynamicTop5ByDateAndKindIs0();
    public List<News> findByIdIn(int[] ids);
}
