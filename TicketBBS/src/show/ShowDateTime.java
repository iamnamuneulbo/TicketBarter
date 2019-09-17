package show;

import java.sql.Timestamp;

public class ShowDateTime {
	private int showID;
	private Timestamp showDateTime;
	
	public int getShowID() {
		return showID;
	}
	public void setShowID(int showID) {
		this.showID = showID;
	}
	public Timestamp getShowDateTime() {
		return showDateTime;
	}
	public void setShowDateTime(Timestamp showDateTime) {
		this.showDateTime = showDateTime;
	}
}
