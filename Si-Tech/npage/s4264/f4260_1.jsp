<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�޶�澯��ѯ
   * ����: 2009/4/1
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4260";
	String opName = "�޶�澯��ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
	/**************** ��ҳ���� ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	String[][] allNumStr = new String[][]{};
	String[][] result = new String[][]{};
	
	String  inputParsm [] = new String[3];
	inputParsm[0] = workNo;
	inputParsm[1] = orgCode;
	inputParsm[2] = opCode;
%>	
    <wtc:service name="s4257Query" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="7">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="2" length="5"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<% 		
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("������Ϣ:<%=tempArr1[0][1]%>");	
	 	removeCurrentTab();	
		</script>
<%		
		return;				 			
	}
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--			
</script> 
 
<title>�޶�澯��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�޶�澯��ѯ</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td nowrap align='center' class="blue"><div ><b>�ֻ�����</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>�ͻ�����</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>��������</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>�޶�澯ֵ</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>���ø澯ֵ</b></div></td>
			</tr>
	<%	
	if(tempArr.length<=10){
		for(int i = 0; i < tempArr.length; i++)
			{
		%>			
				<tr>				
					<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<%	if(tempArr[i][2].equals("0")){   %>
						<td nowrap align='center'>���Ժ�&nbsp;</td>
				<%	}else{ 	%>
					<td nowrap align='center'>�����&nbsp;</td>
				<%	}   	%>	
					<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
				</tr>
		<%
		}
		}else if(tempArr.length-iStartPos<10){
				
		for(int i = iStartPos; i < tempArr.length; i++)
		{
	%>			
			<tr>				
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
			<%	if(tempArr[i][2].equals("0")){   %>
					<td nowrap align='center'>���Ժ�&nbsp;</td>
			<%	}else{ 	%>
				<td nowrap align='center'>�����&nbsp;</td>
			<%	}   	%>	
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	}else{
		for(int i = iStartPos; i < iStartPos+iPageSize; i++)
		{
	%>			
			<tr>				
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
			<%	if(tempArr[i][2].equals("0")){   %>
					<td nowrap align='center'>���Ժ�&nbsp;</td>
			<%	}else{ 	%>
				<td nowrap align='center'>�����&nbsp;</td>
			<%	}   	%>	
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
			</tr>
	<%
		}
		}
	%>		
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%	
					    //ʵ�ַ�ҳ
					    int iQuantity = tempArr.length;
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>				
			</tr>			
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
