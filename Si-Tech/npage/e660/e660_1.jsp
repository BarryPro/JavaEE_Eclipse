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

<script language="JavaScript">
	function do_query( document_name , document_no )
	{
		document.frm.action="e662_1.jsp?document_name="+document_name+"&document_no="+document_no;
		document.frm.submit();
	}
</script> 

<%	
	String opCode = "e660";
	String opName = "�ֹ�ϵͳ��ֵ����";
	String    iErrorNo ="000000";
	String    sErrorMessage ="";
	String document_no = request.getParameter("document_no") ;
	String document_name = request.getParameter("document_name") ;
	String back_rule = request.getParameter("import_date") ;
	String active_name = request.getParameter("active_name") ;
	String all_fee = request.getParameter("all_fee") ;
	String all_user = request.getParameter("all_user") ;
	String ip_Addr = request.getParameter("ip_Addr") ;
	String regionCode = (String)session.getAttribute("regCode");
	String workno = (String)session.getAttribute("workNo");
	String serverIp=realip.trim();
	String	shortmsg1=request.getParameter("shortmsg1") ;
	String	shortmsg2=request.getParameter("shortmsg2") ;
	
	SmartUpload mySmartUpload = new SmartUpload();
	String strFileName = document_name+"-"+document_no ;
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
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if (!myFile.isMissing())
		{
			myFile.saveAs(strSaveFilePath+strFileName);
    }
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ��洢ʱ����");
		iErrorNo = "139046";
		sErrorMessage = "�����ļ��洢ʱ����";
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


<wtc:service name="sE660_upLoad" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="0">
	<wtc:param value="<%=document_name%>"/>
	<wtc:param value="<%=document_no%>"/>
	<wtc:param value="<%=back_rule%>"/>
	<wtc:param value="<%=active_name%>"/>
	<wtc:param value="<%=strSaveFilePath%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=all_fee%>"/>
	<wtc:param value="<%=all_user%>"/>
	<wtc:param value="<%=ip_Addr%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=serverIp%>"/>
	<wtc:param value="<%=shortmsg1%>"/>
	<wtc:param value="<%=shortmsg2%>"/>
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


<title>�ֹ�ϵͳ��ֵ����1</title>
</head>
<BODY onload=""> 

<form action="e660_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" > 
	
	<%@ include file="/npage/include/header.jsp" %> 
  	
		<div class="title">
			<div id="title_zi">�ļ��ϴ��ɹ�������Сʱ����ͨ�� e662 ��ѯ�ϴ������</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">�ļ�����</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="phoneNo" size="70" value=<%=strFileName%>>  <font color="orange">*</font>
				</td>
				
     </tr>
     
    </tbody>
  </table>
  
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
      	<input type="button" name="return2" class="b_foot" value="������ѯ" onClick=do_query("<%=document_name%>","<%=document_no%>") >
      	 &nbsp;
           <input type="button" name="query" class="b_foot" value="����" onclick="history.go(-1)" >

  
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>

	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>

</form>
</BODY> 
