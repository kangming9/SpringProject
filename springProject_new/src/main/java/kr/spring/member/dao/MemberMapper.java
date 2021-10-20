package kr.spring.member.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

public interface MemberMapper {
	@Select("SELECT member_seq.nextval FROM dual")
	public int select_num();
	@Insert("INSERT INTO member (num,id) VALUES (#{num},#{id})")
	public void insertMember(MemberVO member);
	@Insert("INSERT INTO member_detail (num,m_num,name,pass,phone,email,zipcode,address,address_detail) VALUES (member_detail_seq.nextval,#{num},#{name},#{pass},#{phone},#{email},#{zipcode},#{address},#{address_detail})")
	public void insertMember_detail(MemberVO member);
	@Update("UPDATE member_detail SET nickname='익명'||m_num WHERE m_num=#{num}")
	public void updateNickname(Integer m_num);
	@Select("SELECT m.num,m.id,m.grade,d.pass,d.photo,d.nickname FROM member m LEFT OUTER JOIN member_detail d ON m.num=d.m_num WHERE m.id=#{id}")
	public MemberVO selectCheckMember(String id);
	@Select("SELECT * FROM member m JOIN member_detail d ON m.num = d.m_num WHERE m.num=#{num}")
	public MemberVO selectMember(Integer m_num);
	/*
	 * @Update("UPDATE member_detail SET (name=#{name},phone=#{phone},email=#{email},zipcode=#{zipcode},address=#{address},address_detail=#{address_detail},modify_date=SYSDATE WHERE m_num=#{m_num})"
	 * ) public void updateMember(MemberVO member);
	 * 
	 * @Update("SELECT member_detail SET pass=#{pass} WHERE m_num=#{m_num}") public
	 * void updatePassword(MemberVO member);
	 * 
	 * @Update("Update member SET grade=0 WHERE m_num=#{m_num}") public void
	 * deleteMember(Integer m_num);
	 * 
	 * @Delete("DELETE FROM member_detail WHERE m_num=#{m_num}") public void
	 * deleteMember_detail(Integer m_num);
	 * 
	 * @Update("UPDATE member_detail SET photo=#{photo} WHERE m_num=#{m_num}")
	 * public void updateProfile(MemberVO member);
	 */
}
