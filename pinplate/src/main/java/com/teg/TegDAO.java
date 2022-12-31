package com.teg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.db.ConnectionPoolMgr;

public class TegDAO {
	ConnectionPoolMgr pool;
	public TegDAO() {
		pool=new ConnectionPoolMgr();
	}
	public List<TegVO> selectTeg() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		List<TegVO>list=new ArrayList<>();
		ResultSet rs=null;
		TegVO tegvo=null;
		try {
			con=pool.getConnection();
			String sql="select * from teg";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				int teg_no=rs.getInt("teg_no");
				String teg_name=rs.getString("teg_name");
				tegvo=new TegVO(teg_no, teg_name);
				list.add(tegvo);
			}
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
