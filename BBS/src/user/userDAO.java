package user;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class userDAO {

	//데이터베이스를 접근 하게 해주는 객체
	private Connection conn;
	//
	private PreparedStatement pstmt;
	//정보를 담을 수 있는 개체
	private ResultSet rs;

	public userDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPW = "aq1sw2de3";
			Class.forName("com.mysql.jdbc.Driver"); //mysql에 접속할 수 있도록 하는 매개체 역할 
			conn = DriverManager.getConnection(dbURL, dbID, dbPW); //db접속
			//conn객체안에 db정보다 담겨 데이터베이스를 사용할 수 있따.
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	//-2 db 오류,-1 아이디 오류,0 비밀번호 오류,1 성공
	public int login(String userID,String userPassword) {
		String SQL = "select pw from user where ID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, userID); //가장 중요한 부분임  해킹 기법 방어
			rs = pstmt.executeQuery(); //쿼리문 수행후 실행 결과를 담는곳 
			
			//결과 존재시 수행
			if(rs.next()) {
				//결과로 나온 userPW를 받아서 접속 시도 페스워드와 같다면 성고 반환
				if(rs.getString(1).equals(userPassword)){
					return 1; //로그인 성공
				}
				else
					return 0;//로그인 불일치
			}
			else
				return -1; //아이디 오류
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return -2;//데이터베이스 요류
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
			//반드시 0이상의 숫자만 return 함
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1; //데이터베이스 실행
	}
}
