package com.belong.service;

import com.belong.dao.IUserDao;
import com.belong.dao.UserDaoImp;
import com.belong.vo.User;

public class UserServiceImp implements IUserService {
	private IUserDao dao = new UserDaoImp();
	@Override
	public boolean login(User user) {
		// TODO Auto-generated method stub
		return dao.login(user);//��dao����login�����ݿ���ʵĵ�¼���
	}

}
