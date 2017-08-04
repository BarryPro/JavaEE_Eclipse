<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode= (String)session.getAttribute("regCode");
		
		String grpoutname = request.getParameter("grpoutname") == null ? "":request.getParameter("grpoutname");
		String grpoutid = request.getParameter("grpoutid") == null ? "":request.getParameter("grpoutid");;
		String grpMenname = request.getParameter("grpMenname") == null ? "":request.getParameter("grpMenname");
		String grpMensex = request.getParameter("grpMensex") == null ? "":request.getParameter("grpMensex");
		String grpMenduty = request.getParameter("grpMenduty") == null ? "":request.getParameter("grpMenduty");
		String oCManageName = request.getParameter("oCManageName") == null ? "":request.getParameter("oCManageName");
		String oCManageNO = request.getParameter("oCManageNO") == null ? "":request.getParameter("oCManageNO");
		String oCManagePhone = request.getParameter("oCManagePhone") == null ? "":request.getParameter("oCManagePhone");
		//String oInDate = request.getParameter("oInDate") == null ? "":request.getParameter("oInDate");
		String oNewGrpName = request.getParameter("oNewGrpName") == null ? "":request.getParameter("oNewGrpName");
		String oNewGrpNo = request.getParameter("oNewGrpNo") == null ? "":request.getParameter("oNewGrpNo");
		String oNewCManageName = request.getParameter("oNewCManageName") == null ? "":request.getParameter("oNewCManageName");
		String oNewCManageNO = request.getParameter("oNewCManageNO") == null ? "":request.getParameter("oNewCManageNO");
		String oNewCManagePhone = request.getParameter("oNewCManagePhone") == null ? "":request.getParameter("oNewCManagePhone");
		String oInTime = request.getParameter("oInTime") == null ? "":request.getParameter("oInTime");
		String oPhoneNo = request.getParameter("oPhoneNo") == null ? "":request.getParameter("oPhoneNo");
		String oOutAppMsg = request.getParameter("oOutAppMsg") == null ? "":request.getParameter("oOutAppMsg");
		String oInAppMsg = request.getParameter("oInAppMsg") == null ? "":request.getParameter("oInAppMsg");
		String zgdslID = request.getParameter("zgdslID") == null ? "":request.getParameter("zgdslID");
		String outregionname =request.getParameter("outregionname") == null ? "":request.getParameter("outregionname");
		String inregionname =request.getParameter("inregionname") == null ? "":request.getParameter("inregionname");
		%>
			<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="printAccept"/>
		 
     <wtc:service name="sQryTranMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="7">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=oPhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="<%=zgdslID%>"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
        	
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe860.js"></script>
		<script language="javascript">
			function getclosed() {
					window.close();
			}
		</script>
	</head>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	      <table cellspacing="0" >
		  <tr>
		    <td class="blue" width="15%">调出集团名称</td>
		    <td >
		  <input name="outgrpname" type="text"   id="outgrpname" readOnly Class="InputGrey" value="<%=grpoutname%>">
		</td>
				    <td class="blue" width="15%">调出集团编号</td>
		    <td >
		  <input name="outgrpid" type="text"   id="outgrpid" readOnly Class="InputGrey" value="<%=grpoutid%>">
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">集团重要成员姓名</td>
		    <td >
		  <input name="grpMenname" type="text"   id="grpMenname" readOnly Class="InputGrey" value="<%=grpMenname%>">
		</td>
				    <td class="blue" width="15%">集团重要成员性别</td>
		    <td >
		  <input name="grpMensex" type="text"   id="grpMensex" readOnly Class="InputGrey" value="<%=grpMensex%>">
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">集团重要成员职务</td>
		    <td >
		  <input name="grpMenduty" type="text"   id="grpMenduty" readOnly Class="InputGrey" value="<%=grpMenduty%>">
		</td>
				    <td class="blue" width="15%">客户经理名称</td>
		    <td >
		  <input name="oCManageName" type="text"   id="oCManageName" readOnly Class="InputGrey" value="<%=oCManageName%>">
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">客户经理工号</td>
		    <td >
		  <input name="oCManageNO" type="text"   id="oCManageNO" readOnly Class="InputGrey" value="<%=oCManageNO%>">
		</td>
				    <td class="blue" width="15%">客户经理电话</td>
		    <td >
		  <input name="oCManagePhone" type="text"   id="oCManagePhone" readOnly Class="InputGrey" value="<%=oCManagePhone%>">
		</td>

	</tr>
			  <tr>

				    <td class="blue" width="15%">调入集团名称</td>
		    <td >
		  <input name="oNewGrpName" type="text"   id="oNewGrpName" readOnly Class="InputGrey" value="<%=oNewGrpName%>">
		</td>
					    <td class="blue" width="15%">调入集团编号</td>
		    <td >
		  <input name="oNewGrpNo" type="text"   id="oNewGrpNo" readOnly Class="InputGrey" value="<%=oNewGrpNo%>">
		</td>
	</tr>
			  <tr>

				    <td class="blue" width="15%">调入集团客户经理名称</td>
		    <td >
		  <input name="oNewCManageName" type="text"   id="oNewCManageName" readOnly Class="InputGrey" value="<%=oNewCManageName%>">
		</td>
		    <td class="blue" width="15%">调入集团客户经理工号</td>
		    <td >
		  <input name="oNewCManageNO" type="text"   id="oNewCManageNO" readOnly Class="InputGrey" value="<%=oNewCManageNO%>">
		</td>
	</tr>
				  <tr>

				    <td class="blue" width="15%">调入集团客户经理电话</td>
		    <td >
		  <input name="oNewCManagePhone" type="text"   id="oNewCManagePhone" readOnly Class="InputGrey" value="<%=oNewCManagePhone%>">
		</td>
		
				    <td class="blue" width="15%">调入新单位时间</td>
		    <td >
		  <input name="oInTime" type="text"   id="oInTime" readOnly Class="InputGrey" value="<%=oInTime%>">
		</td>

	</tr>

</table>
	 <table >
									<tr >	
								<th>工单创建时间</th>				
								<th>工单完成时间</th>
								<th>工单阶段</th>
								<th>审批工号</th>
								<th>审批时间</th>
								<th>审批结果</th>
								<th>审批信息</th>
							</tr>
									<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   
							   for(int i=0;i<dcust2.length; i++) {
							   							%>
							<tr> 
                <td width="10%"><%=dcust2[i][0]%></td>
								<td width="10%"><%=dcust2[i][1]%></td>
								<td width="10%"><%=dcust2[i][2]%></td>
								<td width="10%"><%=dcust2[i][3]%></td>
								<td width="10%"><%=dcust2[i][4]%></td>
								<td width="10%"><%if(dcust2[i][6].equals("N")){out.print("不通过");} if(dcust2[i][6].equals("Y")){out.print("通过");}%></td>
								<td width="20%"><%=dcust2[i][5]%></td>										
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
					

	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="close" class="b_foot" value="关闭" onClick="getclosed();"/>
			</div>
			</td>
		</tr>
	</table>
		<div id="gongdans">
		</div>	  
<input type="hidden" id="myJSONText" name="myJSONText" />	    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>