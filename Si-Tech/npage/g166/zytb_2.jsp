<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String[] inParas2 = new String[8];
		String opCode = "g166";
		String opName = "报损发票调回";
		String workno = (String)session.getAttribute("workNo");
		String invoice_id = request.getParameter("invoice_id");  
		String invoice_no = request.getParameter("invoice_no"); 
		String busyType2 = request.getParameter("busyType2"); 
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode"); 
		String yingyt = request.getParameter("yingyt"); 
		String s_in_ModeTypeCode_1 = request.getParameter("s_in_ModeTypeCode");
		String s_in_ModeTypeCode="";
		//xl add for 发票类型
		String fplx = request.getParameter("fplx");
		if(s_in_ModeTypeCode_1!=null && !(s_in_ModeTypeCode_1.equals("")))
		{
			s_in_ModeTypeCode=s_in_ModeTypeCode_1.substring(2);
		}
	inParas2[0]= workno;
	inParas2[1]=invoice_id;
	inParas2[2]=invoice_no;
	inParas2[3]=busyType2;//0营业员 1营业厅 2区县 3地市
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAs_in_CaseTypeCode is "+s_in_CaseTypeCode);
	if(s_in_CaseTypeCode!=null && !(s_in_CaseTypeCode.equals("")))
	{
		if(s_in_CaseTypeCode.equals("0"))
		{
			inParas2[4]=s_in_CaseTypeCode;
		}
		else 
		{
			inParas2[4]=s_in_CaseTypeCode.substring(4);
		}
	}
	else
	{
		inParas2[4]="";
	}
	
	
	 
	inParas2[5]=yingyt;
	inParas2[6]=s_in_ModeTypeCode;
	inParas2[7]=fplx;
  %>
  <wtc:service name="sUpdPsInfo" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
	<wtc:param value="<%=inParas2[2]%>"/>
	<wtc:param value="<%=inParas2[3]%>"/>
	<wtc:param value="<%=inParas2[4]%>"/>
	<wtc:param value="<%=inParas2[5]%>"/>
	<wtc:param value="<%=inParas2[6]%>"/>
	<wtc:param value="<%=inParas2[7]%>"/>
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	String retCode= retCode1;
	String retMsg = retMsg1;
	if ( retCode1.equals("000000") ||retCode1=="000000" )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("调回发票录入成功！");
				window.location.href="g166_1.jsp";  
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("调回发票录入失败！错误代码"+"<%=retCode1%>，错误原因："+"<%=retMsg1%>");
				window.location.href="g166_1.jsp";  
			</script>
		<%
	}
%>	
	
 
<HTML>
<HEAD>

 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>

 </BODY>
</HTML>

