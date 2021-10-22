package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.dao.MypageMapper;
import kr.spring.project.vo.ProjectVO;
import kr.spring.support.vo.SupportVO;

@Service
@Transactional
public class MypageServiceImpl implements MypageService{
	
	@Autowired
	private MypageMapper mypageMapper;

	@Override
	public int checkNickname(String nickname) {
		System.out.println("ServiceImpl 메서드 실행전 닉네임:" + nickname);
		int check = mypageMapper.checkNickname(nickname);
		System.out.println("ServiceImpl 메서드 실행후 check:" + check);
		return check;
	}
	
	@Override
	public void updateNickname(MemberVO member) {
		mypageMapper.updateNickname(member);
		
	}
	
	@Override
	public void updateProfile(MemberVO member) {
		
		mypageMapper.updateProfile(member);
		
	}

	@Override
	public void updatePhone(MemberVO member) {
		mypageMapper.updatePhone(member);
		
	}

	@Override
	public void checkPass(String pass) {
		mypageMapper.checkPass(pass);
		
	}

	@Override
	public void updatePass(MemberVO member) {
		mypageMapper.updatePass(member);
	}

	@Override
	public void deleteMember(MemberVO member) {
		mypageMapper.delteMember(member);
		mypageMapper.changeGrade(member);
		
	}

	@Override
	public void insertDelivery(DeliveryVO delivery) {
		mypageMapper.select_deliverynum();
		mypageMapper.insertDelivery(delivery);
		
	}

	@Override
	public void updateDelCheck(DeliveryVO delivery) {
		mypageMapper.updateDelCheck(delivery);
		
	}


	@Override
	public List<DeliveryVO> delSelectList(Map<String, Object> map) {
		return mypageMapper.delSelectList(map);
	}

	@Override
	public int getdelCount(Integer m_num) {
		int check = mypageMapper.getdelCount(m_num);
		return check;
	}

	@Override
	public void deleteDelivery(Integer num) {
		mypageMapper.deleteDelivery(num);
		
	}

	@Override
	public DeliveryVO selectDelivery(Integer num) {
		return mypageMapper.selectDelivery(num);
	}

	@Override
	public void updateDelivery(DeliveryVO deliveryVO) {
		mypageMapper.updateDelivery(deliveryVO);
		
	}

	@Override
	public int getProCount(Integer m_num) {
		int check = mypageMapper.getProCount(m_num);
		return check;
	}

	@Override
	public List<ProjectVO> proSelectList(Map<String, Object> map) {
		return mypageMapper.proSelectList(map);
		
	}

	@Override
	public int getSupportCount(Integer m_num) {
		int check = mypageMapper.getSupportCount(m_num);
		return check;
	}

	@Override
	public List<SupportVO> supportSelectList(Map<String, Object> map) {
		return mypageMapper.supportSelectList(map);
	}

	@Override
	public SupportVO selectmySupport(Map<String, Object> map) {
		return mypageMapper.selectmySupport(map);
	}
}
