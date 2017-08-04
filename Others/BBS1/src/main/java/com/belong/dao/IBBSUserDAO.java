package com.belong.dao;

import com.belong.vo.BBSUser;

public interface IBBSUserDAO {
	public BBSUser login(BBSUser user);
	public boolean register(BBSUser user);
	public byte[] getPic(int id);
	public boolean editPageNum(int pagenum,int userid);
}
