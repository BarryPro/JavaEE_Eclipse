<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%/*------查看手机用户是否是实名制用户*/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");
		String begin_time1 = request.getParameter("begin_time");
		String end_time1 = request.getParameter("end_time");
		String begin_time2 =begin_time1+" 00:00:00";
		String end_time2 =end_time1+" 23:59:59";

/*System.out.println("--wanghyd"+begin_time2);
  System.out.println("--wanghyd"+end_time2);
*/
%>
     <wtc:service name="s495fQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3">
        <wtc:param value="<%=PhoneNo%>"/>
        <wtc:param value="<%=begin_time2%>"/>
        <wtc:param value="<%=end_time2%>"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
									<tr >
								<th>手机号码</th>						
								<th>兑换积分</th>
							<th>兑换时间</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							%>
							<tr> 
								<td width="7%"><%=dcust2[i][0]%></td>
								<td width="7%"><%=dcust2[i][1]%></td>
								<td width="7%"><%=dcust2[i][2]%></td>
						  </tr>
						  		<%
		    }}
		  else {
		%>
		<tr height='25' align='center'><td colspan='3'>查询信息为空！</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
						</table>
					</div>
				</div>
</body>
</html>
