package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

public class DBJavaBean {
	private String driverName = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/roommanager?serverTimezone=UTC";
	private String user = "root";
	private String password = "pas123";
	private Connection con = null;
	private Statement st = null;
	private PreparedStatement pst = null;
	private ResultSet rs = null;

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	public void setPst(Connection con) {
		this.con = con;
	}

	public PreparedStatement getPst(String sql) {
		return pst;
	}

	public Statement getSt() {
		return st;
	}

	public void setSt(Statement st) {
		this.st = st;
	}

	public ResultSet getRs() {
		return rs;
	}

	public void setRs(ResultSet rs) {
		this.rs = rs;
	}

	public Statement getStatement() {
		try {
			Class.forName(getDriverName());
			con = DriverManager.getConnection(getUrl(), getUser(), getPassword());
			return con.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
			message("无法完成数据库的连接或者无法返回容器，请检查getStatement()方法！");
			return null;
		}
	}

	public PreparedStatement getPreparedStatement(String sql) {
		try {
			Class.forName(getDriverName());
			con = DriverManager.getConnection(getUrl(), getUser(), getPassword());
			return con.prepareStatement(sql);
		} catch (Exception e) {
			e.printStackTrace();
			message("无法完成数据库的连接或者无法返回容器，请检查getPreparedStatement()方法！");
			return null;
		}
	}
	
	// 一个带参数的信息提示框，供找错使用
	public void message(String msg) {
		int type = JOptionPane.YES_NO_OPTION;
		String title = "信息提示";
		JOptionPane.showMessageDialog(null, msg, title, type);
	}
}
