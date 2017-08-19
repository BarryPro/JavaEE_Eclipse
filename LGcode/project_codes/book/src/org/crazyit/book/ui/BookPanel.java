package org.crazyit.book.ui;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.util.Collection;
import java.util.Vector;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;

/**
 * �鱾����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class BookPanel extends CommonPanel {

	private Vector columns;
	
	BookService bookService;
	
	TypeService typeService;
	
	ConcernService concernService;
	
	//����������
	JComboBox typeComboBox;
	
	//������������
	JComboBox concernComboBox;
	
	//�鱾id
	JTextField bookId;
	
	//�鱾����
	JTextField bookName;
	
	//�鱾�۸�
	JTextField price;
	
	//�鱾����
	JTextArea intro;
	
	JButton clearButton;
	
	JButton saveButton;
	
	//��ѯ�е��鱾����
	JTextField nameQueryTextField;
	
	//��ѯ��ť
	JButton queryButton;
	
	//ͼƬ�ϴ���ť
	JButton imageButton;
	
	//�ļ�ѡ����
	FileChooser chooser;
	
	//��ǰ��������ʾ��ͼƬ
	ImageIcon currentImage;
	
	//��ǰ��������ʾͼƬ��·��
	String currentImagePath;
	
	//��ʾͼƬ��JLabel
	JLabel imageLabel;
	
	JTextField author;
	
	private final static String DEFAULT_File_Path = "upload/no_pic.gif";
	
	//�鿴��ͼ��JFrame
	ImageFrame imageFrame;
	
	private void initColumns() {
		this.columns = new Vector();
		this.columns.add("id");
		this.columns.add("�鱾����");
		this.columns.add("���");
		this.columns.add("����");
		this.columns.add("��������");
		this.columns.add("������");
		this.columns.add("���");
		this.columns.add("�۸�");
	}
	
	public void initImage() {
		this.currentImage = new ImageIcon(DEFAULT_File_Path);
		this.currentImagePath = DEFAULT_File_Path;
		refreshImage();
	}
	
	public BookPanel(BookService bookService, TypeService typeService, 
			ConcernService concernService) {
		this.bookService = bookService;
		this.typeService = typeService;
		this.concernService = concernService;
		setViewDatas();
		initColumns();
		
		//�����б�
		DefaultTableModel model = new DefaultTableModel(getDatas(), this.columns);
		JTable table = new CommonJTable(model);
		setJTable(table);
		
		JScrollPane upPane = new JScrollPane(table);
		upPane.setPreferredSize(new Dimension(1000, 350));
		
		//�������, �޸ĵĽ���
		JPanel downPane = new JPanel();
		downPane.setLayout(new BoxLayout(downPane, BoxLayout.X_AXIS));

		Box downBox1 = new Box(BoxLayout.X_AXIS);
		//���id������
		bookId = new JTextField(10);
		bookId.setVisible(false);
		downBox1.add(bookId);
		//�б������box
		downBox1.add(new JLabel("�鱾���ƣ�"));
		downBox1.add(Box.createHorizontalStrut(10));
		bookName = new JTextField(10);
		downBox1.add(bookName);
		downBox1.add(Box.createHorizontalStrut(30));
		
		downBox1.add(new JLabel("�۸�"));
		downBox1.add(Box.createHorizontalStrut(10));
		price = new JTextField(10);
		downBox1.add(price);
		downBox1.add(Box.createHorizontalStrut(30));
		
		downBox1.add(new JLabel("���ߣ�"));
		downBox1.add(Box.createHorizontalStrut(10));
		author = new JTextField(10);
		downBox1.add(author);
		downBox1.add(Box.createHorizontalStrut(30));
		
		/***************************************************/
		Box downBox4 = new Box(BoxLayout.X_AXIS);

		downBox4.add(new JLabel("�������ࣺ"));
		downBox4.add(Box.createHorizontalStrut(10));
		typeComboBox = new JComboBox();
		addTypes();
		downBox4.add(typeComboBox);
		downBox4.add(Box.createHorizontalStrut(30));
		
		downBox4.add(new JLabel("�����磺"));
		concernComboBox = new JComboBox();
		addConcerns();
		downBox4.add(concernComboBox);
		downBox4.add(Box.createHorizontalStrut(30));
		
		downBox4.add(new JLabel("�鱾ͼƬ��"));
		this.chooser = new FileChooser(this);
		this.imageButton = new JButton("��ѡ���ļ�");
		downBox4.add(this.imageButton);
		downBox4.add(Box.createHorizontalStrut(30));
		
		/*******************************************************/
		Box downBox2 = new Box(BoxLayout.X_AXIS);
		downBox2.add(new JLabel("�鱾��飺"));
		downBox2.add(Box.createHorizontalStrut(10));

		intro = new JTextArea("", 5, 5);
		JScrollPane introScrollPane = new JScrollPane(intro);
		intro.setLineWrap(true);
		downBox2.add(introScrollPane);
		downBox2.add(Box.createHorizontalStrut(30));
		/*******************************************************/
		Box downBox3 = new Box(BoxLayout.X_AXIS);
		
		saveButton = new JButton("����");
		downBox3.add(saveButton);
		downBox3.add(Box.createHorizontalStrut(30));
		
		clearButton = new JButton("���");
		downBox3.add(clearButton);
		downBox3.add(Box.createHorizontalStrut(30));
		
		/*******************************************************/
		Box downLeftBox = new Box(BoxLayout.Y_AXIS);
		
		downLeftBox.add(getSplitBox());
		downLeftBox.add(downBox1);
		downLeftBox.add(getSplitBox());
		downLeftBox.add(downBox4);
		downLeftBox.add(getSplitBox());
		downLeftBox.add(downBox2);
		downLeftBox.add(getSplitBox());
		downLeftBox.add(downBox3);
		
		Box downRightBox = new Box(BoxLayout.Y_AXIS);
		this.imageLabel = new JLabel();
		this.imageLabel.setPreferredSize(new Dimension(200, 200));
		this.currentImage = new ImageIcon(DEFAULT_File_Path);
		this.currentImagePath = DEFAULT_File_Path;
		this.imageLabel.setIcon(this.currentImage);
		JScrollPane p = new JScrollPane(this.imageLabel);
		downRightBox.add(p);
		
		downPane.add(downLeftBox);
		downPane.add(downRightBox);
		
		/*******************��ѯ******************/
		JPanel queryPanel = new JPanel();
		Box queryBox = new Box(BoxLayout.X_AXIS);
		queryBox.add(new JLabel("������"));
		queryBox.add(Box.createHorizontalStrut(30));
		nameQueryTextField = new JTextField(20);
		queryBox.add(nameQueryTextField);
		queryBox.add(Box.createHorizontalStrut(30));
		queryButton = new JButton("��ѯ");
		queryBox.add(queryButton);
		queryPanel.add(queryBox);
		this.add(queryPanel);
		
		//�б�Ϊ��ӽ���
		JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT, upPane, downPane);
		split.setDividerSize(5);
		this.add(split);
		//��Ӽ�����
		initListeners();
	}
	
	private void initListeners() {
		//���ѡ�������
		getJTable().getSelectionModel().addListSelectionListener(new ListSelectionListener(){
			public void valueChanged(ListSelectionEvent event) {
				//��ѡ����ʱ����ͷ�ʱ��ִ��
				if (!event.getValueIsAdjusting()) {
					//���û��ѡ���κ�һ��, �򷵻�
					if (getJTable().getSelectedRowCount() != 1) return;
					view();
				}
			}
		});
		//��հ�ť������
		clearButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				clear();
			}
		});
		//���水ť������
		saveButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				//��֤��ֵ
				if (bookName.getText().trim().equals("")) {
					showWarn("�������������");
					return;
				}
				save();
			}
		});
		queryButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				query();
			}
		});
		//ͼƬ�ϴ���ť
		imageButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				addImage();
			}
		});
		this.imageLabel.addMouseListener(new MouseAdapter(){
			public void mouseReleased(MouseEvent e) {
				showImageFrame();
			}
		});
	}
	
	//����ʾͼƬ��JFrame
	private void showImageFrame() {
		if (this.imageFrame == null) {
			this.imageFrame = new ImageFrame(this.currentImage);
		}
		this.imageFrame.refresh(getBigImage());
	}
	
	//��ȡ��ͼƬ��·��
	private ImageIcon getBigImage() {
		String smallImagePath = this.currentImagePath;
		if (smallImagePath.equals(this.DEFAULT_File_Path)) {
			return this.currentImage;
		}
		//��ȡ�޺�׺�ļ���(��·��)
		String temp = smallImagePath.substring(0, smallImagePath.lastIndexOf("."));
		//ƴװ��ͼ·��ȫ�ļ���
		String bigImagePath = temp + "-big" + smallImagePath.substring(smallImagePath.lastIndexOf("."), 
				smallImagePath.length());
		return new ImageIcon(bigImagePath);
	}
	
	//����ļ��ķ���
	private void addImage() {
		chooser.showOpenDialog(this);
	}
	
	//�ϴ�ͼƬ
	public void upload(File selectFile) {
		try {
			//ʹ��uuid�����ļ�������֤�ļ���Ψһ
			String uuid =  ImageUtil.getUUID();
			//����ͼ��url
			String smallFilePath = "upload/" + uuid + ".jpg";
			//ԭͼ��url
			String bigFilePath = "upload/" + uuid + "-big.jpg";
			//��������ͼ
			File file = ImageUtil.makeImage(selectFile, smallFilePath, "jpg", true);
			//����ԭͼ
			File source = ImageUtil.makeImage(selectFile, bigFilePath, "jpg", false);
			//���ý�����ʾ��ͼƬ����
			this.currentImage = new ImageIcon(file.getAbsolutePath());
			//���ý�����ʾ��ͼƬurl
			this.currentImagePath = smallFilePath;
			//ˢ��ͼƬ��ʾ��
			refreshImage();
		} catch (UploadException e) {
			e.printStackTrace();
			showWarn(e.getMessage());
		}
	}
	
	//ˢ��ͼƬ��ʾ��JLabel
	private void refreshImage() {
		this.imageLabel.setIcon(this.currentImage);
	}
	
	//�������Ʋ�ѯ��
	private void query() {
		String name = this.nameQueryTextField.getText();
		Vector<Book> books = (Vector<Book>)bookService.find(name);
		Vector<Vector> datas = changeDatas(books);
		setDatas(datas);
		refreshTable();
	}
	
	//��ձ�, ˢ���б�
	public void clear() {
		refreshTable();
		this.bookId.setText("");
		this.bookName.setText("");
		this.price.setText("");
		this.intro.setText("");
		this.author.setText("");
		this.typeComboBox.removeAllItems();
		this.concernComboBox.removeAllItems();
		addTypes();
		addConcerns();
		//���ͼƬ��
		this.currentImage = new ImageIcon(DEFAULT_File_Path);
		refreshImage();
		this.currentImagePath = DEFAULT_File_Path;
	}
	
	//����
	private void save() {
		//���bookId���ı���(����)��ֵΪ��, ��������, ����Ϊ�޸�
		if (this.bookId.getText().equals("")) {
			add();
		} else {
			update();
		}
	}
	
	//�����鱾
	private void add() {
		if (!validatePrice()) {
			JOptionPane.showMessageDialog(this, "��������ȷ�ļ۸�");
			return;
		}
		//�����鱾ʱ���Ϊ0
		Book book = getBook();
		bookService.add(book);
		//���¶�ȡ����
		setViewDatas();
		//ˢ���б�, ��ձ�
		clear();
	}
	
	//��֤����
	private boolean validatePrice() {
		String price = this.price.getText();
		try {
			Integer p = Integer.parseInt(price);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	//�޸��鱾, �޸�ʱ����Ҫ�޸Ŀ��, ��Ϊ���ȡ�������������
	private void update() {
		Book book = getBook();
		//�������޸�, �����Ҫ����id
		book.setID(this.bookId.getText());
		bookService.update(book);
		//���¶�ȡ����
		setViewDatas();
		//ˢ���б�, ��ձ�
		clear();
	}
	
	//�ӽ����л�ȡ���ݲ���װ��Book����
	private Book getBook() {
		String bookName = this.bookName.getText();
		String price = this.price.getText();
		String intro = this.intro.getText();
		String author = this.author.getText();
		Type type = (Type)this.typeComboBox.getSelectedItem();
		Concern concern = (Concern)this.concernComboBox.getSelectedItem();
		return new Book(null, bookName, intro, price, type.getID(), 
				concern.getID(), String.valueOf(0), this.currentImagePath, author);
	}
	
	//�鿴�鱾
	private void view() {
		String id = getSelectId(getJTable());
		Book book = bookService.get(id);
		this.bookId.setText(book.getID());
		this.bookName.setText(book.getBOOK_NAME());
		this.price.setText(book.getBOOK_PRICE());
		this.intro.setText(book.getBOOK_INTRO());
		this.author.setText(book.getAUTHOR());
		this.typeComboBox.setSelectedItem(makeType(book.getType()));
		this.concernComboBox.setSelectedItem(makeConcern(book.getConcern()));
		this.currentImage = new ImageIcon(book.getIMAGE_URL());
		this.currentImagePath = book.getIMAGE_URL();
		refreshImage();
	}
	
	/*
	 * ʵ�ָ��෽��, ��ѯ���ݿⲢ���ض�Ӧ�����ݸ�ʽ, ���ø����setDatas�����������ݼ���
	 */
	public void setViewDatas() {
		//���Ҷ�Ӧ������
		Vector<Book> books = (Vector<Book>)bookService.getAll();
		//ת����ʾ��ʽ
		Vector<Vector> datas =  changeDatas(books);
		//���ø��෽�����ý������
		setDatas(datas);
	}
	
	//������ת������ͼ���ĸ�ʽ
	private Vector<Vector> changeDatas(Vector<Book> datas) {
		Vector<Vector> view = new Vector<Vector>();
		for (Book book : datas) {
			Vector v = new Vector();
			v.add(book.getID());
			v.add(book.getBOOK_NAME());
			v.add(book.getBOOK_INTRO());
			v.add(book.getAUTHOR());
			v.add(book.getType().getTYPE_NAME());
			v.add(book.getConcern().getPUB_NAME());
			v.add(book.getREPERTORY_SIZE());
			v.add(book.getBOOK_PRICE());
			view.add(v);
		}
		return view;
	}

	@Override
	public Vector<String> getColumns() {
		return this.columns;
	}

	@Override
	public void setTableFace() {
		//����id��
		getJTable().getColumn("id").setMinWidth(-1);
		getJTable().getColumn("id").setMaxWidth(-1);
		getJTable().getColumn("���").setMinWidth(350);
		getJTable().setRowHeight(30);
	}
	
	//�����ݿ��л�ȡȫ�������ಢ��ӵ���������
	private void addTypes() {
		//��������ҵ��ӿ�ȡ��ȫ��������
		Collection<Type> types = this.typeService.getAll();
		for (Type type : types) {
			//typeComboBox���������������
			this.typeComboBox.addItem(makeType(type));
		}
	}
	
	//�����ݿ��л�ȡȫ���ĳ����粢��ӵ���������
	private void addConcerns() {
		Collection<Concern> concers = this.concernService.getAll();
		for (Concern c : concers) {
			this.concernComboBox.addItem(makeConcern(c));
		}
	}

	//����һ��Type����, ������ӵ���������, �÷����д�����Type������д��toString��equals����
	private Type makeType(final Type source) {
		Type type = new Type(){
			public String toString(){
				return source.getTYPE_NAME();
			}
			public boolean equals(Object obj) {
				if (obj instanceof Type) {
					Type t = (Type)obj;
					if (getID().equals(t.getID())) return true;
				}
				return false;
			}
		};
		type.setID(source.getID());
		return type;
	}
	
	//����һ��Concern����, ������ӵ���������, �÷����д�����Concern������д��toString��equals����
	private Concern makeConcern(final Concern c) {
		Concern concern = new Concern() {
			public String toString(){
				return c.getPUB_NAME();
			}
			public boolean equals(Object obj) {
				if (obj instanceof Concern) {
					Concern co = (Concern)obj;
					if (getID().equals(co.getID())) return true;
				}
				return false;
			}
		};
		concern.setID(c.getID());
		return concern;
	}
	
	
}

class FileChooser extends JFileChooser {
	//�鱾����������
	BookPanel bookPanel;
	public FileChooser(BookPanel bookPanel){
		this.bookPanel = bookPanel;
	}
	//ѡ�����ļ��󴥷�
	public void approveSelection() {
		//���ѡ����ļ�
		File file = getSelectedFile();
		//�����鱾�����������upload����
		this.bookPanel.upload(file);
		super.approveSelection();
	}
}