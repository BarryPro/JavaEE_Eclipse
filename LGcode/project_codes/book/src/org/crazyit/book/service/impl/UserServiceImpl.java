package org.crazyit.book.service.impl;

/**
 * �û�ҵ��ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class UserServiceImpl implements UserService {

	private UserDao userDao;
	
	public UserServiceImpl(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public void login(String name, String password) {
		User user = userDao.getUser(name, password);
		if (user == null) {
			throw new BusinessException("�û����������");
		}
	}

}
