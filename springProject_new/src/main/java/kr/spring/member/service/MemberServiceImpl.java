package kr.spring.member.service;

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
	public MemberVO loginByGoogle(MemberVO memberVO) {
		MemberVO returnVO = null;
		//추가 수정
		return returnVO;
	}

	@Override
	public void updateNickname(Integer m_num) {
		memberMapper.updateNickname(m_num);
		
	}

}
