<%
   /*
   * 功能: 增值税纳税人资质信息列表
　 * 版本: v1.0
　 * 日期: 2013-08-30
　 * 作者: wangjxc	
　 * 版权: sitech
   * 修改历史
   * 修改日期:  	
   * 修改人:
   * 修改目的:
 　*/
%>
 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String  par_cust_id	     = (String)request.getParameter("par_cust_id");
		String  low_cust_id   = (String)request.getParameter("low_cust_id");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
%>

<wtc:service name="so001RelQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=par_cust_id%>"/>
	  <wtc:param value="<%=low_cust_id%>"/>
	  <wtc:param value="1"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>	


<div class="list">
		<table id="tbSort">
	<tr>
		<th>上级客户标识</th>
		<th>上级纳税人识别号</th>
		<th>下级客户标识</th>
		<th>下级纳税人识别号</th>
    	<th>创建时间</th>
    	<th>操作</th>
	</tr>

	<% 
	if("000000".equals(retCode)){

			if(retList.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(retList.length>0){
				for(int i=0;i<retList.length;i++){
				
				
	%>
   <tr>
		<td><%=retList[i][2]%></td>
		<td><%=retList[i][3]%></td>
		<td><%=retList[i][0]%></td>
		<td><%=retList[i][1]%></td>
		<td><%=retList[i][4]%></td>	
		<td>
			<input class="butDel" type="button" title="删除" onClick="delTaxPayerRel(<%=retList[i][5]%>)"/>
		</td>
   </tr>
   <%
		
	}
   %>
</table>
</div>
	
	
<%	}}else{

		return;
	}
	%>
	<input type="hidden" name="retCode" id="retCode" value="<%=retCode%>" />
	<input type="hidden" name="retMsg" id="retMsg" value="<%=retMsg%>" />
	
