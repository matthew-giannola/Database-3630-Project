package JDBC;
import java.sql.*; // step 1
// database is called 'DBProject'


/*
 * 1. Import Java SQL
 * 2. Load and register the driver --> com.mysql.jdbc.Driver(connector)
 * 3. Creation connection --> connection
 * 4. Create a statement --> statement
 * 5. execute the query
 * 6. Process the result.
 * 7. close the connection
 *
 */

// TO-DO: 1. Create DB with SQL file and connect with database
// 2. Manually add into the tables the combos, they are constants, wont ever change. 1 hot dog is always $3.50, etc.

public class JavaDBConnection {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:mysql://localhost:3306/final";
        String username = "root";
        String password = "";
        // This will load mySql driver
        Class.forName("com.mysql.cj.jdbc.Driver"); // step 2
        // com.mysql.jdbc.Driver is deprecated, must use com.mysql.cj.jdbc.Driver

        // Set up connection with mySql database
        Connection conn = DriverManager.getConnection(url, username, password); // step 3
        // id, salary, emplyee rank, employee schedule, employee hisory, employee name
        // FK = employee rank, salary, schedule, history-employement...
        //String sql = "INSERT INTO employees VALUES(100, 1, 1, 1, 1, 'bob', 1)";
        String sql = "INSERT INTO salaries VALUES(100, 1000)";
        PreparedStatement ps = conn.prepareStatement(sql);
        int count = ps.executeUpdate();
       if(count != 0)
       {
           System.out.println("database connection done");
           System.out.println("record was inserted");
       }
       ps.close();
       conn.close();
    }


    void update(String str)
    {
        if(isInteger(str)) // string can be converted to an int
        {

        }
        else // string cannot be converted to int
        {

        }
    }

    public boolean isInteger( String input )
    {
        try
        {
            Integer.parseInt( input );
            return true;
        }
        catch( Exception e ) {
            return false;
        }
    }

}
