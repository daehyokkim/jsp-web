package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class bbsDAO {

	//데이터베이스를 접근 하게 해주는 객체
	private Connection conn;
	
	// private PreparedStatement pstmt; :마찰방지를 위해 각가 설정 
	//정보를 담을 수 있는 개체
	private ResultSet rs;

	public bbsDAO() {
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
	//현재시간 가져오는 함수 현재 시간 입력을 위해
	public String getData() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비 단계
			rs =pstmt.executeQuery();//가져오기
			if(rs.next()) {
				return rs.getString(1); //날짜를 그대로 반환
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "";
	}
	//마지막에 쓰인 게시물을 가져와서 번호에다 1을 더한값이 다음 게시물이게 하기위해.
	public int getNext() {
		String SQL = "SELECT bbsNum FROM bbs ORDER BY bbsNum DESC"; //내림차순으로 값을 반환
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비 단계
			rs =pstmt.executeQuery();//가져오기
			if(rs.next()) {
				return rs.getInt(1) + 1; //날짜를 그대로 반환
			}
			else
				return 1; //처번쨰 게시물일떄
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO bbs VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getData());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();//정상 수행시 0이상 값 반혼
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	
	//게시글 페이지마다 가져오기
	public ArrayList<bbs> getList(int pageNumber){
		//최대 10개의 개시글을 가져오기
		String SQL = "SELECT * FROM bbs WHERE bbsNum < ? AND bbsAvailable = 1 ORDER BY bbsNum DESC LIMIT 10"; //내림차순으로 값을 반환
		ArrayList<bbs> list = new ArrayList<bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비 단계
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); //(다음 작성 번호)-페이지 만큼 수 
			rs =pstmt.executeQuery();//가져오기
			while(rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsNum(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;// 데이터베이스 오류
	
	}
	//게시글이 10단위 끊기고 게시글이 10페이지 뿐일떄 존재하지 않음을 @@ 알리기 위해 페이징을 위해 사용
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bbs WHERE bbsNum < ? AND bbsAvailable = 1"; //내림차순으로 값을 반환
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비 단계
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); //(다음 작성 번호)-페이지 만큼 수 
			rs =pstmt.executeQuery();//가져오기
			if(rs.next()) {
				return true;
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;// 
		
	}
	
	public bbs getbbs(int bbsNum) {
		String SQL = "SELECT * FROM bbs WHERE bbsNum  = ?"; //내림차순으로 값을 반환
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비 단계
			pstmt.setInt(1,bbsNum); //(다음 작성 번호)-페이지 만큼 수 
			rs =pstmt.executeQuery();//가져오기
			if(rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsNum(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;// 
		
	}
	
	public int update(int bbsNum, String bbsTitle, String bbsContent) {
		
		String SQL = "UPDATE bbs SET bbsTitle= ?, bbsContent = ? WHERE bbsNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsNum);
			return pstmt.executeUpdate();//정상 수행시 0이상 값 반혼
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsNum) {

		String SQL = "UPDATE bbs SET bbsAvailable= 0 WHERE bbsNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsNum);
			return pstmt.executeUpdate();//정상 수행시 0이상 값 반혼
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
}
