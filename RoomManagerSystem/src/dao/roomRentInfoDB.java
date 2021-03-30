package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.admin_userBean;
import bean.normal_userBean;
import bean.roomInfoBean;
import bean.roomRentInfoBean;

public class roomRentInfoDB {
	DBJavaBean d3 = new DBJavaBean();
	
	public boolean deleteRoomRentInfo(String roomNum ,String memberName,String period) throws SQLException {
		String sql = "delete from roomRentInfo where rent_roomNum=? and rent_memberName=? and rent_period=?";
		PreparedStatement pstmt = d3.getPreparedStatement(sql);
		pstmt.setString(1, roomNum);
		pstmt.setString(2, memberName);
		pstmt.setString(3, period);
		int count = pstmt.executeUpdate();
		if(count!=0) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean updateRoomRentInfo(String roomNum ,String memberName,String period,String ispass,String adminName) throws SQLException {
		String sql = "update roomRentInfo set rent_verify=?,rent_adminName=? where rent_roomNum=? and rent_memberName=? and rent_period=?";
		PreparedStatement pstmt = d3.getPreparedStatement(sql);
		if(ispass.equals("true"))
			pstmt.setInt(1, 0);
		else
			pstmt.setInt(1,-1);
		pstmt.setString(2, adminName);
		pstmt.setString(3, roomNum);
		pstmt.setString(4, memberName);
		pstmt.setString(5, period);
		int count = pstmt.executeUpdate();
		if(count!=0) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean is(String roomNum,String date) throws SQLException {
		String sql = "select * from roomRentInfo where rent_roomNum=? and rent_period=? and rent_verify in(0,1)";
		PreparedStatement pst = d3.getPreparedStatement(sql);
		pst.setString(1, roomNum);
		pst.setString(2, date);
		ResultSet rs = pst.executeQuery();
		if(!rs.next()) {
			System.out.println("没有查询到用户信息");
			return true;
		}else{
			return false;
		}
	}
	
	public ResultSet queryAll() throws SQLException {
		String sql = "select * from roomRentInfo";
		Statement stmt = d3.getStatement();
		return stmt.executeQuery(sql);
	}
	
	public boolean insertData(roomRentInfoBean rb) throws SQLException {
		String sql = "insert into roomRentInfo(rent_roomNum,rent_memberName,rent_email,rent_memberTel,rent_period,rent_time) values(?,?,?,?,?,?)";
		PreparedStatement pst = d3.getPreparedStatement(sql);
		pst.setString(1, rb.getRent_roomNum());
		pst.setString(2, rb.getRent_memberName());
		pst.setString(3, rb.getRent_email());
		pst.setString(4, rb.getRent_memberTel());
		pst.setString(5, rb.getRent_period());
		pst.setString(6, rb.getRent_Time());
		int count = pst.executeUpdate();
		if (count != 1) {
			System.out.println("插入失败！");
			return false;
		}
		return true;
	}

}
