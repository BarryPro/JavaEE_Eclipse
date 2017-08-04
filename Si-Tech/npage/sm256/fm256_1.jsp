<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015/3/30 9:37:17-------------------
增“外省有价卡换卡”功能。
查询条件：证件号码/业务流水

先根据证件号码进行查询，查询出对应的操作记录，确定一个操作流水，点击操作流水后在去查询对应的卡号

 -------------------------后台人员：jingang--------------------------------------------
 
********************/
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
    String loginNo    = (String)session.getAttribute("workNo");
 		String noPass     = (String)session.getAttribute("password");
 		String groupID    = (String)session.getAttribute("groupId");
 		
 		String opCode     = (String)request.getParameter("opCode");
		String opName     = (String)request.getParameter("opName");
		String phoneNo    = (String)request.getParameter("activePhone");
%>

  	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
		
		function doQryAccept(){
			
			
			var phoneNo = "";
			var opAccept = $.trim($("#opAccept").val());
			var iccid = $.trim($("#iccid").val());
			
			if(opAccept.length == 0 && iccid.length == 0){
				rdShowMessageDialog("业务流水和证件号码至少输入一项！",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm256_2.jsp","正在获得数据，请稍候......");
			
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
			
			if(infoArray.length > 0){
				$("#resultContent").show();
				$("#appendBody").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='5%'>选择</th>"
					+"<th width='10%'>操作流水</th>"
					+"<th width='15%'>客户名称</th>"
					+"<th width='15%'>客户手机号码</th>"
					+"<th width='22%'>证件号码</th>"
					+"<th width='10%'>操作工号</th>"
					+"<th >操作时间</th>"
					
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
					
					
					
					var opLoginNo = infoArray[i][0];
					var opTime = infoArray[i][1];
					var opAccept = infoArray[i][2];
					var opCustName = infoArray[i][3];
					var opPhoneNo = infoArray[i][4];
					
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td align='center'  ><input type='radio' name='selectRadios' phoneNoM = '"+opPhoneNo+"' value='"+opAccept+"' onclick='doQry(this);'/></td>"
											+"<td align='center'  >"+opAccept+"</td>"
											+"<td align='center'  >"+opCustName+"</td>"
											+"<td align='center'  >"+opPhoneNo+"</td>"
											+"<td align='center'  >"+infoArray[i][5]+"</td>"
											+"<td align='center'  >"+opLoginNo+"</td>"
											+"<td align='center'  >"+opTime+"</td>"
										
					appendStr +="</tr>";	
					
					$("#appendBody").append(appendStr);
					
					$("#configBtn").attr("disabled","");
				}
				
				}else{
					$("#configBtn").attr("disabled","disabled");
					$("#resultContent").hide();
					$("#appendBody").empty();
					rdShowMessageDialog("查询结果为空",1);
				}
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent").hide();
				$("#appendBody").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		
		var globeAccept = "";
		var globePhoneNo = "";
		function doQry(obj){
			
			/*全局变量操作流水*/
			globeAccept = obj.value;
			globePhoneNo = obj.phoneNoM;
			
			var phoneNo = "";
			var opAccept = $.trim(obj.value);
			
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("fm256_3.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("iccid","");
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
		if(retCode == "000000" ){
			if(infoArray.length > 0){
			
				$("#resultContent3").show();
				$("#appendBody3").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='25%'>旧卡号</th>"
					+"<th width='25%'>旧卡面值</th>"
					+"<th width='25%'>新卡号</th>"
					+"<th width='25%'>新卡面值</th>"
					+"</tr>";
				$("#appendBody3").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
				 
					var oldCardNoStart = infoArray[i][0];
					var oldCardNoEnd = infoArray[i][1];
					var newCardNoStart = infoArray[i][2];
					var newCardNoEnd = infoArray[i][3];
					var isgua = infoArray[i][4];//0 否 1 是
					var isguaText = isgua==0?"否":"是";
					
					var custName = infoArray[i][5];
					var phoneNo = infoArray[i][6];
					var iccid = infoArray[i][7];
					var cardMoney = infoArray[i][10];//卡面值
					
					var opAccept = infoArray[i][11];//卡面值
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td align='center' >"+oldCardNoStart+"</td>"
										  +"<td align='center' >"+cardMoney+"</td>"
											+"<td align='center' >"+"<input type='text'  name='newCardNo' maxlength='17' onblur='get_NewCardMoney(this);' value=''  />"+"</td>"
											+"<td align='center' ></td>"
					appendStr +="</tr>";	
					
					$("#appendBody3").append(appendStr);
					$("#configBtn").attr("disabled","");
					
				}
				
				}else{	
					$("#configBtn").attr("disabled","disabled");
					$("#resultContent3").hide();
					$("#appendBody3").empty();
					rdShowMessageDialog("查询结果为空",1);
				}
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent3").hide();
				$("#appendBody3").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
//校验入参是否为数字
function fucCheckNUM(val){
	var reg = /^\d{17}$/;
	return reg.test(val);
}
	
var trObj = null;
//获取新卡号的面值
function get_NewCardMoney(bt){
	var card_no = $(bt).val();
	if(card_no=="") return;
	
	if(!fucCheckNUM(card_no)){
		rdShowMessageDialog("卡号必须为17位数字");
		return;
	} 
	
	var i_num = 0;
	$("#appendBody3 tr:gt(0)").each(function(){
		if(card_no==$(this).find("td:eq(0)").text().trim()){
			i_num ++;
		}
		if(card_no==$(this).find("td:eq(2)").find("input").val()){
			i_num ++ ;
		}
	});
	if(i_num > 1){//一次是自己，超过一次肯定存在重复的卡号
		rdShowMessageDialog("重复的卡号");
		$(bt).val("");
		return;
	}
	
	trObj = $(bt).parent().parent();
	var packet = new AJAXPacket("fm256_5.jsp","请稍后...");
      packet.data.add("iNewCard",$(bt).val());//
    core.ajax.sendPacket(packet,doGet_NewCardMoney);
    packet =null;	
}
function doGet_NewCardMoney(packet){
	var NewCardMoney = packet.data.findValueByName("NewCardMoney");//新卡号对应的面值
	if(NewCardMoney == ""){
		rdShowMessageDialog("未查到该卡号的面值");
		trObj.find("td:eq(2)").find("input").val("");
	}else{
		trObj.find("td:eq(2)").find("input").attr("disabled","disabled");
		trObj.find("td:eq(3)").text(NewCardMoney);
		trObj = null;
	}
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	var pType="print";                     // 打印类型print 打印 subprint 合并打印
	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
	var sysAccept ="<%=loginAccept%>";       // 流水号
	var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
	var mode_code=null;                    //资费代码
	var fav_code=null;                     //特服代码
	var area_code=null;                    //小区代码
	var opCode =   "<%=opCode%>";          //操作代码
	var phoneNo = "";                      //客户电话
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
}

function printInfo(printType)
{
         		
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var retInfo = "";  //打印内容
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4

	var idno = "";
	var ocontact_phone = "";
	var ocontact_name = "";
	//获取证件号码
	$("#appendBody tr:gt(0)").each(function(){
		if($(this).find("input[type='radio']").attr("checked")==true){
			idno           = $(this).find("td:eq(4)").text().trim();
			ocontact_phone = $(this).find("td:eq(3)").text().trim();
			ocontact_name  = $(this).find("td:eq(2)").text().trim();
		}
	});
	
  cust_info+="手机号码：   "+ocontact_phone+"|";
  cust_info+="客户姓名：   "+ocontact_name+"|";
  cust_info+="证件号码：   "+idno+"|";
 
	opr_info += "办理业务：外省卡现场换卡变更（千元以下）"+"|";
	opr_info += "操作流水：<%=loginAccept%>       充值卡换卡费：0元"+"|";
	
	$("#appendBody3 tr:gt(0)").each(function(){
			var temp_iOldCardNoStart = $(this).find("td:eq(0)").text().trim();
			var temp_iOldMoney       = $(this).find("td:eq(1)").text().trim();
			
			opr_info += "原充值卡号："+temp_iOldCardNoStart+"        原充值卡面值："+temp_iOldMoney+"元"+"|";
			
	});
	
	$("#appendBody3 tr:gt(0)").each(function(){
			var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
			var temp_iNewMoney       = $(this).find("td:eq(3)").text().trim();
			if(temp_iNewCardNoStart!=""){
				opr_info += "新充值卡号："+temp_iNewCardNoStart+"        新充值卡面值："+temp_iNewMoney+"元"+"|";
			}
			
	});
	
	
	note_info1 += "备注：原充值卡返还给营业人员处理。"+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
 	
  return retInfo;
  
}

//页面提交
function goSubmit(){
	
	var iOldCardNoStart = new Array();//旧卡开始
	var iNewCardNoStart = new Array();//新卡开始
	
	var iOldMoney       = new Array();//旧卡面值
	var iNewMoney       = new Array();//新卡面值
	
	var iNewMoneySum    = 0;
	$("#appendBody3 tr:gt(0)").each(function(){
			
			var temp_iOldCardNoStart = $(this).find("td:eq(0)").text().trim();
			var temp_iOldMoney       = $(this).find("td:eq(1)").text().trim();
			var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
			var temp_iNewMoney       = $(this).find("td:eq(3)").text().trim();
			
			iNewMoneySum = parseInt(temp_iNewMoney) + iNewMoneySum;
			//校验通过压入数组
			iOldCardNoStart.push(temp_iOldCardNoStart);
			if(temp_iNewCardNoStart!=""){
				iNewCardNoStart.push(temp_iNewCardNoStart);
			}
			iOldMoney.push(temp_iOldMoney);
			if(temp_iNewMoney!=""){
				iNewMoney.push(temp_iNewMoney);
			}
		
	});
	
	if(iNewMoneySum>999){
		rdShowMessageDialog("新卡面值总额不能超过1000元");
		return;
	}
	//alert("iNewCardNoStart.length = "+iNewCardNoStart.length+"\niOldCardNoStart = "+iOldCardNoStart+"\niNewCardNoStart = "+iNewCardNoStart+"\niOldMoney="+iOldMoney+"\niNewMoney="+iNewMoney);
	if(iNewCardNoStart.length==0){
		rdShowMessageDialog("没有新卡");
		return;
	}
	var idno = "";
	//获取证件号码
	$("#appendBody tr:gt(0)").each(function(){
		if($(this).find("input[type='radio']").attr("checked")==true){
			idno = $(this).find("td:eq(4)").text().trim()
		}
	});
		
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
        			
		if(rdShowConfirmDialog('确认要提交信息吗？')==1){
			var packet = new AJAXPacket("fm256_4.jsp","请稍后...");
			    packet.data.add("opCode","<%=opCode%>");//opcode
			    packet.data.add("idno",idno);//
			    packet.data.add("iOldCardNoStart",iOldCardNoStart+"");//
			    packet.data.add("iOldCardNoEnd","");//
			    packet.data.add("iNewCardNoStart",iNewCardNoStart+"");//
			    packet.data.add("iNewCardNoEnd","");//
			    packet.data.add("iOpNote","操作员<%=loginNo%>为客户"+$("#ocontact_name").text()+"进行<%=opName%>");//
			    packet.data.add("icardnumber",$("#ocard_money").text());//
			    packet.data.add("iOldMoney",iOldMoney+"");//
			    packet.data.add("iNewMoney",iNewMoney+"");//
			    core.ajax.sendPacket(packet,doSubmit);
			    packet =null;
	}
}


function doSubmit(packet){
			var error_code = packet.data.findValueByName("code");//返回代码
    	var error_msg  = packet.data.findValueByName("msg");//返回信息

    	if(error_code=="000000"){//操作失成功
    		rdShowMessageDialog("换卡成功",2);
    		removeCurrentTab();
    	}else{
    		rdShowMessageDialog("换卡失败"+error_code+"："+error_msg,0);
    	}
}

	function resetThispage(){
		location = location;
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
	  		<td width="20%" class="blue">业务流水</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept" name="opAccept" v_type="0_9"  value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="doQryAccept();"/>
	  		</td>
	  		<td width="20%" class="blue">证件号码</td>
	  		<td width="30%">
	  			<input type="text" id="iccid"  name="iccid"  value="" />
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
	
	<div id="resultContent3" style="display:none">
		<div class="title">
			<div id="title_zi">有价卡信息查询结果</div>
		</div>
		<table id="exportExcel3" name="exportExcel3">
			<tbody id="appendBody3">
				
			
			</tbody>
		</table>
	</div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="提交" disabled="disabled"  onclick="goSubmit();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="resetThispage();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
		
		</table>
		<!-- 确认结果列表 -->
	<div id="resultContent2" style="display:none">
		<div class="title">
			<div id="title_zi">流量卡购买结果&nbsp;&nbsp;&nbsp;&nbsp;<font class="orange" id="appendResultCon"></font></div>
		</div>
		<table id="exportExcel2" name="exportExcel2">
			<tbody id="appendBody2">
				
			
			</tbody>
		</table>
	</div>
	
	</div>
	
	 

	<%@ include file="/npage/include/footer.jsp" %>
</form>
 
</body>


</html>
