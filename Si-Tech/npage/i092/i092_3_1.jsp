<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<jsp:useBean  id="wlUpload"  scope="page"  class="com.jspsmart.upload.SmartUpload"  />


<%
		String opCode = "i092";
		String opName = "ǿ��Ԥ��";
		String dateStr = new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
		String workno = (String)session.getAttribute("workNo");
		String ip_Addr =  (String)session.getAttribute("ipAddr"); 
		//���ԣ�����ȥ��
		//ip_Addr = "10.110.26.23";
		String    iErrorNo ="000000";
		String    sErrorMessage ="";
		String regionCode = (String)session.getAttribute("regCode");

	SmartUpload mySmartUpload = new SmartUpload();
	String strFileName = workno+"-"+dateStr ;
	String strSaveFilePath =request.getRealPath("/npage/tmp")+"/";
		
	System.out.println("strSaveFilePath="+strSaveFilePath);
	
	 
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
	System.out.println("AAAAAAA");
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
	System.out.println("BBBBBBBBB");
		if (!myFile.isMissing())
		{
			System.out.println("�ļ�����"+strSaveFilePath+strFileName);
			myFile.saveAs(strSaveFilePath+strFileName);
			
    }
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ��洢ʱ����");
		iErrorNo = "139046";
		sErrorMessage = "�����ļ��洢ʱ����";
		ex.printStackTrace();
	}
	
	if( false == iErrorNo.equals("000000"))
	{
  
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("�ļ�׼��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
		//location = "e660.jsp";
		history.go(-1);
	</SCRIPT>
<%
	}
%>


<wtc:service name="bi092_ftp" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=ip_Addr%>"/>
	<wtc:param value="<%=strSaveFilePath%>"/>
	<wtc:param value="<%=strFileName%>"/>
	<wtc:param value="<%=dateStr%>"/>
	<wtc:param value="<%=workno%>"/>
</wtc:service>

<%
	if( ! retCode.equals("000000") )
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("���ݿ��¼������Ϣʧ�ܡ�<br>������룺'<%=retCode%>'��<br>������Ϣ��'<%=retMsg%>'��",0);
		history.go(-1);
	</SCRIPT>
<%
	}
%>
	 



<HTML>
<HEAD>
<script language="JavaScript">
<!--	

   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
  
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >���ֻ������ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">�����в�ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" checked >�ļ�����
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">���������أ�</div>
		</div>
	<table cellspacing="0">
		<tr>

			<td class="blue"  align="center">
			<%=retMsg%>
			</td>
		</tr>


	 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
      		<input type="button" name="query" class="b_foot" value="����" onclick="history.go(-1)" >
					&nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %> 
</form>
 </BODY>
</HTML>