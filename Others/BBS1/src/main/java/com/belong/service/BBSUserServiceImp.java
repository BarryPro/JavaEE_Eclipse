package com.belong.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.util.Streams;

import com.belong.dao.BBSUserDAOImpl;
import com.belong.dao.IBBSUserDAO;
import com.belong.vo.BBSUser;

public class BBSUserServiceImp implements IBBSUserService {
	private IBBSUserDAO dao = new BBSUserDAOImpl();
	private File saveFile= null;//保存的文件夹
	private Map<String,String> type = new HashMap<String,String>();
	public BBSUserServiceImp(){
		type.put("image/jpeg",".jpg");
		type.put("image/gif",".gif");
		type.put("image/x-ms-bmp",".bmp");
		type.put("image/png",".png");		
	}
	@Override
	public BBSUser login(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.login(user);
	}
	@Override
	public boolean register(BBSUser user) {
		// TODO Auto-generated method stub
		return dao.register(user);
	}
	@Override
	public BBSUser upload(String tpath,FileItemIterator fi) {
		BBSUser user = new BBSUser();//存放注册的新用户
		// TODO Auto-generated method stub
		try {
			while(fi.hasNext()){
				FileItemStream fs = fi.next();//得到上传组件的文件流		
				InputStream is = fs.openStream();//把文件流变成输入输出流
				String fieldname = fs.getFieldName();//组件名（file0 reusername repassword）（用来记录form中的组建的名字的）				
				if(!fs.isFormField()&&fs.getName().length()>0){//说明上传的图片不是空
					String contenttype = fs.getContentType();//得到上传的文件流的contentType类型（区分二进制流还是键直对）
					if(!type.containsKey(contenttype)){//不符合文件后缀
						break;
					}
					BufferedInputStream bis = new BufferedInputStream(is);
					String upload = System.getProperty("file.separator")+"upload";//路径为/upload
					UUID id = UUID.randomUUID();
					String filename = id.toString()+type.get(contenttype);//生成文件名（必须是全球唯一的）
					String upath = tpath+upload+System.getProperty("file.separator")+filename;//得到完整的文件名
					saveFile = new File(upath);//得到与tomcat相连的绝对路径+文件名
					BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(saveFile));
					Streams.copy(bis, bos, true);//上传文件到tomcat服务器
					user.setPath(upath);//mysql中的pic
				} else {//上传的是form中的内容(纯键直对)
					switch (fieldname) {
					case "reusername":
						String username = Streams.asString(is,"utf-8");
						user.setUsername(username);//mysql中的username
						break;
					case "repassword":
						String password = Streams.asString(is,"utf-8");
						user.setPassword(password);//mysql中的password
						break;
					default:
						break;
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return user;
	}
	@Override
	public byte[] getPic(int id) {
		// TODO Auto-generated method stub
		return dao.getPic(id);
	}
	@Override
	public boolean editPageNum(int pagenum, int userid) {
		// TODO Auto-generated method stub
		return dao.editPageNum(pagenum, userid);
	}
		
}
