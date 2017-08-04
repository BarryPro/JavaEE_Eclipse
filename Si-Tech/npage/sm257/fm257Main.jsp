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
			var iccid = $.trim($("#iccid").val());
			
			if(opAccept.length == 0 && iccid.length == 0){
				rdShowMessageDialog("业务流水和证件号码至少输入一项！",1);
				return false;
			}
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm257/fm257QryAccept.jsp","正在获得数据，请稍候......");
			
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
				$("#resultContent3").hide();
				$("#appendBody").empty();
				$("#appendBody3").empty();
				
				
				var appendTh = 
					"<tr>"
					+"<th width='5%'>选择</th>"
					+"<th width='17%'>操作流水</th>"
					+"<th width='10%'>客户名称</th>"
					+"<th width='10%'>客户手机号码</th>"
					+"<th width='17%'>证件号码</th>"
					+"<th width='17%'>操作工号</th>"
					+"<th width='17%'>操作时间</th>"
					+"<th width='10%'>邮费</th>"
					
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
						
					appendStr += "<td width='5%' align='center' id='selectRadio'><input type='radio' name='selectRadios' phoneNoM = '"+opPhoneNo+"' value='"+opAccept+"' onclick='doQry(this);'/></td>"
											+"<td width='10%' align='center' id='opAccept'>"+opAccept+"</td>"
											+"<td width='10%' align='center' id='opCustName'>"+opCustName+"</td>"
											+"<td width='5%' align='center' id='opPhoneNo'>"+opPhoneNo+"</td>"
											+"<td width='10%' align='center' id='oIdNo'>"+oIdNo+"</td>"
											+"<td width='10%' align='center' id='opLoginNo'>"+opLoginNo+"</td>"
											+"<td width='10%' align='center' id='opTime'>"+opTime+"</td>"
											+"<td width='10%' align='center' id='postFee'>"+"<input type='text' id='"+opAccept+"_postFee' name='postFee' v_type='money' value='' onblur='checkElement(this);'/>"+"</td>"
										
					appendStr +="</tr>";	
					
					$("#appendBody").append(appendStr);
					
					$("#configBtn").attr("disabled","");
				}
				
				
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent").hide();
				$("#appendBody").empty();
				$("#resultContent3").hide();
				$("#appendBody3").empty();
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
			var getdataPacket = new AJAXPacket("/npage/sm257/fm257Qry.jsp","正在获得数据，请稍候......");
			
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
			
		if(retCode == "000000" && infoArray.length > 0){
			
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
					
					
					var newCardMoney = 
					"		<select id='singlePrice' name='singlePrice' >"
					+"     	<option value='10.00'>10.00</option>"
					+"     	<option value='20.00'>20.00</option>"
					+"     	<option value='30.00'>30.00</option>"
					+"     	<option value='50.00'>50.00</option>"
					+"     	<option value='100.00'>100.00</option>"
					+"     	<option value='200.00'>200.00</option>"
					+"     	<option value='300.00'>300.00</option>"
					+"     	<option value='500.00'>500.00</option>"
					+"    </select>";
					
					var oldCardNoStart = infoArray[i][0];
					var oldCardNoEnd = infoArray[i][1];
					var newCardNoStart = infoArray[i][2];
					var newCardNoEnd = infoArray[i][3];
					var isgua = infoArray[i][4];//0 否 1 是
					var isguaText = isgua==0?"否":"是";
					
					var custName = infoArray[i][5];
					var phoneNo = infoArray[i][6];
					var iccid = infoArray[i][7];
					var ispost = infoArray[i][8];//是否邮寄 0 否 1 邮寄中 2 已邮寄
					var ispostText = ispost==0?"否":"是";
					var callNo = infoArray[i][9];//投诉单号
					var cardMoney = infoArray[i][10];//卡面值
					
					var opAccept = infoArray[i][11];//卡面值
					
					
					var appendStr = "<tr>";
						
					appendStr += "<td width='25%' align='center' id='oldCardNoStart'>"+"<input type='text'  name='oldCardNoStart' value='"+oldCardNoStart+"' class='InputGrey' readonly/>"+"</td>"
											+"<td width='25%' align='center' id='cardMoney'>"+cardMoney+"</td>"
											+"<td width='25%' align='center' id='newCardNo'>"+"<input type='text'  name='newCardNo' v_type='0_9' maxlength='17' v_must = '0' onblur='checkElement(this);' value=''/>"+"&nbsp;&nbsp;</td>"
											+"<td width='25%' align='center' id='newCardMoney'>"+newCardMoney+"</td>"
					appendStr +="</tr>";	
					
					$("#appendBody3").append(appendStr);
					
					$("#configBtn").attr("disabled","");
					
				}
				
				
			}else{
				$("#configBtn").attr("disabled","disabled");
				$("#resultContent3").hide();
				$("#appendBody3").empty();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
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
		 
			opr_info += "办理业务：千元以上外省充值卡，我省收卡邮寄"+"|";
			opr_info += "操作流水：<%=loginAccept%>       "+"|";
			
			
			
			$("#appendBody3 tr:gt(0)").each(function(){
					var temp_iNewCardNoStart = $(this).find("td:eq(2)").find("input").val().trim();
					var temp_iNewMoney       = $(this).find("td:eq(3)").find("select").find("option:selected").val().trim();
					if($.trim(temp_iNewCardNoStart).length != 0){
					opr_info += "新充值卡号："+temp_iNewCardNoStart+"        新充值卡面值："+temp_iNewMoney+"元"+"|";
					}	
			});
			
			
			note_info1 += "备注：客户将充值卡交于黑龙江移动，由黑龙江移动将充值卡载明的相关信息反馈至发卡公司，并由发卡公司向黑龙江公司反馈充值卡是否经过充值。"+"|";
			note_info1 += "其中，对于未经过充值的，发卡公司将上述金额充值卡的等值金额充值卡至黑龙江公司。"+"|";
			
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		 	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
		 	
		  return retInfo;
		  
		}
		
		
	
		/*2015/02/11 9:42:59 gaopeng 提交操作*/
		function nextStep(){
			
				var postFlag = true;
				
				var postFee = $.trim($("#"+globeAccept+"_postFee").val());
				var postFeeObj = $("#"+globeAccept+"_postFee")[0];
				
				if(postFee.length == 0){
					rdShowMessageDialog("请输入邮费!",1);
					postFlag = false;
					return false;
				}
				if(!checkElement(postFeeObj)){
					postFlag = false;
					return false;
				}
			
				/*按照,分割的新卡卡号*/
				var oldCardNoStr = "";
				var newCardNoStr = "";
				var newCardPriceStr = "";
				/*离散卡号*/
				$("input[name='newCardNo']").each(function(){
					var newCardObj = $(this)[0];
					var newCardNo = $.trim($(this).val());
					if(!checkElement(newCardObj)){
							postFlag = false;
							return false;
					}
					if(newCardNo.length != 0){
						if(newCardNo.length != 17){
							rdShowMessageDialog("新卡号必须为17位!",1);
							postFlag = false;
							return false;
						}
					}
					if(newCardNo.length == 0){
						newCardNo = "0";
					}
					
					if($.trim(newCardNoStr).length == 0){
						newCardNoStr = newCardNo;
					}else{
						newCardNoStr += ","+newCardNo;
					}
				});
				
				/*面值*/
				$("select[name='singlePrice']").each(function(){
					
					if($.trim(newCardPriceStr).length == 0){
						newCardPriceStr = $.trim($(this).find("option:selected").val());
					}else{
						newCardPriceStr += ","+$.trim($(this).find("option:selected").val());
					}
				});
				
				
				
				$("input[name='oldCardNoStart']").each(function(){
					
					if($.trim(oldCardNoStr).length == 0){
						oldCardNoStr = $.trim($(this).val());
					}else{
						oldCardNoStr += ","+$.trim($(this).val());
					}
				});
				
				if(postFlag){
					showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
        			
					if(rdShowConfirmDialog('确认要提交信息吗？')==1){
							/*ajax start*/
						var getdataPacket = new AJAXPacket("/npage/sm257/fm257Cfm.jsp","正在获得数据，请稍候......");
						
						var iLoginAccept = globeAccept;
						var iChnSource = "01";
						var iOpCode = "<%=opCode%>";
						var iLoginNo = "<%=loginNo%>";
						var iLoginPwd = "<%=noPass%>";
						var iPhoneNo = globePhoneNo;
						var iUserPwd = "";
						
						
						getdataPacket.data.add("iLoginAccept",iLoginAccept);
						getdataPacket.data.add("iChnSource",iChnSource);
						getdataPacket.data.add("iOpCode",iOpCode);
						getdataPacket.data.add("iLoginNo",iLoginNo);
						getdataPacket.data.add("iLoginPwd",iLoginPwd);
						getdataPacket.data.add("iPhoneNo",iPhoneNo);
						getdataPacket.data.add("iUserPwd",iUserPwd);
						
						getdataPacket.data.add("postFee",postFee);
						
						getdataPacket.data.add("oldCardNoStr",oldCardNoStr);
						getdataPacket.data.add("newCardNoStr",newCardNoStr);
						getdataPacket.data.add("newCardPriceStr",newCardPriceStr);
						
						
						core.ajax.sendPacket(getdataPacket,doRetCfm);
						getdataPacket = null;
				}
			}
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			
			if(retCode == "000000"){
				
				rdShowMessageDialog("操作成功!",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				window.location.reload();
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
	  		<td width="20%" class="blue">业务流水</td>
	  		<td width="30%">
	  			<input type="text" id="opAccept" name="opAccept" v_type="0_9"  value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="doQryAccept();"/>
	  		</td>
	  		<td width="20%" class="blue">证件号码</td>
	  		<td width="30%">
	  			<input type="text" id="iccid"  name="iccid"    value="" />
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
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确定&打印" disabled="disabled"  onclick="nextStep();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.href='/npage/sm257/fm257Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">&nbsp;&nbsp;
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
