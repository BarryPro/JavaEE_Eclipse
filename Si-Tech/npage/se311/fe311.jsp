<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<head>
	<title>测试</title>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		
		%>
		<script language="javascript">
      function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			var phoneNo 	= $("#phoneNo").val().trim();

			var getdataPacket = new AJAXPacket("fe311_1.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo",phoneNo);

			core.ajax.sendPacketHtml(getdataPacket);
			getdataPacket = null;
		}
		function doProcess(data){
				//找到添加表格的div
				var markDiv=$("#intablediv"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
		}
		function doReset(){
			window.location.href = "fe311.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		</script>
		<body >
		<form name="form1" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
				<tr>
			<td class="blue" width="15%">手机号码</td>
			<td>
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1"  maxlength="11" 
						v_type="mobphone" onblur="checkElement(this)" /><font color="orange">*</font> 
			</td>
		</tr>
  </table>
  
 	<div id="intablediv">
	</div>
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button" name="quchoose" class="b_foot" value="查询" onclick="doQuery()" />		
				&nbsp;
				<input type="button" name="close" class="b_foot" value="清除" onClick="doReset()"/>
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>


</body>
</html>