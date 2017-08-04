<%@page import="java.text.SimpleDateFormat"%><%@ page import="java.util.*"
	import="java.io.*"
	import="org.apache.commons.io.FileUtils"
	import="com.sitech.crmpd.core.ijdbc.sql.*"
	import="com.sitech.crmpd.core.ijdbc.*"
	import="org.apache.commons.fileupload.*"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%
	DiskFileUpload diskFileUpload = new DiskFileUpload();
	diskFileUpload.setHeaderEncoding("GBK");
	request.setCharacterEncoding("UTF-8");
	// 设置允许用户上传文件大小,单位:字节，这里设为2m
	diskFileUpload.setSizeMax(10024000);
	// 设置最多只允许在内存中存储的数据,单位:字节
	diskFileUpload.setSizeThreshold(10024000);
	// 设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录
	 
	//diskFileUpload.setRepositoryPath("c:/testupload");
	// 开始读取上传信息
	List fileItems;
	try {
		fileItems = diskFileUpload.parseRequest(request);

		// 依次处理每个上传的文件
		Iterator iter = fileItems.iterator();
		System.out.println("file size:\t" + fileItems.size());
		while(iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (!item.isFormField()) {
				
				/*对上传附件的大小进行校验,当超过最大的限制的时候弹出对话框.数据库的配置文件.START#########*/
				SqlFind sqlfind = new SqlFind();
				String sql_0 = " SELECT T.CONF_VALUE FROM DNOTICECONF T WHERE T.CONF_NAME = 'MAX_ATTACHEMENT_SIZE'  ";
				List list_0 = sqlfind.findList(sql_0);
				if (list_0.size() > 0) {
					try {
						String[] col = (String[])list_0.get(0);
						if(item.getSize() > Long.parseLong(col[0])){
						String errorMsg = "";
						errorMsg = "<script language=javascript>"
								+ "parent.location.href='javaScript:attachmentMaxError();';"
								+ "</script>";
						// 将错误信息显示到页面上直接输出一个调用父节点显示函数.就可以.
						out.write(errorMsg);
						System.out.println("#################文件超过限制.");
						return;
						}
						// 显示信息.
					}catch (IOException e2) {
						e2.printStackTrace();
					}
				}
				/*END#########*/
				
				/*下面开始上传的代码*****************/
				// core.web.interceptor.FileUploadInterceptor
				String uploadFileName = "" + item.getName();
				String uploadFileType = "";
				if (uploadFileName.lastIndexOf("\\") != -1) {
					uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
				}// 添加文件的后缀.如果后缀没有.就添加默认的后缀.
				if (uploadFileName.lastIndexOf(".") != -1) {
					uploadFileType += uploadFileName.substring(uploadFileName.lastIndexOf("."));
				}// 添加文件的后缀.如果后缀没有.就添加默认的后缀.
				else {
					uploadFileType += ".tmp";
				}
				System.out.println(uploadFileType+"#################" + uploadFileName);
				String noteId = ( null == request.getParameter("noteId") ? "" : request.getParameter("noteId") );
				// 得到服务器路径.这样通过request进行直接得到.而不是通过配置文件得到.
				String webContentDir = com.sitech.crmpd.core.util.SystemUtils.getConfigByMap("Note_Upload_Dir");
				// 新的名字.
				String newFileName = "";
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy_MM_dd");
				String dateFolder = fmt.format(new Date());
				File dateFile = new File(webContentDir+ "/" +dateFolder);
				if (!dateFile.isDirectory()) {
					dateFile.mkdirs();
				}
				newFileName = dateFolder+ "/" + noteId + "_" + dateFolder + "_"
						+ System.currentTimeMillis() + uploadFileType;
				// 生成新文件的格式是: 公告ID + 年月日+ 随机数 + 文件后缀(没有使用.tmp)
				System.out.println("#################" + webContentDir);
				try {
					/*FileUtils.copyFile(upFile, new File(webContentDir + newFileName));*/
					item.write(new File(webContentDir + newFileName));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String noteAttachmentId = "";

				sqlfind = new SqlFind();
				String sql_1 = " SELECT SEQ_NOTEATTACHMENT_ID.NEXTVAL FROM DUAL ";
				List list = sqlfind.findList(sql_1);
				if (list.size() > 0) {
					noteAttachmentId = ((String[]) list.get(0))[0];
				}

				// select SEQ_PUBLICNOTE_ID.nextval from dual

				SqlChange change = new SqlChange();
				String sql_2 = " INSERT INTO  DNOTEATTACHMENT(ID,NOTE_ID,ATTACHEMENT_NAME,ATTACHEMENT_TYPE,ATTACHEMENT_PATH) "
						+ " VALUES (?,?,?,?,?) ";
				// 将附件信息插入到数据库里面.
				change.addParam(new SqlParameter("ID", SqlTypes.VARCHAR,
						noteAttachmentId));
				// 这个地方不能直接将seq 放到insert sql.要先查询.
				change.addParam(new SqlParameter("NOTE_ID", SqlTypes.VARCHAR, noteId));
				// 绑定的当前的公告的id
				change.addParam(new SqlParameter("ATTACHEMENT_NAME", SqlTypes.VARCHAR,
						uploadFileName));
				// 上传文件名称.有可能是中文.
				change.addParam(new SqlParameter("ATTACHEMENT_TYPE", SqlTypes.VARCHAR,
						uploadFileType));
				// 上传文件类型.
				change.addParam(new SqlParameter("ATTACHEMENT_PATH", SqlTypes.VARCHAR,
						newFileName));
				// 上传文件保存到服务器的名称.因为是linux服务器.所有是数字保存.
				change.execute(sql_2);
				// 执行插入数据库.

				String jsMsg = "";
				try {
					jsMsg = "<script language=javascript>"
							+ "parent.location.href='javaScript:showAttachment();';"
							+ "</script>";
					// 将错误信息显示到页面上直接输出一个调用父节点显示函数.就可以.
					out.write(jsMsg);
					// 显示信息.
				} catch (IOException e2) {
					System.out.println("***************上传报错开始**********");
					e2.printStackTrace();
					System.out.println("***************上传报错结束**********");
				}
			}

		}
	} catch (Exception e) {
		System.out.println("***************上传报错结束**********"+e.getMessage());
		String errorMsg = "";
		errorMsg = "<script language=javascript>"
				+ "parent.location.href='javaScript:attachmentMaxError();';"
				+ "</script>";
		// 将错误信息显示到页面上直接输出一个调用父节点显示函数.就可以.
		out.write(errorMsg);
	}
%>