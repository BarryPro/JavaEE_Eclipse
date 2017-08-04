<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		
		String grpoutname = request.getParameter("grpoutname");
		String grpoutid = request.getParameter("grpoutid");
		String grpMenname = request.getParameter("grpMenname");
		String grpMensex = request.getParameter("grpMensex");
		String grpMenduty = request.getParameter("grpMenduty");
		String oCManageName = request.getParameter("oCManageName");
		String oCManageNO = request.getParameter("oCManageNO");
		String oCManagePhone = request.getParameter("oCManagePhone");
		String oInDate = request.getParameter("oInDate");
		String oNewGrpName = request.getParameter("oNewGrpName");
		String oNewGrpNo = request.getParameter("oNewGrpNo");
		String oNewCManageName = request.getParameter("oNewCManageName");
		String oNewCManageNO = request.getParameter("oNewCManageNO");
		String oNewCManagePhone = request.getParameter("oNewCManagePhone");
		String oOutAppMsg = request.getParameter("oOutAppMsg");
		String oInAppMsg = request.getParameter("oInAppMsg");
		String zgdslID = request.getParameter("zgdslID");
		String cyphonenum = request.getParameter("cyphonenum");
		%>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe860.js"></script>
		<script language="javascript">
			
				function returnBefo() {
				  window.location.href = "fe863_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
				}
			function cofirms() {
						 var shenpitype = $("#shenpitype").val();
						 if(shenpitype=="nn") {
						 rdShowMessageDialog("审批类型不能为空，请选择！");
						 return false;
						 }
						 			if(!check(frm))
						 {
							 return false;
						 }
						 var grpids = $("#oNewGrpNo").val();
						 var zgdsl_id = "<%=zgdslID%>";
						 
						 	var getdataPacket = new AJAXPacket("fe863_submit.jsp","正在提交中，请稍候......");
						getdataPacket.data.add("opCode","<%=opCode%>");
						getdataPacket.data.add("opName","<%=opName%>");
						getdataPacket.data.add("myJSONText",$("#myJSONText").val());
						getdataPacket.data.add("shenpitype",$("#shenpitype").val());
						getdataPacket.data.add("shenpimsg",$("#shenpimsg").val());
						getdataPacket.data.add("unit_id",grpids);
						getdataPacket.data.add("zgdsl_id",zgdsl_id);
						core.ajax.sendPacket(getdataPacket);
						getdataPacket = null;
						 
												
			}
						function doProcess(packet) {

			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog(retMsg,2);
				returnBefo();
				//removeCurrentTab();
			}else {
				rdShowMessageDialog("提交失败，错误代码："+retCode+"错误信息："+retMsg,0);
				//removeCurrentTab();
			}
		}
		
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
				    <td class="blue" width="15%">集团重要成员手机号码</td>
		    <td >
		  <input name="cyphonenum" type="text"   id="cyphonenum" readOnly Class="InputGrey" value="<%=cyphonenum%>">
		</td>

	</tr>
	<tr>
			<td class="blue" width="15%">客户经理名称</td>
		    <td colspan="3">
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
		    <td class="blue" width="15%">调入新集团时间</td>
		    <td >
		  <input name="oInDate" type="text"   id="oInDate" readOnly Class="InputGrey" value="<%=oInDate%>">
		</td>
				    <td class="blue" width="15%">调入新集团名称</td>
		    <td >
		  <input name="oNewGrpName" type="text"   id="oNewGrpName" readOnly Class="InputGrey" value="<%=oNewGrpName%>">
		</td>

	</tr>
			  <tr>
		    <td class="blue" width="15%">调入新集团ID</td>
		    <td >
		  <input name="oNewGrpNo" type="text"   id="oNewGrpNo" readOnly Class="InputGrey" value="<%=oNewGrpNo%>">
		</td>
				    <td class="blue" width="15%">调入新集团客户经理名称</td>
		    <td >
		  <input name="oNewCManageName" type="text"   id="oNewCManageName" readOnly Class="InputGrey" value="<%=oNewCManageName%>">
		</td>

	</tr>
				  <tr>
		    <td class="blue" width="15%">调入新集团客户经理工号</td>
		    <td >
		  <input name="oNewCManageNO" type="text"   id="oNewCManageNO" readOnly Class="InputGrey" value="<%=oNewCManageNO%>">
		</td>
				    <td class="blue" width="15%">调入新集团客户经理电话</td>
		    <td >
		  <input name="oNewCManagePhone" type="text"   id="oNewCManagePhone" readOnly Class="InputGrey" value="<%=oNewCManagePhone%>">
		</td>

	</tr>
					  <tr>
		    <td class="blue" width="15%">调出审批信息</td>
		    <td >
		  <input name="oOutAppMsg" type="text"   id="oOutAppMsg" readOnly Class="InputGrey" value="<%=oOutAppMsg%>" size="50">
		</td>
				    <td class="blue" width="15%">调入审批信息</td>
		    <td >
		  <input name="oInAppMsg" type="text"   id="oInAppMsg" readOnly Class="InputGrey" value="<%=oInAppMsg%>" size="50">
		</td>

	</tr>
</table>
<table >
					<tr>					
						<td class="blue" width="15%">审批类型</td>
						<td >
											<select id="shenpitype" name="shenpitype"  style="width:200px;">
												<option value ="nn">--请选择--</option>
												<option value ="A">打回给重要成员调入地市管理员</option>
												<option value ="C">打回给重要成员调出地市管理员</option>
												<option value ="S">通过</option>
											</select>
							<font class="orange">*</font>&nbsp;
						</td>
												<td class="blue" width="15%">备注信息</td>
						<td >
							<input type="text"  id="shenpimsg" name="shenpimsg"  size="50" maxlength="200" v_must="1">
							<font class="orange">*</font>
						</td>
					</tr>
					<br>
				</table>		  

	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="comfirms" class="b_foot" value="确定" onClick="cofirms()"/>
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="getclosed();"/>
				&nbsp;
				<input type="button" name="rets" class="b_foot" value="返回" onClick="returnBefo()"/>
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