package cn.ldingyi.zbpp.DAO;

import cn.ldingyi.zbpp.Entity.Activity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ActivityDAO extends JpaRepository<Activity,Integer>, JpaSpecificationExecutor<Activity> {
    public List<Activity> findByIdIn(int[] ids);
    public List<Activity> findByActivityMembersIdIs(int id);
    @Query(value = "select * from activity a where a.kind = 0 order by a.at desc limit 5" ,nativeQuery = true)
    public List<Activity> queryActivityTop5ByAtAndKindIs0();

}

