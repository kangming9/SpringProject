package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	public void insertMember(MemberVO member);
	public void updateNickname(Integer mem_num);
	public MemberVO selectCheckMember(String id);
	public MemberVO selectMember(Integer mem_num);
	//구글회원가입
	public void registerByGoogle(MemberVO memberVO);
	//구글로그인
	public MemberVO loginByGoogle(MemberVO memberVO);
}
