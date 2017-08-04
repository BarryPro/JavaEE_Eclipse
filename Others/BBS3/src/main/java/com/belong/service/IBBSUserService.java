package com.belong.service;

import org.apache.commons.fileupload.FileItemIterator;

import com.belong.vo.BBSUser;

public interface IBBSUserService {
	public BBSUser ligin(BBSUser user);
	public boolean register(BBSUser user);
	public BBSUser upload(FileItemIterator fii,String tpath);
	public byte[] getPic(int id);
	public boolean editPagenum(int id,int pagenum);
}
