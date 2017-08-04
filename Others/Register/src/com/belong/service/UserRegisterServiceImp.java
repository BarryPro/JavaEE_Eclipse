package com.belong.service;

import com.belong.dao.IUserDao;
import com.belong.dao.UserDaoRegisterImp;
import com.belong.vo.User;

public class UserRegisterServiceImp implements IUserService {
	IUserDao dao = new UserDaoRegisterImp();
	@Override
	public boolean login(User user) {
		// TODO Auto-generated method stub
		return dao.login(user);
	}

}
