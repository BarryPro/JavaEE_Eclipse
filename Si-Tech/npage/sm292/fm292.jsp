<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
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
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQryAccept(){
			
			
			var phoneNo = "";
			var opAccept = $.trim($("#opAccept").val());
			var iccid = "";
			
			if(opAccept.length == 0 ){
				rdShowMessageDialog("业务流水不能为空！",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm292Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iOpName","<%=opName%>");
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("opAccept",opAccept);
			getdataPacket.data.add("iccid",iccid);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegionAcc);
			getdataPacket = null;
			
			
		}
		
		function doRetRegionAcc(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
		if(retCode == "000000" ){
			
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#appendBody3").empty();				
				
				
				var appendTh = 
					"<tr>"

					+"<th width='10%'>客户名称</th>"
					+"<th width='10%'>客户手机号码</th>"
					+"<th width='17%'>证件号码</th>"
					+"<th width='17%'>操作工号</th>"
					+"<th width='17%'>操作时间</th>"

					
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
					
					
					
					var opLoginNo = infoArray[i][0];
					var opTime = infoArray[i][1];
					var opAccept = infoArray[i][2];
					var opCustName = infoArray[i][3];
					var opPhoneNo = infoArray[i][4];
					var oIdNo = infoArray[i][5];
					
					
					
					var appendStr = "<tr>";
						
					appendStr += ""
											+""
											+"<td width='10%' align='center' id='opCustName'>"+opCustName+"</td>"
											+"<td width='5%' align='center' id='opPhoneNo'>"+opPhoneNo+"</td>"
											+"<td width='10%' align='center' id='oIdNo'>"+oIdNo+"</td>"
											+"<td width='10%' align='center' id='opLoginNo'>"+opLoginNo+"</td>"
											+"<td width='10%' align='center' id='opTime'>"+opTime+"</td>"
											+""
										
					appendStr +="</tr>";	
					
					$("#appendBody").append(appendStr);
					
					$("#configBtn").attr("disabled","");
					
	  document.f1.qryUnitBtn.disabled=true;
	
		$("input[name='opAccept']").attr("class","InputGrey");
		$("input[name='opAccept']").attr("readonly","readonly");
		
				}
				
				
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#appendBody3").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		

		/*2015/02/11 9:42:59 gaopeng 提交操作*/
		function nextStep(){
		
				if(rdShowConfirmDialog('确认要提交信息吗？')==1){
					
				document.f1.configBtn.disabled=true;
	     
				document.f1.action = "fm292Cfm.jsp";
   			document.f1.submit();
	
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
	  		<td width="8%" class="blue">业务流水</td>
	  		<td width="35%">
	  			<input type="text" id="opAccept" name="opAccept"   value="" maxlength="14" /><font color="red">*</font>&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="doQryAccept();"/>
	  		</td>

	    </tr>
	  </table>
	 </div>
	 
	 <!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">有价卡操作信息查询结果</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确定" disabled="disabled"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.href='/npage/sm292/fm292.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>		
		</table>
	
	</div>
		 
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
  <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>


</html>
