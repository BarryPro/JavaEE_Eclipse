<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-19 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	 
	String opCode = "8175";
	String opName = "���Ž�ɫ����";
		
	String workNo =(String)session.getAttribute("workNo");		
	String nopass  =  (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
%>

<%
	
	String loginNo = request.getParameter("loginNo") == null ? "" : request.getParameter("loginNo"); 
	String powerCode = request.getParameter("powerCode") == null ? "" : request.getParameter("powerCode");
	
	/*************** ������� ****************************/	
	String paramsIn[] = new String[6];	 	
	
 	paramsIn[0] = workNo;                //����
 	paramsIn[1] = nopass;                //����
 	paramsIn[2] = opCode;                //��������
 	paramsIn[3] = "2";                   //������ʽ
 	paramsIn[4] = loginNo;               //����ѯ����
 	paramsIn[5] = powerCode;             //��ѯ��ɫ
	/*****************************************************/
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	String errCode = "-1";
	String errMsg ="";	
	
		//acceptList = callView.callFXService("s8175Qry", paramsIn, "4","region", regionCode);
	%>
		<wtc:service name="s8175Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
			<wtc:param value="<%=paramsIn[0]%>"/>
			<wtc:param value="<%=paramsIn[1]%>"/>
			<wtc:param value="<%=paramsIn[2]%>"/>
			<wtc:param value="<%=paramsIn[3]%>"/>
			<wtc:param value="<%=paramsIn[4]%>"/>
			<wtc:param value="<%=paramsIn[5]%>"/>
		</wtc:service>		
		<wtc:array id="sLoginNo1" start="0" length="1" scope="end"/>
		<wtc:array id="sLoginName1" start="1" length="1" scope="end"/>
		<wtc:array id="sRoleCode1" start="2" length="1" scope="end"/>
		<wtc:array id="sRoleName1" start="3" length="1" scope="end"/>
	<%	
		errCode = retCode1;
		errMsg = retMsg1;
		System.out.println("errCode====================="+errCode);
		System.out.println("errMsg====================="+errMsg);
	
	
	/********************* ������� ***********************************/
	String[][] sLoginNo   = new String[][]{};      //��ѯ����
	String[][] sLoginName = new String[][]{};      //��������
	String[][] sRoleCode  = new String[][]{};      //��ɫ����
	String[][] sRoleName  = new String[][]{};      //��ɫ����
	/******************************************************************/
	
 	if(("000000").equals(errCode))
 	{
 		sLoginNo   = sLoginNo1;
		sLoginName = sLoginName1;
		sRoleCode  = sRoleCode1;
		sRoleName  = sRoleName1;
		
		if(sLoginNo==null||sLoginNo.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��",0);	
				parent.location="f8175_1.jsp?returnFlag=3";			
			</script>
<%  
		}
	}
	else
	{
%>
		<script language='jscript'>
		     rdShowMessageDialog("������Ϣ��<%=errMsg%><br>������룺<%=errCode%>", 0);	     
		     parent.location="f8175_1.jsp?returnFlag=3";
	    </script> 
<%
		
	}
%>	

<html>
<body>
<form name="form1" method="post" action="">	
<div id="Main">

   <DIV id="Operation_Table"> 
	
			
	<table id="tabList" cellspacing=0>			
			<tr>				
				<th>���Ŵ���</th>
				<th>��������</th>
				<th>��ɫ����</th>
				<th>��ɫ����</th>
			</tr>
	<%	
		for(int i = 0; i < sLoginNo.length; i++)
		{
	%>			
			<tr>				
				<td nowrap ><%=sLoginNo[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sLoginName[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sRoleCode[i][0].trim()%>&nbsp;</td>
				<td nowrap ><%=sRoleName[i][0].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>		
			
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>  
</form>
</body>
</html>