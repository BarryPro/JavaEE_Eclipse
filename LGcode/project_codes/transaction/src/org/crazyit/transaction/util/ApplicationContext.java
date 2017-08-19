package org.crazyit.transaction.util;

import transaction.src.org.crazyit.transaction.dao.CommentDao;
import transaction.src.org.crazyit.transaction.dao.LogDao;
import transaction.src.org.crazyit.transaction.dao.RoleDao;
import transaction.src.org.crazyit.transaction.dao.TransactionDao;
import transaction.src.org.crazyit.transaction.dao.UserTransferDao;
import transaction.src.org.crazyit.transaction.dao.impl.CommentDaoImpl;
import transaction.src.org.crazyit.transaction.dao.impl.LogDaoImpl;
import transaction.src.org.crazyit.transaction.dao.impl.RoleDaoImpl;
import transaction.src.org.crazyit.transaction.dao.impl.TransactionDaoImpl;
import transaction.src.org.crazyit.transaction.dao.impl.UserTransferDaoImpl;
import transaction.src.org.crazyit.transaction.service.CommentService;
import transaction.src.org.crazyit.transaction.service.RoleService;
import transaction.src.org.crazyit.transaction.service.impl.CommentServiceImpl;
import transaction.src.org.crazyit.transaction.service.impl.RoleServiceImpl;
import transaction.src.org.crazyit.transaction.service.impl.TransactionServiceImpl;

/**
 * Ӧ��������
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ApplicationContext {

	//ϵͳ��¼�û�
	public static User loginUser;

	public static UserDao userDao;
	
	public static RoleDao roleDao;
	
	public static RoleService roleService;
	
	public static UserService userService;
	
	public static TransactionDao transactionDao;
	
	public static TransactionService transactionService;
	
	public static CommentDao commentDao;
	
	public static CommentService commentService;
	
	public static UserTransferDao userTransferDao;
	
	public static LogDao logDao;
	
	static {
		logDao = new LogDaoImpl();
		roleDao = new RoleDaoImpl();
		roleService = new RoleServiceImpl(roleDao);
		userDao = new UserDaoImpl();
		userTransferDao = new UserTransferDaoImpl();
		userService = new UserServiceImpl(userDao, roleDao);
		transactionDao = new TransactionDaoImpl();
		commentDao = new CommentDaoImpl();
		transactionService = new TransactionServiceImpl(transactionDao, userDao, 
				commentDao, userTransferDao, logDao);
		
		commentService = new CommentServiceImpl(commentDao, transactionDao, userDao);
	}

}
