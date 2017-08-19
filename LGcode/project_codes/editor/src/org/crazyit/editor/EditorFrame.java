package org.crazyit.editor;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.InputEvent;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JDesktopPane;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JToolBar;
import javax.swing.JTree;
import javax.swing.KeyStroke;
import javax.swing.tree.TreePath;

import editor.src.org.crazyit.editor.commons.AddInfo;
import editor.src.org.crazyit.editor.commons.EditFile;
import editor.src.org.crazyit.editor.commons.WorkSpace;
import editor.src.org.crazyit.editor.handler.add.AddFileHandler;
import editor.src.org.crazyit.editor.handler.add.AddFolderHandler;
import editor.src.org.crazyit.editor.handler.add.AddProjectHandler;
import editor.src.org.crazyit.editor.handler.run.JavaRunHandler;
import editor.src.org.crazyit.editor.handler.save.SaveMediator;
import editor.src.org.crazyit.editor.handler.save.SaveMediatorConcrete;
import editor.src.org.crazyit.editor.tree.ProjectTreeModel;
import editor.src.org.crazyit.editor.tree.ProjectTreeNode;
import editor.src.org.crazyit.editor.tree.TreeCreator;

/**
 * �༭����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class EditorFrame extends JFrame {
	
	//���ļ���tab����
	private JTabbedPane tabPane;
	
	//���tabPane��desk
	private Box box;
	
	//����һ�����ĵ�����������
	private JDesktopPane desk;
	
	//���ڷָ����༭������Ϣ��ʾ��������
	private JSplitPane editorSplitPane;
	
	//���Թ�����JScrollPane�������ڷ�infoArea
	private JScrollPane infoPane;
	
	//������ʾ��Ϣ���ı���
	private JTextArea infoArea;
	
	//������Ŀɹ�������
	private JScrollPane treePane;
	
	//��������ķָ����������
	private JSplitPane mainSplitPane;
	
	//��Ŀ������
	private JTree tree;
	
	//�˵�������
	private JMenuBar menuBar;
	
	//�༭�˵�����
	private JMenu editMenu;
	
	//�ļ��˵�
	private JMenu fileMenu;
	
	//������
	private JToolBar toolBar;
	
	private WorkSpace workSpace;
	
	private TreeCreator treeCreator;
	
	//��ӵĽ���
	private AddFrame addFrame;
	
	//�ļ�ѡ����
	private FileChooser fileChooser;
	
	//��ǰ���ڱ༭���ļ�����
	private EditFile currentFile;
	
	//���ڼ�����
	private IFrameListener iframeListener;
	
	//���ļ��ļ���
	private List<EditFile> openFiles = new ArrayList<EditFile>();

	//�н��߶���
	private SaveMediator saveMediator;
	
	//����class�ļ��Ĵ�����
	private JavaRunHandler runHandler;
	
	//�½��ļ���Action����
	private Action fileNew = new AbstractAction("�½��ļ�", new ImageIcon("images/newFile.gif")) {
		public void actionPerformed(ActionEvent e) {
			newFile();
		}
	};
	//�½�Ŀ¼��Action����
	private Action folerNew = new AbstractAction("�½�Ŀ¼", new ImageIcon("images/newFile.gif")) {
		public void actionPerformed(ActionEvent e) {
			newFolder();
		}
	};
	//�½���Ŀ��Action����
	private Action projectNew = new AbstractAction("�½���Ŀ", new ImageIcon("images/newFile.gif")) {
		public void actionPerformed(ActionEvent e) {
			newProject();
		}
	};
	//���ļ���Action����
	private Action open = new AbstractAction("��     ��", new ImageIcon("images/open.gif")) {
		public void actionPerformed(ActionEvent e) {
			selectFile();
		}
	};
	//�����ļ���Action����
	private Action save = new AbstractAction("��     ��", new ImageIcon("images/save.gif")) {
		public void actionPerformed(ActionEvent e) {
			saveFile(getCurrentFile());
		}
	};
	//ˢ������Action����
	private Action refresh = new AbstractAction("ˢ     ��", new ImageIcon("images/refresh.gif")) {
		public void actionPerformed(ActionEvent e) {
			reloadNode(getSelectNode());
		}
	};
	//�����ļ���Action����
	private Action run = new AbstractAction("��     ��", new ImageIcon("images/run.gif")) {
		public void actionPerformed(ActionEvent e) {
			run();
		}
	};
	//�˳���Action����
	private Action exit = new AbstractAction("��     ��") {
		public void actionPerformed(ActionEvent e) {
			System.exit(0);//ֱ���˳�
		}
	};
	//�����ı���Action����
	private Action copy = new AbstractAction("��     ��", new ImageIcon("images/copy.gif")) {
		public void actionPerformed(ActionEvent e) {
			if (getCurrentFile() != null) {
				getCurrentFile().getEditPane().copy();
			}
		}
	};
	//�����ı���Action����
	private Action cut = new AbstractAction("��     ��", new ImageIcon("images/cut.gif")) {
		public void actionPerformed(ActionEvent e) {
			if (getCurrentFile() != null) {
				getCurrentFile().getEditPane().cut();
			}
		}
	};
	//ճ���ı���Action����
	private Action paste = new AbstractAction("ճ     ��", new ImageIcon("images/paste.gif")) {
		public void actionPerformed(ActionEvent e) {
			if (getCurrentFile() != null) {
				getCurrentFile().getEditPane().paste();
			}
		}
	};
	
	public EditorFrame(String title, TreeCreator treeCreator) {
		super(title); //���ñ���
		this.treeCreator = treeCreator;
		this.iframeListener = new IFrameListener(this);
		this.saveMediator = new SaveMediatorConcrete();
		this.runHandler = new JavaRunHandler();
	}
	
	public void initFrame(WorkSpace space) {
		this.workSpace = space;
		//���ô��ڹرգ��˳�����
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		//�������༭����tabPane
		tabPane = new JTabbedPane(JTabbedPane.TOP, JTabbedPane.SCROLL_TAB_LAYOUT );
		desk = new JDesktopPane();//����JDesktopPane����
		desk.setBackground(Color.GRAY);//����desk�ı�����ɫΪ��ɫ
		box = new Box(BoxLayout.Y_AXIS);//����box�Ĳ���
		box.add(tabPane);
		box.add(desk);
		//������Ϣ��ʾ�����ı���
		infoArea = new JTextArea("", 5, 50);
		//��infoArea�ı�����Ϊ����ŵ�infoPane��
		infoPane = new JScrollPane(infoArea);
		//������Ϣ�����ɱ༭
		infoArea.setEditable(false);
		//��������ָ����������������box�����infoPane��������
		editorSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, box, infoPane);
		editorSplitPane.setDividerSize(3);
		editorSplitPane.setDividerLocation(500);
		//������
		tree = treeCreator.createTree(this);
		//�����ɹ�������������
		treePane = new JScrollPane(tree);
		//�����������JSplitPane���������ΪtreePane���ұ�ΪeditorSplitPane
		mainSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, treePane, 
				editorSplitPane);
		//���÷ָ�����λ��
		mainSplitPane.setDividerLocation(200);
		//���÷ָ����Ĵ�ϸ
		mainSplitPane.setDividerSize(3);
		add(mainSplitPane);
		
		//�����˵�������
		menuBar = new JMenuBar();
		//�����༭�˵�����
		editMenu = new JMenu("�༭");
		//�����ļ��˵�
		fileMenu = new JMenu("�ļ�");
		//���ļ��˵���ӵ��˵�����
		menuBar.add(fileMenu);
		//���༭�˵���ӵ��˵�����
		menuBar.add(editMenu);
		//����JFrame�Ĳ˵���
		setJMenuBar(menuBar);
		
		toolBar = new JToolBar();
		toolBar.setFloatable(false);//���ù����������ƶ�
		toolBar.setMargin(new Insets(0, 10, 5, 5));//���ù������ı߾�
		add(toolBar, BorderLayout.NORTH);//����������ӵ�EditorFrame��
		
		pack();//ʹJFrame������Ѵ�С
		addListeners();
	}
	
	public TreeCreator getTreeCreator() {
		return treeCreator;
	}
	
	//ΪEditorFrame�е������Ӽ�����
	public void addListeners() {
		//�½��ļ��ļ�����
		fileMenu.add(fileNew).setAccelerator(KeyStroke.getKeyStroke('N', InputEvent.CTRL_MASK));
		//�½�Ŀ¼�ļ�����
		fileMenu.add(folerNew).setAccelerator(KeyStroke.getKeyStroke('F', InputEvent.CTRL_MASK));
		//�½���Ŀ�ļ�����
		fileMenu.add(projectNew).setAccelerator(KeyStroke.getKeyStroke('P', InputEvent.CTRL_MASK));
		//�򿪲˵���Ӽ�����
		fileMenu.add(open).setAccelerator(KeyStroke.getKeyStroke('O', InputEvent.CTRL_MASK));
		//Ϊ����˵���Ӽ�����
		fileMenu.add(save).setAccelerator(KeyStroke.getKeyStroke('S', InputEvent.CTRL_MASK));
		//Ϊˢ�²˵���Ӽ�����
		fileMenu.add(refresh).setAccelerator(KeyStroke.getKeyStroke("F5"));
		//Ϊ���в˵���Ӽ�����
		fileMenu.add(run).setAccelerator(KeyStroke.getKeyStroke('R', InputEvent.CTRL_MASK));
		fileMenu.add(exit);
		//��Ӹ��Ƽ�����
		editMenu.add(copy).setAccelerator(KeyStroke.getKeyStroke('C', InputEvent.CTRL_MASK));
		//��Ӽ��м�����
		editMenu.add(cut).setAccelerator(KeyStroke.getKeyStroke('X', InputEvent.CTRL_MASK));
		//���ճ��������
		editMenu.add(paste).setAccelerator(KeyStroke.getKeyStroke('V', InputEvent.CTRL_MASK));
	
		//Ϊ��������Ӹ�������
		toolBar.add(fileNew).setToolTipText("�½��ļ�");
		toolBar.add(open).setToolTipText("��");
		toolBar.add(save).setToolTipText("����");
		toolBar.add(refresh).setToolTipText("ˢ��");
		toolBar.add(run).setToolTipText("����");
		toolBar.add(copy).setToolTipText("����");
		toolBar.add(cut).setToolTipText("����");
		toolBar.add(paste).setToolTipText("ճ��");
		
		//ΪtabPane��Ӽ�����
		tabPane.addChangeListener(new TabListener(this));
	}
	
	//��ȡ�༭����������Ŀ������ѡ�еĽڵ�
	public ProjectTreeNode getSelectNode() {
		//��õ�ǰ��ѡ��Ľڵ������е�·��
		TreePath path = tree.getSelectionPath();
		//�����ǰѡ���˽ڵ�
		if (path != null) {
			//����һ��ProjectTreeNode�������ڷ���
			ProjectTreeNode selectNode = (ProjectTreeNode)path.getLastPathComponent();
			return selectNode;
		}
		//��ǰû��ѡ��ھͷ���null
		return null;
	}
	
	//��ʾiframe����
	public void showIFrame(JInternalFrame iframe) {
		try {
			iframe.setSelected(true);
			iframe.toFront();
		} catch (Exception ex) {
		}
	}
	
	//���ļ��ķ���
	public void openFile(File file) {
		if (currentFile != null) {
			//�������file�ǵ�ǰ���ڱ༭���ļ�
			if (file.equals(currentFile.getFile())) return;
		}
		//�ڴ��ļ��ļ����в��Ҹ��ļ�, ���жϸ��ļ��Ƿ��Ѿ���
		EditFile openedFile = getOpenFile(file);
		//����ļ��Ѿ����ˣ����ô򿪷��������Ѿ��ڱ༭tabҳ������ʾ���ļ���
		if (openedFile != null) {
			openExistFile(openedFile, file);
			return;
		}
		//���µ��ļ�
		openNewFile(file);
	}
	
	//�ӱ����м�¼�Ѿ��򿪵��ļ������еõ������fileһ����EditFile����
	private EditFile getOpenFile(File file) {
		for (EditFile openFile : openFiles) {
			if (openFile.getFile().equals(file)) return openFile;
		}
		return null;
	}
	
	//���ݲ���file��ȡ��file��Ӧ��tabҳ�е�����
	private int getFileIndex(File file) {
		//����Ӵ��ļ��ļ������Ҳ��������file��Ӧ��EditFile���󣬷���-1
		EditFile openFile = getEditFile(file);
		if (openFile == null) return -1;
		return getTabIndex(openFile.getIframe().getToolTipText());
	}
	
	//�ڴ򿪵��ļ��л���ļ���file��EditFile����
	private EditFile getEditFile(File file) {
		for (EditFile openFile : openFiles) {
			if (openFile.getFile().equals(file)) return openFile;
		}
		return null;
	}
	
	//����tabҳ�е�tips�ҵ�����Ӧ����tabPane������
	public int getTabIndex(String tips) {
		for (int i = 0; i < this.tabPane.getTabCount(); i++) {
			if (this.tabPane.getToolTipTextAt(i).equals(tips)) return i;
		}
		return -1;
	}
	
	//���Ѿ����ڵ��ļ����Ѿ��ڱ༭�ļ������е��ļ�����openFiles�����е��ļ�
	public void openExistFile(EditFile openedFile, File willOpenFile) {
		//��tabҳ��ɵ�ǰ��ѡ���ļ�������
		tabPane.setSelectedIndex(getFileIndex(willOpenFile));
		//��ʾiframe
		showIFrame(openedFile.getIframe());
		//���õ�ǰ���ļ�
		this.currentFile = openedFile;
		//��ӵ���ǰ�򿪵��ļ�������
		this.openFiles.add(openedFile);
	}
	
	//��һ�����ļ������ļ������ڱ༭�б��У�
	public void openNewFile(File file) {
		//����EditorFrame�ı���Ϊ���ļ���ȫ·��
		setTitle(file.getAbsolutePath());
		//����һ��JInternalFrame����titleΪ�ļ��ľ���·��
		JInternalFrame iframe = new JInternalFrame(file.getAbsolutePath(), true, true, true, true);
		
		//�½�һ��EditPane����
		EditPane editPane = new EditPane(file);
		
		//ΪEditPane��Ӽ��̼�����
		editPane.getDocument().addDocumentListener(new EditDocumentListener(this));
		iframe.add(new JScrollPane(editPane));
		//ΪJInternalFrame��Ӵ��ڼ�����
		iframe.addInternalFrameListener(this.iframeListener);
		desk.add(iframe);
		iframe.show();
		iframe.reshape(0, 0, 400, 300);
		tabPane.addTab(file.getName(), null, null, file.getAbsolutePath());
		tabPane.setSelectedIndex(tabPane.getTabCount() - 1);
		//���õ�ǰ���ļ�����
		this.currentFile = new EditFile(file, true, iframe, editPane);
		//����ǰ���ļ��ӵ��򿪵��ļ�������
		this.openFiles.add(this.currentFile);
	}
	
	public void selectFile() {
		fileChooser = new FileChooser(this);
	}
	
	//�½��ļ��ķ���
	public void newFile() {
		//��û��ѡ��һ���ڵ���½�Ŀ¼��ʱ����Ҫ����
		if (getSelectNode() == null) {
			JOptionPane.showMessageDialog(this, "��ѡ��Ŀ¼"); 
			return;
		}
		AddInfo info = new AddInfo("�ļ����ƣ�", this, new AddFileHandler());
		showAddFrame(info);
	}
	//��ʾ�����Ľ���
	private void showAddFrame(AddInfo info) {
		//ʹEditorFrame��Ϊ������
		setEnabled(false);
		addFrame = new AddFrame(info);
		addFrame.pack();
		addFrame.setVisible(true);
	}
	
	//ˢ�����ڵ�
	public void reloadNode(ProjectTreeNode selectNode) {
		if (selectNode == null) return; 
		//ˢ�����Ľڵ�
		ProjectTreeModel model = (ProjectTreeModel)getTree().getModel();
		//���¼�����ѡ��Ľڵ�
		model.reload(selectNode, treeCreator);
	}
	
	public WorkSpace getWorkSpace() {
		return workSpace;
	}
	
	public JTree getTree() {
		return this.tree;
	}
	
	//�½�Ŀ¼�ķ���
	public void newFolder() {
		//��û��ѡ��һ���ڵ���½�Ŀ¼��ʱ����Ҫ����
		if (getSelectNode() == null) {
			JOptionPane.showMessageDialog(this, "��ѡ��Ŀ¼"); 
			return;
		}
		AddInfo info = new AddInfo("Ŀ¼���ƣ�", this, new AddFolderHandler());
		showAddFrame(info);
	}
	
	//�½���Ŀ�ķ���
	public void newProject() {
		AddInfo info = new AddInfo("��Ŀ���ƣ�", this, new AddProjectHandler());
		showAddFrame(info);
	}
	
	//������treePane�й���һ����
	public void refreshTree(JTree newTree) {
		//��tree�����Ϊ�����е�newTree
		this.tree = newTree;
		//��treePane������������������newTreeΪ�µ���ͼ
		treePane.setViewportView(newTree);
		//���½���
		treePane.updateUI();
	}

	public EditFile getCurrentFile() {
		return currentFile;
	}

	public void setCurrentFile(EditFile currentFile) {
		this.currentFile = currentFile;
	}

	public List<EditFile> getOpenFiles() {
		return openFiles;
	}

	public JDesktopPane getDesk() {
		return desk;
	}

	public JTabbedPane getTabPane() {
		return tabPane;
	}
	
	//����JInternalFrame�����ҵ�JInternalFrame����
	public JInternalFrame getIFrame(String title) {
		JInternalFrame[] iframes = desk.getAllFrames();
		for (JInternalFrame iframe : iframes) {
			if (iframe.getTitle().equals(title)) return iframe;
		}
		return null;
	}
	
	//����JInternalFrame�ڴ򿪵��ļ������л�ȡ��Ӧ���ļ�����
	public EditFile getEditFile(JInternalFrame iframe) {
		for (EditFile openFile : openFiles) {
			if (openFile.getIframe().equals(iframe)) return openFile;
		}
		return null;
	}
	
	//ѯ���Ƿ�Ҫ����, ����Ϊ�����򿪵��ļ�
	public void askSave(EditFile file) {
		//�÷��ļ��޸Ĺ�û�б���
		if (!file.isSaved()) {
			//����ѯ��
			int val = JOptionPane.showConfirmDialog(this, "�Ƿ�Ҫ���棿", "ѯ��", 
					JOptionPane.YES_NO_OPTION);
			//�������Ҫ����
			if (JOptionPane.YES_OPTION == val) {
				//����EditorFrame�ı��淽�����ļ����б���
				saveFile(file);
			}
		}
	}
	
	//���ڱ��浱ǰ���򿪵��ļ�
	public void saveFile(EditFile file) {
		if (file == null) return;
		//�����н��߶���ķ���ȥ�����ļ�
		String result = saveMediator.doSave(this);
		//������ŵ���Ϣ��ʾ�����ı�����
		infoArea.setText(result);
		//д���ļ������õ�ǰ�ļ��ı���״̬Ϊtrue����ʾ�Ѿ�����
		file.setSaved(true);
	}
	
	//�ر�һ������
	public void closeIFrame(JInternalFrame iframe) {
		//��õ�ǰ���ļ�����Ҫ�رյ��ļ�����
		EditFile closeFile = getEditFile(iframe);
		//���ñ����е�currentFile����
		afterClose(closeFile);
		//��ø�iframe��tabҳ�ж�Ӧ������
		int index = getTabIndex(iframe.getTitle());
		//��tabҳ��ɾ��
		getTabPane().remove(index);
		//�Ӵ򿪵��ļ�������ɾ������رյ��ļ�
		openFiles.remove(closeFile);
	}
	
	//���ر�һ���ļ������ñ������currentFile����
	private void afterClose(EditFile closeFile) {
		//��ȡ�ر��ļ��ڴ��ļ������е�����
		int openFilesIndex = getEditFileIndex(closeFile);
		//������ļ��Ѿ������д򿪵��ļ������һ��
		if (this.openFiles.size() == 1) {
			this.currentFile = null;
		} else {//������������ļ����жϹرյ��ļ�λ��
			if (openFilesIndex == 0) {
				//����رյ��ļ��ǵ�һ�ݣ��ü����еĵڶ���
				this.currentFile = openFiles.get(openFilesIndex + 1);
			} else if (openFilesIndex == (openFiles.size() - 1)) {
				//����رյ������һ�ݣ�ȡ�����ڶ���
				this.currentFile = openFiles.get(openFiles.size() - 2);
			} else {
				//���ǵ�һ�ݣ�Ҳ�������һ��
				this.currentFile = openFiles.get(openFilesIndex - 1);
			}
		}
	}
	
	//��ȡeditFile�ڴ򿪵��ļ������е�����
	private int getEditFileIndex(EditFile editFile) {
		for (int i = 0; i < this.openFiles.size(); i++) {
			if (openFiles.get(i).equals(editFile)) return i;
		}
		return -1;
	}
	
	//������Ŀ����ǰ��ѡ�еĽڵ���������Ŀ�ڵ��Ӧ��Ŀ¼
	public File getCurrentProject() {
		//��ȡ���ڵ�(�����ռ�)
		ProjectTreeNode root = (ProjectTreeNode)getSelectNode().getRoot();
		//��ȡ���ڵ��µ������ӽڵ㣨����Ŀ�ڵ㼯�ϣ�
		List<ProjectTreeNode> projects = root.getChildren();
		ProjectTreeNode selectNode = getSelectNode();
		if (selectNode != null) {
			for (ProjectTreeNode project : projects) {
				//��ǰ���нڵ��Ǹ�project�µ��ӽڵ�
				if (selectNode.isNodeAncestor(project)) {
					return project.getFile();
				}
			}
		}
		return null;
	}
	
	//�����ļ��ķ���
	public void run() {
		//����ǰ�ȱ���
		saveFile(getCurrentFile());
		//�������ʾ
		String result = runHandler.run(this);
		infoArea.setText(result);
	}
	
}
class FileChooser extends JFileChooser {
	
	private EditorFrame editorFrame;
	
	
	public FileChooser(EditorFrame editorFrame){
		//���ø���Ĺ�����
		//����editorFrame�Ĺ����ռ���Ϊ�ļ�ѡ������ʱ��Ĭ��Ŀ¼
		super(editorFrame.getWorkSpace().getFolder());
		this.editorFrame = editorFrame;
		showOpenDialog(editorFrame);
	}
	
	public void approveSelection() {
		File file = getSelectedFile();
		//��������ǰѡ��Ľڵ�Ϊnull, ����û�б�ѡ��
		this.editorFrame.getTree().setSelectionPath(null);
		this.editorFrame.openFile(file);
		super.approveSelection();
	}
}