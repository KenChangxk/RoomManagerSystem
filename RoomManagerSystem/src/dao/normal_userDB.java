package dao;

import bean.admin_userBean;
import bean.normal_userBean;

import java.sql.*;

public class normal_userDB {
	DBJavaBean d1 = new DBJavaBean();
	
	public boolean updateUser(normal_userBean ab) throws SQLException {
		String sql = "update normal_user set normal_memberPassword=?,normal_memberSex=?,normal_email=?,normal_memberTel=? where normal_memberName=?";
		PreparedStatement pstmt = d1.getPreparedStatement(sql);
		pstmt.setString(1, ab.getNormal_memberPassword());
		pstmt.setString(2, ab.getNormal_memberSex());
		pstmt.setString(3, ab.getNormal_email());
		pstmt.setString(4, ab.getNormal_memberTel());
		pstmt.setString(5, ab.getNormal_memberName());
//		System.out.println("接收值："+memberName);
		int count = pstmt.executeUpdate();
		if(count!=0) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean deleteUser(normal_userBean nub) throws SQLException {
		String sql = "delete from normal_user where normal_memberName=? and normal_memberPassword=? and normal_memberSex=? and normal_email=? and normal_memberTel=?";
		PreparedStatement pstmt = d1.getPreparedStatement(sql);
		pstmt.setString(1, nub.getNormal_memberName());
		pstmt.setString(2, nub.getNormal_memberPassword());
		pstmt.setString(3, nub.getNormal_memberSex());
		pstmt.setString(4, nub.getNormal_email());
		pstmt.setString(5, nub.getNormal_memberTel());
		int affectRows = pstmt.executeUpdate();
		if(affectRows!=0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public ResultSet queryAll() throws SQLException {
		String sql = "select * from normal_user";
		Statement stmt = d1.getStatement();
		return stmt.executeQuery(sql);
	}
	
	public normal_userBean queryById(String name) throws SQLException {
		normal_userBean nub = new normal_userBean();
		String sql = "select * from normal_user where normal_memberName=?";
		PreparedStatement pst = d1.getPreparedStatement(sql);
		pst.setString(1, name);
		ResultSet rs = pst.executeQuery();
		if(!rs.next()) {
			System.out.println("没有查询到用户信息");
			return null;
		}else{
			nub.setNormal_memberName(name);
			nub.setNormal_memberPassword(rs.getString("normal_memberPassword"));
			nub.setNormal_memberSex(rs.getString("normal_memberSex"));
			nub.setNormal_email(rs.getString("normal_email"));
			nub.setNormal_memberTel(rs.getString("normal_memberTel"));
			return nub;
		}
	}
	
	public boolean insertData(normal_userBean nb) throws SQLException {
		String sql = "insert into normal_user values(?,?,?,?,?)";
		PreparedStatement pst = d1.getPreparedStatement(sql);
		pst.setString(1, nb.getNormal_memberName());
		pst.setString(2, nb.getNormal_memberPassword());
		pst.setString(3, nb.getNormal_memberSex());
		pst.setString(4, nb.getNormal_email());
		pst.setString(5, nb.getNormal_memberTel());
		int count = pst.executeUpdate();
		if(count!=1){
			System.out.println("插入失败！");
			return false;
		}
		return true;
	}
	
}
