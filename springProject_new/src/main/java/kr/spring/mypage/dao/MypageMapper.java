package kr.spring.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;

public interface MypageMapper {
	
	/*
	 * @Update("UPDATE member_detail SET (name=#{name},phone=#{phone},email=#{email},zipcode=#{zipcode},address=#{address},address_detail=#{address_detail},modify_date=SYSDATE WHERE m_num=#{m_num})"
	 * ) public void updateMember(MemberVO member);
	 * 
	 * @Update("SELECT member_detail SET pass=#{pass} WHERE m_num=#{m_num}") 
	 * public void updatePassword(MemberVO member);
	 * 
	 * @Update("Update member SET grade=0 WHERE m_num=#{m_num}") 
	 * public void deleteMember(Integer m_num);
	 * 
	 * @Delete("DELETE FROM member_detail WHERE m_num=#{m_num}") 
	 * public void deleteMember_detail(Integer m_num);
	 */
	  @Select("SELECT member_seq.nextval FROM dual")
	  public int select_num();
	  @Select("select count(*) from member_detail where nickname=#{nickname}")
	  public int checkNickname(String nickname);
	  @Update("UPDATE member_detail SET nickname=#{nickname} WHERE m_num=#{num}")
	  public void updateNickname(MemberVO member);
	  @Update("UPDATE member_detail SET photo=#{photo},photo_name=#{photo_name} WHERE m_num=#{num}")
	  public void updateProfile(MemberVO member);
	  @Update("UPDATE member_detail SET phone=#{phone} WHERE m_num=#{num}")
	  public void updatePhone(MemberVO member);
	  @Select("SELECT count(*) FROM member_detail WHERE m_num=#{num} AND pass=#{pass}")
	  public int checkPass(String pass);
	  @Update("UPDATE member_detail SET pass=#{now_password} WHERE m_num=#{num}")
	  public void updatePass(MemberVO member);
	  @Delete("DELETE FROM member_detail WHERE m_num=#{num}")
	  public void delteMember(MemberVO member);
	  @Update("UPDATE member SET grade=1 WHERE num=#{num}")
	  public void changeGrade(MemberVO member);
	  @Select("SELECT delivery_seq.nextval FROM dual")
	  public int select_deliverynum();
	  @Insert("INSERT INTO delivery (num,m_num,name,zipcode,address,address_detail,address_check,phone) VALUES (delivery_seq.nextval,#{m_num},#{name},#{zipcode},#{address},#{address_detail},#{address_check},#{phone})")
	  public void insertDelivery(DeliveryVO delivery);
	  @Update("UPDATE delivery SET address_check=0 WHERE m_num=#{m_num} AND address_check=1")
	  public void updateDelCheck(DeliveryVO delivery);
	  public int getdelCount(Integer m_num);
	  public List<DeliveryVO> delSelectList(Map<String, Object> map);
	  @Delete("DELETE FROM delivery WHERE num=#{num}")
	  public void deleteDelivery(Integer num);
	  @Select("SELECT * FROM delivery WHERE num=#{num}")
	  public DeliveryVO selectDelivery(Integer num);
	  @Update("UPDATE delivery SET name=#{name}, zipcode=#{zipcode}, address=#{address}, address_detail=#{address_detail}, address_check=#{address_check}, phone=#{phone} WHERE num=#{num}")
	  public void updateDelivery(DeliveryVO deliveryVO);
}




