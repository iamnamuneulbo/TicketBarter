package show;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import show.ShowDateTime;
public class ShowDateTimeDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ShowDateTimeDAO() { 
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/BBS?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "ifnt0719";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 공연 찾기
	public ArrayList<ShowDateTime> getDateTime(int showID) {
		String SQL = "SELECT * FROM SHOW_DATETIME WHERE showID = ?";
		ArrayList<ShowDateTime> list = new ArrayList<ShowDateTime>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, showID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ShowDateTime showDateTime = new ShowDateTime();
				showDateTime.setShowID(rs.getInt(1));
				showDateTime.setShowDateTime(rs.getTimestamp(2));
				list.add(showDateTime);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}

