<%
    /********************
     version v2.0
     ������: si-tech
     *
     * update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
     * 
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "com.sitech.boss.pub.util.*" %>

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
  String opCode = "1526";
  String opName = "��ͨ�굥��ѯ";
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
	String workNo = (String)session.getAttribute("workNo");
	String ip = request.getRemoteAddr();
	String imageName = ip+workNo+".jpg"; //yuanqs add 2010-9-1 12:43:30

%>
<html>
<head>
<title> �굥��ѯ-<%=qryName%></title>
</head>	
<body topmargin="0" onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
			<p align="center"><font color="#0000FF" size="5">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</font></p>
			<table border="0" align="center" cellspacing="0" id="t1">
	
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
   	$("#t1").css("background-image","url(img/<%=imageName%>)"); 
      window.print();
      window.close();
   }
</SCRIPT>
</html>
