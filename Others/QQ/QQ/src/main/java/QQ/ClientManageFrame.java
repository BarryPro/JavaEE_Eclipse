package QQ;
import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

import com.borland.jbcl.layout.*;

import java.io.*;
import java.net.*;
import java.util.*;
import java.awt.BorderLayout;
import javax.swing.border.Border;
import java.awt.Font;

public class ClientManageFrame extends JFrame implements Runnable, ActionListener {
    JPanel mainPane = new JPanel();
    JPanel buttonPane = new JPanel();
    JPanel labelPane = new JPanel();
    XYLayout xYLayout2 = new XYLayout();
    JLabel infoLabel = new JLabel();
    JPanel userListPane = new JPanel();
    JButton find = new JButton();
    JButton update = new JButton();
    JButton deleteFriend = new JButton();
    JButton addFriend = new JButton();
    JButton exit = new JButton();
    JScrollPane jScrollPane1 = new JScrollPane();
    BorderLayout borderLayout1 = new BorderLayout();
    DefaultListModel listModel = new DefaultListModel();
    JList userList = new JList(listModel);
    JMenuBar jMenuBar1 = new JMenuBar();
    JMenu jMenu1 = new JMenu();
    JMenu jMenu2 = new JMenu();
    JMenuItem jMenuItem1 = new JMenuItem();
    JMenuItem jMenuItem2 = new JMenuItem();
    JMenuItem jMenuItem3 = new JMenuItem();
    JMenuItem jMenuItem4 = new JMenuItem();
    JMenuItem jMenuItem6 = new JMenuItem();
    JMenuItem jMenuItem7 = new JMenuItem();
    JPopupMenu jPopupMenu1 = new JPopupMenu();
    JMenuItem jMenuItem8 = new JMenuItem();
    JMenuItem jMenuItem9 = new JMenuItem();
    JMenuItem jMenuItem10 = new JMenuItem();
    XYLayout xYLayout1 = new XYLayout();
    XYLayout xYLayout3 = new XYLayout();
    XYLayout xYLayout4 = new XYLayout();

    //创建用于存储好友信息的哈希表
    private Hashtable friendInfoTable = new Hashtable();
    private Socket socket = null; //定义套接口
    private DataInputStream in = null; //定义输入流
    private DataOutputStream out = null; //定义输出流
    private int QQNUM = 0; //用户的QQ号
    private String PASSWORD = null; //用户的密码
    //以下四个变量用于存储监听鼠标移动事件所获得的信息
    private int currentIndex = 0; //鼠标所指的列表索引
    private String currentInfo = ""; //鼠标所指的列表值
    private Integer currentQQNUM = null; //鼠标所指好友的QQ号码
    private UserInfoBean currentFriend = null; //鼠标所指好友的信息类
    private UserInfoBean myInfo = new UserInfoBean(); //存储自己的信息
    //存储查找到的用户的基本信息
    UserInfoBean findUserBean = new UserInfoBean();

    Login login = null;

    InetAddress logAddress = null; //服务器IP
    int serverPort = 0; //服务器端口

    int udpPort = getPort("udp.Port"); //从文件中获取UDP的初始端口号

    int usePort = getNextPort(udpPort);//当前用户使用的端口号

    //声明接收信息的数据报套结字
    private DatagramSocket receiveSocket = null;
    //声明接收信息的数据包
    private DatagramPacket receivePacket = null;

    //缓冲数组的大小
    public static final int BUFFER_SIZE = 5120;

    private byte inBuf[] = null; //接收数据的缓冲数组

    JLabel ownPic = new JLabel();
    JLabel ownInfo = new JLabel();
    Border border1 = BorderFactory.createLineBorder(UIManager.getColor(
            "InternalFrame.inactiveTitleBackground"), 1);
    JLabel jLabel1 = new JLabel();

