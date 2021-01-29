package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class bbsDAO {

	//�����ͺ��̽��� ���� �ϰ� ���ִ� ��ü
	private Connection conn;
	
	// private PreparedStatement pstmt; :���������� ���� ���� ���� 
	//������ ���� �� �ִ� ��ü
	private ResultSet rs;

	public bbsDAO() {
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
	//����ð� �������� �Լ� ���� �ð� �Է��� ����
	public String getData() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //���� �غ� �ܰ�
			rs =pstmt.executeQuery();//��������
			if(rs.next()) {
				return rs.getString(1); //��¥�� �״�� ��ȯ
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "";
	}
	//�������� ���� �Խù��� �����ͼ� ��ȣ���� 1�� ���Ѱ��� ���� �Խù��̰� �ϱ�����.
	public int getNext() {
		String SQL = "SELECT bbsNum FROM bbs ORDER BY bbsNum DESC"; //������������ ���� ��ȯ
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //���� �غ� �ܰ�
			rs =pstmt.executeQuery();//��������
			if(rs.next()) {
				return rs.getInt(1) + 1; //��¥�� �״�� ��ȯ
			}
			else
				return 1; //ó���� �Խù��ϋ�
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;// �����ͺ��̽� ����
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
			return pstmt.executeUpdate();//���� ����� 0�̻� �� ��ȥ
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	
	//�Խñ� ���������� ��������
	public ArrayList<bbs> getList(int pageNumber){
		//�ִ� 10���� ���ñ��� ��������
		String SQL = "SELECT * FROM bbs WHERE bbsNum < ? AND bbsAvailable = 1 ORDER BY bbsNum DESC LIMIT 10"; //������������ ���� ��ȯ
		ArrayList<bbs> list = new ArrayList<bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //���� �غ� �ܰ�
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); //(���� �ۼ� ��ȣ)-������ ��ŭ �� 
			rs =pstmt.executeQuery();//��������
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
		return list;// �����ͺ��̽� ����
	
	}
	//�Խñ��� 10���� ����� �Խñ��� 10������ ���ϋ� �������� ������ @@ �˸��� ���� ����¡�� ���� ���
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM bbs WHERE bbsNum < ? AND bbsAvailable = 1"; //������������ ���� ��ȯ
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL); //���� �غ� �ܰ�
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); //(���� �ۼ� ��ȣ)-������ ��ŭ �� 
			rs =pstmt.executeQuery();//��������
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
		String SQL = "SELECT * FROM bbs WHERE bbsNum  = ?"; //������������ ���� ��ȯ
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL); //���� �غ� �ܰ�
			pstmt.setInt(1,bbsNum); //(���� �ۼ� ��ȣ)-������ ��ŭ �� 
			rs =pstmt.executeQuery();//��������
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
			return pstmt.executeUpdate();//���� ����� 0�̻� �� ��ȥ
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
			return pstmt.executeUpdate();//���� ����� 0�̻� �� ��ȥ
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
}
