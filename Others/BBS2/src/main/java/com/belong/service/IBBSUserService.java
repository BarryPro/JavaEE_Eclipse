package com.belong.service;

import org.apache.commons.fileupload.FileItemIterator;

import com.belong.vo.BBSUser;

public interface IBBSUserService {
	public BBSUser login(BBSUser user);
	public boolean register(BBSUser user);
	public byte[] getPic(int id);
	public BBSUser upload(String tpath,FileItemIterator fii);//上传到tomcat服务器上
	public boolean editPagenum(int pagenum,int userid);
}
