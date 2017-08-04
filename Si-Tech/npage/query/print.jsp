<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.common.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	 String opCode=request.getParameter("opCode");
	 String opName=request.getParameter("opName");
   String fileName = request.getParameter("fileName");
   String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");;
   String path = DETAIL_PATH + fileName;
   System.out.println("--liujian--path=" + path);
// String path = request.getRealPath("/npage/1tes/test.txt");
// String allTr = parseDocument(path,-1);
   
   String ip = request.getRemoteAddr();
	 String workNo = (String)session.getAttribute("workNo");
   /* 水印 */
	 String str = ip + "    " + workNo;
   String imageName = ip+workNo+".jpg";
   String imagePath = application.getRealPath("/") + "/npage/query/img/" + imageName;
   System.out.println(imagePath + "===============imagePath");
   int width = 600;
	 int height = 250;
	 float alpha = 0.5f;
   CreateImg.drawImage(str, imagePath, width, height, alpha);
%>
<head>
	<title>详单查询</title>
	<link href="detail.css" rel="stylesheet" type="text/css"></link>
	<script language="VBScript">
			dim hkey_root,hkey_path,hkey_key,doPrint,RegWsh
			hkey_root="HKEY_CURRENT_USER"
			hkey_path="\Software\Microsoft\Internet Explorer"
			doPrint="yes"
			
			Set RegWsh =CreateObject("WScript.Shell")
			
			//设置打印背景图片
			//on error resume next
			hkey_key=hkey_root+hkey_path+"\Main\Print_Background"
			//MsgBox hkey_key
			RegWsh.RegWrite hkey_key,doPrint
			//关闭RegWsh
			set RegWsh=nothing
	</script>
	<script>
		$(function() {
      window.print();
      window.close();
		})
	</script>
</head>

<body onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
	<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">中国移动通信客户详单</div>
		</div>
		<div style="background-image:url(/npage/query/img/<%=imageName%>)" id="detailDiv">
				<%
					if(exsitFile(path)) {
							File file = new File(path);
							StringBuffer sb = new StringBuffer("");
							InputStreamReader isr = null;
							BufferedReader br = null;
							try{
								isr = new InputStreamReader(new FileInputStream(file), "GBK");
								br = new BufferedReader(isr);
								//0:currLine；1：beforeLine
								String[] beforeAndcurrLines = new String[2];
								String s = null;
								int currNum = 0;
								while((s = br.readLine()) != null) {
									currNum++;
									if(s.startsWith("title")) {
										currTitleLine = s;
									}
									//填充数组
									if(beforeAndcurrLines[0] == null ) {
										beforeAndcurrLines[0] = s;
									}else {
										beforeAndcurrLines[1] = beforeAndcurrLines[0];
										beforeAndcurrLines[0] = s;
									}
									//设置行的html样式，包括设置table
									out.println(setTr(beforeAndcurrLines).toString());
								}
								out.println("</table>");
							}catch(Exception e) {
								retCode = "000003";
					 	 		retMsg = "文件处理异常！";
							}finally {
								try{
									br.close();
									isr.close();
									System.out.println("关闭数据流");
								}catch(Exception e) {
									System.out.println("数据流为空");
								}
							}
					}
					
				%>
		</div>
	</form>
</body>
</html>