    public ClientManageFrame(int QQNUM, String PASSWORD, Login log,
                             InetAddress address, int port) {
        this.QQNUM = QQNUM;
        this.PASSWORD = PASSWORD;
        this.login = log;
        this.logAddress = address;
        this.serverPort = port;
        try {
            jbInit();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        try {
            socket = new Socket(logAddress, serverPort);
            in = new DataInputStream(socket.getInputStream());
            out = new DataOutputStream(socket.getOutputStream());
            //创建接收信息的数据报套接字
            receiveSocket = new DatagramSocket(usePort);
            inBuf = new byte[BUFFER_SIZE];
            //创建接收信息的数据报
            receivePacket = new DatagramPacket(inBuf, BUFFER_SIZE);
        } catch (IOException ex) {
            login.loginFail();
            return;
        }
        //登录
        loadUserInfo();
        //启动线程，用来刷新好友信息
        new Thread(this).start();
        this.setSize(210, 490);
        this.setVisible(true);
    }

    private void loadUserInfo() {
        if (login()) {
            getFriendInfo(); //获得好友信息列表
            userList.setCellRenderer(new FriendLabel());
            ownPic.setIcon(new ImageIcon(myInfo.getPic()));
            ownInfo.setText(myInfo.getName() + "[" + myInfo.getQqnum() + "]");
        } else {
            login.loginFail();
            return;
        }
    }

    //这个线程的作用是每隔10秒刷新一次好友信息
    public void run() {
        while(true){
            try {
                Thread.sleep(10000);
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }
            //刷新用户的信息
            loadUserInfo();
        }
    }

    protected void processWindowEvent(WindowEvent e) {
        if (e.getID() == WindowEvent.WINDOW_CLOSING) {
            exit();
        }
    }

    private void jbInit() throws Exception {
        getContentPane().setLayout(xYLayout4);
        this.setJMenuBar(jMenuBar1);
        this.setResizable(false);
        this.setTitle("MyQQ管理界面");
        mainPane.setLayout(xYLayout2);
        infoLabel.setHorizontalAlignment(SwingConstants.CENTER);
        infoLabel.setText("我的好友列表");
        userListPane.setBackground(Color.white);
        userListPane.setLayout(borderLayout1);
        find.setText("查找");
        find.addActionListener(this);
        update.setText("更新");
        update.addActionListener(this);
        deleteFriend.setText("删除好友");
        deleteFriend.addActionListener(this);
        addFriend.setText("添加好友");
        addFriend.addActionListener(this);
        buttonPane.setLayout(xYLayout3);
        exit.setText("退出");
        exit.addActionListener(this);
        jMenu1.setText("用户管理");
        jMenu2.setText("帮助");
        jMenuItem1.setText("查找");
        jMenuItem1.addActionListener(this);
        jMenuItem2.setText("更新");
        jMenuItem2.addActionListener(this);
        jMenuItem3.setText("删除好友");
        jMenuItem3.addActionListener(this);
        jMenuItem4.setText("添加好友");
        jMenuItem4.addActionListener(this);
        jMenuItem6.setText("退出");
        jMenuItem6.addActionListener(this);
        jMenuItem7.setText("关于");
        jMenuItem7.addActionListener(this);
        jMenuItem8.setText("查看详细信息");
        jMenuItem8.addActionListener(this);
        jMenuItem9.setText("从好友中删除");
        jMenuItem9.addActionListener(this);
        jMenuItem10.setText("发送信息");
        jMenuItem10.addActionListener(this);
        labelPane.setLayout(xYLayout1);
        userList.addMouseListener(new ClientManageFrame_userList_mouseAdapter());
        userList.addMouseMotionListener(new
                                        ClientManageFrame_userList_mouseMotionAdapter());
        xYLayout4.setWidth(200);
        xYLayout4.setHeight(453);
        labelPane.setBorder(border1);
        ownInfo.setFont(new java.awt.Font("宋体", Font.PLAIN, 13));
        ownInfo.setForeground(Color.blue);
        ownPic.addMouseListener(new ClientManageFrame_ownPic_mouseAdapter());
        jLabel1.setHorizontalAlignment(SwingConstants.RIGHT);
        jLabel1.setText("好友信息每隔10秒刷新一次  ");
        jMenuBar1.add(jMenu1);
        jMenuBar1.add(jMenu2);
        jMenu1.add(jMenuItem1);
        jMenu1.add(jMenuItem2);
        jMenu1.add(jMenuItem3);
        jMenu1.add(jMenuItem4);
        jMenu1.addSeparator();
        jMenu1.add(jMenuItem6);
        jMenu2.add(jMenuItem7);
        jPopupMenu1.add(jMenuItem10);
        jPopupMenu1.add(jMenuItem8);
        jPopupMenu1.add(jMenuItem9);
        userList.setComponentPopupMenu(jPopupMenu1);
        buttonPane.add(deleteFriend, new XYConstraints(103, 36, -1, -1));
        buttonPane.add(addFriend, new XYConstraints(6, 36, -1, -1));
        buttonPane.add(update, new XYConstraints(103, 4, 80, -1));
        buttonPane.add(find, new XYConstraints(6, 4, 81, -1));
        buttonPane.add(exit, new XYConstraints(56, 67, 80, -1));
        mainPane.add(infoLabel, new XYConstraints(3, 42, 190, -1));
        mainPane.add(userListPane, new XYConstraints(2, 60, 191, 238));
        userListPane.add(jScrollPane1, java.awt.BorderLayout.CENTER);
        jScrollPane1.getViewport().add(userList);
        this.getContentPane().add(buttonPane, new XYConstraints(2, 338, 194, -1));
        this.getContentPane().add(mainPane, new XYConstraints(2, 4, -1, 330));
        mainPane.add(labelPane, new XYConstraints(3, 4, 190, -1));
        labelPane.add(ownInfo, new XYConstraints(67, 5, 119, 23));
        labelPane.add(ownPic, new XYConstraints(2, 1, 37, 29));
        mainPane.add(jLabel1, new XYConstraints(23, 301, 168, 22));
    }

    //这个方法用于获得好友的信息,以创建列表
    private void getFriendInfo() {
        listModel.removeAllElements();
        Enumeration it = friendInfoTable.elements();
        String name = "";
        int currentQQNUM = 0;
        String pic = "";
        String friendInfo = "";
        int status = 0;
        while (it.hasMoreElements()) {
            UserInfoBean user = (UserInfoBean) it.nextElement();
            name = user.getName();
            currentQQNUM = user.getQqnum();
            pic = user.getPic();
            status = user.getStatus();
            friendInfo = status + name + "[" + currentQQNUM + "]" + "*" + pic;
            listModel.addElement(friendInfo);
        }
    }

    //读取端口号
    private int getPort(String key) {
        int port = 0;
        Properties p = new Properties();
        String file_separator = System.getProperty("file.separator");
        try {
            File file = new File("property" + file_separator +
                                 "dbProperties.txt");
            FileInputStream in = new FileInputStream(file);
            FileOutputStream out = new FileOutputStream(file, true);

            p.load(in); //从输入流中读取属性列表
            port = Integer.parseInt(p.getProperty(key));
            port = port + 1;
            p.setProperty("udp.Port", new Integer(port).toString());
            p.store(out, "new udp.port");
            in.close();
            out.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return port;
    }

    //这个方法用于登录时读取自己和好友信息
    private Boolean login() {
        try {
            out.writeUTF("login"); //向服务器发送登录得消息
            out.writeUTF(new Integer(QQNUM).toString()); //向服务器发送自己的QQ号码
            out.writeUTF(PASSWORD); //向服务器发送自己的密码
            out.writeUTF(new Integer(usePort).toString()); //向服务器发送自己的端口号

            String loginInfo1 = in.readUTF();
            //读取用户自己的信息
            if (loginInfo1.equals("loginFail")) {
                return false;
            } else if (loginInfo1.equals("sendUserInfo")) {
                String flag1 = in.readUTF();
                if (flag1.equals("queryUserFail")) {
                    return false;
                } else {
                    myInfo.setQqnum(Integer.parseInt(flag1));
                    myInfo.setName(in.readUTF());
                    myInfo.setPassword(in.readUTF());
                    myInfo.setStatus(Integer.parseInt(in.readUTF()));
                    myInfo.setIp(in.readUTF());
                    myInfo.setInfo(in.readUTF());
                    myInfo.setPic(in.readUTF());
                    myInfo.setSex(in.readUTF());
                    myInfo.setEmail(in.readUTF());
                    myInfo.setPlace(in.readUTF());
                    myInfo.setBirthday(in.readUTF());
                    myInfo.setPort(Integer.parseInt(in.readUTF()));
                }
            }

            String loginInfo2 = in.readUTF();
            //如果登录成功,就读取好友的资料
            if (loginInfo2.equals("loginSuccess")) {
                //如果该哈希表中的内容不为空，将其清空
                //if(!friendInfoTable.isEmpty()){
                    friendInfoTable.clear();
               // }
                String flag2 = "";
                do { //读取好友的信息
                    flag2 = in.readUTF();
                    System.out.println("flag2" + flag2);
                    //判断信息是否读取完毕,如果完毕则退出
                    if (flag2.equals("queryFriendOver")) {
                        break;
                    } else {
                        int f_qqnum = Integer.parseInt(flag2);
                        String f_name = in.readUTF();
                        String f_password = in.readUTF();
                        int f_status = Integer.parseInt(in.readUTF());
                        String f_ip = in.readUTF();
                        String f_info = in.readUTF();
                        String f_pic = in.readUTF();
                        String f_sex = in.readUTF();
                        String f_email = in.readUTF();
                        String f_place = in.readUTF();
                        String f_birthday = in.readUTF();
                        int f_port = Integer.parseInt(in.readUTF());
                        //创建存储好友信息的类
                        UserInfoBean friendBean = new UserInfoBean();
                        //将好友的信息存储到该类中
                        friendBean.setQqnum(f_qqnum);
                        friendBean.setName(f_name);
                        friendBean.setPassword(f_password);
                        friendBean.setStatus(f_status);
                        friendBean.setIp(f_ip);
                        friendBean.setInfo(f_info);
                        friendBean.setPic(f_pic);
                        friendBean.setSex(f_sex);
                        friendBean.setEmail(f_email);
                        friendBean.setPlace(f_place);
                        friendBean.setBirthday(f_birthday);
                        friendBean.setPort(f_port);
                        //将存放好友信息的类放入哈希表中
                        friendInfoTable.put(f_qqnum, friendBean);
                    }
                } while (!flag2.equals("queryFriendOver"));
            } else if (loginInfo2.equals("loginFail")) { //如果登录失败,要重新启动登录对话框
                return false;
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return true;
    }

    public void exit_actionPerformed(ActionEvent e) {
        exit();
    }

    //这个方法处理用户的查找好友的请求
    public void findUser(int qqnum) {
        System.out.println("查找用户");
        try {
            //向服务器发送查找用户的请求
            out.writeUTF("queryUser");
            //发送要查找的用户的QQ号
            out.writeUTF(new Integer(qqnum).toString());
            String msg = in.readUTF();
            if (msg.equals("queryUserFail")) {
                JOptionPane.showMessageDialog(this, "查找失败!");
            } else if (msg.equals("noUser")) {
                JOptionPane.showMessageDialog(this, "该用户的信息不存在!");
            } else {
                findUserBean.setQqnum(Integer.parseInt(msg));
                findUserBean.setName(in.readUTF());
                findUserBean.setPassword(in.readUTF());
                findUserBean.setStatus(Integer.parseInt(in.readUTF()));
                findUserBean.setIp(in.readUTF());
                findUserBean.setInfo(in.readUTF());
                findUserBean.setPic(in.readUTF());
                findUserBean.setSex(in.readUTF());
                findUserBean.setEmail(in.readUTF());
                findUserBean.setPlace(in.readUTF());
                findUserBean.setBirthday(in.readUTF());
                findUserBean.setPort(Integer.parseInt(in.readUTF()));
                //查找完成后,在显示该用户的信息
                FindUserInfo fuiDlg = new FindUserInfo(this, "用户信息", false,
                        findUserBean, this);
                SetCenter.setDialogCenter(this, fuiDlg);
                fuiDlg.setVisible(true);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    //这个方法处理用户添加新好友的请求
    public void addNewFriend() {
        try {
            //向服务器发送添加好友的请求
            out.writeUTF("addFriend");
            //发送自己的QQ号
            out.writeUTF(new Integer(myInfo.getQqnum()).toString());
            //发送好友的QQ号
            out.writeUTF(new Integer(findUserBean.getQqnum()).toString());
            //读取服务器返回的信息
            String msg = in.readUTF();
            if (msg.equals("addFriendOver")) {
                JOptionPane.showMessageDialog(this, "添加成功！");
                //将新添加的好友信息存入哈希表中
                friendInfoTable.put(findUserBean.getQqnum(), findUserBean);
                //在列表中显示新添加的好友
                String name = findUserBean.getName();
                int qqnum = findUserBean.getQqnum();
                String pic = findUserBean.getPic();
                int status = findUserBean.getStatus();
                String friendInfo = status + name + "[" + qqnum + "]" +
                                    "*" + pic;
                if(listModel.contains(friendInfo)){
                    JOptionPane.showMessageDialog(this, "该用户已存在好友列表中！");
                }else{
                    listModel.addElement(friendInfo);
                }
            } else {
                JOptionPane.showMessageDialog(this, "添加失败,数据库中不存在该用户的信息！");
            }
        } catch (IOException ex) {
        }
    }

    //这个方法更新用户自己的头像和用户名
    public void refreashOwnInfo() {
        ownPic.setIcon(new ImageIcon(myInfo.getPic()));
        ownInfo.setText(myInfo.getName() + "[" + myInfo.getQqnum() + "]");
    }

    //这个方法处理用户的删除好友请求
    public void deleteFriend() {
        int index = userList.getSelectedIndex();
        Integer friendQqnum = null;
        if (index == -1) {
            JOptionPane.showMessageDialog(this, "请单击鼠标选择一个用户！");
        } else {
            String userInfo = (String) listModel.getElementAt(index);
            friendQqnum = new Integer(userInfo.substring(userInfo.indexOf("[") +
                    1,
                    userInfo.indexOf("]")));
            UserInfoBean delFriend = (UserInfoBean) friendInfoTable.get(
                    friendQqnum);
            int myQqnum = myInfo.getQqnum();
            try {
                //向服务器发送删除好友的请求
                out.writeUTF("deleteFriend");
                //发送自己的QQ号
                out.writeUTF(new Integer(myQqnum).toString());
                //发送要删除的好友的QQ号
                out.writeUTF(new Integer(friendQqnum).toString());
                String msg = in.readUTF();
                if (msg.equals("deleteFriendOver")) {
                    JOptionPane.showMessageDialog(this,
                                                  "好友 [" + delFriend.getName() +
                                                  "] 已被成功删除！");
                    listModel.remove(index);
                } else if (msg.equals("deleteFriendFail")) {
                    JOptionPane.showMessageDialog(this,
                                                  "删除好友 [" + delFriend.getName() +
                                                  "] 时失败，请稍候再试！");
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    //这个方法处理用户的下线
    public void exit() {
        int option = JOptionPane.showConfirmDialog(this, "你确定要退出么？");
        if (option == JOptionPane.YES_OPTION) {
            try {
                //发送查询请求
                out.writeUTF("logout");
                //发送自己的QQ号
                out.writeUTF(new Integer(myInfo.getQqnum()).toString());
                String msg = in.readUTF();
                if (msg.equals("logout")) {
                    in.close(); //关闭输入流
                    out.close(); //关闭输出刘
                    socket.close(); //关闭套结字连接
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            } finally {
                this.dispose();
                System.exit(0);
            }
        }
    }

    public void userList_mouseClicked(MouseEvent e) {
        if (e.getClickCount() == 2 && e.getButton() == MouseEvent.BUTTON1) {
            //System.out.println("事件已触发！　＋ 2");
            new Thread(new ChatFrame(myInfo, currentFriend, this, usePort,
                                     receiveSocket, receivePacket,friendInfoTable)).
                    start();
        }
    }
    //获取下一个端口
    private int getNextPort(int port) {
        int nextPort = port;
        Boolean flag = true;
        DatagramSocket testsocket = null;
        //下面这个循环主要用于检测端口是否被占用
        while (true) {
            flag = true;
            try {
                testsocket = new DatagramSocket(++nextPort);
            } catch (SocketException ex) {
                flag = false;
            }
            if (flag == true) {
                break;
            }
            System.out.println(nextPort);
        }
        testsocket.close();
        return nextPort;
    }

    public void userList_mouseMoved(MouseEvent e) {
        if (!listModel.isEmpty()) {
            //获得鼠标当前所在的列表索引
            currentIndex = userList.locationToIndex(e.getPoint());
            //获得当前列表的值
            currentInfo = listModel.getElementAt(currentIndex).toString();
            //从当前的列表的值中提取QQ号
            currentQQNUM = new Integer(currentInfo.substring(currentInfo.
                    indexOf(
                            "[") + 1,
                    currentInfo.indexOf("]")));
            //根据好友的QQ号查找好友的信息类
            currentFriend = (UserInfoBean) friendInfoTable.get(currentQQNUM);
            String name = currentFriend.getName();
            String sex = currentFriend.getSex();
            String birth = currentFriend.getBirthday();
            int status = currentFriend.getStatus();
            String address = currentFriend.getPlace();
            String toolTip = "姓名：" + name + "  性别：" + sex + "  生日：" + birth +
                             "  籍贯：" +
                             address;
            if (status == 0) {
                userList.setToolTipText(" [离线] " + toolTip);
            } else {
                userList.setToolTipText(toolTip);
            }
        }
    }

    public void ownPic_mouseEntered(MouseEvent e) {
        ownPic.setCursor(new Cursor(Cursor.HAND_CURSOR));
    }

    public void ownPic_mousePressed(MouseEvent e) {
        UserInfo userInfo = new UserInfo(this, "我的基本信息", false, myInfo);
        SetCenter.setDialogCenter(this, userInfo);
        userInfo.setVisible(true);
    }

    public void jMenuItem6_actionPerformed(ActionEvent e) {
        exit();
    }

    public void deleteFriend_actionPerformed(ActionEvent e) {
        int option = JOptionPane.showConfirmDialog(this, "你确定要删除该好友么?");
        if (option == JOptionPane.YES_OPTION) {
            deleteFriend();
        }
    }

    public void jMenuItem3_actionPerformed(ActionEvent e) {
        int option = JOptionPane.showConfirmDialog(this, "你确定要删除该好友么?");
        if (option == JOptionPane.YES_OPTION) {
            deleteFriend();
        }
    }

    public void find_actionPerformed(ActionEvent e) {
        FindUserDlg find = new FindUserDlg(this, "查找用户", false, this);
        SetCenter.setDialogCenter(this, find);
        find.setVisible(true);
    }

    //
    public void jMenuItem1_actionPerformed(ActionEvent e) {
        find.doClick();
    }

    public void addFriend_actionPerformed(ActionEvent e) {
        find.doClick();
    }

    public void jMenuItem4_actionPerformed(ActionEvent e) {
        find.doClick();
    }

    //修改信息的按钮事件
    public void update_actionPerformed(ActionEvent e) {
        UpdateDialog udl = new UpdateDialog(this, "修改信息", true, logAddress,
                                            serverPort, myInfo);
        SetCenter.setDialogCenter(this, udl);
        udl.setVisible(true);
        this.refreashOwnInfo();
    }

    //修改信息的菜单事件
    public void jMenuItem2_actionPerformed(ActionEvent e) {
        UpdateDialog udl = new UpdateDialog(this, "修改信息", true, logAddress,
                                            serverPort, myInfo);
        SetCenter.setDialogCenter(this, udl);
        udl.setVisible(true);
        System.out.println("修改事件发生");
        this.refreashOwnInfo();
    }

    //发送信息的菜单事件
    public void jMenuItem10_actionPerformed(ActionEvent e) {
        new Thread(new ChatFrame(myInfo, currentFriend, this, usePort,
                                 receiveSocket, receivePacket,friendInfoTable)).
                start();
    }

    //删除好友的菜单事件
    public void jMenuItem9_actionPerformed(ActionEvent e) {
        int option = JOptionPane.showConfirmDialog(this, "你确定要删除该好友么?");
        if (option == JOptionPane.YES_OPTION) {
            deleteFriend();
        }
    }

    //查看好友详细信息的菜单事件
    public void jMenuItem8_actionPerformed(ActionEvent e) {
        UserInfo userInfo = new UserInfo(this, "我的基本信息", false, currentFriend);
        SetCenter.setDialogCenter(this, userInfo);
        userInfo.setVisible(true);
    }

    public void jMenuItem7_actionPerformed(ActionEvent e) {
        MyInfo_AboutBox dailog = new MyInfo_AboutBox(this);
        SetCenter.setDialogCenter(this,dailog);
        dailog.pack();
        dailog.setModal(true);
        dailog.setVisible(true);
    }
    
    public void actionPerformed(ActionEvent e){
       Object obj;
       obj = e.getSource();
       if (obj == jMenuItem1)
         jMenuItem1_actionPerformed(e);
       else if(obj == jMenuItem2)
         jMenuItem2_actionPerformed(e);
       else if(obj == jMenuItem3)
         jMenuItem3_actionPerformed(e);
       else if(obj == jMenuItem4)
         jMenuItem4_actionPerformed(e);
       else if(obj == jMenuItem6)
         jMenuItem6_actionPerformed(e);
       else if(obj == jMenuItem7)
         jMenuItem7_actionPerformed(e);
       else if(obj == jMenuItem8)
         jMenuItem8_actionPerformed(e);
       else if(obj == jMenuItem9)
         jMenuItem9_actionPerformed(e);
       else if(obj == jMenuItem10)
         jMenuItem10_actionPerformed(e);
       else if(obj == find) 
         find_actionPerformed(e);
       else if(obj == addFriend)
         addFriend_actionPerformed(e);
       else if(obj == update)
         update_actionPerformed(e);
       else if(obj == deleteFriend)
         deleteFriend_actionPerformed(e);
       else if(obj == exit)
         exit_actionPerformed(e);
    }
    
    class ClientManageFrame_ownPic_mouseAdapter extends MouseAdapter {
       public void mouseEntered(MouseEvent e) {
          ownPic_mouseEntered(e);
       }
       public void mousePressed(MouseEvent e) {
          ownPic_mousePressed(e);
      }
   }
   
   class ClientManageFrame_userList_mouseAdapter extends MouseAdapter {
      public void mouseClicked(MouseEvent e) {
        userList_mouseClicked(e);
      }
   }
   
   class ClientManageFrame_userList_mouseMotionAdapter extends MouseMotionAdapter {
       public void mouseMoved(MouseEvent e) {
         userList_mouseMoved(e);
       }
   }
}








