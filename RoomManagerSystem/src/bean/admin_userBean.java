package bean;

public class admin_userBean {
	private String admin_memberName;
	private String admin_memberPassword;
	private String admin_memberSex;
	private String admin_email;
	private String admin_memberTel;
	private int admin_level;
	
	public void setAdmin_level(int admin_level) {
		this.admin_level = admin_level;
	}
	
	public int getAdmin_level() {
		return admin_level;
	}
	
	public String getAdmin_memberName() {
		return admin_memberName;
	}
	public void setAdmin_memberName(String admin_memberNameString) {
		this.admin_memberName = admin_memberNameString;
	}
	public String getAdmin_memberPassword() {
		return admin_memberPassword;
	}
	public void setAdmin_memberPassword(String admin_memberPassword) {
		this.admin_memberPassword = admin_memberPassword;
	}
	public String getAdmin_memberSex() {
		return admin_memberSex;
	}
	public void setAdmin_memberSex(String admin_memberSexString) {
		this.admin_memberSex = admin_memberSexString;
	}
	public String getAdmin_email() {
		return admin_email;
	}
	public void setAdmin_email(String admin_emailString) {
		this.admin_email = admin_emailString;
	}
	public String getAdmin_memberTel() {
		return admin_memberTel;
	}
	public void setAdmin_memberTel(String admin_memberTel) {
		this.admin_memberTel = admin_memberTel;
	}
	
	
}
