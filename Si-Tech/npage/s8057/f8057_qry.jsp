<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-19 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>


<%
	String opCode = "8057";
	String opName = "���Ž�ɫ����";
		
	String loginNo =(String)session.getAttribute("workNo");		
	String nopass  =  (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	
%>

<%

	String roleCode = request.getParameter("role_code"); 
	String pdomCode = request.getParameter("pdom_code");
	
	System.out.println(">>>>>>>>>>>"+roleCode+">>>>"+pdomCode);
	
	/*************** ������� ****************************/
	String paramsIn[] = new String[5];
	
 	paramsIn[0] = loginNo;       //����
 	paramsIn[1] = nopass;        //����
 	paramsIn[2] = opCode;        //��������
 	paramsIn[3] = roleCode;      //��ɫ����
 	paramsIn[4] = pdomCode;      //Ȩ�޴���
	/*****************************************************/
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	String errCode = "-1";
	String errMsg ="";
	
	//acceptList = callView.callFXService("s8057_Qry", paramsIn, "5","region", regionCode);	
	%>
	<wtc:service name="s8057_Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>		
	</wtc:service>		
	<wtc:array id="spowerCode1" start="0" length="1" scope="end"/>
	<wtc:array id="spowerName1" start="1" length="1" scope="end"/>
	<wtc:array id="sPdomCode1" start="2" length="1" scope="end"/>
	<wtc:array id="sFuncCode1" start="3" length="1" scope="end"/>
	<wtc:array id="sPdomName1" start="4" length="1" scope="end"/>
	<%
		errCode = retCode1;
		errMsg = retMsg1;
	
	
	/********************* ������� ***********************************/
	String[][] spowerCode  = new String[][]{};      //��ɫ����
	String[][] spowerName  = new String[][]{};      //��ɫ����
	String[][] sPdomCode   = new String[][]{};      //Ȩ�޴���
	String[][] sFuncCode   = new String[][]{};      //ӳ�����
	String[][] sPdomName   = new String[][]{};      //Ȩ������
	/******************************************************************/
	
 	if(errCode.equals("000000"))
 	{
		spowerCode  = spowerCode1;
		spowerName  = spowerName1;
		sPdomCode   = sPdomCode1;
		sFuncCode   = sFuncCode1;
		sPdomName   = sPdomName1;
		System.out.println("sPdomCode======================="+sPdomCode.length);
		if(spowerCode.length==0)
		{
%>
			<script language='jscript'>
				rdShowMessageDialog("û�в鵽��ؼ�¼��");
				parent.location="f8057_1.jsp?returnFlag=3";
			</script>
<%  
		}
	}
	else
	{
%>
	   <script>
		     rdShowMessageDialog("������Ϣ��<%=errMsg%><br>������룺<%=errCode%>", 0);	     
		     parent.location="f8057_1.jsp?returnFlag=3";
	    </script> 
<%
	}
%>	

<html>
<head>
</head>
<body>
<form name="form2" method="post" action="">	
	<%@ include file="/npage/include/header.jsp" %>   	
	<table id="tabList" cellspacing=0 >			
			<tr>				
				<th>��ɫ����</th>
				<th>��ɫ����</th>
				<th>Ȩ�޴���</th>
				<th>��������</th>
				<th>Ȩ������</th>
			</tr>
	
	<%	
		for(int i = 0; i < spowerCode.length; i++)
		{
	%>			
			<tr >				
				<td ><%=spowerCode[i][0].trim()%>&nbsp;</td>
				<td ><%=spowerName[i][0].trim()%>&nbsp;</td>
				<td> <%=sPdomCode[i][0].trim()%>&nbsp;</td>
				<td ><%=sFuncCode[i][0].trim()%>&nbsp;</td>
				<td ><%=sPdomName[i][0].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>
		
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>  
</form>
</body>
</html>
