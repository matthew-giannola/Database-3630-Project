/*TO DO BEFORE PASSING CODE:
* 1. Delete password or error will encountered
* 2. */

package JDBC;

import com.intellij.openapi.ui.messages.MessageDialog;
import com.intellij.openapi.vcs.actions.ShowMessageHistoryAction;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.sql.*;

public class GUI {
    private JPanel panelMain;
    private JComboBox comboBox;
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


        comboBox.addItem("Employees");
        comboBox.addItem("Customers");
        comboBox.addItem("Items");

        selectBtn.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {
                if(comboBox.getSelectedItem() == comboBox.getItemAt(0)) // select employees
                {
                   textField1.setEnabled(true);
                   textField1.setText("Insert ID");
                   textField2.setEnabled(true);
                   textField2.setText("Insert name");
                   textField3.setEnabled(true);
                   textField3.setText("Insert employee rank");
                   textField4.setEnabled(true);
                   textField4.setText("Insert salary");
                   textField5.setEnabled(true);
                   textField5.setText("Insert shift start time");
                   textField6.setEnabled(true);
                   textField6.setText("Insert shift end time");
                }
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(1)) // select customers
                {
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
                else if(comboBox.getSelectedItem() == comboBox.getItemAt(2)) // select items
                {
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
                    JOptionPane.showMessageDialog(null, "Error encountered.");
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

                    // Insertion into employees looks something like this (this is an example only)
                    String sql = "INSERT INTO employees VALUES(100, 1, 1, 1, 1, 'bob', 1)";

                    String insertSalariesTbl = "INSERT INTO salaries VALUES(" + Integer.parseInt(id) +
                            ", " + Integer.parseInt(salary) + ")";



                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.executeUpdate(insertSalariesTbl);

                        // Delete this later on otherwise we will have too many popups because we need to insert into other
                        // tables too, not just the salary table. This is just here for confirmation that the
                        // insertion worked.
                        JOptionPane.showMessageDialog(null, "Salary insertion done!");

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
              /* if() // check if name exists in the table
               {
                   JOptionPane.showMessageDialog(null, textField1.toString() + " was successfully deleted.");
               }
               else
                {
                   JOptionPane.showMessageDialog(null, textField1.toString() + " was not found in the Database");
                }*/

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
        frame.pack();
        frame.setVisible(true);
    }
}
