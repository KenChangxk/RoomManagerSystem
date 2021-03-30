package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.normal_userBean;
import bean.roomInfoBean;

public class roomInfoDB {
	DBJavaBean d = new DBJavaBean();

	public boolean deleteRoomInfoById(String roomNum) throws SQLException {
		String sql = "delete from roomInfo where roomNum=?";
		System.out.println(roomNum);
		PreparedStatement pstmt = d.getPreparedStatement(sql);
		pstmt.setString(1, roomNum);
		int affectRows = pstmt.executeUpdate();
		if (affectRows != 0) {
			return true;
		} else {
			return false;
		}
	}

	public ResultSet queryAll() throws SQLException {
		String sql = "select * from roomInfo";
		Statement stmt = d.getStatement();
		return stmt.executeQuery(sql);
	}

	public boolean insertData(roomInfoBean rb) throws SQLException {
		String sql = "insert into roomInfo(roomNum,roomSeats,roomClass,roomDept,roomRequire) values(?,?,?,?,?)";
		PreparedStatement pst = d.getPreparedStatement(sql);
		pst.setString(1, rb.getRoomNum());
		pst.setInt(2, rb.getRoomSeats());
		pst.setString(3, rb.getRoomClass());
		pst.setString(4, rb.getRoomDept());
		pst.setString(5, rb.getRoomRequire());
		int count = pst.executeUpdate();
		if (count != 1) {
			System.out.println("插入失败！");
			return false;
		}
		return true;
	}

	public boolean deleteRoomInfo(roomInfoBean rb) throws SQLException {
		String sql = "delete from roomInfo where roomNum=? and roomSeats=? and roomClass=? and roomDept=? and roomRequire=?";
		PreparedStatement pstmt = d.getPreparedStatement(sql);
		pstmt.setString(1,rb.getRoomNum());
		pstmt.setInt(2,rb.getRoomSeats());
		pstmt.setString(3,rb.getRoomClass());
		pstmt.setString(4,rb.getRoomDept());
		pstmt.setString(5,rb.getRoomRequire());
		int affectRows = pstmt.executeUpdate();
		if(affectRows!=0) {
			return true;
		}
		else {
			return false;
		}
	}

}
