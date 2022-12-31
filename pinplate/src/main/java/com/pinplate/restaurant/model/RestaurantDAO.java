package com.pinplate.restaurant.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import java.util.List;

import com.db.ConnectionPoolMgr;
import com.image.model.ImageVO;
import com.member.model.memberVO;



public class RestaurantDAO {
	private ConnectionPoolMgr pool;
	
	public RestaurantDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public int insertRes(RestaurantVO resvo,memberVO memvo,List<ImageVO> list) throws SQLException {
		int cnt=0;
		Connection con=null;
		PreparedStatement ps=null;
	
		try {
			con=pool.getConnection();
			con.setAutoCommit(false);
			String sql="insert into restaurant(res_no,res_name,res_tel,res_addr,res_type,res_content,res_x,res_y,res_yn,res_use,app_userno)";
					if(memvo.getMem_auth().equals("1")) {
						//매니저인경우
						sql+=" values(res_seq.nextval,?,?,?,?,?,?,?,'Y','Y',?)";
					}else {
						//일반회원인경우
						sql+=" values(res_seq.nextval,?,?,?,?,?,?,?,'N','Y',?)";
					}
			ps=con.prepareStatement(sql);
			ps.setString(1,resvo.getRes_name());
			ps.setString(2,resvo.getRes_tel());
			ps.setString(3,resvo.getRes_addr());
			ps.setString(4,resvo.getRes_type());
			ps.setString(5,resvo.getRes_content());
			ps.setDouble(6,resvo.getRes_x());
			ps.setDouble(7,resvo.getRes_y());
			ps.setInt(8,memvo.getMem_no());
			
			ps.executeUpdate();
			
			String sql2="insert into images(img_no,tb_type_no,tb_no,img_filename,img_originalfilename)"
					+ " values(images_seq.nextval,1,?,?,?)";
			ImageVO imgvo=null;
			
			for(int i=0;i<list.size();i++) {
				imgvo=list.get(i);
				ps=con.prepareStatement(sql2);
				ps.setInt(1,imgvo.getTb_no());
				ps.setString(2,imgvo.getImg_filename());
				ps.setString(3,imgvo.getImg_originalfilename());
				
				cnt+=ps.executeUpdate();
			}
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
			con.rollback();
		}finally {
			con.setAutoCommit(true);
			pool.dbClose(ps, con);
		}
		return cnt;//이미지의 인서트갯수 반환
	}
	
