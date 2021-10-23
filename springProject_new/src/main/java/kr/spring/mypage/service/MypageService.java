package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.project.vo.ProjectVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.support.vo.SupportVO;

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
    
    public int getProCount(Integer m_num);
	public List<ProjectVO> proSelectList(Map<String, Object> map);
	
	public int getSupportCount(Integer m_num);
	public List<SupportVO> supportSelectList(Map<String, Object> map);
	public SupportVO selectmySupport(Map<String, Object> map);
	
	public List<QuestionVO> questionSelectList(Map<String, Object> map);
	public int questionselectCount(Map<String,Object> map);
	
	public DeliveryVO selectPaymentAddress(Integer s_num);
}
