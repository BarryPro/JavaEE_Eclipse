
import java.text.*;
import java.util.Date;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import java.net.*;
/**
 * Description:
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br/>Copyright (C), 2001-2016, Yeeku.H.Lee
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date:
 * @author Yeeku.H.Lee kongyeeku@163.com
 * @version 1.0
 */
public class LanTalk extends JFrame
{
	private DefaultListModel<UserInfo> listModel
		= new DefaultListModel<>();
	// ����һ��JList����
	private JList<UserInfo> friendsList = new JList<>(listModel);
	// ����һ�����ڸ�ʽ�����ڵĸ�ʽ��
	private DateFormat formatter = DateFormat.getDateTimeInstance();
	public LanTalk()
	{
		super("����������");
		// ���ø�JListʹ��ImageCellRenderer��Ϊ��Ԫ�������
		friendsList.setCellRenderer(new ImageCellRenderer());
		listModel.addElement(new UserInfo("all" , "������"
			, null , -2000));
		friendsList.addMouseListener(new ChangeMusicListener());
		add(new JScrollPane(friendsList));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(2, 2, 160 , 600);
	}
	// ���ݵ�ַ����ѯ�û�
	public UserInfo getUserBySocketAddress(SocketAddress address)
	{
		for (int i = 1 ; i < getUserNum() ; i++)
		{
			UserInfo user = getUser(i);
			if (user.getAddress() != null
				&& user.getAddress().equals(address))
			{
				return user;
			}
		}
		return null;
	}
	// ------�����ĸ������Ƕ�ListModel�İ�װ------
	// ���û��б�������û�
	public void addUser(UserInfo user)
	{
		listModel.addElement(user);
	}
	// ���û��б���ɾ���û�
	public void removeUser(int pos)
	{
		listModel.removeElementAt(pos);
	}
	// ��ȡ�����촰�ڵ��û�����
	public int getUserNum()
	{
		return listModel.size();
	}
	// ��ȡָ��λ�õ��û�
	public UserInfo getUser(int pos)
	{
		return listModel.elementAt(pos);
	}
	// ʵ��JList�ϵ����˫���¼��ļ�����
	class ChangeMusicListener extends MouseAdapter
	{
		public void mouseClicked(MouseEvent e)
		{
			// ������Ļ�����������2
			if (e.getClickCount() >= 2)
			{
				// ȡ�����˫��ʱѡ�е��б���
				UserInfo user = (UserInfo)friendsList.getSelectedValue();
				// ������б����Ӧ�û��Ľ�̸����Ϊnull
				if (user.getChatFrame() == null)
				{
					// Ϊ���û�����һ����̸���ڣ����ø��û����øô���
					user.setChatFrame(new ChatFrame(null , user));
				}
				// ������û��Ĵ���û����ʾ�����ø��û��Ĵ�����ʾ����
				if (!user.getChatFrame().isShowing())
				{
					user.getChatFrame().setVisible(true);
				}
			}
		}
	}
	/**
	 * �����������ݱ����÷���������������Ϣ�õ������ߣ�
	 * ������Ϣ��ʾ������Ի����С�
	 * @param packet ��Ҫ��������ݱ�
	 * @param single ����Ϣ�Ƿ�Ϊ˽����Ϣ
	 */
	public void processMsg(DatagramPacket packet , boolean single)
	{
		// ��ȡ�÷��͸����ݱ���SocketAddress
		InetSocketAddress srcAddress = (InetSocketAddress)
			packet.getSocketAddress();
		// �����˽����Ϣ�����Packet��ȡ����DatagramSocket�ĵ�ַ��
		// ���˿ڼ�1���Ƕ�Ӧ��MulticastSocket�ĵ�ַ
		if (single)
		{
			srcAddress = new InetSocketAddress(srcAddress.getHostName()
				, srcAddress.getPort() - 1);
		}
		UserInfo srcUser = getUserBySocketAddress(srcAddress);
		if (srcUser != null)
		{
			// ȷ����Ϣ��Ҫ��ʾ���ĸ��û���Ӧ�����ϡ�
			UserInfo alertUser = single ? srcUser : getUser(0);
			// ������û���Ӧ�Ĵ���Ϊ�գ���ʾ�ô���
			if (alertUser.getChatFrame() == null)
			{
				alertUser.setChatFrame(new ChatFrame(null , alertUser));
			}
			// ������ӵ���ʾ��Ϣ
			String tipMsg = single ? "����˵��" : "�Դ��˵��";
			try{
				// ��ʾ��ʾ��Ϣ
				alertUser.getChatFrame().addString(srcUser.getName()
					+ tipMsg + "......................("
					+ formatter.format(new Date()) + ")\n"
					+ new String(packet.getData() , 0 , packet.getLength()
					, ComUtil.CHARSET) + "\n");
			} catch (Exception ex) { ex.printStackTrace(); }
			if (!alertUser.getChatFrame().isShowing())
			{
				alertUser.getChatFrame().setVisible(true);
			}
		}
	}
	// ����������������
	public static void main(String[] args)
	{
		LanTalk lanTalk = new LanTalk();
		new LoginFrame(lanTalk , "�������û�����ͷ����¼");
	}
}
// �������ڸı�JList�б�����۵���
class ImageCellRenderer extends JPanel
	implements ListCellRenderer<UserInfo>
{
	private ImageIcon icon;
	private String name;
	// ������Ƶ�Ԫ��ʱ�ı���ɫ
	private Color background;
	// ������Ƶ�Ԫ��ʱ��ǰ��ɫ
	private Color foreground;
	@Override
	public Component getListCellRendererComponent(JList list
		, UserInfo userInfo , int index
		, boolean isSelected , boolean cellHasFocus)
	{
		// ����ͼ��
		icon = new ImageIcon("ico/" + userInfo.getIcon() + ".gif");
		name = userInfo.getName();
		// ���ñ���ɫ��ǰ��ɫ
		background = isSelected ? list.getSelectionBackground()
			: list.getBackground();
		foreground = isSelected ? list.getSelectionForeground()
			: list.getForeground();
		// ���ظ�JPanel������Ϊ��Ԫ�������
		return this;
	}
	// ��дpaintComponent�������ı�JPanel�����
	public void paintComponent(Graphics g)
	{
		int imageWidth = icon.getImage().getWidth(null);
		int imageHeight = icon.getImage().getHeight(null);
		g.setColor(background);
		g.fillRect(0, 0, getWidth(), getHeight());
		g.setColor(foreground);
		// ���ƺ���ͼ��
		g.drawImage(icon.getImage() , getWidth() / 2 - imageWidth / 2
			, 10 , null);
		g.setFont(new Font("SansSerif" , Font.BOLD , 18));
		// ���ƺ����û���
		g.drawString(name, getWidth() / 2 - name.length() * 10
			, imageHeight + 30 );
	}
	// ͨ���÷��������ø�ImageCellRenderer����Ѵ�С
	public Dimension getPreferredSize()
	{
		return new Dimension(60, 80);
	}
}