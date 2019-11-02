package cn.ldingyi.zbpp.serviceImpl;

import cn.ldingyi.zbpp.DAO.MemberDAO;
import cn.ldingyi.zbpp.DAO.NewStudentDAO;
import cn.ldingyi.zbpp.DAO.RoleDAO;
import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.NewStudent;
import cn.ldingyi.zbpp.Entity.Role;
import cn.ldingyi.zbpp.util.MessageUtil;
import com.mchange.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import cn.ldingyi.zbpp.service.MemberService;
import cn.ldingyi.zbpp.util.Condition;
import cn.ldingyi.zbpp.util.MemberCondition;
import cn.ldingyi.zbpp.util.NewMemberCondition;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.*;
import java.util.*;

@Service("memberService")
public class MemberServiceImpl extends BaseServiceImpl<Member> implements MemberService {
    @Autowired
    MemberDAO memberDAO;
    @Autowired
    NewStudentDAO newStudentDAO;
    @Autowired
    RoleDAO roleDAO;

    @Override
    public JpaRepository<Member, Integer> getDAO() {
        return memberDAO;
    }




    private Specification getSpecification(Condition memberCondition) {
        Specification specification = new Specification() {
            MemberCondition condition =(MemberCondition) memberCondition;
            @Override
            public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> andList = new ArrayList<>();
                if (condition.getSno() != null) {
                    andList.add(criteriaBuilder.like(root.get("sno"), "%" + condition.getSno() + "%"));
                }
                if (condition.getName() != null) {
                    andList.add(criteriaBuilder.equal(root.get("name"), condition.getName()));
                }
                if (condition.getGrade() != null) {
                    andList.add(criteriaBuilder.like(root.get("grade"), "%" + condition.getGrade() + "%"));
                }
                if (condition.getMajor() != null) {
                    andList.add(criteriaBuilder.like(root.get("major"), "%" + condition.getMajor() + "%"));
                }
                if (condition.getSex() != null) {
                    andList.add(criteriaBuilder.equal(root.get("sex"), condition.getSex()));
                }
                if (condition.getRole() != null) {
                    Join<Member, Role> join = root.join("role", JoinType.INNER);
                    andList.add(criteriaBuilder.equal(join.get("id"), condition.getRole()));
                }
                Predicate[] andArr = new Predicate[andList.size()];
                Predicate and = criteriaBuilder.and(andList.toArray(andArr));
                return and;
            }
        };
        return specification;
    }
    public Specification getNewMemberSpecification(Condition condition) {
        NewMemberCondition newMemberCondition =(NewMemberCondition)condition;
        Specification<NewStudent> specification = new Specification<NewStudent>() {
            @Override
            public Predicate toPredicate(Root<NewStudent> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> andList = new ArrayList<>();
                if(newMemberCondition.getName()!=null){
                    andList.add(criteriaBuilder.equal(root.get("name"),newMemberCondition.getName()));
                }
                if (newMemberCondition.getSno()!=null){
                    andList.add(criteriaBuilder.like(root.get("sno"),newMemberCondition.getSno()));
                }
                if (newMemberCondition.getAcademy()!=null){
                    andList.add(criteriaBuilder.like(root.get("academy"),newMemberCondition.getAcademy()));
                }
                if (newMemberCondition.getMajor()!=null){
                    andList.add(criteriaBuilder.like(root.get("major"),newMemberCondition.getMajor()));
                }
                if (newMemberCondition.getSex()!=null){
                    andList.add(criteriaBuilder.equal(root.get("sex"),newMemberCondition.getSex()));
                }
                Predicate[] andArr = new Predicate[andList.size()];
                Predicate and = criteriaBuilder.and(andList.toArray(andArr));

                return and;
            }
        };
        return specification;
    }




    @Override
    public Member login(String sno, String password) {
        Member member = memberDAO.findBySnoAndPasswordIs(sno, password);
        if (member != null) {
            return member;
        }else {
            return null;
        }

    }


    @Override
    public Page memberList (Condition condition, int currentPage){
        //定义排序
        Sort sort = new Sort(Sort.Direction.ASC,"id");
        //定义分页
        int size=15;
        Pageable pageable = new PageRequest(currentPage,size,sort);
        Page<Member> page = memberDAO.findAll(getSpecification(condition),pageable);
        return page;
    }

    @Override
    public boolean addMember(Member member) {
        if (memberDAO.findBySnoIs(member.getSno()).size()==0){
            memberDAO.save(member);
            return true;
        }else {
            return false;
        }

    }

    @Override
    public void deleteMember(int[] ids, int isAll, Condition condition) {
        List<Member> members = memberDAO.findAll(getSpecification(condition));
        Set<Integer> allIds = new HashSet<>();
        for (Member member : members) {
            allIds.add(member.getId());
        }
        ids = getIds(ids,isAll,allIds);

        memberDAO.deleteInBatch(memberDAO.findByIdIn(ids));
    }

    @Override
    public Member memberPersonalInformation(int id) {

        return memberDAO.findOne(id);
    }

    @Override
    public boolean sign(NewStudent member) {

        if (newStudentDAO.findBySnoIs(member.getSno()).size()==0&memberDAO.findBySnoIs(member.getSno()).size()==0){
            newStudentDAO.save(member);
            return true;
        }else {
            return false;
        }
    }

    @Override
    public Page newMemberList(Condition newMemberCondition, int currentPage) {
        Sort sort = new Sort(Sort.Direction.ASC,"id");
        int size=15;
        Pageable pageable = new PageRequest(currentPage,size,sort);
        Page<NewStudent> page = newStudentDAO.findAll(getNewMemberSpecification(newMemberCondition),pageable);
        return page;

    }

    @Override
    public void accept(int[] ids, int isAll, Condition newMemberCondition) {
        List<Member> members = new ArrayList<>();
        List<NewStudent> newStudentsExcept = newStudentDAO.findAll(getNewMemberSpecification(newMemberCondition));
        Set<Integer> allIds = new HashSet<>();
        for (NewStudent newStudent : newStudentsExcept) {
            allIds.add(newStudent.getId());
        }
        ids=getIds(ids,isAll,allIds);
        List<NewStudent> newStudents = newStudentDAO.findByIdIn(ids);
        for (NewStudent newStudent : newStudents) {
            Member member = new Member();
            member.setSno(newStudent.getSno());
            member.setName(newStudent.getName());
            member.setAcademy(newStudent.getAcademy());
            member.setMajor(newStudent.getMajor());
            member.setSex(newStudent.getSex());
            member.setPhone(newStudent.getPhone());
            members.add(member);

        }
        memberDAO.save(members);
        newStudentDAO.deleteInBatch(newStudents);


    }

    @Override
    public void deleteNewMember(int[] ids, int isAll, Condition newMemberCondition) {
        List<NewStudent> members = newStudentDAO.findAll(getNewMemberSpecification(newMemberCondition));
        Set<Integer> allIds = new HashSet<>();
        for (NewStudent member : members) {
            allIds.add(member.getId());
        }
        ids = getIds(ids,isAll,allIds);

        newStudentDAO.deleteInBatch(newStudentDAO.findByIdIn(ids));
    }

    @Override
    public Member updatePersonalInformation(Member member,int rid,String photo)  {
        Member oldMember = memberDAO.findOne(member.getId());
        Role role = roleDAO.findOne(rid);
        member.setRole(role);
        if (photo!=""){
            member.setPhoto(photo);
        }else {
            member.setPhoto(oldMember.getPhoto());
        }

        member.setPassword(oldMember.getPassword());
        member.setSex(oldMember.getSex());
        memberDAO.save(member);
        return memberDAO.findBySnoIs(member.getSno()).get(0);

    }

    @Override
    public boolean sendMessage(int[] ids, int isAll, Condition newMemberCondition) {

        List<NewStudent> members = newStudentDAO.findAll(getNewMemberSpecification(newMemberCondition));
        Set<Integer> allIds = new HashSet<>();
        for (NewStudent member : members) {
            allIds.add(member.getId());
        }
        ids = getIds(ids,isAll,allIds);

        List<NewStudent> newStudentsForPhone = newStudentDAO.findByIdIn(ids);
        String[] params =new String[1];
        String[] phoneNumbers= new String[1];
        try {
            for (NewStudent newStudent : newStudentsForPhone) {

                params[0]=newStudent.getName();
                phoneNumbers[0] = newStudent.getPhone();
                MessageUtil messageUtil = new MessageUtil();
                messageUtil.sendMessage(params,phoneNumbers);
            }




            return true;
        } catch (Exception e) {
            return false;
        }


    }

    @Override
    public boolean updatePassword(Member member,String password) {
        member.setPassword(password);
        try {
            memberDAO.save(member);
            return true;
        }catch (Exception e){
            return false;
        }

    }


}