<%!
	   String retCode = "111111";
 	   String retMsg = "文件不存在！";
		 //判断文件是否存在
		 public boolean exsitFile(String path) {
				File file = new File(path);
				if (!file.exists() || file.isDirectory() || !file.canRead()) {
						retCode = "000001";
 	 					retMsg = "文件不存在！";
				    return false;
				}else {
					return true;
				}
			}
			
			//判断是否末尾是空白行
			public boolean lastLineIsBlank(File file) throws IOException {
			  RandomAccessFile raf = null;
			  try {
			    raf = new RandomAccessFile(file, "r");
			    long len = raf.length();
			    if (len == 0L) {
			    	retCode = "000002";
 	 					retMsg = "文件存在，文件大小为0！";
			      return false;
			    } else {
			      long pos = len - 1;
			      raf.seek(pos);
		    	  if( raf.readByte() == '\n' ) {
				    	return true;
				  	}
			    }
			  } catch (FileNotFoundException e) {
			  		retCode = "000003";
 	 					retMsg = "文件处理异常！";
			  } finally {
			    if (raf != null) {
			      try {
			        raf.close();
			      } catch (Exception e2) {
			      }
			    }
			  }
			  return false;
		}
	
		// 获得文件的行数,去掉空白行
		public int getLineNumber(String path) {
			int number = 0;
			File file = new File(path);
			long fileLength = file.length();
			LineNumberReader rf = null;
			try {
				rf = new LineNumberReader(new FileReader(file));
				if (rf != null) {
					rf.skip(fileLength);
					number = rf.getLineNumber();
					//行数不为1或者只有一行，并且此行不为空
					if(number != 0 || (number == 0 && fileLength != 0L)) {
						number++;
					}
					rf.close();
				}
				//如果存在空白行，去掉。规定最多只有一个空白行
				if(number >0 && lastLineIsBlank(new File(path))) {
					  number--;
				}
			} catch (IOException e) {
				if (rf != null) {
					try {
						retCode = "000003";
 	 					retMsg = "文件处理异常！";
						rf.close();
					} catch (IOException ee) {
						retCode = "000003";
 	 					retMsg = "文件处理异常！";
					}
				}
			}
			return number;
		}
	
	//设置html一行的数据
	public StringBuffer setTr(String[] beforeAndcurrLines) {
		System.out.println("---liujian---337---setTr begin ---");
		char beforeLineFirstChar = '0'; //默认为0
		boolean isFirstLine = true; 
		if(beforeAndcurrLines[1] != null) {
			beforeLineFirstChar = beforeAndcurrLines[1].charAt(0);
			isFirstLine = false;
		}
		StringBuffer sb = new StringBuffer();
		//切割行数据，获得每一个字段,-1是因为出现|||这种的情况，有竖线就切割，最后总数-1
		String[] fields = beforeAndcurrLines[0].split("\\|",-1);
		
		//第一个字段可能是：cust/g/body/head/title/span/foot
		//利用正则去掉数字,或者匹配字符
		switch(fields[0].charAt(0)) {
			case 'c' : {
				if(beforeLineFirstChar == '0') {
					sb.append("<table cellspacing=\"0\" style=\"background:;\">");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'g' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table class=\"g\" cellspacing=\"0\" style=\"background:;\">").append("<tr><td>").append(fields[1]).append("</td></tr>");
				break;
			}
			case 'h' : {
				if(beforeLineFirstChar == 'h') {
					sb.append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == 'g') {
					sb.append("</table>");
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == '0' && isFirstLine) { //第一行
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				break;
			}
			case 't' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'b' : {
				if(isFirstLine) {
					//添加标题
					String[] titleFields = currTitleLine.split("\\|",-1);
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<titleFields.length-1;i++) {
						sb.append("<td>").append(titleFields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 's' : {
				if(isFirstLine) {
					sb.append("<table><tr>");
				}else {
					sb.append("<tr>");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td  colspan=\"" + fieldSize + "\" class=\"detailtitle\">").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'f' : {
				if(isFirstLine) {
					sb.append("<table><tr class=\"detailfoot\">");
				}else {
					sb.append("<tr class=\"detailfoot\">");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					if(i == 2) {
						sb.append("<td colspan=\"" + fieldSize + "\" align=\"right\">").append(fields[i]).append("</td>");
					}else {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
				}
				sb.append("</tr>");
				break;
		    }
		}
		System.out.println("---liujian---337---setTr end ---" + sb.toString());
		return sb;
	}
	
//	public static final int LINES_ONE_PAGE = 10;
	String currTitleLine = "";
	/*
	//解析文档
	public String parseDocument(String path,int pageNum){
		File file = new File(path);
		//一个模块一个模块的加入到页面中，先不考虑分页问题
		StringBuffer sb = new StringBuffer("");
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
			isr = new InputStreamReader(new FileInputStream(file), "GBK");
			br = new BufferedReader(isr);
			//0:currLine；1：beforeLine
			String[] beforeAndcurrLines = new String[2];
			String s = null;
			int currNum = 0;
			//TODO 先用普通方法，后改造成高效的
			while((s = br.readLine()) != null) {
				currNum++;
				if(s.startsWith("title")) {
					currTitleLine = s;
				}
				if(pageNum == -1 || (currNum > (pageNum-1) * LINES_ONE_PAGE && currNum <= pageNum * LINES_ONE_PAGE)) {
					//填充数组
					if(beforeAndcurrLines[0] == null ) {
						beforeAndcurrLines[0] = s;
					}else {
						beforeAndcurrLines[1] = beforeAndcurrLines[0];
						beforeAndcurrLines[0] = s;
					}
					//设置行的html样式，包括设置table
					sb.append(setTr(beforeAndcurrLines).toString());
				}
			}
			sb.append("</table>");
		}catch(Exception e) {
			retCode = "000003";
 	 		retMsg = "文件处理异常！";
		}finally {
			try{
				br.close();
				isr.close();
				System.out.println("关闭数据流");
			}catch(Exception e) {
				System.out.println("数据流为空");
			}
		}
		return sb.toString();
	}

	public int getPageCount(String path) throws IOException {
		return (getLineNumber(path)-1) / LINES_ONE_PAGE + 1;
	}
	*/
%>
