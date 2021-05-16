/*TO DO BEFORE PASSING CODE:
* 1. Delete password or error will encountered
* 2. */

package JDBC;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.Objects;

import static javax.swing.WindowConstants.DISPOSE_ON_CLOSE;

public class GUI {
    private JPanel panelMain;
    private JComboBox<String> comboBox;
    private JButton selectBtn;
    private JButton insertButton;
    private JButton deleteButton;
    private JButton updateButton;
    private JTextField textField1;
    private JTextField textField2;
    private JTextField textField3;
    private JTextField textField4;
    private JTextField textField5;
    private JTextField textField6;
    private JTextPane txtPaneOutput;

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
    public GUI() throws Exception {
        String url = "jdbc:mysql://localhost:3306/final";
        String username = "root";
        String password = ""; // Insert your password here

        comboBox.addItem("None");
        comboBox.addItem("Employees");
        comboBox.addItem("Customers");
        comboBox.addItem("Employee To Order");

        selectBtn.setEnabled(false);
        insertButton.setEnabled(false);
        updateButton.setEnabled(false);
        deleteButton.setEnabled(false);

        comboBox.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {
                if(comboBox.getSelectedItem() == comboBox.getItemAt(1)) // select employees
                {
                    selectBtn.setEnabled(true);
                    insertButton.setEnabled(true);
                    updateButton.setEnabled(true);
                    deleteButton.setEnabled(true);

                    textField1.setEnabled(true);
                    textField1.setText("Insert ID (ex: 10)");
                    textField2.setEnabled(true);
                    textField2.setText("Insert name (ex: Bob)");
                    textField3.setEnabled(true);
                    textField3.setText("Insert employee rank (ex: 2)");
                    textField4.setEnabled(true);
                    textField4.setText("Insert salary (ex: 35000)");
                    textField5.setEnabled(true);
                    textField5.setText("Insert shift start time (ex: 2pm)");
                    textField6.setEnabled(true);
                    textField6.setText("Insert shift end time (ex: 10pm)");
                }
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select customers
                {
                    selectBtn.setEnabled(true);
                    insertButton.setEnabled(true);
                    updateButton.setEnabled(true);
                    deleteButton.setEnabled(true);

                    textField1.setEnabled(true);
                    textField1.setText("Insert customer ID");
                    textField2.setEnabled(true);
                    textField2.setText("Insert customer name");
                    textField3.setEnabled(true);
                    textField3.setText("Insert customer payment type");
                    textField4.setEnabled(true);
                    textField4.setText("Insert combo ID"); // used to get combo price, where price*quantity = total $
                    textField5.setEnabled(true);
                    textField5.setText("Insert combo quantity");
                    textField6.setEnabled(false);
                    textField6.setText("");
                }
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(3)) // select items
                {
                    selectBtn.setEnabled(true);
                    insertButton.setEnabled(true);
                    updateButton.setEnabled(true);
                    deleteButton.setEnabled(true);

                    textField1.setEnabled(true);
                    textField1.setText("Insert employee ID (ex: 10)");
                    textField2.setEnabled(true);
                    textField2.setText("Insert Order ID (ex: 12)");
                    textField3.setEnabled(false);
                    textField3.setText("");
                    textField4.setEnabled(false);
                    textField4.setText("");
                    textField5.setEnabled(false);
                    textField5.setText("");
                    textField6.setEnabled(false);
                    textField6.setText("");
                }
                else
                {
                    textField1.setEnabled(false);
                    textField1.setText("");
                    textField2.setEnabled(false);
                    textField2.setText("");
                    textField3.setEnabled(false);
                    textField3.setText("");
                    textField4.setEnabled(false);
                    textField4.setText("");
                    textField5.setEnabled(false);
                    textField5.setText("");
                    textField6.setEnabled(false);
                    textField6.setText("");

                    // Disable Buttons
                    selectBtn.setEnabled(false);
                    insertButton.setEnabled(false);
                    updateButton.setEnabled(false);
                    deleteButton.setEnabled(false);
                    JOptionPane.showMessageDialog(null, "Error encountered.");
                }
            }
        });


        selectBtn.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement stmt = conn.createStatement();
                    if(comboBox.getSelectedItem() == comboBox.getItemAt(1) ||
                            comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select employees
                    {
                        String input = textField1.getText();
                        String table = Objects.requireNonNull(comboBox.getSelectedItem()).toString();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM " + table + " WHERE id = " + input);
                        ResultSetMetaData rs_md = rs.getMetaData();

                        StringBuilder text = new StringBuilder();
                        while(rs.next())
                        {
                            for (int i = 1; i <= rs_md.getColumnCount(); i++)
                            {
                                text.append(rs_md.getColumnName(i))
                                        .append(": ")
                                        .append(rs.getString(rs_md.getColumnName(i)))
                                        .append(" ");
                            }
                            text.append("\n");
                        }
                        JOptionPane.showMessageDialog(null, text);
                    }
                    else if(comboBox.getSelectedItem() == comboBox.getItemAt(3)) // select employees
                    {
                        String input = textField1.getText();
                        String table = Objects.requireNonNull(comboBox.getSelectedItem()).toString();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM employees_has_orders WHERE employees_id = " + input);
                        ResultSetMetaData rs_md = rs.getMetaData();

                        StringBuilder text = new StringBuilder();
                        while(rs.next())
                        {
                            for (int i = 1; i <= rs_md.getColumnCount(); i++)
                            {
                                text.append(rs_md.getColumnName(i))
                                        .append(": ")
                                        .append(rs.getString(rs_md.getColumnName(i)))
                                        .append(" ");
                            }
                            text.append("\n");
                        }
                        JOptionPane.showMessageDialog(null, text);
                    }

                    conn.close();
                }
                catch (SQLException | ClassNotFoundException throwable)
                {
                    JOptionPane.showMessageDialog(null, "Please Enter a ID To Select");
                }
            }
        });

        insertButton.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {

                if(comboBox.getSelectedItem() == comboBox.getItemAt(0)) // select employees
                {
                    /* TextField1 = ID (int)
                     *  TextField2 = Name (string)
                     *  TextField3 = Employee Rank (string), check sql table for codes
                     *  TextField4 = Salary (int)
                     *  TextField5 = Shift start time
                     *  TextField6 = Shift end time */

                    // TO-DO: have to check if id exists and stop inserting if it does

                    // id, salary, employee rank, employee schedule, employee history, employee name
                    // FK = employee rank, salary, schedule, history-employement...
                    String id = textField1.getText();
                    String name = textField2.getText();
                    String employeeRank = textField3.getText();
                    String salary = textField4.getText();
                    String shiftStartTime = textField5.getText();
                    String shiftEndTime = textField6.getText();

                    // values: id, salary
                    String insertSalariesTbl = "INSERT INTO salaries VALUES(" + Integer.parseInt(id) +
                            ", " + Integer.parseInt(salary) + ")";

                    // insert into shift start time, end time
                    String insertShiftTbl = "INSERT INTO schedules VALUES(" + Integer.parseInt(id)+ ", '" +
                            shiftStartTime + "', '" + shiftEndTime + "');";

                    // insert employment table
                    String insertEmpHistory = "INSERT INTO employment_history VALUES(" + Integer.parseInt(id)+
                            ", NOW());";

                    // Insertion into employees looks something like this (this is an example only)
                    String sql = "INSERT INTO employees VALUES(100, 1, 1, 1, 1, 'bob', 1)";
                    // insert into employee
                    /* Employee rank system for the integers:
                        1 - Manager
                        2 - Food service worker
                        3 - Cashier
                    */
                    // values: id, salary(fk), employee rank(fk), employee schedule(fk), employee history(fk), employee name
                    String insertEmployeesTable = "INSERT INTO employees VALUES(" + Integer.parseInt(id) + // id
                            ", " + Integer.parseInt(id) + // salary id
                            ", " + Integer.parseInt(employeeRank) + // employee rank id, refer to chart
                            ", " + Integer.parseInt(id) + // employee schedule id
                            ", " + Integer.parseInt(id) + // employee history id
                            ", '" + name + "');"; // employee name




                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);

                        // Insert id, salary into salaries table
                        PreparedStatement salaryInsert = conn.prepareStatement(sql);
                        salaryInsert.executeUpdate(insertSalariesTbl);


                        // Insert shift start and end time in schedules table
                        PreparedStatement insertShiftTime = conn.prepareStatement(sql);
                        insertShiftTime.executeUpdate(insertShiftTbl);

                        // Insert current date into employment history table to mark the employee being hired
                        // since they are being added to system currently
                        PreparedStatement insertEmployeeHist = conn.prepareStatement(sql);
                        insertEmployeeHist.executeUpdate(insertEmpHistory);


                        // Insert employee into employee table
                        PreparedStatement insertEmployee = conn.prepareStatement(sql);
                        insertEmployee.executeUpdate(insertEmployeesTable);


                        if(Integer.parseInt(employeeRank) == 1) // added a Manager
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Manager with an ID of " + id
                                    + "! " + name + " will have a salary of " + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 2) // added a Cook
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Cook with an ID of " + id
                                    + "! " + name + " will have a salary of " + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 3) // added a cashier
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Cashier with an ID of " + id
                                    + "! " + name + " will have a salary of " + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 4) // add a Server
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Server with an ID of " + id
                                    + "! " + name + " will have a salary of " + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else
                        {
                            txtPaneOutput.setText("Uh oh! Looks like an error was encountered, did you assign the correct employee rank? \n" +
                                    "1. Manager \n" +
                                    "2. Cook \n" +
                                    "3. Cashier \n" +
                                    "4. Server");
                        }


                    }
                    catch(Exception ee){
                        JOptionPane.showMessageDialog(null, ee);
                    }

                }

                else if(comboBox.getSelectedItem() == comboBox.getItemAt(1)) // select customers
                {

                }

                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select items
                {

                }

                else
                {
                    JOptionPane.showMessageDialog(null, "Error encountered.");
                }
            }

        });

        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e)
            {
                String idText = textField1.getText();
                if(idText.matches("\\d+[^a-zA-z]^[^a-zA-Z0-9]+$")) // check if name exists in the table
                {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);
                        String queryCheck = "SELECT id from Employees WHERE id = " + idText;
                        String salaryDelete = "DELETE FROM salaries where id = " + idText;
                        String delete = "DELETE FROM Employees WHERE id = " + idText;
                        String deleteScheduleSql = "DELETE FROM Schedules WHERE id = " + idText;
                        String deleteHistorysql = "DELETE FROM Employment_history WHERE id = " + idText;
                        PreparedStatement checkEmployee = conn.prepareStatement(queryCheck);
                        if(checkEmployee.executeUpdate(queryCheck) > 0 )
                        {
                            PreparedStatement deleteSalary = conn.prepareStatement(salaryDelete);
                            deleteSalary.executeUpdate(salaryDelete);
                            PreparedStatement deleteEmployee = conn.prepareStatement(delete);
                            deleteEmployee.executeUpdate(delete);
                            PreparedStatement deleteHistory = conn.prepareStatement(deleteScheduleSql);
                            deleteHistory.executeUpdate(delete);
                            PreparedStatement deleteSchedule = conn.prepareStatement(deleteHistorysql);
                            deleteSchedule.executeUpdate(deleteHistorysql);
                            conn.close();
                        }
                        else
                            JOptionPane.showMessageDialog(null, textField1.toString() + "was not found input");
                    } catch (SQLException | ClassNotFoundException throwables) {
                        throwables.printStackTrace();
                    }
                }
                else
                    JOptionPane.showMessageDialog(null, textField1.toString() + "was not an acceptable input");

            }
        });

        updateButton.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {

            }
        });
    }

    public static void main(String[] args) throws Exception {
        JFrame frame = new JFrame("Restaurant Management System");
        frame.setPreferredSize(new Dimension(500, 500));
        frame.setContentPane(new GUI().panelMain);
        frame.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
