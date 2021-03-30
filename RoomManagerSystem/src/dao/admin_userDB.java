package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.admin_userBean;
import bean.normal_userBean;

public class admin_userDB {
	DBJavaBean d2 = new DBJavaBean();
	
	public boolean updateUser(admin_userBean ab,String memberName) throws SQLException {
		String sql = "update admin_user set admin_memberPassword=?,admin_memberSex=?,admin_email=?,admin_memberTel=? where admin_memberName=?";
		PreparedStatement pstmt = d2.getPreparedStatement(sql);
		pstmt.setString(1, ab.getAdmin_memberPassword());
		pstmt.setString(2, ab.getAdmin_memberSex());
		pstmt.setString(3, ab.getAdmin_email());
		pstmt.setString(4, ab.getAdmin_memberTel());
		pstmt.setString(5, memberName);
//		System.out.println("接收值："+memberName);
		int count = pstmt.executeUpdate();
		if(count!=0) {
			return true;
		}else {
			return false;
		}
	}
	
	public ResultSet queryAll() throws SQLException {
		String sql = "select * from admin_user";
		Statement stmt = d2.getStatement();
		return stmt.executeQuery(sql);
	}
	
	public boolean deleteUser(admin_userBean aub) throws SQLException {
		String sql = "delete from admin_user where admin_memberName=? and admin_memberPassword=? and admin_memberSex=? and admin_email=? and admin_memberTel=?";
		PreparedStatement pstmt = d2.getPreparedStatement(sql);
		pstmt.setString(1, aub.getAdmin_memberName());
		pstmt.setString(2, aub.getAdmin_memberPassword());
		pstmt.setString(3, aub.getAdmin_memberSex());
		pstmt.setString(4, aub.getAdmin_email());
		pstmt.setString(5, aub.getAdmin_memberTel());
		int affectRows = pstmt.executeUpdate();
		if(affectRows!=0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public admin_userBean queryById(String name) throws SQLException {
		admin_userBean aub = new admin_userBean();
		System.out.println(name);
		String sql = "select * from admin_user where admin_memberName=?";
		PreparedStatement pst = d2.getPreparedStatement(sql);
		pst.setString(1, name);
		ResultSet rs = pst.executeQuery();
		if(!rs.next()) {
			System.out.println("没有查询到用户信息");
			return null;
		}else{
			aub.setAdmin_memberName(name);
			aub.setAdmin_memberPassword(rs.getString("admin_memberPassword"));
			aub.setAdmin_memberSex(rs.getString("admin_memberSex"));
			aub.setAdmin_email(rs.getString("admin_email"));
			aub.setAdmin_memberTel(rs.getString("admin_memberTel"));
			aub.setAdmin_level(rs.getInt("admin_level"));
			return aub;
		}
	}

	public boolean insertData(admin_userBean ab) throws SQLException {
		String sql = "insert into admin_user(admin_memberName,admin_memberPassword,admin_memberSex,admin_email,admin_memberTel) values(?,?,?,?,?)";
		PreparedStatement pst = d2.getPreparedStatement(sql);
		pst.setString(1, ab.getAdmin_memberName());
		pst.setString(2, ab.getAdmin_memberPassword());
		pst.setString(3, ab.getAdmin_memberSex());
		pst.setString(4, ab.getAdmin_email());
		pst.setString(5, ab.getAdmin_memberTel());
		int count = pst.executeUpdate();
		if (count != 1) {
			System.out.println("插入失败！");
			return false;
		}
		return true;
	}
}
