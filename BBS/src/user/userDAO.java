package user;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class userDAO {

	//�����ͺ��̽��� ���� �ϰ� ���ִ� ��ü
	private Connection conn;
	//
	private PreparedStatement pstmt;
	//������ ���� �� �ִ� ��ü
	private ResultSet rs;

	public userDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPW = "aq1sw2de3";
			Class.forName("com.mysql.jdbc.Driver"); //mysql�� ������ �� �ֵ��� �ϴ� �Ű�ü ���� 
			conn = DriverManager.getConnection(dbURL, dbID, dbPW); //db����
			//conn��ü�ȿ� db������ ��� �����ͺ��̽��� ����� �� �ֵ�.
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	//-2 db ����,-1 ���̵� ����,0 ��й�ȣ ����,1 ����
	public int login(String userID,String userPassword) {
		String SQL = "select pw from user where ID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, userID); //���� �߿��� �κ���  ��ŷ ��� ���
			rs = pstmt.executeQuery(); //������ ������ ���� ����� ��°� 
			
			//��� ����� ����
			if(rs.next()) {
				//����� ���� userPW�� �޾Ƽ� ���� �õ� �佺����� ���ٸ� ���� ��ȯ
				if(rs.getString(1).equals(userPassword)){
					return 1; //�α��� ����
				}
				else
					return 0;//�α��� ����ġ
			}
			else
				return -1; //���̵� ����
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return -2;//�����ͺ��̽� ���
	}
	public int join(user user) {
		String SQL = "insert into user values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user.getId());
			pstmt.setString(2,user.getPw());
			pstmt.setString(3, user.getName());
			pstmt.setString(4,user.getEmail());
			pstmt.setString(5,user.getSex());
			
			return pstmt.executeUpdate();
			//�ݵ�� 0�̻��� ���ڸ� return ��
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
}
