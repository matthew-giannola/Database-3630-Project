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
                    if(comboBox.getSelectedItem() == comboBox.getItemAt(1))
                    {
                        JOptionPane.showMessageDialog(null, "Please select an option from the dropdown menu.");
                    }

                    else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select employees
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

                if(comboBox.getSelectedItem() == comboBox.getItemAt(1)) // select employees
                {
                    /* TextField1 = ID (int)
                     *  TextField2 = Name (string)
                     *  TextField3 = Employee Rank (string), check sql table for codes
                     *  TextField4 = Salary (int)
                     *  TextField5 = Shift start time
                     *  TextField6 = Shift end time */

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
                        PreparedStatement salaryInsert = conn.prepareStatement(insertSalariesTbl);
                        salaryInsert.executeUpdate(insertSalariesTbl);


                        // Insert shift start and end time in schedules table
                        PreparedStatement insertShiftTime = conn.prepareStatement(insertShiftTbl);
                        insertShiftTime.executeUpdate(insertShiftTbl);

                        // Insert current date into employment history table to mark the employee being hired
                        // since they are being added to system currently
                        PreparedStatement insertEmployeeHist = conn.prepareStatement(insertEmpHistory);
                        insertEmployeeHist.executeUpdate(insertEmpHistory);


                        // Insert employee into employee table
                        PreparedStatement insertEmployee = conn.prepareStatement(insertEmployeesTable);
                        insertEmployee.executeUpdate(insertEmployeesTable);


                        if(Integer.parseInt(employeeRank) == 1) // added a Manager
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Manager with an ID of " + id
                                    + "! " + name + " will have a salary of $" + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 2) // added a Cook
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Cook with an ID of " + id
                                    + "! " + name + " will have a salary of $" + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 3) // added a cashier
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Cashier with an ID of " + id
                                    + "! " + name + " will have a salary of $" + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(employeeRank) == 4) // add a Server
                        {
                            txtPaneOutput.setText(name + " was successfully added to the system as a Server with an ID of " + id
                                    + "! " + name + " will have a salary of $" + salary + " and will have their shift start from "
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

                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select customers
                {
                    /* TextField1 = ID (int)
                     *  TextField2 = Name (string)
                     *  TextField3 = Payment type (String)
                     *  TextField4 = Combo ID (int)
                     *  TextField5 = Combo Quantity (int)
                     */

                    // id, salary, employee rank, employee schedule, employee history, employee name
                    // FK = employee rank, salary, schedule, history-employement...
                    String id = textField1.getText();
                    String name = textField2.getText();
                    String paymentType = textField3.getText();
                    String comboID = textField4.getText();
                    String comboQuantity = textField5.getText();

                    // customer table takes in: id, name, payment type
                    String insertCustomersTable = "INSERT INTO customers VALUES(" + Integer.parseInt(id) +
                            ", '" + name + "', '" + paymentType + "');";



                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);
                        Statement stmt = conn.createStatement();

                        // Insert id, name, payment type
                        PreparedStatement customerInsert = conn.prepareStatement(insertCustomersTable);
                        customerInsert.executeUpdate(insertCustomersTable);



                        ResultSet rs = stmt.executeQuery("SELECT combo_cost FROM combos WHERE id = " + Integer.parseInt(comboID));
                        ResultSetMetaData rs_md = rs.getMetaData();
                        StringBuilder combo_cost = new StringBuilder();

                        while(rs.next())
                        {
                            for (int i = 1; i <= rs_md.getColumnCount(); i++)
                            {
                                combo_cost.append(rs.getString(rs_md.getColumnName(i)));
                            }
                        }
                        rs.close();

                        ResultSet rsName = stmt.executeQuery("SELECT combos_name FROM combos WHERE id = " + Integer.parseInt(comboID));
                        ResultSetMetaData rs_mdName = rsName.getMetaData();
                        StringBuilder combo_Name = new StringBuilder();

                        while(rsName.next())
                        {
                            for (int i = 1; i <= rs_mdName.getColumnCount(); i++)
                            {
                                combo_Name.append(rsName.getString(rs_mdName.getColumnName(i)));

                            }
                        }
                        rsName.close();
                        String comboID_name = combo_Name.toString();


                        double comboID_cost = Double.parseDouble(combo_cost.toString());
                        double orderTotal = comboID_cost * Double.parseDouble(comboQuantity);


                        // orders table takes in: id, total_cost, customer id, combo quantity
                        String insertOrdersTable = "INSERT INTO orders VALUES(" + Integer.parseInt(id) +
                                ", " + orderTotal + ", " + Integer.parseInt(id) + ", " + Integer.parseInt(comboQuantity) + ");";


                        PreparedStatement ordersInsert = conn.prepareStatement(insertCustomersTable);
                        ordersInsert.executeUpdate(insertOrdersTable);


                        txtPaneOutput.setText(name + " has ordered successfully by paying with " + paymentType + "\n" +
                                "They ordered " + comboQuantity + " " + comboID_name + " at a cost of $" + comboID_cost + " each. \n" +
                                "This means that the total price is $" + orderTotal);

                    }
                    catch(Exception ee){
                        JOptionPane.showMessageDialog(null, ee);
                    }

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
                if(comboBox.getSelectedItem() == comboBox.getItemAt(1))
                {

                    String idText = textField1.getText();
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection(url, username, password);
                            String queryCheck = "SELECT id from Employees WHERE id = " + idText;
                            String salaryDelete = "DELETE FROM salaries where id = " + idText;
                            String employeeDelete = "DELETE FROM Employees WHERE id = " + idText;
                            String scheduleDelete = "DELETE FROM Schedules WHERE id = " + idText;
                            String empHistoryDelete = "DELETE FROM Employment_history WHERE id = " + idText;
                            PreparedStatement checkEmployee = conn.prepareStatement(queryCheck);
                            if(checkEmployee.executeQuery().next())
                            {
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT employee_name FROM Employees WHERE id = " + Integer.parseInt(idText));
                                ResultSetMetaData rs_md = rs.getMetaData();
                                StringBuilder employeeBuilder = new StringBuilder();
                                while(rs.next())
                                {
                                    for (int i = 1; i <= rs_md.getColumnCount(); i++)
                                    {
                                        employeeBuilder.append(rs.getString(rs_md.getColumnName(i)));
                                    }
                                }
                                txtPaneOutput.setText(employeeBuilder.toString() +
                                        " and all their data was deleted from the database.");

                                PreparedStatement deleteSalary = conn.prepareStatement(salaryDelete);
                                deleteSalary.executeUpdate(salaryDelete);

                                PreparedStatement deleteEmployee = conn.prepareStatement(employeeDelete);
                                deleteEmployee.executeUpdate(employeeDelete);

                                PreparedStatement deleteSchedule = conn.prepareStatement(scheduleDelete);
                                deleteSchedule.executeUpdate(scheduleDelete);

                                PreparedStatement deleteHistory = conn.prepareStatement(empHistoryDelete);
                                deleteHistory.executeUpdate(empHistoryDelete);
                                rs.close();
                            }
                            else
                            {
                                JOptionPane.showMessageDialog(null,
                                        "There is no employee in the database with an ID of " + idText.toString());
                            }
                            conn.close();
                        } catch (SQLException | ClassNotFoundException throwables) {
                            JOptionPane.showMessageDialog(null, "Error encountered");
                        }
                }
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2))
                {
                    String idText = textField1.getText();
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection(url, username, password);
                            String queryCheck = "SELECT id from customers WHERE id = " + idText;
                            String customerDelete = "DELETE FROM customers where id = " + idText;
                            String delete = "DELETE FROM orders WHERE id = " + idText;
                            PreparedStatement checkEmployee = conn.prepareStatement(queryCheck);
                            if(checkEmployee.executeQuery().next())
                            {
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT name FROM Customers WHERE id = " + Integer.parseInt(idText));
                                ResultSetMetaData rs_md = rs.getMetaData();
                                StringBuilder customerBuilder = new StringBuilder();
                                while(rs.next())
                                {
                                    for (int i = 1; i <= rs_md.getColumnCount(); i++)
                                    {
                                        customerBuilder.append(rs.getString(rs_md.getColumnName(i)));

                                    }
                                }
                                txtPaneOutput.setText(customerBuilder.toString() +
                                        " and all their data was deleted from the database.");
                                PreparedStatement deleteOrder = conn.prepareStatement(delete);
                                deleteOrder.executeUpdate(delete);
                                PreparedStatement deleteCustomer = conn.prepareStatement(customerDelete);
                                deleteCustomer.executeUpdate(customerDelete);
                                rs.close();
                            }
                            else
                            {
                                JOptionPane.showMessageDialog(null,
                                        "There is no customer in the database with an ID of " + idText.toString());
                            }
                            conn.close();

                        } catch (SQLException | ClassNotFoundException throwables) {
                            JOptionPane.showMessageDialog(null, "Error encountered");
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
                String id = textField1.getText();
                String name = textField2.getText();
                String rank = textField3.getText();
                String salary = textField4.getText();
                String shiftStartTime = textField5.getText();
                String shiftEndTime = textField6.getText();

                // tables to update, salaries, schedules, employement history, employees


                if(comboBox.getSelectedItem() == comboBox.getItemAt(1)) // employees
                {
                    String sqlUpdateSchedule = "UPDATE schedules SET next_shift_start = '" + shiftStartTime +
                            "', next_shift_end = '" + shiftEndTime + "' WHERE id = " + Integer.parseInt(id)
                            + ";";

                    String sqlUpdateSalary = "UPDATE salaries SET salary = " + Integer.parseInt(salary) +
                            " WHERE id = " + Integer.parseInt(id) + ";";

                    String sqlUpdateEmployees = "UPDATE employees SET employee_rank = " + Integer.parseInt(rank)
                            +
                            ", employee_name = '" + name + "' WHERE id = " + Integer.parseInt(id) + ";";
                    // since salary and shift are foreign keys, employees table should update, nothing else is needed


                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);


                        PreparedStatement salaryUpdate = conn.prepareStatement(sqlUpdateSalary);
                        salaryUpdate.executeUpdate(sqlUpdateSalary);

                        PreparedStatement schedulesUpdate = conn.prepareStatement(sqlUpdateSchedule);
                        schedulesUpdate.executeUpdate(sqlUpdateSchedule);

                        PreparedStatement employeeUpdate = conn.prepareStatement(sqlUpdateEmployees);
                        employeeUpdate.executeUpdate(sqlUpdateEmployees);

                        if(Integer.parseInt(rank) == 1) // added a Manager
                        {
                            txtPaneOutput.setText("The ID " + id + " has been updated. "
                                     + name + " will have the position of Manager and have a salary of $"
                                    + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(rank) == 2) // added a Cook
                        {
                            txtPaneOutput.setText("The ID " + id + " has been updated. "
                                    + name + " will have the position of Cook and have a salary of $"
                                    + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(rank) == 3) // added a cashier
                        {
                            txtPaneOutput.setText("The ID " + id + " has been updated. "
                                    + name + " will have the position of Cashier and have a salary of $"
                                    + salary + " and will have their shift start from "
                                    + shiftStartTime + " to " + shiftEndTime);
                        }
                        else if(Integer.parseInt(rank) == 4) // add a Server
                        {
                            txtPaneOutput.setText("The ID " + id + " has been updated. "
                                    + name + " will have the position of Server and have a salary of $"
                                    + salary + " and will have their shift start from "
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
                    catch (Exception ex)
                    {
                        JOptionPane.showMessageDialog(null, "Error encountered.");
                    }


                }
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // customers
                {

                }



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
