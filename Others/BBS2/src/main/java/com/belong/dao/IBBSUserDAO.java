package com.belong.dao;

import com.belong.vo.BBSUser;

public interface IBBSUserDAO {
	public BBSUser login(BBSUser user);
	public boolean register(BBSUser user);
	public byte[] getPic(int id);
	public boolean editPagenum(int pagenum,int userid);//通过文章中关联用户id来修改每页多少笔帖子
}
