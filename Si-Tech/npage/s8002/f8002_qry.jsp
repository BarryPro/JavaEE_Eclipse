<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String opCode ="8002";
	String opName = "���Ź���";
	String regionCode =  (String)session.getAttribute("regCode");
	
	String opLogin =(String)session.getAttribute("workNo");	
	String nopass  = (String)session.getAttribute("password");
	
%>

<%
	String loginNo  = request.getParameter("loginNo");
	String roleCode = request.getParameter("roleCode"); 
	String pdomCode = request.getParameter("pdomCode");
	String pdomType = request.getParameter("pdomType");
	
	if(roleCode == null)
	{
		roleCode = "";
	}
	
	if(pdomCode == null)
	{
		pdomCode = "";
	}
	
	System.out.println(">>>>>["+roleCode+"]>>>>["+pdomCode+"]>>>>["+pdomType+"]");
	
	/*************** ������� ***************/
	String paramsIn[] = new String[7];
	
 	paramsIn[0] = opLogin;       //����
 	paramsIn[1] = nopass;        //����
 	paramsIn[2] = opCode;        //��������
 	paramsIn[3] = loginNo;
 	paramsIn[4] = roleCode;      //��ɫ����
 	paramsIn[5] = pdomCode;      //Ȩ�޴���
 	paramsIn[6] = pdomType;
	/****************************************/	
	String errCode = "-1";
	String errMsg ="";
	
	//acceptList = callView.callFXService("s8002Qry", paramsIn, "8","region", regionCode);	
%>	
	<wtc:service name="s8002Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
	</wtc:service>
	<wtc:array id="sLoginNo1" start="0" length="1" scope="end"/>
	<wtc:array id="sLoginName1" start="1" length="1" scope="end"/>
	<wtc:array id="sPowerCode1" start="2" length="1" scope="end"/>
	<wtc:array id="sPowerName1" start="3" length="1" scope="end"/>
	<wtc:array id="sFuncCode1" start="4" length="1" scope="end"/>
	<wtc:array id="sPdomCode1" start="5" length="1" scope="end"/>	
	<wtc:array id="sPdomName1" start="6" length="1" scope="end"/>
	<wtc:array id="sPdomType1" start="7" length="1" scope="end"/>
<%

	errCode = retCode1;
	errMsg = retMsg1;
	
	
	/********************* ������� ***********************************/
	String[][] sLoginNo   = new String[][]{};
	String[][] sLoginName = new String[][]{};
	String[][] sPowerCode = new String[][]{};      //��ɫ����
	String[][] sPowerName = new String[][]{};      //��ɫ����
	String[][] sPdomCode  = new String[][]{};      //Ȩ�޴���
	String[][] sFuncCode  = new String[][]{};      //ӳ�����
	String[][] sPdomName  = new String[][]{};      //Ȩ������
	String[][] sPdomType  = new String[][]{};
	/******************************************************************/
	
 	if(errCode.equals("000000"))
 	{
 		sLoginNo   = sLoginNo1;
 		sLoginName = sLoginName1;
		sPowerCode = sPowerCode1;
		sPowerName = sPowerName1;
		sFuncCode  = sFuncCode1;
		sPdomCode  = sPdomCode1;
		sPdomName  = sPdomName1;
		sPdomType  = sPdomType1;
		
		if(sPowerCode.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��");			
				window.close();
			</script>
<%  
		}
	}
	else
	{
%>
		<script language='jscript'>
		     rdShowMessageDialog("������Ϣ��<%=errMsg%><br>������룺<%=errCode%>", 0);	 
		     window.close();
	    </script> 
<%
	}
%>	

<html>
<head>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="post" action="">		
		<%@ include file="/npage/include/header.jsp" %>   
			<div class="title">
				<div id="title_zi">����<%=loginNo%>�Ľ�ɫȨ����Ϣ</div>
			</div>
		<table cellspacing=0>
			<tr align='center'>
				<th nowrap>���ź���</th>
				<th nowrap>��������</th>
				<th nowrap>��ɫ����</th>
				<th nowrap>��ɫ����</th>
				<th nowrap>��������</th>
				<th nowrap>Ȩ������</th>
				<th nowrap>Ȩ������/th>
			</tr>
			<%	
				for(int i = 0; i < sPowerCode.length; i++)
				{
			%>			
					<tr>
						<td nowrap align='center'><%=sLoginNo[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sLoginName[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sPowerCode[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sPowerName[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sFuncCode[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sPdomName[i][0].trim()%>&nbsp;</td>
						<td nowrap align='center'><%=sPdomType[i][0].trim()%>&nbsp;</td>
					</tr>
			<%
				}
			%>
		</table>
		<table cellspacing=0 >
			<tr>
				<td id="footer">
					<input class="b_foot" type="button" name="Return" onclick="window.close()" value="�ر�">
				</td>
			</tr>
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
