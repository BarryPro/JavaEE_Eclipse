<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=GB2312" %>
<%@ page import = "javax.ejb.*" %>
<%@ page import = "com.sitech.boss.pub.*" %>
<%@ page import = "com.sitech.boss.pub.config.*" %>
<%@ page import = "com.sitech.boss.pub.conn.*" %>
<%@ page import = "com.sitech.boss.pub.exception.*" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>
<%@ page import = "com.sitech.boss.pub.wtc.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.lang.String" %>
<%@ page import = "java.text.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%!
private static String CGI_PATH = "";
private static String DETAIL_PATH = "";

static{
    //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
    CGI_PATH = SystemUtils.getConfig("CGI_PATH");
	DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
    //�������"/"��ʽ����,����"/"
    if(!CGI_PATH.endsWith("/")){
		CGI_PATH=CGI_PATH+"/";
	    DETAIL_PATH=DETAIL_PATH+"/"; 
    }
  }
%>

<%
	String phoneNo = request.getParameter("phoneNo");		//�ֻ�����
	String billBegin = request.getParameter("billBegin");	//��ʼʱ��
	String billEnd = request.getParameter("billEnd");		//����ʱ��
	String qryType = request.getParameter("qryType");		//��ѯ����
	String qryName = request.getParameter("qryName");		//������ϸ����
	String dateStr = request.getParameter("dateStr");		//��ѯʱ��
	String outFile = request.getParameter("outFile");		//���ɵ��ļ�
	String beginLineStr = request.getParameter("beginLine");	//��ȡ��ʼ��
	String custName = request.getParameter("custName");			//ͨѶ�˿�
	String icount = request.getParameter("icount");			//ͨѶ�˿�
%>
<html>
<head>
<title> �굥��ѯ-<%=qryName%></title>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
</head>	
<body>
<p align="center"><font color="#0000FF" size="5">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</font></p>
<table border="0" align="center" cellspacing="0">
    <%
       //�õ�����ļ� 
  	   String txtPath = DETAIL_PATH;
       File temp = new File(txtPath,outFile);
       
       String tline = null;
       FileReader outFrT1 = new FileReader(temp);
       BufferedReader outBrT1 = new BufferedReader(outFrT1);	
       
       do {
		     tline = outBrT1.readLine();
		     String tlinetep = "";
		     if (tline != null) {
		        tlinetep = tline.replaceAll(" ", "&nbsp;");
		     }
		     out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
		  } while(tline!=null);
       outBrT1.close();
	   outFrT1.close();
    %>    
</table>
</body>
<SCRIPT type=text/javascript>
   onload=function() {
      window.print();
   }
</SCRIPT>
</html>