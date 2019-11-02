package cn.ldingyi.zbpp.DAO;

import cn.ldingyi.zbpp.Entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;
import java.util.List;

public interface MemberDAO extends JpaRepository<Member,Integer> , JpaSpecificationExecutor<Member> {
    public Member findBySnoAndPasswordIs(String sno, String password);
    public List<Member> findBySnoIs(String sno);
    public List<Member> findByIdIn(int[] a);
    @Transactional
    @Query(value = "update member set rid=? where id = ?",nativeQuery = true)
    @Modifying
    public void updateRole(int rid,int id);

}
