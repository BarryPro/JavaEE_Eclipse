<%
  /*
   * 功能:关于“双十一”主题营销活动相关支撑功能的开发需求——18元套卡销售
   * 版本: 1.0
   * 日期: 2013/11/05 16:26:33
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		//String phoneNo = (String)request.getParameter("activePhone");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			
			
		});
		function doQuery(){
			if(!check(f1)){
					return false;
				}
			var getdataPacket = new AJAXPacket("fg530RemoveQry.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("phoneNo",$("#phoneNo").val());
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			core.ajax.sendPacketHtml(getdataPacket);
			getdataPacket = null;
			
		}
		
		function doProcess(data){
				//找到添加表格的div
				var markDiv=$("#intablediv"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				//document.form1.toexcel.disabled=false;
		}
		function doReset(){
			$("#phoneNo").val("");
		}
	function removeBill(phoneNo){
			//alert(phoneNo);
			var myPacket = new AJAXPacket("/npage/sg603/orderDraw.jsp","服务正在提交，请稍候...");
			myPacket.data.add("accept","<%=loginAccept%>");
			myPacket.data.add("opCode", '<%=opCode%>');
			myPacket.data.add("phoneNo", phoneNo);
			
			core.ajax.sendPacket(myPacket, function(packet){
					//$(button).attr('disabled', 'true');
					
					var errorCode = packet.data.findValueByName('errorCode');
					var errorMsg = packet.data.findValueByName('errorMsg');
					
					if ("000000" == errorCode){
							rdShowMessageDialog("撤单成功！");
							window.location.href = "/npage/sg529/fg530RemoveMain.jsp?opCode=i229&opName=网上售卡撤单";
					} else {
							rdShowMessageDialog("撤单失败！" + errorCode + errorMsg, 1);
							window.location.href = "/npage/sg529/fg530RemoveMain.jsp?opCode=i229&opName=网上售卡撤单";
					}
			});
			
			myPacket = null;
		
		}
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	
	<table cellspacing="0">
		<tr>
	    <td class="blue">手机号码</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" maxlength="15" 
				 v_type="mobphone" v_must="1" onblur="checkElement(this)" />&nbsp;<font color="orange">*</font>
			</td>
		</tr>
	</table>
	<div id="intablediv">
	</div>
	<table cellspacing="0">
		<tr>
			<td>
				<div align="center">
				<input type="button" name="query" class="b_foot" value="查询" onclick="doQuery()" />
			
				&nbsp;
				<input type="reset" name="reset" class="b_foot" value="清除" onclick="doReset()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
				</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>



</html>