<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2016/5/30 14:25:14 转售业务查询
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
		

	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
		
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select t.code_id,t.code_name from pd_unicodedef_dict T where code_class =:code_class order by t.code_id";
    inParamsMail[1] = "code_class="+"ZS002";
	 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script src="/npage/public/json2.js" type="text/javascript"></script>
	<script src="/npage/sm380/fm380Obj.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		function doQry(){
			
			
			var phoneNo = $.trim($("#phoneNo").val());
			if(phoneNo.length == 0){
				rdShowMessageDialog("请输入手机号码！");
				return false;
			}
		
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm380/fm384Qry.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
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
				$("#phoneNo").attr("readonly","readonly");
				$("#phoneNo").attr("class","InputGrey");
				
				var tefStr = infoArray[0][9]+"";
				$("#oldTefStr").val(tefStr);
				var tefArray = tefStr.split(";");
				//alert(tefArray);
				for(var i=0;i<tefArray.length;i++){
					
					$("input[name='tef']").each(function(){
						var thisVal = $(this).val();
						//alert(thisVal+"="+tefArray[i]);
						if(thisVal == tefArray[i]){
							$(this).attr("checked","checked");
							
						}
					});
				}
				
				
				var appendTh = 
					"<tr>"
					+"<th width='11%'>归属地市</th>"
					+"<th width='11%'>员工编号</th>"
					+"<th width='11%'>证件类型</th>"
					+"<th width='11%'>证件号码</th>"
					+"<th width='11%'>客户姓名</th>"
					+"<th width='11%'>客户地址</th>"
					+"<th width='11%'>开户时间</th>"
					+"<th width='11%'>操作工号</th>"
					+"<th width='12%'>操作营业厅</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
					
					var appendStr = "<tr>";
					
					appendStr += "<td width='11%' align='center' id='cardType'>"+infoArray[i][0]+"</td>"
											+"<td width='11%' align='center' id='cardPrice'>"+infoArray[i][1]+"</td>"
											+"<td width='11%' align='center' id='cardDiscount'>"+infoArray[i][2]+"</td>"
											+"<td width='11%' align='center' id='cardRealPrice'>"+infoArray[i][3]+"</td>"
											+"<td width='11%' align='center' id='cardSum'>"+infoArray[i][4]+"</td>"
											+"<td width='11%' align='center' id='cardRealMoney'>"+infoArray[i][5]+"</td>"
											+"<td width='11%' align='center' id='cardValid'>"+infoArray[i][6]+"</td>"
											+"<td width='11%' align='center' id='cardValid'>"+infoArray[i][7]+"</td>"
											+"<td width='12%' align='center' id='cardValid'>"+infoArray[i][8]+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		/*2016/5/27 14:44:26 gaopeng 提交操作*/
		function nextStep(){
			
			if(!check(f1)){
				return false;
			}
			
			var newtfStr = "";
			$("input[name='tef'][checked]").each(function(){
				var thisval = $(this).val();
				if(newtfStr.length == 0){
					newtfStr = thisval;
				}else{
					newtfStr += ";"+thisval;
				}
			});
			
			if(newtfStr.length == 0){
				rdShowMessageDialog("请选择特服信息！");
				return false;
			}
			
			var oldTefStr = $("#oldTefStr").val();
			
			/* 审批公文编号 
			var spgwNum = $.trim($("#spgwNum").val());
			var accountNum = $.trim($("#accountNum").val());
			var idTypeSelect = $.trim($("#idTypeSelect").find("option:selected").val().split("|")[0]);
			var custName = $.trim($("#custName").val());
			var idIccid = $.trim($("#idIccid").val());
			var idAddr = $.trim($("#idAddr").val());
			var contactPhone = $.trim($("#contactPhone").val());
			var simCode = $.trim($("#simCode").val());
			*/
			var phoneNo = $.trim($("#phoneNo").val());
			
			
			var paramBelong		= new	param();
			
			paramBelong.setAPPROVAL_ID("");	
			paramBelong.setLOGIN_NO("");
			paramBelong.setID_TYPE("");
			paramBelong.setID_NUM("");
			paramBelong.setCUST_NAME("");
			paramBelong.setCUST_ADDR("");
			paramBelong.setPHONE_NO("");
			paramBelong.setSIM_NO("");
			
			/*拼json串*/
			
			var myJSONText = JSON.stringify(paramBelong,function(key,value){
				return value;
			});
			
			//alert(myJSONText);
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm380/fm380Cfm.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("ioprtype","1003");
			getdataPacket.data.add("vOldParam",oldTefStr);
			getdataPacket.data.add("vNewParam",newtfStr);
			getdataPacket.data.add("custinfostr",myJSONText);
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("特服变更成功！",2);
				removeCurrentTab();
			}else{
				
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				removeCurrentTab();
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
	  		<td width="20%" class="blue">手机号码</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="doQry();"/>
	  		</td>
	  		
	    </tr>
	  </table>
	 <div>
	 	
	
	 <!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">转售信息查询结果</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		 <div class="title">
			<div id="title_zi">特服信息</div>
		</div>
		<table>
	    <tr>
	  		<td>
	  			<%
	  				if(result_mail.length > 0 && "000000".equals(retCode_mail)){
	  					for(int i=0;i<result_mail.length;i++){
	  							if(i != 0 && i%6==0){
	  								%>
	  							  
	  								<%
	  							}
	  						%>
	  							<input type="checkbox" name="tef" value="<%=result_mail[i][0]%>"/><%=result_mail[i][1]%> &nbsp;
	  						<%
	  					}
	  				}
	  			%>
	  		</td>
	    </tr>
	  </table>
	  <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="cfmBtn" name="cfmBtn"  type="button" value="确认"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
			</tr>
		</table>
	</div>
	
	
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	<input type="hidden" name="oldTefStr" id="oldTefStr" value=""/>
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
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
