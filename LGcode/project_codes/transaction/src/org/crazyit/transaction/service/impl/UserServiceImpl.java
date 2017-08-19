package org.crazyit.transaction.service.impl;

import java.util.List;

import transaction.src.org.crazyit.transaction.dao.RoleDao;

public class UserServiceImpl implements UserService {

	private UserDao userDao;
	
	private RoleDao roleDao;
	
	public UserServiceImpl(UserDao userDao, RoleDao roleDao) {
		this.userDao = userDao;
		this.roleDao = roleDao;
	}
	
	public void login(String userName, String passwd) {
		User user = this.userDao.findUser(userName, passwd);
		//û���ҵ��û�, �׳��쳣
		if (user == null) throw new BusinessException("�û����������");
		Role role = this.roleDao.find(user.getROLE_ID());
		user.setRole(role);
		ApplicationContext.loginUser = user;
	}

	public List<User> getUsers() {
		List<User> users = this.userDao.findUsers();
		for (User u : users) {
			Role role = this.roleDao.find(u.getROLE_ID());
			u.setRole(role);
		}
		return users;
	}

	/*
	 * ����û�
	 * @see org.crazyit.transaction.service.UserService#addUser(org.crazyit.transaction.model.User)
	 */
	public void addUser(User user) {
		//�����µ��û���ȥ����, �ж��Ƿ������ͬ�û������û�
		User u = this.userDao.findUser(user.getUSER_NAME());
		if (u != null) throw new BusinessException("���û����Ѿ�����");
		this.userDao.save(user);
	}

	/*
	 * ɾ���û�, ���û���IS_DELETE������Ϊ1
	 * @see org.crazyit.transaction.service.UserService#delete(java.lang.String)
	 */
	public void delete(String id) {
		//���һ���û�����ɾ��
		if (this.userDao.getUserCount() <= 1) {
			throw new BusinessException("���һ���û�����ɾ��");
		}
		this.userDao.delete(id);
	}

	public List<User> query(String realName) {
		List<User> users = this.userDao.query(realName);
		for (User u : users) {
			Role role = this.roleDao.find(u.getROLE_ID());
			u.setRole(role);
		}
		return users;
	}

	
}
