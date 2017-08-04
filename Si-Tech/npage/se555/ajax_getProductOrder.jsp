<%
  /*
   * 功能: e555·工单流转状态同步管理
   * 版本: 1.0
   * 日期: 20120118
   * 作者: wanghfa
   * 版权: si-tech
  */
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String poOrderNumber = request.getParameter("poOrderNumber");
	String opType = request.getParameter("opType");
	String disabledStr = "";
	if ("q".equals(opType)) {
		disabledStr = "disabled";
	}
	System.out.println("====wanghfa====ajax_getProductOrder.jsp====poOrderNumber = " + poOrderNumber);
	System.out.println("====wanghfa====ajax_getProductOrder.jsp====opType = " + opType);

%>
<wtc:service name="sStaProdListQry" routerKey="region" 
		routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="e555"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=poOrderNumber%>"/>
	<wtc:param value="<%=opType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
if (!"000000".equals(retCode1)) {
	%>
	<tr>
		<td colspan="6">
			sStaProdListQry服务查询错误：<%=retCode1%>，<%=retMsg1%>。
		</td>
	</tr>
	<%
} else {
	for (int i = 0; i < result1.length; i ++) {
		%>
		<tr name="productOrder" p_productId="<%=result1[i][0]%>" 
			p_circuitCode="<%=result1[i][1]%>"
			p_result="<%=result1[i][2]%>"
			p_reason="<%=result1[i][3]%>"
			p_customContact="<%=result1[i][4]%>"
			p_customContactPhone="<%=result1[i][5]%>"
			p_planCompTime="<%=result1[i][6]%>"
		>
			<td>
				<input type="checkbox" name="productOrderDetailSelect" value="<%=result1[i][0]%>" <%=disabledStr%>>
			</td>
			<td><a style="cursor: hand;" onclick="productOrderDetail(this)"><%=result1[i][0]%></a></td>
			<td><%=result1[i][1]%></td>
			<td><%="1".equals(result1[i][2])?"已成功完成":("1".equals(result1[i][2])?"未成功完成":"未知结果")%></td>
			<td><%=result1[i][4]%></td>
		<%
		for (int j = 0; j < result1[i].length; j ++) {
			System.out.println("====wanghfa====ajax_getProductOrder.jsp====result1["+i+"]["+j+"] = " + result1[i][j]);
		}
		%>
		</tr>
		<%
	}
}
%>
