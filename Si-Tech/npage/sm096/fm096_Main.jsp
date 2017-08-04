<%
  /*
   * 功能:关于请贵部配合进行2014年Radius工程相关需求开发的函
   * 版本: 1.0
   * 日期: 2014/05/08 14:22:51
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String serverIp=realip.trim();
 		String chnSource="01";
 		
 		String opCode = (String)request.getParameter("opCode");		
 		String opName = (String)request.getParameter("opName");
 		
		String phoneNo = (String)request.getParameter("activePhone");
		
%>
<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		
		$(document).ready(function(){
			
			
			$("input[name='radioFlag']").each(function(){
				var ts = $(this);
				if(ts.val() == "<%=opCode%>"){
					$(this).attr("checked","checked");
				}	
			});
			showAndHideDiv("<%=opCode%>");
		
		});
		/*2013/12/11 15:27:10 gaopeng 显隐方法*/
		function showAndHideDiv(sOpCode){
			
			if(sOpCode == "m096"){
				$("#opCode").val("m096");
				$("#opName").val("WLAN主动暂停");
				$("#resetPass").hide();
				$("#editPass").hide();
				
			}
			if(sOpCode == "m097"){
				$("#opCode").val("m097");
				$("#opName").val("WLAN主动恢复");
				$("#resetPass").hide();
				$("#editPass").hide();
				
			}
			if(sOpCode == "m098"){
				$("#opCode").val("m098");
				$("#opName").val("WLAN密码修改");
				$("#resetPass").show();
				$("#editPass").show();
			
				
				
			}
			if(sOpCode == "m099"){
				$("#opCode").val("m099");
				$("#opName").val("WLAN密码重置");
				$("#resetPass").hide();
				$("#editPass").hide();
				
			}
			
		}
		
		/*提交方法*/
		function doConfBtn(){
			
			/*操作方式*/
			var sOpCode = $("input[name='radioFlag'][checked]").val();
			
			var iLoginAccept = "<%=printAccept%>";
			var iChnSource = "01";
			var iOpCode = $("#opCode").val();
			var iOpName = $("#opName").val();
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "<%=phoneNo%>";
			var iUserPwd = "";
			
			var iBiz_type = "ZY";
			var iSpid = "045105";
			var iBiz_code = "ZY0504";
			var iOprCode ="";
			var iEff_date = "";//当前时间
			var iExp_date = "20501230000000";
			var iOp_time = "";//当前时间
			var iOp_note = "["+iLoginNo+"]执行"+iOpCode+"操作";
			var pwd1 = "";
			var pwd2 = "";
				
			/*WLAN主动暂停*/
			if(sOpCode == "m096"){
					iOprCode = "04";
			}
			/*WLAN主动恢复*/
			if(sOpCode == "m097"){
				iOprCode = "05";
			}
			/*WLAN密码修改*/
			if(sOpCode == "m098"){
				iOprCode = "12";
				if(!checkElement(document.all.oldPass)){
					return false;
				}
				if(!checkElement(document.all.newPass)){
					return false;
				}
				if(!checkElement(document.all.cfmPass)){
					return false;
				}
				
				var oldPass = $.trim(document.all.oldPass.value);
				var newPass = $.trim(document.all.newPass.value);
				var cfmPass = $.trim(document.all.cfmPass.value);
				
				if(cfmPass != newPass){
					rdShowMessageDialog("新密码与确认密码不一致！",1);
					return false;
				}
				if(oldPass == newPass){
					rdShowMessageDialog("旧密码与新密码不能相同！",1);
					return false;
				}
				
				pwd1 = oldPass;
				pwd2 = newPass;
				
			}
			/*WLAN密码重置*/
			if(sOpCode == "m099"){
				iOprCode = "11";
				
				
			}
			if(rdShowConfirmDialog("是否确认本操作？")==1)
				{	
			var getdataPacket = new AJAXPacket("/npage/sm096/fm096Cfm.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iOpName",iOpName);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			
			getdataPacket.data.add("iBiz_type",iBiz_type);
			getdataPacket.data.add("iSpid",iSpid);
			getdataPacket.data.add("iBiz_code",iBiz_code);
			getdataPacket.data.add("iOprCode",iOprCode);
			getdataPacket.data.add("iEff_date",iEff_date);
			getdataPacket.data.add("iExp_date",iExp_date);
			getdataPacket.data.add("iOp_time",iOp_time);
			getdataPacket.data.add("iOp_note",iOp_note);
			getdataPacket.data.add("pwd1",pwd1);
			getdataPacket.data.add("pwd2",pwd2);
			
			
			core.ajax.sendPacket(getdataPacket,retCfmBack);
			getdataPacket = null;
			
		}
			
		}
		
		function retCfmBack(packet){
			
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
			
			
			
			if(errCode == "000000"){
				rdShowMessageDialog("操作成功！",2);
				window.location.href="/npage/sm096/fm096_Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			}else{
				rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,1);
				window.location.href="/npage/sm096/fm096_Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
			}
		}
		
		
	</script>
	</head>
<body>
	<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">操作类型</td>
			<td colspan="3">
				<input type="radio" name="radioFlag" value="m096" checked  onclick = "showAndHideDiv(this.value);" />[m096]WLAN主动暂停 &nbsp;&nbsp;
			  <input type="radio" name="radioFlag" value="m097" onclick = "showAndHideDiv(this.value);" />[m097]WLAN主动恢复 &nbsp;&nbsp;
			  <input type="radio" name="radioFlag" value="m098" onclick = "showAndHideDiv(this.value);" />[m098]WLAN密码修改 &nbsp;&nbsp;
			  <input type="radio" name="radioFlag" value="m099" onclick = "showAndHideDiv(this.value);" />[m099]WLAN密码重置 &nbsp;&nbsp;
			</td>
		</tr>
		<tr id="resetPass" style = "display:none">
			<td class = "blue">WLAN密码</td>
			<td colspan="3">
				<input type="password" name="oldPass" v_must="1"  id="oldPass" value=""/> &nbsp;<font color="red">*<font>
			</td>
		</tr>
		<tr id="editPass" style = "display:none">
			<td class = "blue">WLAN新密码</td>
			<td><input type="password" name="newPass" v_must="1"   id="newPass" value=""/> &nbsp;<font color="red">*<font></td>
			<td class = "blue">确认密码</td>
			<td><input type="password" name="cfmPass" v_must="1" id="cfmPass"  value=""/> &nbsp;<font color="red">*<font></td>
		</tr>
		</table>
		
		<table  cellSpacing=0>
				<tbody>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="doConfBtn()"   id="doconf" >&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="重置" onclick="javascript:window.location.href='/npage/si281/fi281Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
				</tbody>
			</table>
			<!--流水号 -->
			<input type="hidden" name="printAccept" value="">
			<!-- 操作代码 -->
			<input type="hidden" id="opCode" name="opCode" value="">
			<!-- 操作名称 -->
			<input type="hidden" id="opName" name="opName" value="">
			
			
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>