package cn.ldingyi.zbpp.DAO;

import cn.ldingyi.zbpp.Entity.NewStudent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface NewStudentDAO extends JpaRepository<NewStudent,Integer> , JpaSpecificationExecutor<NewStudent> {
    public List<NewStudent> findBySnoIs(String sno);
    public List<NewStudent> findByIdIn(int[] ids);
}
