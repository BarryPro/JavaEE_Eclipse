<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
开发商: si-tech
ningtn 2012-4-18 09:33:16
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String phoneNo = request.getParameter("phoneNo");
  String cccTime=new java.text.SimpleDateFormat("yyyyMMdd HHmmss", Locale.getDefault()).format(new java.util.Date());
%>
<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="pubProdScript.js"></script>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
<script language="javascript">
	$(document).ready(function(){
		getPriceRevoMsg();
		/* 用户资源量，当前使用、下月预约 点击触发的事件 */
		$(".m-box-txt2 a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
			num = $(".m-box-txt2 a").index($(this)[0]);
			$(".m-box-txt2 .tab-con").eq(num).show().siblings(".tab-con").hide();
		});
	});
	function getPriceRevoMsg(){
		var getdataPacket = new AJAXPacket("fe759PubPriceRevoMsg.jsp","请稍后...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("qryType","3");
		getdataPacket.data.add("flag","0");
		core.ajax.sendPacketHtml(getdataPacket,doGetPriceRevoMsgHtml);
		getdataPacket =null;
	}
	function doGetPriceRevoMsgHtml(data){
		$("#stockTab").empty();
		$("#stockTab").append(data);
	}
	function doBack(){
		window.location.href="fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
	}
</script>
<body class="second">
<form name="frm" method="post">
	<div id="Operation_Title">
	<div class="icon"></div>
		<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>·<%=WtcUtil.repNull(opName)%></B>
	</div>
	<div class="prodContent">
			<!----- 已订购产品部分 ----->
			<div class="m-box">
				<div class="m-box1-top">
					用户资源量
				</div>
				<div class="m-box-txt2" id="stockTab">
					
				</div>
			</div>
			<!----- 已订购产品部分  end ----->
		<table cellspacing="0">
			<tr id="footer"> 
				<td> 
					<div align="center"> 
					<input name="goBack" type="button" class="b_foot" value="返回" onClick="doBack()" />
						&nbsp;
					<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
					&nbsp; 
					</div>
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>