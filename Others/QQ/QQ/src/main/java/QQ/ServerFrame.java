package QQ;
/**
 *服务器的控制界面，它实现以下功能：
 * 1、管理上线的用户
 * 2、显示用户登录的时间
 * 3、控制服务器的启动与停止
 */
import java.awt.*;
import java.awt.event.*;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;

import javax.swing.*;
import javax.swing.border.*;

public class ServerFrame extends JFrame implements ActionListener{
    JPanel contentPane;
    JPanel leftPane = new JPanel();
    JPanel rightPane = new JPanel();
    JLabel timeLabel = new JLabel();
    Border border1 = BorderFactory.createLineBorder(UIManager.getColor(
            "ProgressBar.selectionBackground"), 1);
    Border border2 = new TitledBorder(border1, "在线用户列表");
    JPanel jPanel2 = new JPanel();
    JScrollPane jScrollPane1 = new JScrollPane();
    DefaultListModel listModel = new DefaultListModel();
    JList userList = new JList(listModel);
    JLabel jLabel1 = new JLabel();
    JButton lookInfoButton = new JButton();
    JButton jButton2 = new JButton();
    JLabel jLabel2 = new JLabel();
    JLabel userNum = new JLabel();
    JLabel jLabel3 = new JLabel();
    JScrollPane jScrollPane2 = new JScrollPane();
    JTextArea serverInfo = new JTextArea();
    JPanel jPanel1 = new JPanel();
    JButton pauseButton = new JButton();
    JButton exitButton = new JButton();
    BorderLayout borderLayout1 = new BorderLayout();
    BorderLayout borderLayout2 = new BorderLayout();
    GridBagLayout gridBagLayout1 = new GridBagLayout();
    GridBagLayout gridBagLayout2 = new GridBagLayout();
    FlowLayout flowLayout1 = new FlowLayout();


    private Hashtable userTable= new Hashtable();

    DBConnection DBcon = new DBConnection();
    private Connection con = null; //数据库连接对象
    ServerThread serverThread = null;

