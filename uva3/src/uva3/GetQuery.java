package uva3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class GetQuery  {
    // main array for SQLQueryResult
    public static String[][] outDB;

    // JDBC URL, username and password of MySQL server
    private static final String url = "jdbc:mysql://localhost:3306/newdb";
    private static final String user = "admin";
    private static final String password = "password";

    // JDBC variables for opening and managing connection
    private static Connection con;
    private static Statement stmt, Cstmt;
    private static ResultSet rs, Crs;
    private static int Count;
    
    private static String query = "select  p.name as FIO, "+ 
										  "p.sal as Salary, "+
										  "d.name as Department, "+ 
										  "ph.name as Chief, "+
										  "ph.sal as Chief_sal "+		
								  "from department d "+
								  "join personal p on p.id_dep=d.id "+
								  "join personal ph on ph.id=p.id_head "+
								  "where p.sal > ph.sal "+
								  "order by p.sal desc;";
 
    private static String queryCount = "select  count(*) as count "+ 
    									"from department d "+
    									"join personal p on p.id_dep=d.id "+
    									"join personal ph on ph.id=p.id_head "+
    									"where p.sal > ph.sal;";   
    
 public  GetQuery() {    
    try {
       
    	// opening database connection to MySQL server
        con = DriverManager.getConnection(url, user, password);

        // getting Statement object to execute query
        Cstmt = con.createStatement();
        Crs = Cstmt.executeQuery(queryCount);
        while(Crs.next()){
            Count = Crs.getInt("count");
            }
        
        //System.out.printf("Count= %d %n",Count);
        
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);
        String[][] db = new String[5][Count];
        int i=0;
        
        while (rs.next()) {
        		    
        	db[0][i] = rs.getString(1);
        	db[1][i] = rs.getString(2);
        	db[2][i] = rs.getString(3);
        	db[3][i] = rs.getString(4);
        	db[4][i] = rs.getString(5);
           //  System.out.printf("i= %d  - db[0][i] : %s,   db[1][i] : %s, db[2][i] : %s, db[3][i] : %s, db[4][i] : %s   %n", 
 	       // 		               i, db[0][i] ,   db[1][i] , db[2][i] , db[3][i] , db[4][i] );
            i++;	 
        }
        
        outDB=db;
        
        
    } catch (SQLException sqlEx) {
        sqlEx.printStackTrace();
    } finally {
        //close connection ,stmt and resultset here
        try { con.close(); } catch(SQLException se) { /*can't do anything */ }
        try { stmt.close(); } catch(SQLException se) { /*can't do anything */ }
        try { Cstmt.close(); } catch(SQLException se) { /*can't do anything */ }
        try { rs.close(); } catch(SQLException se) { /*can't do anything */ }
        try { Crs.close(); } catch(SQLException se) { /*can't do anything */ }

    }
    
//	return outDB;
  }

}
