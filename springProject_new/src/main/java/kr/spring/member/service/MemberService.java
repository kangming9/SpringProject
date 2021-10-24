package kr.spring.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member);
	public void insertDelivery(DeliveryVO delivery);
	
	public void updateNickname(Integer mem_num);
	public MemberVO selectCheckMember(String id);
	public MemberVO selectMember(Integer mem_num);
	//구글회원가입
	public void registerByGoogle(MemberVO memberVO);
	//소셜로그인
	public MemberVO loginBySocial(String email);
	
	public String searchId(@Param("name")String name,@Param("email")String email,@Param("phone")String phone);
	
	public String searchPass(@Param("id")String id,@Param("email")String email,@Param("phone")String phone);
	public void changePass(@Param("pass")String pass,@Param("email")String email);
	
	
	public int countMember();
	public int countMemberDetail();
		
	public List<MemberVO> getListMember();
	public List<MemberVO> getListMemberDetail();
		
	public int getMaxMemNum();
	public int getMaxMemDetailNum();
	
	public void delteOutMember(Integer num);
	
	public int realMemCount();
	public int pMemCount();
	public int allMemCount();
	public int sMemCount();
}
