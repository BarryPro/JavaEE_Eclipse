

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>		
<%
	String orgCode = (String)session.getAttribute("orgCode");
 	String regionCode = orgCode.substring(0,2);
 	String cellGroup="";
%>
<wtc:pubselect  name="sPubSelect"  outnum="2">
	<wtc:sql>select distinct flag_code, note from location_code_info a where exists(select 1 from sRegioncode b where trim(a.visit_area_code)=substr(trim(toll_no), 2,4) and b.region_code='?')</wtc:sql>
	<wtc:param value="<%=regionCode%>"/>
</wtc:pubselect>
<wtc:array id="rows1">
<%

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>选择小区群号</title>
		 <script type="text/javascript">
		 	function haveChose(){
		 			var e = arguments[0] || window.event;
					var trCur = e.srcElement.parentNode.parentNode || e.target.parentNode.parentNode;
					var cellNo = trCur.getElementsByTagName("td")[1].innerHTML;
					window.returnValue = cellNo;
					window.close();
		 		}
		 </script>
	</head>
	<body>
	<div id="operation">
	<form method=post name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
	<div id="operation_table">
 		<div class="list">
 			<table>
 				<tr>
	 				<th>选择</th>
	 				<th>小区名称</th>
	 				<th>小区号码</th>
 				</tr>
<%
 			if(rows1.length!=0 && rows1[0].length!=0){
 				for(int i=0;i<rows.length;i++){
%>
 				<tr>
	 				<td><input type="radio" name="radio" onclick="haveChose(event)"></td>
	 				<td><%=rows[i][0]%></td>
	 				<td><%=rows[i][1]%></td>
 				</tr>
<%					
						}
 				}else{
%>
				<script language="JavaScript">
					  rdShowMessageDialog("没有查询到记录");
				</script>
<%
	}
%>
 			</table>
 		</div>
 	</div>
 	<div id="operation_button">
		<input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
	</div>
 		<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>