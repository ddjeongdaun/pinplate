package com.review.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.db.ConnectionPoolMgr;

public class ReviewDAO {
	private ConnectionPoolMgr pool;
	
	public ReviewDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public int insertRev(ReviewVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt=0;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into review(rev_no, mem_no, res_no, rev_content)"
					+ " values(rev_seq.nextval, ?, ?, ?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getMem_no());
			ps.setInt(2, vo.getRes_no());
			ps.setString(3, vo.getRev_content());
			
			//4
			cnt=ps.executeUpdate();
			
		}finally {
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}
	
	public int deleteRev(ReviewVO vo, String mem_auth) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		
		try {
			//1, 2
			con=pool.getConnection();
			//3
			String sql="";
			
			if(Integer.parseInt(mem_auth)==1) { //관리자 : 모든 리뷰 삭제 권한
				sql="update review "
					+ " set use_yn='N'"
					+ " where rev_no=?";
				ps=con.prepareStatement(sql);
				ps.setInt(1, vo.getRev_no());
				
			}else {
				sql="update review"
					+ " set use_yn='N'"
					+ " where rev_no=? and mem_no=?";
				ps=con.prepareStatement(sql);
				ps.setInt(1, vo.getRev_no());
				ps.setInt(2, vo.getMem_no());	
			}			
			
			//4
			cnt=ps.executeUpdate();
		}finally {
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}
	
	public List<ReviewVO> selectReview(int res_no) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ReviewVO reviewVo=new ReviewVO();
		List<ReviewVO> list= new ArrayList<>();
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="select * from review "
					+ " where res_no=? and use_yn='Y'"
					+ " order by rev_no desc";
			ps=con.prepareStatement(sql);
			ps.setInt(1, res_no);
			
			//4
			rs=ps.executeQuery();
			while(rs.next()) {
				int rev_no=rs.getInt("rev_no");
				int mem_no=rs.getInt("mem_no");
				String rev_content=rs.getString("rev_content");
				
				reviewVo = new ReviewVO(rev_no, mem_no, res_no, rev_content);
				list.add(reviewVo);
			}
			
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
		return list;
	}

	public List<ReviewVO> selectReviewByUserNo(int mem_no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ReviewVO reviewVo=new ReviewVO();
		List<ReviewVO> list= new ArrayList<>();
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="select * from review"
					+ " where mem_no=? and use_yn='Y'"
					+ " order by rev_no";
			ps=con.prepareStatement(sql);
			ps.setInt(1, mem_no);
			
			//4
			rs=ps.executeQuery();
			while(rs.next()) {
				int rev_no=rs.getInt("rev_no");
				int res_no=rs.getInt("res_no");
				String rev_content=rs.getString("rev_content");
				
				reviewVo = new ReviewVO(rev_no, mem_no, res_no, rev_content);
				list.add(reviewVo);
			}
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
		return list;
	}
}
