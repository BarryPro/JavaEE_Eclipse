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
		 
     <wtc:service name="sQryImpCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="9">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=PhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
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

								<th>调出集团名称</th>						
								<th>调出集团编号</th>
								<th>集团重要成员姓名</th>
								<th>集团重要成员性别</th>
								<th>集团重要成员职务</th>
								<th>客户经理名称</th>
								<th>客户经理工号</th>
								<th>客户经理电话</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							%>

							<tr> 
								
								<td width="20%"><%=dcust2[0][0]%></td>
								<td width="7%"><%=dcust2[0][1]%></td>
								<td width="7%"><%=dcust2[0][2]%></td>
								<td width="4%"><%=dcust2[0][3]%></td>
								<td width="10%"><%=dcust2[0][4]%></td>
								<td width="7%"><%=dcust2[0][5]%></td>
								<td width="4%"><%=dcust2[0][6]%></td>
								<td width="7%"><%=dcust2[0][7]%></td>						
						  </tr>
								</table>
								<table >
					<tr>
						<td class="blue" width="14%">调入新单位时间</td>
						<td width="20%">
							<input type="text" v_type="date"  id="begin_time" name="begin_time" value=<%=dateStr%> size="17" maxlength="8" v_must="1">
							<font class="orange">*</font>&nbsp;<font class="orange">YYYYMMDD</font>
						</td>
												<td class="blue" width="12%">调入集团名称</td>
						<td width="26%">
							<input type="text"  id="jtnames1" name="jtnames1"  size="30" maxlength="100" v_must="1">
							<font class="orange">*</font>
						</td>
												<td class="blue" >选择调入地市</td>
						<td>
											<select id="intocity" name="intocity"  style="width:120px;">
												<option value ="nn">--请选择--</option>
												<wtc:qoption name="TlsPubSelCrm" outnum="2">
													<wtc:sql>
														SELECT region_code, region_name
														  FROM sregioncode
														 WHERE use_flag = '?'
													</wtc:sql>
													<wtc:param value="Y"/>
												</wtc:qoption>
											 </select>
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
		<tr height='25' align='center'><td colspan='3'>查询信息为空！</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
						
					</div>
				</div>
</body>
</html>
