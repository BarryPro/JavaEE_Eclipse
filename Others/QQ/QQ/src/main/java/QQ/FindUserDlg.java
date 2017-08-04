package QQ;
/**
 * 查找用户的对话框，用来提示用户输入要查找的用户的QQ号
 */
import java.awt.*;

import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.border.TitledBorder;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class FindUserDlg extends JDialog implements ActionListener {
    JPanel panel1 = new JPanel();
    JLabel infoLabel = new JLabel();
    JTextField qqnumField = new JTextField();
    JButton findButton = new JButton();
    JPanel findPane = new JPanel();
    Border border1 = BorderFactory.createLineBorder(UIManager.getColor(
            "InternalFrame.inactiveTitleBackground"), 1);
    FlowLayout flowLayout1 = new FlowLayout();

    ClientManageFrame father = null;
    BorderLayout borderLayout1 = new BorderLayout();

    public FindUserDlg(JFrame owner, String title, boolean modal,ClientManageFrame father) {
        super(owner, title, modal);
        this.father = father;
        try {
            setDefaultCloseOperation(DISPOSE_ON_CLOSE);
            jbInit();
            pack();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    public FindUserDlg() {
        this(new JFrame(), "FindUserDlg", false,null);
    }

    private void jbInit() throws Exception {
        border1 = new TitledBorder(BorderFactory.createLineBorder(new Color(122,
                150, 223), 1), "查找用户");
        panel1.setLayout(borderLayout1);
        infoLabel.setText("请输入你要查找的QQ号：");
        qqnumField.setColumns(10);
        qqnumField.addActionListener(this);
        findButton.setText("查找");
        findButton.addActionListener(this);
        findPane.setLayout(flowLayout1);
        findPane.setBorder(border1);
        panel1.setBorder(null);
        getContentPane().add(panel1);
        findPane.add(infoLabel, null);
        findPane.add(qqnumField, null);
        findPane.add(findButton, null);
        panel1.add(findPane, java.awt.BorderLayout.CENTER);
        pack();
    }

    public boolean isNum(String text) { //判断输入是否为数字
        boolean error = false;
        try {
            Integer.parseInt(text); //非整数抛出异常
        } catch (Exception e) {
            error = true;
        }
        if (error) {
            return false; //表示非数字
        } else {
            return true; //表示是数字
        }
    }

    public void findButton_actionPerformed(ActionEvent e) {
        String info = qqnumField.getText().trim();
        if(info.equals("")||info == null){
            JOptionPane.showMessageDialog(this, "请输入你要查找的用户的QQ号");
        }else if(isNum(info)){
            this.setVisible(false);
           father.findUser(Integer.parseInt(info));
        }else{
            JOptionPane.showMessageDialog(this, "对不起,你输入的QQ号有误!");
        }
    }

    public void qqnumField_actionPerformed(ActionEvent e) {
        findButton.doClick();
    }
    
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == qqnumField)
          qqnumField_actionPerformed(e);
        else if (e.getSource() == findButton)
          findButton_actionPerformed(e);
    }  
}