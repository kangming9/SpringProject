package kr.spring.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		//회원번호 셋팅
		member.setNum(memberMapper.select_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
	}

	@Override
    public MemberVO selectCheckMember(String id) {
      return memberMapper.selectCheckMember(id);
    }

	@Override
	public MemberVO selectMember(Integer m_num) {
		return memberMapper.selectMember(m_num);
	}

	@Override
	public void registerByGoogle(MemberVO memberVO) {
		memberMapper.insertMember(memberVO);
	}

	@Override
	public void updateNickname(Integer m_num) {
		memberMapper.updateNickname(m_num);
		
	}

	@Override
	public String searchId(String name, String email, String phone) {
		return memberMapper.searchId(name, email, phone);
	}

	@Override
	public String searchPass(String id, String email, String phone) {
		return memberMapper.searchPass(id, email, phone);
	}

	@Override
	public void changePass(String pass,String email) {
		memberMapper.changePass(pass,email);
		
	}
	@Override
	public MemberVO loginBySocial(String email) {
		return memberMapper.loginBySocial(email);
	}
	
	@Override
	public int countMember() {
		return memberMapper.countMember();
	}
	@Override
	public int countMemberDetail() {
		return memberMapper.countMemberDetail();
	}
	@Override
	public List<MemberVO> getListMember() {
		return memberMapper.getListMember();
	}
	@Override
	public List<MemberVO> getListMemberDetail() {
		return memberMapper.getListMemberDetail();
	}
	@Override
	public int getMaxMemNum() {
		return memberMapper.getMaxMemNum();
	}
	@Override
	public int getMaxMemDetailNum() {
		return memberMapper.getMaxMemDetailNum();
	}


}
