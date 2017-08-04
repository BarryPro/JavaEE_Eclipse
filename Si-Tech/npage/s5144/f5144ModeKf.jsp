<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	String opName="资费FAQ";
	String opCode = "5144";		
	
	String regionCode  = (String)session.getAttribute("regCode");
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select region_code,to_char(region_code)||'->'||region_name from sregioncode ");
	sql.append(" where region_code<='13' order by region_code   ");
	System.out.println("sql====="+sql);
%>
<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<script>
//var activeXWin = top.voiceFrame.document.scripts;
function doQuery(){
	document.frm.action = "./f5144Mode.jsp?region_code="+document.all.region_code1.value;
	document.frm.submit();
}

</script>
</head>

<body>
<form name="frm" method="post" >
	<%@ include file="/npage/include/header.jsp" %>
	<table>
		<tr>
			<td class="blue" nowrap>省市标志</td>
			<td>
					<select name="region_code1">
						<option value="" selected>请选择</option>
						<%for (int i = 0; i < result.length; i++) {%>
				      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
				      		</option>
				    	<%}%>
					</select>
			</td>		
		 </tr>
		 <tr >
			<td id="footer" colspan="2"> 
	           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()">&nbsp;
	        </td>		 	
		 </tr>
	</table>
    <%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>
</html>

