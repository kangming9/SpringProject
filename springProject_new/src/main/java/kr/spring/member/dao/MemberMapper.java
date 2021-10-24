package kr.spring.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;

public interface MemberMapper {
	@Select("SELECT member_seq.nextval FROM dual")
	public int select_num();
	
	@Insert("INSERT INTO member (num,id) VALUES (#{num},#{id})")
	public void insertMember(MemberVO member);
	
	@Insert("INSERT INTO member_detail (num,m_num,name,pass,phone,email,zipcode,address,address_detail) VALUES (member_detail_seq.nextval,#{num},#{name},#{pass},#{phone},#{email},#{zipcode},#{address},#{address_detail})")
	public void insertMember_detail(MemberVO member);
	
	@Select("SELECT delivery_seq.nextval FROM dual")
	public int select_deliverynum();
	
	@Insert("INSERT INTO delivery (num,m_num,name,zipcode,address,address_detail,address_check,phone) VALUES (delivery_seq.nextval,#{m_num},#{name},#{zipcode},#{address},#{address_detail},1,#{phone})")
	public void insertDelivery(DeliveryVO delivery);
	
	@Update("UPDATE member_detail SET nickname='익명'||m_num WHERE m_num=#{num}")
	public void updateNickname(Integer m_num);
	
	public MemberVO selectCheckMember(String id);
	
	@Select("SELECT * FROM member m JOIN member_detail d ON m.num = d.m_num WHERE m.num=#{num}")
	public MemberVO selectMember(Integer m_num);
	
	@Select("SELECT m.id FROM member m JOIN member_detail d ON m.num=d.m_num WHERE d.name=#{name} AND d.email=#{email} AND d.phone=#{phone}")
	public String searchId(@Param("name")String name,@Param("email")String email,@Param("phone")String phone);
	
	//비밀번호 확인 시 회원 정보 검색
	@Select("SELECT d.pass FROM member m JOIN member_detail d ON m.num = d.m_num WHERE m.id=#{id} AND d.email=#{email} AND d.phone=#{phone}")
	public String searchPass(@Param("id")String id,@Param("email")String email,@Param("phone")String phone);
	//비밀번호 변경
	@Update("UPDATE member_detail SET pass=#{pass} WHERE email=#{email}")
	public void changePass(@Param("pass")String pass,@Param("email")String email);
	

	//구글회원가입
	public void registerBySocial(String id, String email);
	
	//구글로그인
	@Select("SELECT * FROM member m JOIN member_detail d ON m.num = d.m_num WHERE d.email=#{email}")
	public MemberVO loginBySocial(@Param("email")String email);
	
	
	//탈퇴 회원 포함 멤버 수 카운트
	@Select("SELECT count(*) from member")
	public int countMember();
		
	//활동 중인 멤버 수 카운트
	@Select("SELECT count(*) from member_detail")
	public int countMemberDetail();
		
	//회원 기본정보 리스트 받아오기
	@Select("SELECT * from member")
	public List<MemberVO> getListMember();
		
	//회원 디테일정보 리스트 받아오기
	@Select("SELECT * from member_detail")
	public List<MemberVO> getListMemberDetail();
		
	//member테이블에서 가장 큰 num값 가져오기
	@Select("SELECT MAX(num) AS alias FROM member")
	public int getMaxMemNum();
		
	//member_detail테이블에서 가장 큰 m_num값 가져오기
	@Select("SELECT MAX(m_num) AS alias FROM member_detail")
	public int getMaxMemDetailNum();
	
	//관리자
	//강퇴 멤버
	@Delete("DELETE FROM member_detail WHERE m_num=#{num}")
	public void delteOutMember(Integer num);
	@Update("UPDATE member SET grade=4 WHERE num=#{num}")
	public void OutMember(Integer num);
	
	//회원 수 카운트
	@Select("select count(*) from member where grade=2 or grade=3")
	public int realMemCount();
	@Select("select count(*) from (select DISTINCT p.m_num from member m, project p where m.num=p.m_num)")
	public int pMemCount();
	@Select("select count(*) from member where grade > 1")
	public int allMemCount();
	@Select("select count(*) from (select DISTINCT s.m_num from member m, support s where m.num=s.m_num)")
	public int sMemCount();
	
}

