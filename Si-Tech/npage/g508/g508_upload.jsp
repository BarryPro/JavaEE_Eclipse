<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../page/common/serverip.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<jsp:useBean  id="wlUpload"  scope="page"  class="com.jspsmart.upload.SmartUpload"  />  
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>


<%	
	String iErrorNo ="000000";
	String sErrorMessage ="";
	String return_page = "g508_3.jsp";
	SmartUpload mySmartUpload = new SmartUpload();
	String sysAccept = request.getParameter("sysAccept");
	String strFileName = "OFFER"+sysAccept ;
	String strSaveFilePath =request.getRealPath("/npage/tmp")+"/";
		
	System.out.println("strSaveFilePath="+strSaveFilePath);
	System.out.println("strFileName="+strFileName);
	
	 
	try
	{
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ������г���");
		iErrorNo = "139045";
		sErrorMessage = "�����ļ������г���";
	}
	try 
	{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if (!myFile.isMissing())
		{
			myFile.saveAs(strSaveFilePath+strFileName);
    	}
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ��洢ʱ����");
		System.out.println(ex);
		iErrorNo = "139046";
		sErrorMessage = "�����ļ��洢ʱ����";
	}
	
	if( false == iErrorNo.equals("000000"))
	{
  
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("�ļ�׼��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
		history.go(-1);
	</SCRIPT>
<%
	}
	else
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("�ļ��ϴ��ɹ�",0);
		window.location.href="<%=return_page%>"+"?sysAccept="+"<%=sysAccept%>"+"&flag=1";
//		history.go(-1);
	</SCRIPT>
<%
	}
%>
