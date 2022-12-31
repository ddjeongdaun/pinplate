package com.member.model;

import java.sql.SQLException;
import java.util.List;

public class memberService {
	//로그인 상수
	public static final int LOGIN_OK=1;	//로그인ok
	public static final int WRONG_PW=2;	//비밀번호 불일치
	public static final int WRONG_ID=3;	//아이디 존재 X
	
	//아이디 중복확인 상수
	public static final int EXIST_ID=1;	//이미 존재하는 아이디
	public static final int NON_EXIST_ID=2;	//사용가능한 아이디
	
	//주민번호 중복확인 상수
	public static final int EXIST_SSN=1;	//이미 존재하는 주민번호
	public static final int NON_EXIST_SSN=2;	//사용가능한 주민번호

	private memberDAO memberDao;
	
	public memberService() {
		memberDao=new memberDAO();
	}
	
	public int loginCheck(String userid, String pwd) throws SQLException {
		return memberDao.loginCheck(userid, pwd);
	}
	
	public int joinMember(memberVO vo) throws SQLException {
		return memberDao.joinMember(vo);
	}
	
	//회원or관리자 확인 메서드
	public int checkMember(String mem_id) throws SQLException {
		return memberDao.checkMember(mem_id);
	}
	
	//아이디 중복확인 메서드
	public int duplicateId(String mem_id) throws SQLException {
		return memberDao.duplicateId(mem_id);
	}
	
	//주민번호 중복확인 메서드
	public int duplicateSsn(String mem_ssn) throws SQLException {
		return memberDao.duplicateSsn(mem_ssn);
	}
	
	//세션저장정보 메서드(이름,번호)
	public memberVO memberInfo(String mem_id) throws SQLException {
		return memberDao.memberInfo(mem_id);
	}
	
	//회원정보 읽어오기
	public memberVO selectByUserid(String mem_id) throws SQLException {
		return memberDao.selectByUserid(mem_id);
	}
	
	//회원정보수정
	public int updateMember(memberVO vo) throws SQLException {
		return memberDao.updateMember(vo);
	}
	
	//아이디 찾기
	public String findId(String mem_name, String mem_ssn) throws SQLException {
		return memberDao.findId(mem_name, mem_ssn);
	}
	
	//비밀번호 변경
	public int changePw(String mem_id, String mem_name, String mem_ssn, String mem_pwd) throws SQLException {
		return memberDao.changePw(mem_id, mem_name, mem_ssn, mem_pwd);
	}
	
	//관리자-회원목록조회
	public List<memberVO> selectAll() throws SQLException {
		return memberDao.selectAll();
	}
	
	//관리자-회원조회(번호로/디테일)
	public memberVO selectByNo(int mem_no) throws SQLException {
		return memberDao.selectByNo(mem_no);
	}
	
	//관리자-회원삭제
	public int deleteMember(int mem_no) throws SQLException {
		return memberDao.deleteMember(mem_no);
	}
	
	//관리자-회원수정
	public int admin_updateMember(memberVO vo) throws SQLException {
		return memberDao.admin_updateMember(vo);
	}
	
	//회원-회원탈퇴
	public int deleteMember2(String mem_id) throws SQLException {
		return memberDao.deleteMember2(mem_id);
	}
}
