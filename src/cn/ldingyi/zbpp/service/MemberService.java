package cn.ldingyi.zbpp.service;

import cn.ldingyi.zbpp.Entity.Member;
import cn.ldingyi.zbpp.Entity.NewStudent;
import org.springframework.data.domain.Page;
import cn.ldingyi.zbpp.util.Condition;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
    public Member login(String sno,String password);//用户登录，返回一个member
    public Page memberList (Condition memberCondition, int currentPage);//用于队员管理，列出列表
    public boolean addMember(Member member);//会员管理中，添加一个成员
    public void deleteMember(int[] ids, int isAll, Condition memberCondition);//会员管理中，可以批量删除成员，需要判断是否为全选。
    public Member memberPersonalInformation(int id);//队长查看个人信息
    public boolean sign(NewStudent member);//报名照新
    public Page newMemberList(Condition newMemberCondition,int currentPage);//用于招新管理，列出列表
    public void accept(int[] ids,int isAll,Condition newMemberCondition);//同意入队
    public void deleteNewMember(int[] ids, int isAll, Condition newMemberCondition);
    public Member updatePersonalInformation(Member member,int rid,String photo);
    public boolean sendMessage(int[] ids, int isAll, Condition newMemberCondition);
    public boolean updatePassword(Member member,String password);
}
