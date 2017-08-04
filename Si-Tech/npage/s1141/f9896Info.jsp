<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: sp增值业务套餐申请
　 * 版本: 
　 * 日期: 2009-09-22
　 * 作者: dujl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

String opCode = "9896";
String opName = "sp增值业务套餐申请";

/**需要regionCode来做服务的路由**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

String orgCode =(String)session.getAttribute("orgCode");
String workNo = (String)session.getAttribute("workNo");
String pass = (String)session.getAttribute("password");
String saleCode = WtcUtil.repNull(request.getParameter("saleCode"));

String checkSql = "SELECT a.sale_code,a.sale_name,a.sp_type,b.type_name FROM sspsaledetail a,sSpSaleDetType b where a.sp_type = b.sp_type and a.sale_code= '"+saleCode+"'";
System.out.println("22222 checkSql->"+checkSql);

%>
<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="4"> 
<wtc:sql><%=checkSql%></wtc:sql>
</wtc:pubselect> 
<wtc:array id="result" scope="end"/>

<html>
<head>
<title><%=opName%></title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">
<!--

//-->
</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0" id="tabList">
			<tr align="center">
				<th nowrap>营销案代码</th>
				<th nowrap>营销案名称</th>
				<th nowrap>增值业务名称</th>
			</tr>
	<%
			if(result.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='4'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
				
			}else if(result.length>0)
			{
				String tbclass = "";
				for(int i=0;i<result.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
					<tr align="center" length="500">
						<td class="<%=tbclass%>"><%=result[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=result[i][1]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=result[i][3].trim()%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
  	</div>
</body>
</html>    

