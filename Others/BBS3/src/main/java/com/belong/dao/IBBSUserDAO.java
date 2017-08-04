package com.belong.dao;

import com.belong.vo.BBSUser;

public interface IBBSUserDAO {
	public BBSUser login(BBSUser user);//登录成功就返回登录成功的对象
	public boolean register(BBSUser user);//注册用户
	public byte[] getPic(int id);//返回的是图片的字节数组
	public boolean editPagenum(int id,int pagenum);//设置用户的默认一页有几笔帖子
}