	//리스트에 레스토랑과 단하나의 이미지만 반환하는 메서드(filename이 넘어올 것이고 이를통해 이미지를 불러올것이다.)
	public List<RestaurantVO> resimgselect() throws SQLException{
		
		List<RestaurantVO> list =new ArrayList<>();
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		RestaurantVO vo=null;
		try {
			con=pool.getConnection();
			
			String sql="select * from resimgone where res_yn='Y' and res_use='Y'";
			
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
		
			while(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String res_tel=rs.getString("res_tel");
				String res_addr=rs.getString("res_addr");
				String res_type=rs.getString("res_type");
				String res_content=rs.getString("res_content");
				double res_x=rs.getDouble("res_x");
				double res_y=rs.getDouble("res_y");
				String res_yn=rs.getString("res_yn");
				String res_use=rs.getString("res_use");
				Timestamp res_regdate=rs.getTimestamp("res_regdate");
				int app_userno=rs.getInt("app_userno");
				String imgone=rs.getString("imgone");
				
				vo=new RestaurantVO(res_no, res_name, res_tel, res_addr, res_type, res_content, 
						res_x, res_y, res_yn, res_use, res_regdate, app_userno, imgone);
				list.add(vo);
			}
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//현재 레스토랑 시퀀스의 값을 가져오는 메서드
	public int res_seq_curr() throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int res_seq_curr=0;
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="select last_number from user_sequences\r\n"
					+ "where sequence_name='RES_SEQ'";
					
			ps=con.prepareStatement(sql);
			//4
			rs=ps.executeQuery();
			
			if(rs.next()) {
				res_seq_curr=rs.getInt("LAST_NUMBER");
			}		
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
		return res_seq_curr;
	}
	public RestaurantVO resSelectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		RestaurantVO vo = null;
		try {
			con=pool.getConnection();
			String sql="select * from resimgone where res_no=? and res_yn = 'Y' and res_yn='Y'";
			ps=con.prepareStatement(sql);
			ps.setInt(1,no);
			rs=ps.executeQuery();
			if(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String res_tel=rs.getString("res_tel");
				String res_addr=rs.getString("res_addr");
				String res_type=rs.getString("res_type");
				String res_content=rs.getString("res_content");
				double res_x=rs.getDouble("res_x");
				double res_y=rs.getDouble("res_y");
				String res_yn=rs.getString("res_yn");
				String res_use=rs.getString("res_use");
				Timestamp res_regdate=rs.getTimestamp("res_regdate");
				int app_userno=rs.getInt("app_userno");
				String imgone=rs.getString("imgone");
				
				
				vo=new RestaurantVO(res_no, res_name, res_tel, res_addr, res_type, res_content, res_x, res_y, res_yn, res_use, res_regdate, app_userno, imgone);
				
			}
			
			return vo;
		} finally {
			pool.dbClose(ps, con);
		}
		
	}
	public List<RestaurantVO> resSelectByKeyword(String search) throws SQLException {
		List<RestaurantVO> list=new ArrayList<>();
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		RestaurantVO resvo=null;
		
		try {
			con=pool.getConnection();
			String sql="select res_no,res_name,imgone from resimgone"
		               + " where res_yn='Y' and res_use='Y' and res_name like '%'|| ? ||'%'"
		               + " or res_yn='Y' and res_use='Y'and res_no=(select res_no from res_teg where teg_no=(select teg_no from teg where teg_name like '%'|| ? ||'%'))"
		               + " or res_yn='Y' and res_use='Y'and res_type like '%' || ? || '%'"
		               + " union"
		               + " select res_no,res_name,imgone from resimgone"
		               + "   where res_yn='Y' and res_use='Y'and res_no in (select res_no from menu where menu_name like '%'|| ? ||'%')";
		 
			ps=con.prepareStatement(sql);
			ps.setString(1,search);
			ps.setString(2,search);
			ps.setString(3,search);
			ps.setString(4,search);
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String imgone=rs.getString("imgone");
				
				resvo = new RestaurantVO();
				resvo.setRes_no(res_no);
				resvo.setRes_name(res_name);
				resvo.setImgone(imgone);
				
				list.add(resvo);
			}
			
			return list;
		} finally {
			// TODO: handle finally clause
			pool.dbClose(rs,ps,con);
		}
		
		
	}
	public List<RestaurantVO> selectAllRes() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<RestaurantVO> list=new ArrayList<>();
		RestaurantVO resvo=null;
		try {
			con=pool.getConnection();
			String sql="select * from restaurant";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			
			
			while(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String res_tel=rs.getString("res_tel");
				String res_addr=rs.getString("res_addr");
				String res_type=rs.getString("res_type");
				String res_content=rs.getString("res_content");
				double res_x=rs.getDouble("res_x");
				double res_y=rs.getDouble("res_y");
				String res_yn=rs.getString("res_yn");
				String res_use=rs.getString("res_use");
				Timestamp res_regdate=rs.getTimestamp("res_regdate");
				int app_userno=rs.getInt("app_userno");
				resvo=new RestaurantVO(res_no, res_name, res_tel, res_addr, res_type, res_content, res_x, res_y, res_yn, res_use, res_regdate, app_userno);
				list.add(resvo);
			}
			return list;
		}finally {
			pool.dbClose(rs, ps, con);		
			}
	}
	public List<RestaurantVO> selectDisAgreeRes() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<RestaurantVO> list=new ArrayList<>();
		RestaurantVO resvo=null;
		try {
			con=pool.getConnection();
			String sql="select * from restaurant where res_yn='N'and res_use='Y'";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			
			
			while(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String res_tel=rs.getString("res_tel");
				String res_addr=rs.getString("res_addr");
				String res_type=rs.getString("res_type");
				String res_content=rs.getString("res_content");
				double res_x=rs.getDouble("res_x");
				double res_y=rs.getDouble("res_y");
				String res_yn=rs.getString("res_yn");
				String res_use=rs.getString("res_use");
				Timestamp res_regdate=rs.getTimestamp("res_regdate");
				int app_userno=rs.getInt("app_userno");
				resvo=new RestaurantVO(res_no, res_name, res_tel, res_addr, res_type, res_content, res_x, res_y, res_yn, res_use, res_regdate, app_userno);
				list.add(resvo);
			}
			return list;
		}finally {
			pool.dbClose(rs, ps, con);		
			}
	}
	public List<RestaurantVO> selectManageRes() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<RestaurantVO> list=new ArrayList<>();
		RestaurantVO resvo=null;
		try {
			con=pool.getConnection();
			String sql="select * from restaurant where res_use='Y'";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			
			
			while(rs.next()) {
				int res_no=rs.getInt("res_no");
				String res_name=rs.getString("res_name");
				String res_tel=rs.getString("res_tel");
				String res_addr=rs.getString("res_addr");
				String res_type=rs.getString("res_type");
				String res_content=rs.getString("res_content");
				double res_x=rs.getDouble("res_x");
				double res_y=rs.getDouble("res_y");
				String res_yn=rs.getString("res_yn");
				String res_use=rs.getString("res_use");
				Timestamp res_regdate=rs.getTimestamp("res_regdate");
				int app_userno=rs.getInt("app_userno");
				resvo=new RestaurantVO(res_no, res_name, res_tel, res_addr, res_type, res_content, res_x, res_y, res_yn, res_use, res_regdate, app_userno);
				list.add(resvo);
			}
			return list;
		}finally {
			pool.dbClose(rs, ps, con);		
			}
	}
	public int updateAgree(int no) throws SQLException {
			Connection con=null;
			PreparedStatement ps=null;
			int cnt=0;
			try {
				con=pool.getConnection();
				String sql="update restaurant set res_yn='Y' where res_no=?";
				ps=con.prepareStatement(sql);
				ps.setInt(1, no);
				cnt=ps.executeUpdate();
				return cnt;
				
			}
			finally {
				pool.dbClose(ps, con);
			}
		}
	public int updateResImg(RestaurantVO resvo,List<ImageVO> list) throws SQLException {
		int cnt=0;
		Connection con=null;
		PreparedStatement ps=null;
	
		try {
			con=pool.getConnection();
			con.setAutoCommit(false);
			String sql="update  restaurant set res_name=?,res_tel=?,res_addr=?,res_type=?,res_x=?,res_y=?"
					+ " where res_no=?";
					
			ps=con.prepareStatement(sql);
			ps.setString(1,resvo.getRes_name());
			ps.setString(2,resvo.getRes_tel());
			ps.setString(3,resvo.getRes_addr());
			ps.setString(4,resvo.getRes_type());
			ps.setDouble(5,resvo.getRes_x());
			ps.setDouble(6,resvo.getRes_y());
			ps.setInt(7, resvo.getRes_no());
			System.out.println("여긴되나...");
			ps.executeUpdate();
			
			String sql2="update images set img_filename=?,img_originalfilename=?"
					+ " where tb_type_no=? and tb_no=?";
			ImageVO imgvo=null;
			System.out.println("여기안됨?");
			for(int i=0;i<list.size();i++) {
				imgvo=list.get(i);
				ps=con.prepareStatement(sql2);
				
				ps.setString(1,imgvo.getImg_filename());
				ps.setString(2,imgvo.getImg_originalfilename());
				ps.setInt(3,1);
				
				ps.setInt(4,resvo.getRes_no());
				
				cnt+=ps.executeUpdate();
			}
			
		} 
		catch (SQLException e) {
			e.printStackTrace();
			con.rollback();
		}finally {
			con.setAutoCommit(true);
			pool.dbClose(ps, con);
		}
		return cnt;//이미지의 인서트갯수 반환
	} 
	public int updateRes(RestaurantVO resvo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		try {
			con=pool.getConnection();
			String sql="update  restaurant set res_name=?,res_tel=?,res_addr=?,res_type=?,res_x=?,res_y=?"
					+ " where res_no=?";
			
			ps=con.prepareStatement(sql);
			ps.setString(1,resvo.getRes_name());
			ps.setString(2,resvo.getRes_tel());
			ps.setString(3,resvo.getRes_addr());
			ps.setString(4,resvo.getRes_type());
			ps.setDouble(6,resvo.getRes_x());
			ps.setDouble(7,resvo.getRes_y());
			ps.setDouble(8,resvo.getRes_no());
			
			
			
			cnt=ps.executeUpdate();
			return cnt;
		}
	
		finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int deleteRes(int resno) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		try {
			con=pool.getConnection();
			String sql="update restaurant set res_use='N' where res_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, resno);
			cnt=ps.executeUpdate();
			
			return cnt;	
		}
		finally {
			pool.dbClose(ps, con);
		}
	}
	
	//모든 레스토랑 [넘버]와 [이름]만을 가져오는 메서드_22.11.08 18:07 추가함 ★
		public List<RestaurantVO> selectAllresName() throws SQLException {
			Connection con=null;
			PreparedStatement ps= null;
			ResultSet rs = null;
			List<RestaurantVO> list = new ArrayList<>();
			RestaurantVO vo=null;		
			
			try {
				//1,2
				con=pool.getConnection();
				//3
				String sql="select res_no, res_name, res_yn, res_use from restaurant"
						+ " order by res_no";
				ps=con.prepareStatement(sql);
				
				//4
				rs=ps.executeQuery();
				
				while(rs.next()) {
					int res_no = rs.getInt("res_no");
					String res_name = rs.getString("res_name");
					String res_yn = rs.getString("res_yn");
					String res_use = rs.getString("res_use");
					vo=new RestaurantVO(res_no, res_name, res_yn, res_use);
					list.add(vo);
				}
			}finally {
				//5			
				pool.dbClose(rs, ps, con);
			}
			return list;
		}
}
