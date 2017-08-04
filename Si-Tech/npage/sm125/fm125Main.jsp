<%
  /*
   * 功能:关于在CRM系统中开发电商线上订单查询页面和增加客户下行通知短信的需求
   * 版本: 1.0
   * 日期: 2014/07/11 15:18:07
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
		
		function doQry(){
			
			
			var phoneNo = $.trim($("input[name='phoneNo']").val());
			if(phoneNo.length == 0){
				rdShowMessageDialog("请输入手机号码！",1);
				return false;
			}
			
				/*ajax start*/
				
				/* 2014/07/11 15:18:56 gaopeng 调用蒋磊查询服务
					sM125Qry
				 *@input parameter information
				 *@        iLoginAccept		操作流水
				 *@        iChnSource		渠道标识
				 *@        iOpCode			操作代码
				 *@        iLoginNo    		操作工号
				 *@        iLoginPwd    	工号密码
				 *@        iPhoneNo     	手机号码
				 *@        iUserPwd     	号码密码
				 *@        iOpNote     		操作备注
				 
				 出参：
				 手机号码
				 订单生成时间
				 订单类型（号卡）
				 订单当前状态（未处理/已处理待下单/已下单）
				 用户归属地市(即地市名称)
				 邮寄地址
				 联系人姓名
				 联系电话
				 物流单号
					transOUT = Add_Ret_Value(GPARM32_0,iPhoneNo);
		    	transOUT = Add_Ret_Value(GPARM32_1,vOrder_time);
		    	transOUT = Add_Ret_Value(GPARM32_2,vOrder_type);
		    	transOUT = Add_Ret_Value(GPARM32_3,vOrder_static);
		    	transOUT = Add_Ret_Value(GPARM32_4,vRegionName);
		    	transOUT = Add_Ret_Value(GPARM32_5,vMail_address);
		    	transOUT = Add_Ret_Value(GPARM32_6,vMail_person);
		    	transOUT = Add_Ret_Value(GPARM32_7,vMail_phone);
		    	transOUT = Add_Ret_Value(GPARM32_8,vStream_no);

				*/
			var getdataPacket = new AJAXPacket("/npage/sm125/fm125Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			var iOpNote = iLoginNo+"进行["+iOpCode+"]操作";
			
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iOpNote",iOpNote);
		
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");

		if(retCode == "000000"){
			
			
				$("#resultContent").show();
				$("#appendBody").empty();
				/*
				 手机号码
				 订单生成时间
				 订单类型 （号卡）
				 订单当前状态 （未处理/已处理待下单/已下单）
				 用户归属地市 (即地市名称)
				 邮寄地址
				 联系人姓名
				 联系电话
				 物流单号
				*/
				var appendTh = 
					"<tr>"
					+"<th width='8%'>手机号码</th>"
					+"<th width='8%'>订单生成时间</th>"
					+"<th width='8%'>订单类型</th>"
					+"<th width='8%'>订单当前状态</th>"
					+"<th width='8%'>用户归属地市</th>"
					+"<th width='28%'>邮寄地址</th>"
					+"<th width='8%'>联系人姓名</th>"
					+"<th width='8%'>联系电话</th>"
					+"<th width='8%'>物流单号</th>"
					+"<th width='8%'>操作</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);
				
					
				
				
				for(var i=0;i<infoArray.length;i++){
					
					var phoneNo = infoArray[i][0];
					var billTime = infoArray[i][1];
					var billType = infoArray[i][2];
					var billState = infoArray[i][3];
					var userRegion = infoArray[i][4];
					var postAddr = infoArray[i][5];
					var constacName = infoArray[i][6];
					var constactPhone = infoArray[i][7];
					var billNo = infoArray[i][8];
					var btnState = "disabled";
					//if(billState.indexOf("受理成功") != -1){
					if(billState.indexOf("未处理") != -1){
						btnState = "";
					}
					
					var appendStr = "<tr>";
					appendStr += "<td width='8%'>"+phoneNo+"</td>"
											+"<td width='8%'>"+billTime+"</td>"
											+"<td width='8%'>"+billType+"</td>"
											+"<td width='8%'>"+billState+"</td>"
											+"<td width='8%'>"+userRegion+"</td>"
											+"<td width='28%'>"+"<input type='text' id='postAddr"+i+"' name='postAddr"+i+"' value='"+postAddr+"' style='width:95%' class='InputGrey' readonly='readonly'/>"+"</td>"
											+"<td width='8%'>"+"<input type='text' id='constacName"+i+"' name='constacName"+i+"' value='"+constacName+"' class='InputGrey' readonly='readonly' />"+"</td>"
											+"<td width='8%'>"+"<input type='text' id='constactPhone"+i+"' name='constactPhone"+i+"' value='"+constactPhone+"' class='InputGrey' readonly='readonly' />"+"</td>"
											+"<td width='8%'>"+billNo+"</td>"
											+"<td width='8%'>"+"<input type='button' class='b_text' id='editSome"+i+"' name='editSome"+i+"' onclick='editBtn("+i+","+phoneNo+")' value='修改' "+btnState+"/>"+"</td>"
					appendStr +="</tr>";	
					$("#appendBody").append(appendStr);
				}
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		/*修改方法*/
		function editBtn(num,phoneNo){
			var opFlag = $("#editSome"+num).val();
			/*如果是修改,则变更可修改,并将按钮变为确认*/
			if(opFlag == "修改"){
				
				$("#postAddr"+num).attr("readonly","");
				$("#postAddr"+num).attr("class","");
				$("#constacName"+num).attr("readonly","");
				$("#constacName"+num).attr("class","");
				$("#constactPhone"+num).attr("readonly","");
				$("#constactPhone"+num).attr("class","");
				/*按钮变为确认*/
				$("#editSome"+num).val("确认");
				
			}else if(opFlag == "确认"){
				if(rdShowConfirmDialog("请确认是否进行更改？")==1)
				{	
					/*调用服务进行修改*/
					var iPhoneNo = phoneNo;
					var iLoginAccept = "<%=loginAccept%>";
					var iChnSource = "01";
					var iOpCode = "<%=opCode%>";
					var iLoginNo = "<%=loginNo%>";
					var iLoginPwd = "<%=noPass%>";
					var iPhoneNo = phoneNo;
					var iUserPwd = "";
					var iOpNote = "工号"+iLoginNo+"进行"+iOpCode+"操作,修改信息";
					var postAddr = $("#postAddr"+num).val();
					var constacName = $("#constacName"+num).val();
					var constactPhone = $("#constactPhone"+num).val();
					
					var getdataPacket = new AJAXPacket("/npage/sm125/fm125Cfm.jsp","正在获得数据，请稍候......");
					
					getdataPacket.data.add("iLoginAccept",iLoginAccept);
					getdataPacket.data.add("iChnSource",iChnSource);
					getdataPacket.data.add("iOpCode",iOpCode);
					getdataPacket.data.add("iLoginNo",iLoginNo);
					getdataPacket.data.add("iLoginPwd",iLoginPwd);
					getdataPacket.data.add("iPhoneNo",iPhoneNo);
					getdataPacket.data.add("iUserPwd",iUserPwd);
					getdataPacket.data.add("iOpNote",iOpNote);
					getdataPacket.data.add("postAddr",postAddr);
					getdataPacket.data.add("constacName",constacName);
					getdataPacket.data.add("constactPhone",constactPhone);
				
					core.ajax.sendPacket(getdataPacket,doRetCfm);
					getdataPacket = null;
					
					
					
				}else{
					/*全置灰不可改*/
					$("#postAddr"+num).attr("readonly","readonly");
					$("#postAddr"+num).attr("class","InputGrey");
					$("#constacName"+num).attr("readonly","readonly");
					$("#constacName"+num).attr("class","InputGrey");
					$("#constactPhone"+num).attr("readonly","readonly");
					$("#constactPhone"+num).attr("class","InputGrey");
					/*重新查询*/
					reQry(iPhoneNo);
				}
		}
	}
	/*修改服务回调函数*/
	function doRetCfm(packet){
		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var iPhoneNo = packet.data.findValueByName("iPhoneNo");
		
		if(retCode == "000000"){
			rdShowMessageDialog("修改成功！",2);
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		}
		reQry(iPhoneNo);
		
	}
	
	/*重新查询页面方法*/
	function reQry(phoneNo){
		$("input[name='phoneNo']").val(phoneNo);
		doQry();
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
	  		<td width=16% class="blue">手机号码</td>
	  		<td width=84% colspan="3">
	  			<input type="text" name="phoneNo"  value=""/>&nbsp;<font color="red">*</font>
	  		</td>
	    </tr>
	    <tr>
	    	<td colspan="4">
	    		<font color="red">注：此界面只展示集团18元套卡的相关信息。</font>
	    	</td>
	    </tr>
	    <tr> 
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">
				<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
				
			</td>
		</tr>
		</table>
	</div>
	<!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">查询结果列表</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel2;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
