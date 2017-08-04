<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2015/07/28 R_CMI_HLJ_guanjg_2015_2350528@关于哈分公司为第二批社会渠道申请开通身份证扫描仪使用权限的请示
   * 作者: gejing
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
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
    	String iLoginNo = loginNo;
 		String iLoginPwd = noPass;
 		String iOpCode = opCode;
 		String iPhoneNo = phoneNo;
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		function findGroupById(){
			var iGroupId	= $("#groupId").val().trim();			//网点代码
			if(iGroupId == null || iGroupId == ''){
				rdShowMessageDialog("请填写网点代码！",1);
				return false;
			}else{
				var packet = new AJAXPacket("fm294Query.jsp","请稍后...");
				packet.data.add("iLoginAccept" ,"");//流水，不用填写，服务自动获取
				packet.data.add("iChnSource" ,"01");//渠道标识
				packet.data.add("iOpCode" ,"<%=iOpCode%>");//操作代码
				packet.data.add("iLoginNo" ,"<%=iLoginNo%>");//操作工号	
				packet.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//操作工号密码
				packet.data.add("iPhoneNo" ,"");//手机号码
				packet.data.add("iUserPwd" ,"");//用户密码
				packet.data.add("iOpNote","查询网点");
				packet.data.add("iGroupId" ,iGroupId);//网点代码
				core.ajax.sendPacket(packet,getGroup,true);//异步
				packet = null;
			}
			
		}
		
		function getGroup(packet){
			$("#append").remove();
			var vGroupName = packet.data.findValueByName("vGroupName");
			/* var funCodeStr = packet.data.findValueByName("funCodeStr"); */
			var iGroupId = packet.data.findValueByName("iGroupId");
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				if(vGroupName != null && vGroupName != ""){
					$("#tabTr").append("<tr id='append'>"+
														"<td>("+iGroupId+")"+vGroupName+
														"<input type='hidden' id='iGroupId' value='"+iGroupId+"'/>"+
														"</td>"+
														//"<td title='"+funCodeStr+"'>"+funCodeStr+"</td>"+
														"<td><input type='button' value='删除' class='b_text' onclick='deleteGroupFunc("+iGroupId+")'/></td>"
												+"</tr>");
				}else{
					rdShowMessageDialog("该网点没有配置！",1);
				}
			}else{
				rdShowMessageDialog(retMsg,1);
			}
		}
		
		function deleteGroupFunc(){
			var iGroupId	= $("#iGroupId").val();			//网点代码
			
			if(rdShowConfirmDialog('确认要删除信息吗？')==1){
				/*ajax start*/
				var getdataPacket = new AJAXPacket("fm294Submit.jsp","正在提交数据，请稍候......");
				getdataPacket.data.add("iLoginAccept" ,"");//流水，不用填写，服务自动获取
				getdataPacket.data.add("iChnSource" ,"01");//渠道标识
				getdataPacket.data.add("iOpCode" ,"<%=iOpCode%>");//操作代码
				getdataPacket.data.add("iLoginNo" ,"<%=iLoginNo%>");//操作工号	
				getdataPacket.data.add("iLoginPwd" ,"<%=iLoginPwd%>");//操作工号密码
				getdataPacket.data.add("iPhoneNo" ,"");//手机号码
				getdataPacket.data.add("iUserPwd" ,"");//用户密码
				getdataPacket.data.add("iOpNote","删除读卡器网点配置");//备注
				getdataPacket.data.add("iGroupId" ,iGroupId);//网点代码 必传
				
				core.ajax.sendPacket(getdataPacket,doSuccess,true);
				getdataPacket = null;
			}
			
		}
		
		function doSuccess(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("删除成功！",2);
				window.location.reload();
			} else{
				rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
			}
		}
	</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<div>
			<table>
				<tr>
					<td class="blue">网点代码</td>
					<td>
						<input type="text" id="groupId" value="" v_type=string onblur="findGroupById();"/>
					</td>
			    </tr>
		  	</table>
		 </div>
		 
		 <div>
			 <table>
			   <tr>
					<td align=center colspan="4" id="footer"></td>
				</tr>
			</table>
		</div>
		
		 <div>
		 	<table id="tabTr">
		 		<tr>
		 			<th>营业厅名称 </th>
		 			<!-- <th>功能代码(代码名称)</th> -->
		 			<th>操作</th>
		 		</tr>
		 	</table>
		 </div>
		 
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
