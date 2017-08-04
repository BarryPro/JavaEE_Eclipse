<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="utils.system"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String loginNo = (String)request.getParameter("loginNo");//操作员登陆工号
	String password = (String)request.getParameter("password");//操作员登陆工号密码
	String group_id = (String)request.getParameter("groupId");
	String phoneNo = (String)request.getParameter("activePhone");//手机号
	String saleSeq = (String)request.getParameter("saleSeq");//流水
	System.out.println("++++++++++++++++++++++f4939_attention group_id="+group_id);
	System.out.println("++++++++++++++++++++++f4939_attention loginNo="+loginNo);
	System.out.println("++++++++++++++++++++++f4939_attention password="+password);
	System.out.println("++++++++++++++++++++++f4939_attention phoneNo="+phoneNo);
	System.out.println("++++++++++++++++++++++f4939_attention saleSeq="+saleSeq);
	
%>
<html>
<head>
	<title>冲正退费提醒</title>
</head>
<body>
	<div id="operation">
		<div id="operation_table"> 
			<div class="title"><div class="text">冲正退费提醒</div></div>		
			<div class="input">
				<table id="searchTable">
					<tr>
						<th>冲正选项</th><th>提示信息</th>
					</tr>
					<tr>
						<td>
							<select id="selectId" onchange="changeCity(this.value)">
								<option value="0">--请选择--</option>
								<option value="1">电子渠道购机冲正 </option>
								<option value="2">普通业务冲正 </option>							
							</select>
						</td>
						<td>
							<SMALL>电子渠道购机冲正<font style="color:red">[无需退还现金]</font><br/>普通业务冲正<font style="color:red">[冲正退现金]</font>！</SMALL>
							<!-- <input class="required" name="meanName" value=""	maxlength="100" size="30" /> -->
						</td>
					</tr>
				</table>				
			</div>
			<div id="operation_button"><!-- disabled="disabled" -->
				<input type="button" class="b_foot"  disabled="disabled" value="确定" id="btnSubmit" name="btnSubmit" onclick="doRetMain()" />
				<input type="button" class="b_foot" value="关闭" id="btnCancel" name="btnCancel" onclick="closeWin()" />
			</div>
		</div>
	</div>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
<script>
	var frm = document.all("frm");
	function changeCity(opId){
		if(opId == "0"){
			$("#btnSubmit").attr("disabled",true);
			return;
		}
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se118/f4939_checkOrderId.jsp","请稍后...");//调用校验服务。。返回对应信息
		packet.data.add("saleSeq","<%=saleSeq%>");
		packet.data.add("optype",opId);
		packet.data.add("loginNo","<%=loginNo %>");
		core.ajax.sendPacketHtml(packet,doCheckOrderId,true);
		packet =null;
	}
	function doCheckOrderId(data){
		var sdata = data.split("~");
		var retCode = sdata[0];
		var opType = sdata[1];
		if(retCode == 0){
			$("#btnSubmit").attr("disabled",false);
			rdShowMessageDialog("业务验证成功！",1);
		}else{		
			$("#btnSubmit").attr("disabled",true);
			rdShowMessageDialog("您选择的冲正选项与实际不符，请确认业务！",1);
			return false;
		}	
	}
	
	function doRetMain(){
		window.opener.retSeq();
		window.close();
	}
	function closeWin(){
		window.close();
	}
	
	
</script>
</html>