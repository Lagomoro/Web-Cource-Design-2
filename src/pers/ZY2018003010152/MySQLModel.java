package pers.ZY2018003010152;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

public class MySQLModel {
	
	public final static String SQL_USER     = "webteach";
	public final static String SQL_PASSWARD = "webteach";
	public final static String SQL_URL      = "jdbc:mysql://202.194.14.120:3306/webteach?useSSL=true&serverTimezone=GMT%2B8&characterEncoding=utf8";
	
	public final static String TABLE_NAME    = "web201800301015_zy1_";
	public final static String TABLE_USER    = TABLE_NAME + "userinfo";
	public final static String TABLE_COMMENT = TABLE_NAME + "comment";
	
	public static Connection connection;
	
	public static PreparedStatement statementUserTable;
	public static PreparedStatement statementCommentTable;
	
	public static PreparedStatement statementUserGet;
	public static PreparedStatement statementUserInsert;
	public static PreparedStatement statementUserNickname;
	public static PreparedStatement statementUserPassword;
	
	public static PreparedStatement statementCommentGet;
	public static PreparedStatement statementCommentInsert;
	public static PreparedStatement statementCommentGetAll;
	
	public static boolean inited = false;

	// ================================================================================
	// * Initialize
	// ================================================================================
	
	public static void init() {
		if(inited)return;
		try {   
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(SQL_URL, SQL_USER, SQL_PASSWARD);
			
			statementUserTable = connection.prepareStatement("CREATE TABLE " + TABLE_USER + " ("
					+ "id INT NOT NULL AUTO_INCREMENT, "
					+ "username VARCHAR(16) NOT NULL, "
					+ "nickname VARCHAR(16) NOT NULL, "
					+ "password VARCHAR(32) NOT NULL, PRIMARY KEY (id)) ENGINE = InnoDB;");
			statementCommentTable = connection.prepareStatement("CREATE TABLE " + TABLE_COMMENT + " ("
					+ "id INT NOT NULL AUTO_INCREMENT, "
					+ "username VARCHAR(16) NOT NULL, "
					+ "content VARCHAR(256) NOT NULL, "
					+ "father INT NOT NULL, "
					+ "timestamp DATETIME(3) NOT NULL, PRIMARY KEY (id)) ENGINE = InnoDB;");
			
			statementUserGet = connection.prepareStatement("SELECT * FROM " + TABLE_USER
					+ " WHERE username = ?");
			statementUserInsert = connection.prepareStatement("INSERT INTO " + TABLE_USER
					+ " (username, nickname, password) VALUES (?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			statementUserNickname = connection.prepareStatement("UPDATE " + TABLE_USER
					+ " SET nickname = ? WHERE username = ?");
			statementUserPassword = connection.prepareStatement("UPDATE " + TABLE_USER
					+ " SET password = REPLACE (password, ?, ?) WHERE username = ?");
			
			statementCommentGet = connection.prepareStatement("SELECT * FROM " + TABLE_COMMENT
					+ " WHERE id = ?");
			statementCommentInsert = connection.prepareStatement("INSERT INTO " + TABLE_COMMENT
					+ " (username, content, father, timestamp) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			statementCommentGetAll = connection.prepareStatement("SELECT * FROM " + TABLE_COMMENT);
			
			createUserTable();
			createCommentTable();
			
			inited = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	// ================================================================================
	// * Base Functions
	// ================================================================================
	
	public static Connection getConnection() {
		return connection;
	}
	
	public static Timestamp getTimestamp() {
		return new Timestamp(new Date().getTime());
	}
	
	public static boolean haveTable(String table_name) {
		try {
			ResultSet resultSet = connection.getMetaData().getTables(null, null, table_name, null);
			boolean have = resultSet.next();
			resultSet.close();
			return have;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// ================================================================================
	// * Table Check
	// ================================================================================
	
	public static void createUserTable() {
		try {
			if(!haveTable(TABLE_USER)){
				statementUserTable.executeLargeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void createCommentTable() {
		try {
			if(!haveTable(TABLE_COMMENT)){
				statementCommentTable.executeLargeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// ================================================================================
	// * Table User
	// ================================================================================
	
	public static boolean haveUser(String username) {
		try {
			statementUserGet.setString(1, username);
			ResultSet resultSet = statementUserGet.executeQuery();
			boolean have = resultSet.next();
			resultSet.close();
			return have;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static ResultSet getUser(String username) {
		try {
			statementUserGet.setString(1, username);
			return statementUserGet.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Current user already exist.
	 */
	public static int insertUser(String username, String password) {
		return insertUser(username, username, password);
	}
	public static int insertUser(String username, String nickname, String password) {
		try {
			statementUserInsert.setString(1, username);
			statementUserInsert.setString(2, nickname);
			statementUserInsert.setString(3, password);
			statementUserInsert.executeUpdate();
			ResultSet resultSet = statementUserInsert.getGeneratedKeys(); 
			if(resultSet.next()) {
				resultSet.close();
				return 0;
			}else {
				resultSet.close();
				return 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Unknown user.
	 * 2: Invalid old password.
	 */
	public static int resetPassword(String username, String oldPassword, String newPassword) {
		try {
			if(!haveUser(username)) {
				return 1;
			} else {
				ResultSet resultSet = getUser(username);
				resultSet.next();
				if(!resultSet.getString("password").equals(oldPassword)) {
					resultSet.close();
					return 2;
				}else {
					resultSet.close();
					statementUserPassword.setString(1, oldPassword);
					statementUserPassword.setString(2, newPassword);
					statementUserPassword.setString(3, username);
					return 1 - statementUserPassword.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Unknown user.
	 */
	public static int updatePassword(String username, String password) {
		try {
			if(!haveUser(username)) {
				return 1;
			} else {
				ResultSet resultSet = getUser(username);
				resultSet.next();
				int callback = resetPassword(username, resultSet.getString("password"), password);
				resultSet.close();
				return callback;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Unknown user.
	 */
	public static int updateNickname(String username, String nickname) {
		try {
			if(!haveUser(username)) {
				return 1;
			} else {
				statementUserNickname.setString(1, nickname);
				statementUserNickname.setString(2, username);
				return 1 - statementUserNickname.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Unknown user.
	 * 2: Invalid password.
	 */
	public static int checkLogin(String username, String password) {
		try {
			if(!haveUser(username)) {
				return 1;
			} else {
				ResultSet resultSet = getUser(username);
				resultSet.next();
				if(resultSet.getString("password").equals(password)) {
					resultSet.close();
					return 0;
				}else {
					resultSet.close();
					return 2;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	public static String getUserNickname(String username) {
		try {
			if(!haveUser(username)) {
				return null;
			} else {
				ResultSet resultSet = getUser(username);
				resultSet.next();
				String nickname = resultSet.getString("nickname");
				resultSet.close();
				return nickname;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// ================================================================================
	// * Table Comment
	// ================================================================================
	
	public static boolean haveComment(int comment_id) {
		try {
			statementCommentGet.setInt(1, comment_id);
			ResultSet resultSet = statementCommentGet.executeQuery();
			boolean have = resultSet.next();
			resultSet.close();
			return have;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static ResultSet getComment(int comment_id) {
		try {
			statementCommentGet.setInt(1, comment_id);
			return statementCommentGet.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * @return
	 * 0: Success 
	 * 1: Current Comment already exist.
	 */
	public static int insertComment(String username, String content, int father, Timestamp timestamp) {
		try {
			statementCommentInsert.setString(1, username);
			statementCommentInsert.setString(2, content);
			statementCommentInsert.setInt(3, father);
			statementCommentInsert.setTimestamp(4, timestamp);
			statementCommentInsert.executeUpdate();
			ResultSet resultSet = statementCommentInsert.getGeneratedKeys(); 
			if(resultSet.next()) {
				resultSet.close();
				return 0;
			}else {
				resultSet.close();
				return 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 1;
		}
	}
	
	public static ArrayList<Comment> getAllComment() {
		try {
			ResultSet resultSet = statementCommentGetAll.executeQuery();
			ArrayList<Comment> data = new ArrayList<Comment>();
			while (resultSet.next()) {
				data.add(new Comment(resultSet.getInt("id"), resultSet.getString("username"), resultSet.getString("content"), resultSet.getInt("father"), resultSet.getTimestamp("timestamp")));
			}
			resultSet.close();
			for (Comment comment : data) {
				if(comment.haveFather()) {
					comment.getSuperFatherComment(data).addChild(comment);
				}
			}
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
