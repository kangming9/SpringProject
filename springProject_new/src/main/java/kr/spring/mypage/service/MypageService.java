package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;

public interface MypageService {
	
	/*
	 * public void updateMember(MemberVO member); public void
	 * updatePassword(MemberVO member); public void deleteMember(Integer mem_num);
	 */
	public int checkNickname(String nickname);
	public void updateNickname(MemberVO member);
	public void updateProfile(MemberVO member);
	public void updatePhone(MemberVO member);
	public void checkPass(String pass);
	public void updatePass(MemberVO member);
	public void deleteMember(MemberVO member);
	public void insertDelivery(DeliveryVO delivery);
	public void updateDelCheck(DeliveryVO delivery);
	public int getdelCount(Integer m_num);
	public List<DeliveryVO> delSelectList(Map<String, Object> map);
    public void deleteDelivery(Integer num);
    public DeliveryVO selectDelivery(Integer num);
    public void updateDelivery(DeliveryVO deliveryVO);
}