    public ServerFrame() {
        try {
            //创建数据库连接
            con = DBcon.makeConnection();

            setDefaultCloseOperation(EXIT_ON_CLOSE);
            jbInit();
            serverThread = new ServerThread(serverInfo);
            serverThread.start();

            //下面在标签中动态显示时间
            java.util.Timer myTimer1 = new java.util.Timer();
            java.util.TimerTask task1 = new showTimeTask(timeLabel);
            myTimer1.schedule(task1, 0, 1000);

            java.util.Timer myTimer2 = new java.util.Timer();
            java.util.TimerTask task2 = new LoginUser(listModel,userList,userNum,userTable,con);
            myTimer2.schedule(task2, 0, 10000);//每10秒刷新一次

        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    protected void processWindowEvent(WindowEvent e){
        if(e.getID() == WindowEvent.WINDOW_CLOSING){
            int option = JOptionPane.showConfirmDialog(this,"你确定要退出么？");
            if(option == JOptionPane.YES_OPTION){
                DBcon.closeConnection();//关闭数据库连接对象
                Server.DBcon.closeConnection();//关闭服务器线程的数据库连接
                System.exit(0);
            }
        }
    }

    private void jbInit() throws Exception {
        contentPane = (JPanel) getContentPane();
        contentPane.setLayout(gridBagLayout1);
        setSize(new Dimension(640, 475));
        setTitle("MyQQ服务器控制界面");
        leftPane.setBorder(BorderFactory.createEtchedBorder());
        leftPane.setPreferredSize(new Dimension(192, 150));
        leftPane.setLayout(borderLayout1);
        rightPane.setLayout(borderLayout2);
        timeLabel.setBorder(null);
        timeLabel.setHorizontalAlignment(SwingConstants.RIGHT);
        timeLabel.setText("jLabel1");
        jPanel2.setLayout(gridBagLayout2);
        jLabel1.setMaximumSize(new Dimension(72, 50));
        jLabel1.setPreferredSize(new Dimension(72, 25));
        jLabel1.setHorizontalAlignment(SwingConstants.CENTER);
        jLabel1.setText("在线用户列表(10秒刷新一次)");
        lookInfoButton.setText("查看信息");
        lookInfoButton.addActionListener(this);
        jButton2.setText("踢出");
        jButton2.addActionListener(this);
        jLabel2.setHorizontalAlignment(SwingConstants.RIGHT);
        jLabel2.setText("在线人数：");
        jLabel3.setBorder(null);
        jLabel3.setMaximumSize(new Dimension(100, 50));
        jLabel3.setMinimumSize(new Dimension(100, 25));
        jLabel3.setPreferredSize(new Dimension(100, 25));
        jLabel3.setText("    服务器日志：");
        serverInfo.setEditable(false);
        pauseButton.setText("暂停服务");
        pauseButton.addActionListener(this);
        exitButton.setText("退出");
        exitButton.addActionListener(this);
        jPanel2.setBorder(null);
        jPanel1.setBorder(null);
        jPanel1.setLayout(flowLayout1);
        rightPane.setBorder(BorderFactory.createEtchedBorder());
        flowLayout1.setHgap(30);
        jScrollPane1.getViewport().add(userList);
        jScrollPane2.getViewport().add(serverInfo);
        jPanel1.add(pauseButton);
        jPanel1.add(exitButton);
        leftPane.add(jLabel1, java.awt.BorderLayout.NORTH);
        leftPane.add(jScrollPane1, java.awt.BorderLayout.CENTER);
        leftPane.add(jPanel2, java.awt.BorderLayout.SOUTH);
        rightPane.add(jLabel3, java.awt.BorderLayout.NORTH);
        rightPane.add(jScrollPane2, java.awt.BorderLayout.CENTER);
        rightPane.add(jPanel1, java.awt.BorderLayout.SOUTH);
        jPanel2.add(jLabel2, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
                , GridBagConstraints.WEST, GridBagConstraints.NONE,
                new Insets(9, 9, 0, 0), 20, 12));
        jPanel2.add(userNum, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
                , GridBagConstraints.WEST, GridBagConstraints.NONE,
                new Insets(10, 23, 0, 22), 19, 9));
        jPanel2.add(lookInfoButton, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
                , GridBagConstraints.CENTER, GridBagConstraints.NONE,
                new Insets(13, 9, 0, 0), 0, 0));
        jPanel2.add(jButton2, new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
                , GridBagConstraints.CENTER, GridBagConstraints.NONE,
                new Insets(13, 18, 0, 7), 24, 0));
        contentPane.add(rightPane, new GridBagConstraints(1, 0, 1, 1, 0.7, 0.9
                , GridBagConstraints.CENTER, GridBagConstraints.BOTH,
                new Insets(0, 0, 0, 0), 300, 334));
        contentPane.add(leftPane, new GridBagConstraints(0, 0, 1, 1, 0.3, 0.9
                , GridBagConstraints.CENTER, GridBagConstraints.BOTH,
                new Insets(0, 0, 0, 0), 10, 186));
        contentPane.add(timeLabel, new GridBagConstraints(0, 1, 2, 1, 1.0, 0.1
                , GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL,
                new Insets(0, 0, 0, 0), 570, 9));
    }

    public void removeUser(int QQNUM){
        String sql = "UPDATE USER_INFO SET STATUS = 0 WHERE QQNUM = "+ QQNUM;
        try {
            Statement stmt = con.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void lookInfoButton_actionPerformed(ActionEvent e) {
        String selectedUser = null;
        Integer QQNUM = null;
        selectedUser = (String)userList.getSelectedValue();
        if(selectedUser == null){
            JOptionPane.showMessageDialog(this,"请单击鼠标选择一个用户！");
        }else{
            System.out.println(selectedUser);
            QQNUM = new Integer(selectedUser.substring(selectedUser.indexOf("[") + 1,
                selectedUser.indexOf("]")));
            //根据好友的QQ号查找好友的信息类
            UserInfoBean user = (UserInfoBean)userTable.get(QQNUM);
            UserInfo userInfo = new UserInfo(this,"用户的基本信息",true,user);
            SetCenter.setDialogCenter(this,userInfo);
            userInfo.setVisible(true);
        }
    }

    public void jButton2_actionPerformed(ActionEvent e) {
        int index = userList.getSelectedIndex();
        Integer QQNUM = null;
        if(index == -1){
            JOptionPane.showMessageDialog(this,"请单击鼠标选择一个用户！");
        }else{
            String userInfo = (String)listModel.getElementAt(index);
            QQNUM = new Integer(userInfo.substring(userInfo.indexOf("[") + 1,
                userInfo.indexOf("]")));
            removeUser(QQNUM);
            listModel.remove(index);
            int num = Integer.parseInt(userNum.getText())-1;
            userNum.setText(new Integer(num).toString());
        }
    }

    public void pauseButton_actionPerformed(ActionEvent e) {
        String command = e.getActionCommand();
        if(command.equals("暂停服务")){
            serverThread.pauseThread();
            pauseButton.setText("恢复服务");
        }else if(command.equals("恢复服务")){
            serverThread.reStartThread();
            pauseButton.setText("暂停服务");
        }
    }

    public void exitButton_actionPerformed(ActionEvent e) {
        int option = JOptionPane.showConfirmDialog(this,"你确定要退出么？");
        if(option == JOptionPane.YES_OPTION){
            DBcon.closeConnection();//关闭数据库连接对象
            System.exit(0);
            }
    }
    
    public void actionPerformed(ActionEvent e){
       if (e.getSource() == pauseButton)
          pauseButton_actionPerformed(e);
       else if (e.getSource() == exitButton)
          exitButton_actionPerformed(e);
       else if (e.getSource() == jButton2)
          jButton2_actionPerformed(e);
       else if (e.getSource() == lookInfoButton)
          lookInfoButton_actionPerformed(e);
    }
}
