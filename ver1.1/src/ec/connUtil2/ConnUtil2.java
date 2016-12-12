package ec.connUtil2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnUtil2 {
   static {
      try {
         String driverName = "com.mysql.jdbc.Driver";
         Class.forName(driverName);
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      }
   }

   public static Connection getConnection() throws SQLException {
      String url = "jdbc:mysql://183.109.81.220:3306/statistics?useSSL=true&verifyServerCertificate=false";
      //String url = "jdbc:mysql://183.109.81.220:3306/ver1";
      String id = "root";
      String password = "ec2017&ss";
      Connection conn = DriverManager.getConnection(url, id, password);
      return conn;
   }

   public static void close(PreparedStatement ps, Connection conn) {
      if (ps != null) {
         try {
            ps.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
      if (conn != null) {
         try {
            conn.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
   }

   public static void close(ResultSet rs, PreparedStatement ps, Connection conn) {
      if (rs != null) {
         try {
            rs.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
      close(ps, conn);
   }
}