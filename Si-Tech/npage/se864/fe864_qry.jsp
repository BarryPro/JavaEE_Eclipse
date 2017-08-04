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
		
		String PhoneNo = request.getParameter("PhoneNo") == null ? "":request.getParameter("PhoneNo");
		String beginTimegds = request.getParameter("beginTimegds") == null ? "":request.getParameter("beginTimegds");
		String endTimegds = request.getParameter("endTimegds") == null ? "":request.getParameter("endTimegds");
		String iQryFlag = request.getParameter("iQryFlag") == null ? "":request.getParameter("iQryFlag");
		String dishi = request.getParameter("dishi") == null ? "":request.getParameter("dishi");
		String iRegionFlag = request.getParameter("iRegionFlag") == null ? "":request.getParameter("iRegionFlag");
		
	

/*System.out.println("--wanghyd"+begin_time2);
  System.out.println("--wanghyd"+end_time2);
*/
			
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="printAccept"/>
		 
     <wtc:service name="sQryTransInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="18">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=PhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="<%=beginTimegds%>"/>
        <wtc:param value="<%=endTimegds%>"/>
        <wtc:param value="<%=iRegionFlag%>"/>
        <wtc:param value="<%=iQryFlag%>"/>
        <wtc:param value="<%=dishi%>"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
<%
if(iQryFlag.equals("1")) {/*地市查询*/
%>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
									<tr >	
								<th>手机号码</th>				
								<th>调入地市</th>
								<th>调出地市</th>
								<td></td>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   
							   for(int i=0;i<dcust2.length; i++) {
							 /*  
							   out.println("---"+dcust2[i][0]+"---");
							    out.println("---"+dcust2[i][1]+"---");
							     out.println("---"+dcust2[i][2]+"---");
							      out.println("---"+dcust2[i][3]+"---");
							       out.println("---"+dcust2[i][4]+"---");
							        out.println("---"+dcust2[i][5]+"---");
							         out.println("---"+dcust2[i][6]+"---");
							          out.println("---"+dcust2[i][7]+"---");
							           out.println("---"+dcust2[i][8]+"---");
							            out.println("---"+dcust2[i][9]+"---");
							             out.println("---"+dcust2[i][10]+"---");
							              out.println("---"+dcust2[i][11]+"---");
							               out.println("---"+dcust2[i][12]+"---");
							                out.println("---"+dcust2[i][13]+"---");
							                 out.println("---"+dcust2[i][14]+"---");
							                  out.println("---"+dcust2[i][15]+"---");
							                  out.println("---"+dcust2[i][16]+"---");
							                  out.println("---"+dcust2[i][17]+"---");
							              */    
							                  
							%>
							<tr> 
                <td width="12%"><%=dcust2[i][14]%></td>
								<td width="12%"><%=dcust2[i][16]%></td>
								<td width="12%"><%=dcust2[i][17]%></td>
								<td width="7%"><a href="<%=request.getContextPath()%>/npage/se864/fe864_qryAll.jsp?grpoutname=<%=dcust2[i][0]%>&grpoutid=<%=dcust2[i][1]%>&grpMenname=<%=dcust2[i][2]%>&grpMensex=<%=dcust2[i][3]%>&grpMenduty=<%=dcust2[i][4]%>&oCManageName=<%=dcust2[i][5]%>&oCManageNO=<%=dcust2[i][6]%>&oCManagePhone=<%=dcust2[i][7]%>&oNewGrpName=<%=dcust2[i][8]%>&oNewGrpNo=<%=dcust2[i][9]%>&oNewCManageName=<%=dcust2[i][10]%>&oNewCManageNO=<%=dcust2[i][11]%>&oNewCManagePhone=<%=dcust2[i][12]%>&oInTime=<%=dcust2[i][13]%>&oPhoneNo=<%=dcust2[i][14]%>&opCode=<%=opCode%>&opName=<%=opName%>&zgdslID=<%=dcust2[i][15]%>&inregionname=<%=dcust2[i][16]%>&outregionname=<%=dcust2[i][17]%>" target="_blank">详细信息</a>	</td>										
						  </tr>
						  		<%
		    }
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='4'>查询信息为空！</td></tr>
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
<%}
else {/*手机号码查询*/
%>
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
								<th>客户经理名称</th>
								<th>客户经理工号</th>
								<th>调入新单位时间</th>
								<th>调入集团名称</th>
								<th>调入集团客户经理名称</th>
								<th>调入集团客户经理工号</th>
								<td></td>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   
							   for(int i=0;i<dcust2.length; i++) {
							  /* 
							   out.println("---"+dcust2[i][0]+"---");
							    out.println("---"+dcust2[i][1]+"---");
							     out.println("---"+dcust2[i][2]+"---");
							      out.println("---"+dcust2[i][3]+"---");
							       out.println("---"+dcust2[i][4]+"---");
							        out.println("---"+dcust2[i][5]+"---");
							         out.println("---"+dcust2[i][6]+"---");
							          out.println("---"+dcust2[i][7]+"---");
							           out.println("---"+dcust2[i][8]+"---");
							            out.println("---"+dcust2[i][9]+"---");
							             out.println("---"+dcust2[i][10]+"---");
							              out.println("---"+dcust2[i][11]+"---");
							               out.println("---"+dcust2[i][12]+"---");
							                out.println("---"+dcust2[i][13]+"---");
							                 out.println("---"+dcust2[i][14]+"---");
							                  out.println("---"+dcust2[i][15]+"---");
							                  out.println("---"+dcust2[i][16]+"---");
							                  */
							                  
							                  
							%>
							<tr> 
                <td width="12%"><%=dcust2[i][0]%></td>
								<td width="9%"><%=dcust2[i][1]%></td>
								<td width="8%"><%=dcust2[i][2]%></td>
								<td width="7%"><%=dcust2[i][5]%></td>
								<td width="7%"><%=dcust2[i][6]%></td>
								<td width="10%"><%=dcust2[i][8]%></td>
								<td width="12%"><%=dcust2[i][9]%></td>
								<td width="7%"><%=dcust2[i][11]%></td>
								<td width="7%"><%=dcust2[i][12]%></td>	
								<td width="7%"><a href="<%=request.getContextPath()%>/npage/se864/fe864_qryAll.jsp?grpoutname=<%=dcust2[i][0]%>&grpoutid=<%=dcust2[i][1]%>&grpMenname=<%=dcust2[i][2]%>&grpMensex=<%=dcust2[i][3]%>&grpMenduty=<%=dcust2[i][4]%>&oCManageName=<%=dcust2[i][5]%>&oCManageNO=<%=dcust2[i][6]%>&oCManagePhone=<%=dcust2[i][7]%>&oNewGrpName=<%=dcust2[i][8]%>&oNewGrpNo=<%=dcust2[i][9]%>&oNewCManageName=<%=dcust2[i][10]%>&oNewCManageNO=<%=dcust2[i][11]%>&oNewCManagePhone=<%=dcust2[i][12]%>&oInTime=<%=dcust2[i][13]%>&oPhoneNo=<%=dcust2[i][14]%>&opCode=<%=opCode%>&opName=<%=opName%>&zgdslID=<%=dcust2[i][15]%>&inregionname=<%=dcust2[i][16]%>&outregionname=<%=dcust2[i][17]%>" target="_blank">详细信息</a>	</td>										
						  </tr>
						  		<%
		    }
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='10'>查询信息为空！</td></tr>
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
<%}%>
</body>
</html>