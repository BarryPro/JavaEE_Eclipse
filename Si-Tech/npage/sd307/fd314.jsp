<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		$(document).ready(function(){
			$("#cardNo").focus();
		});
		
		function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			/* 调用提交服务 */

			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("serviceName","sD314Cfm");
			getdataPacket.data.add("outnum","6");
			getdataPacket.data.add("inputParamsLength","8");
			getdataPacket.data.add("inParams0","");
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5",$("#phoneNo").val());
			getdataPacket.data.add("inParams7",$("#cardNo").val());
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if("000000" == retCode){
				rdShowMessageDialog("操作成功","2");
				removeCurrentTab();
				
			}else{
				rdShowMessageDialog("操作失败" + retCode + ":" + retMsg,"0");
				return false;
			}
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue">卡号</td>
			<td>
				<input type="text" name="cardNo" id="cardNo" maxlength="30" 
				 v_must="1" onblur="checkElement(this)" />
				 <font class="orange"><span>*</span></font>
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="2">
				<input type="button" name="query" class="b_foot" value="确认" 
          style="cursor:hand;" onClick="doQuery()">
				<input type="button" name="closeButton" class="b_foot" value="关闭" 
          style="cursor:hand;" onClick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>