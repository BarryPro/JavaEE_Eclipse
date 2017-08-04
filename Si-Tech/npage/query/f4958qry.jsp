<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 用户机卡分离信息查询
　 * 版本: 
　 * 日期: 2009-08-25
　 * 作者: dujl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**需要清楚缓存.如果是新页面,可删除**/
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 

String opCode = "4958";
String opName = "用户机卡分离信息查询";

/**需要regionCode来做服务的路由**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

String phone_no = request.getParameter("phoneNo");
String modeCode = request.getParameter("modeCode");
String selTime = request.getParameter("selTime");

String sql = "SELECT a.imei,a.flag,a.imei_day  FROM wsimoutdata a,ssaletype b,dcustmsg c WHERE c.phone_no='"+phone_no+"' and c.id_no=a.id_no and a.op_code='"+modeCode+"' and a.op_code=b.op_code and a.statis_month='"+selTime+"' group by a.imei,a.flag,a.imei_day";

System.out.println("sql============"+sql);

%>
<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
System.out.println("retCode===="+retCode1);
System.out.println("retMsg===="+retMsg1);
%>

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
				<th nowrap>捆绑的IMEI号</th>
				<th nowrap>是否机卡分离</th>
				<th nowrap>捆绑使用天数</th>
			</tr> 
	<%
			if(result.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
				
			}else if(result.length>0)
			{
				String tbclass = "";
				for(int i=0;i<result.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
					<tr align="center">
						<td class="<%=tbclass%>"><%=result[i][0]%>&nbsp;</td>
						<%
						if(result[i][1].equals("0"))
						{
						%>
							<td class="<%=tbclass%>">未拆包</td>
						<%
						}else if(result[i][1].equals("1"))
						{
						%>
							<td class="<%=tbclass%>">拆包</td>
						<%
						}
						%>
						<td class="<%=tbclass%>"><%=result[i][2]%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
  	</div>
</body>
</html>    

