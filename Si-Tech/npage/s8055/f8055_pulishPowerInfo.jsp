<%
   /*
   * ����: ��ɫ������Ϣ��ѯ
�� * �汾: v1.0
�� * ����: 2007/06/25
�� * ����: hanfa
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.06
 ģ��: ��ɫ����
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>	

<%
	String loginNo = (String)session.getAttribute("workNo");
	String nopass  = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
%>

<%
	
	String opCode  = "8055";
	
	String power_code = request.getParameter("power_code") == null ? "" : request.getParameter("power_code"); 
	String objectId = request.getParameter("objectId") == null ? "" : request.getParameter("objectId");
	
	/*************** ������� ****************************/	
	String paramsIn[] = new String[5];	 	
	
 	paramsIn[0] = loginNo;               //����
 	paramsIn[1] = nopass;                //����
 	paramsIn[2] = opCode;                //��������
 	paramsIn[3] = power_code;            //��ɫ����
 	paramsIn[4] = objectId;              //������֯�ڵ�
	/*****************************************************/
	
	ArrayList acceptList = new ArrayList();
	String errCode = "";
	String errMsg ="";
	
	
	//acceptList = callView.callFXService("s8055_Qry", paramsIn, "5","region", regionCode);	
%>
	<wtc:service name="s8055_Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5">			
	<wtc:param value="<%=paramsIn[0]%>"/>
	<wtc:param value="<%=paramsIn[1]%>"/>	
	<wtc:param value="<%=paramsIn[2]%>"/>	
	<wtc:param value="<%=paramsIn[3]%>"/>	
	<wtc:param value="<%=paramsIn[4]%>"/>	
	</wtc:service>	
	<wtc:array id="spowerCode"  start="0" length="1" scope="end"/>
	<wtc:array id="spowerName"  start="1" length="1" scope="end"/>
	<wtc:array id="sobjectId"   start="2" length="1" scope="end"/>
	<wtc:array id="sobjectName" start="3" length="1" scope="end"/>
	<wtc:array id="sDisName"    start="4" length="1" scope="end"/>
<%
	errCode = retCode1;
	errMsg = retMsg1;
	
	  
 	if(errCode.equals("000000"))
 	{

		if(spowerCode.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��",2);	
				parent.location="f8055_1.jsp?returnFlag=3";			
			</script>
<%  
		}
	}
	else
	{
%>
		<script language='jscript'>
		     rdShowMessageDialog("������Ϣ��<%=errMsg%><br>������룺<%=errCode%>", 0);	     
		     parent.location="f8055_1.jsp?returnFlag=3";
	    </script> 
<%
	}
%>	

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<body>
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		
		<table id="tabList" cellspacing="0">			
			<tr>				
				<th nowrap>��ɫ����</th>
				<th nowrap>��ɫ����</th>
				<th nowrap>��֯����</th>
				<th nowrap>��֯��������</th>
				<th nowrap>��֯������������</th>
			</tr>
	<%	
		for(int i = 0; i < spowerCode.length; i++)
		{
	%>			
			<tr>				
				<td nowrap align='center'><%=spowerCode[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=spowerName[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=sobjectId[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=sobjectName[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=sDisName[i][0].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
		</table>
	</div>   
</form>
</body>
</html>