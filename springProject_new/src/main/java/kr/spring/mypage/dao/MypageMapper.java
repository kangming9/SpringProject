package kr.spring.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.project.vo.ProjectVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.support.vo.SupportVO;

public interface MypageMapper {
	
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
	  @Select("SELECT * FROM delivery d, support s WHERE s.d_num=d.num AND s.num=#{s_num}")
	  public DeliveryVO selectPaymentAddress(Integer s_num);
	  @Update("UPDATE delivery SET name=#{name}, zipcode=#{zipcode}, address=#{address}, address_detail=#{address_detail}, address_check=#{address_check}, phone=#{phone} WHERE num=#{num}")
	  public void updateDelivery(DeliveryVO deliveryVO);
	  
	  public int getProCount(Integer m_num);
	  public List<ProjectVO> proSelectList(Map<String, Object> map);
	  
	  public int getSupportCount(Integer m_num);
	  public List<SupportVO> supportSelectList(Map<String, Object> map);
	  public SupportVO selectmySupport(Map<String, Object> map);
	  
	  public List<QuestionVO> questionSelectList(Map<String, Object> map);
	  public int questionselectCount(Map<String,Object> map);
}





