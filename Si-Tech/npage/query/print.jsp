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
   /* ˮӡ */
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
	<title>�굥��ѯ</title>
	<link href="detail.css" rel="stylesheet" type="text/css"></link>
	<script language="VBScript">
			dim hkey_root,hkey_path,hkey_key,doPrint,RegWsh
			hkey_root="HKEY_CURRENT_USER"
			hkey_path="\Software\Microsoft\Internet Explorer"
			doPrint="yes"
			
			Set RegWsh =CreateObject("WScript.Shell")
			
			//���ô�ӡ����ͼƬ
			//on error resume next
			hkey_key=hkey_root+hkey_path+"\Main\Print_Background"
			//MsgBox hkey_key
			RegWsh.RegWrite hkey_key,doPrint
			//�ر�RegWsh
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
			<div id="title_zi">�й��ƶ�ͨ�ſͻ��굥</div>
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
								//0:currLine��1��beforeLine
								String[] beforeAndcurrLines = new String[2];
								String s = null;
								int currNum = 0;
								while((s = br.readLine()) != null) {
									currNum++;
									if(s.startsWith("title")) {
										currTitleLine = s;
									}
									//�������
									if(beforeAndcurrLines[0] == null ) {
										beforeAndcurrLines[0] = s;
									}else {
										beforeAndcurrLines[1] = beforeAndcurrLines[0];
										beforeAndcurrLines[0] = s;
									}
									//�����е�html��ʽ����������table
									out.println(setTr(beforeAndcurrLines).toString());
								}
								out.println("</table>");
							}catch(Exception e) {
								retCode = "000003";
					 	 		retMsg = "�ļ������쳣��";
							}finally {
								try{
									br.close();
									isr.close();
									System.out.println("�ر�������");
								}catch(Exception e) {
									System.out.println("������Ϊ��");
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
 	   String retMsg = "�ļ������ڣ�";
		 //�ж��ļ��Ƿ����
		 public boolean exsitFile(String path) {
				File file = new File(path);
				if (!file.exists() || file.isDirectory() || !file.canRead()) {
						retCode = "000001";
 	 					retMsg = "�ļ������ڣ�";
				    return false;
				}else {
					return true;
				}
			}
			
			//�ж��Ƿ�ĩβ�ǿհ���
			public boolean lastLineIsBlank(File file) throws IOException {
			  RandomAccessFile raf = null;
			  try {
			    raf = new RandomAccessFile(file, "r");
			    long len = raf.length();
			    if (len == 0L) {
			    	retCode = "000002";
 	 					retMsg = "�ļ����ڣ��ļ���СΪ0��";
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
 	 					retMsg = "�ļ������쳣��";
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
	
		// ����ļ�������,ȥ���հ���
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
					//������Ϊ1����ֻ��һ�У����Ҵ��в�Ϊ��
					if(number != 0 || (number == 0 && fileLength != 0L)) {
						number++;
					}
					rf.close();
				}
				//������ڿհ��У�ȥ�����涨���ֻ��һ���հ���
				if(number >0 && lastLineIsBlank(new File(path))) {
					  number--;
				}
			} catch (IOException e) {
				if (rf != null) {
					try {
						retCode = "000003";
 	 					retMsg = "�ļ������쳣��";
						rf.close();
					} catch (IOException ee) {
						retCode = "000003";
 	 					retMsg = "�ļ������쳣��";
					}
				}
			}
			return number;
		}
	
	//����htmlһ�е�����
	public StringBuffer setTr(String[] beforeAndcurrLines) {
		System.out.println("---liujian---337---setTr begin ---");
		char beforeLineFirstChar = '0'; //Ĭ��Ϊ0
		boolean isFirstLine = true; 
		if(beforeAndcurrLines[1] != null) {
			beforeLineFirstChar = beforeAndcurrLines[1].charAt(0);
			isFirstLine = false;
		}
		StringBuffer sb = new StringBuffer();
		//�и������ݣ����ÿһ���ֶ�,-1����Ϊ����|||���ֵ�����������߾��и�������-1
		String[] fields = beforeAndcurrLines[0].split("\\|",-1);
		
		//��һ���ֶο����ǣ�cust/g/body/head/title/span/foot
		//��������ȥ������,����ƥ���ַ�
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
				}else if(beforeLineFirstChar == '0' && isFirstLine) { //��һ��
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
					//��ӱ���
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
	//�����ĵ�
	public String parseDocument(String path,int pageNum){
		File file = new File(path);
		//һ��ģ��һ��ģ��ļ��뵽ҳ���У��Ȳ����Ƿ�ҳ����
		StringBuffer sb = new StringBuffer("");
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
			isr = new InputStreamReader(new FileInputStream(file), "GBK");
			br = new BufferedReader(isr);
			//0:currLine��1��beforeLine
			String[] beforeAndcurrLines = new String[2];
			String s = null;
			int currNum = 0;
			//TODO ������ͨ�����������ɸ�Ч��
			while((s = br.readLine()) != null) {
				currNum++;
				if(s.startsWith("title")) {
					currTitleLine = s;
				}
				if(pageNum == -1 || (currNum > (pageNum-1) * LINES_ONE_PAGE && currNum <= pageNum * LINES_ONE_PAGE)) {
					//�������
					if(beforeAndcurrLines[0] == null ) {
						beforeAndcurrLines[0] = s;
					}else {
						beforeAndcurrLines[1] = beforeAndcurrLines[0];
						beforeAndcurrLines[0] = s;
					}
					//�����е�html��ʽ����������table
					sb.append(setTr(beforeAndcurrLines).toString());
				}
			}
			sb.append("</table>");
		}catch(Exception e) {
			retCode = "000003";
 	 		retMsg = "�ļ������쳣��";
		}finally {
			try{
				br.close();
				isr.close();
				System.out.println("�ر�������");
			}catch(Exception e) {
				System.out.println("������Ϊ��");
			}
		}
		return sb.toString();
	}

	public int getPageCount(String path) throws IOException {
		return (getLineNumber(path)-1) / LINES_ONE_PAGE + 1;
	}
	*/
%>
