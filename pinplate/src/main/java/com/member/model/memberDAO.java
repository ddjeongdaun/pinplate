package com.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.db.ConnectionPoolMgr;

public class memberDAO {
	private ConnectionPoolMgr pool;

	public memberDAO() {
		pool = new ConnectionPoolMgr();
	}

	public int joinMember(memberVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;

		try{
			con=pool.getConnection();
			String sql="insert into member(mem_no,mem_name,mem_id,mem_pwd,mem_ssn,mem_addr,mem_tel,mem_email) "
					+ "values(mem_seq.nextval,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getMem_name());
			ps.setString(2, vo.getMem_id());
			ps.setString(3, vo.getMem_pwd());
			ps.setString(4, vo.getMem_ssn());
			ps.setString(5, vo.getMem_addr());
			ps.setString(6, vo.getMem_tel());
			ps.setString(7, vo.getMem_email());
			
			
			
			cnt=ps.executeUpdate();
			System.out.println("회원가입 처리 결과 cnt="+cnt);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	public int loginCheck(String mem_id, String mem_pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		try {
			//1 2
			con=pool.getConnection();
			//3
			String sql="select mem_pwd from member"
					+ " where mem_id=? and mem_use='Y'";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_id);

			//4
			rs=ps.executeQuery();
			int result=0;
			if(rs.next()) {
				String pwd=rs.getString(1);

				if(mem_pwd.equals(pwd)) {
					result=memberService.LOGIN_OK;
				}else if(mem_pwd!=pwd) {
					result=memberService.WRONG_PW;
				}
			}else {
				result=memberService.WRONG_ID;
			}
			System.out.println("로그인 처리결과 result="+result+", 매개변수 mem_id="+mem_id+", mem_pwd"+mem_pwd);
			return result;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	//회원/관리자 확인 메서드
	public int checkMember(String mem_id) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int mem_auth = 0;		//0:회원, 1:관리자

		try {
			//1 2 con
			con=pool.getConnection();
			//3
			String sql="select mem_auth from member"
					+ " where mem_id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_id);

			rs=ps.executeQuery();

			while(rs.next()) {
				mem_auth=rs.getInt(1);
			}

			return mem_auth;			
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	//아이디 중복확인
	public int duplicateId(String mem_id) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="select count(*) from member where mem_id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_id);

			//4
			int result=0;
			rs=ps.executeQuery();
			if(rs.next()) {
				int count=rs.getInt(1);
				if(count>0) {
					result=memberService.EXIST_ID; //이미 존재
				}else {
					result=memberService.NON_EXIST_ID; //사용가능					
				}
			}
			System.out.println("아이디 중복확인 결과 : "+result
					+", 매개변수 mem_id="+mem_id);

			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//주민번호 중복확인
	public int duplicateSsn(String mem_ssn) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="select count(*) from member where mem_ssn=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_ssn);

			//4
			int result=0;
			rs=ps.executeQuery();
			if(rs.next()) {
				int count=rs.getInt(1);
				if(count>0) {
					result=memberService.EXIST_ID; //이미 존재
				}else {
					result=memberService.NON_EXIST_ID; //사용가능					
				}
			}
			System.out.println("아이디 중복확인 결과 : "+result
					+", 매개변수 mem_id="+mem_ssn);

			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	//회원정보 메서드(session용)
	public memberVO memberInfo(String mem_id) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		memberVO vo=new memberVO();

		try {
			con=pool.getConnection();
			String sql="select mem_no,mem_name,mem_AUTH from member where mem_id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_id);

			rs=ps.executeQuery();
			while(rs.next()) {
				int mem_no=rs.getInt("mem_no");
				String mem_name=rs.getString("mem_name");
				String mem_AUTH=rs.getString("mem_AUTH");

				vo.setMem_no(mem_no);
				vo.setMem_name(mem_name);
				vo.setMem_auth(mem_AUTH);
			}
			return vo;

		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	//회원-회원정보 읽어오기
	public memberVO selectByUserid(String mem_id) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		memberVO vo = new memberVO();

		try {
			con = pool.getConnection();

			String sql = "select * from member where mem_id= ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mem_id);

			rs = ps.executeQuery();
			if(rs.next()) {
				int mem_no = rs.getInt("mem_no");
				String mem_name = rs.getString("mem_name");
				String mem_ssn = rs.getString("mem_ssn");
				String mem_addr = rs.getString("mem_addr");
				String mem_tel = rs.getString("mem_tel");
				String mem_email = rs.getString("mem_email");
				
				vo.setMem_no(mem_no);
				vo.setMem_name(mem_name);
				vo.setMem_ssn(mem_ssn);
				vo.setMem_addr(mem_addr);
				vo.setMem_tel(mem_tel);
				vo.setMem_email(mem_email);
			}
			System.out.println("회원조회 결과 vo="+vo+", 매개변수 userid="+mem_id);

			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//회원정보 수정
	public int updateMember(memberVO vo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      int cnt=0;
	      
	      try {
	         con=pool.getConnection();
	         
	         String sql="update member"
	               + " set mem_pwd=?,mem_addr=?,mem_tel=?,mem_email=?"
	               + " where mem_id=? and mem_use='Y'";
	         ps=con.prepareStatement(sql);
	         ps.setString(1, vo.getMem_pwd());
	         ps.setString(2, vo.getMem_addr());
	         ps.setString(3, vo.getMem_tel());
	         ps.setString(4, vo.getMem_email());
	         ps.setString(5, vo.getMem_id());
	         
	         cnt=ps.executeUpdate();
	         System.out.println("회원수정 결과 개수="+cnt);
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	
	//아이디 찾기
	public String findId(String mem_name, String mem_ssn) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String result="";
		
		try {
			con=pool.getConnection();
			String sql="select mem_id from member"
					+ " where mem_name=? and mem_ssn=? and mem_use='Y'";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_name);
			ps.setString(2, mem_ssn);
			
			
			rs=ps.executeQuery();
			while(rs.next()) {
				result=rs.getString(1);
			}
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//비밀번호 찾기(변경)
	public int changePw(String mem_id, String mem_name, String mem_ssn, String mem_pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		
		try {
			con=pool.getConnection();
			String sql="update member"
					+ " set mem_pwd=?"
					+ " where mem_id=? and mem_name=? and mem_ssn=? and mem_use='Y'";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_pwd);
			ps.setString(2, mem_id);
			ps.setString(3, mem_name);
			ps.setString(4, mem_ssn);
			
			cnt=ps.executeUpdate();
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//관리자-회원목록조회
	public List<memberVO> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<memberVO> list = new ArrayList<>();
		
		try {
			con=pool.getConnection();
			String sql="select * from member"
					+ " where mem_auth=0"
					+ " and mem_use='Y'"
					+ " order by mem_no";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int mem_no=rs.getInt("mem_no");
				String mem_name=rs.getString("mem_name");
				String mem_id=rs.getString("mem_id");
				String mem_ssn=rs.getString("mem_ssn");
				String mem_addr=rs.getString("mem_addr");
				String mem_email=rs.getString("mem_email");
				String mem_tel=rs.getString("mem_tel");
				String mem_use=rs.getString("mem_use");
				Timestamp mem_regdate=rs.getTimestamp("mem_regdate");
				
				memberVO vo = new memberVO();
				
				vo.setMem_no(mem_no);
				vo.setMem_name(mem_name);
				vo.setMem_id(mem_id);
				vo.setMem_ssn(mem_ssn);
				vo.setMem_addr(mem_addr);
				vo.setMem_email(mem_email);
				vo.setMem_tel(mem_tel);
				vo.setMem_use(mem_use);
				vo.setMem_regdate(mem_regdate);
				
				list.add(vo);
			}
			return list;
		}finally{
			pool.dbClose(ps, con);
		}
	}
	
	//관리자-번호로 회원 조회(디테일)
	public memberVO selectByNo(int mem_no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		memberVO vo = new memberVO();

		try {
			con = pool.getConnection();

			String sql = "select * from member where mem_no= ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, mem_no);

			rs = ps.executeQuery();
			if(rs.next()) {
				String mem_name = rs.getString("mem_name");
				String mem_id = rs.getString("mem_id");
				String mem_ssn = rs.getString("mem_ssn");
				String mem_addr = rs.getString("mem_addr");
				String mem_tel = rs.getString("mem_tel");
				String mem_email = rs.getString("mem_email");
				String mem_use = rs.getString("mem_use");
				Timestamp mem_regdate = rs.getTimestamp("mem_regdate");

				vo.setMem_name(mem_name);
				vo.setMem_id(mem_id);
				vo.setMem_ssn(mem_ssn);
				vo.setMem_addr(mem_addr);
				vo.setMem_tel(mem_tel);
				vo.setMem_email(mem_email);
				vo.setMem_use(mem_use);
				vo.setMem_regdate(mem_regdate);
			}
			System.out.println("회원조회 결과 vo="+vo+", 매개변수 mem_no="+mem_no);

			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//관리자-회원 삭제(비회원 전환)
	public int deleteMember(int mem_no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			String sql="update member set mem_use='N'"
					+ " where mem_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, mem_no);
			
			int cnt=ps.executeUpdate();
			System.out.println("회원 탈퇴 처리 결과 cnt="+cnt);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//관리자-회원정보수정
	public int admin_updateMember(memberVO vo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      int cnt=0;
	      
	      try {
	         con=pool.getConnection();
	         
	         String sql="update member"
	               + " set mem_addr=?,mem_tel=?,mem_email=?"
	               + " where mem_no=?";
	         ps=con.prepareStatement(sql);
	         ps.setString(1, vo.getMem_addr());
	         ps.setString(2, vo.getMem_tel());
	         ps.setString(3, vo.getMem_email());
	         ps.setInt(4, vo.getMem_no());
	         
	         cnt=ps.executeUpdate();
	         System.out.println("회원수정 결과 개수="+cnt);
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	
	//회원 - 회원탈퇴2(비회원 전환)
	public int deleteMember2(String mem_id) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			String sql="update member set mem_use='N'"
					+ " where mem_id=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, mem_id);
			
			int cnt=ps.executeUpdate();
			System.out.println("회원 탈퇴 처리 결과 cnt="+cnt);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}