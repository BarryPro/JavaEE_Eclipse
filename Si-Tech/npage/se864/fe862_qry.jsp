<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String groupId = (String)session.getAttribute("groupId");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

/*System.out.println("--wanghyd"+begin_time2);
  System.out.println("--wanghyd"+end_time2);
*/
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="printAccept"/>
		 
     <wtc:service name="sQryWOrderInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="12">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=PhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="1"/>
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
										<th></th>
								<th>调出集团名称</th>						
								<th>调出集团编号</th>
								<th>集团重要成员姓名</th>
								<th>重要成员手机号码</th>
								<th>重要成员性别</th>
								<th>重要成员职务</th>
								<th>客户经理名称</th>
								<th>客户经理工号</th>
								<th>客户经理电话</th>
								<th>调入新单位时间</th>
								<th>调入集团名称</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							%>
							<tr> 
								<td width="4%"><input type="radio" name="jtradio" value="<%=dcust2[i][1]%>|<%=dcust2[i][10]%>|<%=dcust2[i][9]%>|<%=i%>"  ></td>
								<td width="20%"><%=dcust2[i][0]%></td>
								<td width="7%"><%=dcust2[i][1]%></td>
								<td width="7%"><%=dcust2[i][2]%></td>
								<td width="7%"><%=dcust2[i][11]%></td>
								<td width="4%"><%=dcust2[i][3]%></td>
								<td width="10%"><%=dcust2[i][4]%></td>
								<td width="7%"><%=dcust2[i][5]%></td>
								<td width="4%"><%=dcust2[i][6]%></td>
								<td width="7%"><%=dcust2[i][7]%></td>	
								<td width="7%"><%=dcust2[i][8]%></td>
								<td width="7%"><input type="text" id="grpName<%=i%>" value="<%=dcust2[i][9]%>" style="width:100px;"> <input type="hidden" name="grpID<%=i%>" id="grpID<%=i%>" value="">	</td>										
						  </tr>
						  		<%
		    }
		    %>
		    <table >
					<tr>
					 <td class="blue" width="12%">要调入的集团查询</td>
						<td width="15%">
							<input type="button"  name="quegrps" class="b_text" value="调入集团查询" onclick="queGrp()" />
						</td>
					
						<td class="blue" width="12%">审批类型</td>
						<td width="15%">
											<select id="shenpitype" name="shenpitype"  style="width:120px;">
												<option value ="nn">--请选择--</option>
												<option value ="0">审批通过</option>
												<option value ="1">审批不通过</option>
											</select>
							<font class="orange">*</font>&nbsp;
						</td>
												<td class="blue" width="12%">审批信息</td>
						<td width="40%">
							<input type="text"  id="shenpimsg" name="shenpimsg"  size="50" maxlength="200" v_must="1">
							<font class="orange">*</font>
						</td>
					</tr>
					<br>
				</table>		  
					<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="提交" onClick="confirmS()" />
			</div>
			</td>
		</tr>
	</table>
		    <%
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='11'>查询信息为空！</td></tr>
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