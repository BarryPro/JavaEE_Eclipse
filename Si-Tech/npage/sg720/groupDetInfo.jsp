<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<%
String groupId = WtcUtil.repNull(request.getParameter("GroupId"));//群组ID
System.out.println("#####################################################groupId===="+groupId);
%>
<!--取得群组基本展示信息-->
<wtc:utype name="sPMGroupDetail" id="retVal" scope="end">
	<wtc:uparam value="<%=groupId%>" type="LONG"/>   
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1);
%>
<!--取得群组成员列表-->
<wtc:utype name="sPMMebList" id="retMebVal" scope="end">
	<wtc:uparam value="<%=groupId%>" type="LONG"/>   
</wtc:utype>
<%
	 String retMebCode = retMebVal.getValue(0);
	 String retMebMsg = retMebVal.getValue(1);
%>
<html>
<body>
<div id="operation">
<FORM name="gropFm" action="" method=post>
<%@ include file="/npage/include/header.jsp" %>	
<div id="operation_table">	
<DIV class="title"><div class="text">群组基本信息展示</div></DIV>	

<div class="input">
<table>
	<%
		 if(retCode.equals("0")){
		 for(int i=0;i<retVal.getUtype("2").getSize();i++){
		 System.out.println("##############################################################=="+retVal.getUtype("2").getValue(i));
		 }
	%>
	<tr> 
		<th>销售品ID：</th>
		<td><%=WtcUtil.repNull(retVal.getUtype("2").getValue(7))%></td>
		<th>销售品名称：</th>
		<td><%=WtcUtil.repNull(retVal.getUtype("2").getValue(8))%></td>
	</tr>
	<tr> 
		<th>群组标识：</th>
		<td><%=groupId%></td>
		<th>群组类型：</th>
		<td><%=WtcUtil.repNull(retVal.getUtype("2").getValue(2))%></td>
	</tr>
	<tr> 
		<th>生效时间：</th>
		<td>
			<%=WtcUtil.repNull(retVal.getUtype("2").getValue(12))%>
		</td>
		<th>失效时间：</th>
		<td>
			<%=WtcUtil.repNull(retVal.getUtype("2").getValue(13))%>
		</td>
	</tr>
	<tr> 
		<th>群组描述：</th>
		<td colspan="3">
		<span class="text_long"><%=WtcUtil.repNull(retVal.getUtype("2").getValue(3))%></span>
		</td>
	</tr>
	<%
		}
	%>
</table>
</div>

<DIV class="title"><div class="text">群组成员信息展示</div></DIV>	
<div class="list">
	<table>
		<tr>
			<th>成员号码</th>
			<th>成员类型</th>
			<th>状态</th>
			<th>生效时间</th>
			<th>失效时间</th>
		</tr>	
		<%
		if(retMebCode.equals("0")){
		String location="";
		 int retValNum = retMebVal.getUtype("2").getSize();
		 for(int i=0;i<retValNum;i++)
		 {
			location = "2."+i;
		%>
		<tr>
		<td><%=WtcUtil.repNull(retMebVal.getUtype(location).getValue(2))%></td>
		<td><%=WtcUtil.repNull(retMebVal.getUtype(location).getValue(7))%></td>
		<td><%=WtcUtil.repNull(retMebVal.getUtype(location).getValue(13))%></td>
		<td><%=WtcUtil.repNull(retMebVal.getUtype(location).getValue(15))%></td>
		<td><%=WtcUtil.repNull(retMebVal.getUtype(location).getValue(16))%></td>
	  </tr>
		<%
			}
		}
		%>
	</table>
</div>

</div>

<div id="operation_button">
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
</div>
<%@ include file="/npage/include/footer.jsp"%>
</FORM>
</DIV>
</BODY>
</HTML>