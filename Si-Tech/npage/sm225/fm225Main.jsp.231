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
		

	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
	
	 
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
			
			
			var phoneNo = "";
			var startCardNo = $.trim($("#startCardNo").val());
			var endCardNo = $.trim($("#endCardNo").val());
			
			if(startCardNo.length == 0 || endCardNo.length == 0){
				rdShowMessageDialog("请输入开始卡号和结束卡号！",1);
				return false;
			}
			if(startCardNo.length != endCardNo.length){
				rdShowMessageDialog("开始卡号和结束卡号长度必须相同！",1);
				return false;
			}
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm225/fm225CardQry.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("startCardNo",startCardNo);
			getdataPacket.data.add("endCardNo",endCardNo);
			
			
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
				
				var appendTh = 
					"<tr>"
					+"<th width='20%'>流量卡类型</th>"
					+"<th width='16%'>流量卡面值</th>"
					+"<th width='10%'>折扣</th>"
					+"<th width='16%'>折扣后实际单价</th>"
					+"<th width='10%'>购买数量</th>"
					+"<th width='10%'>总金额</th>"
					+"<th width='20%'>流量卡有效期</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
			
			
					/*流量卡数量*/
					var cardSum = infoArray[i][0];
					/*销售单价*/
					var cardPrice = infoArray[i][1];
					/*流量卡有效期*/
					var cardValid = infoArray[i][2];
					/*流量卡类型*/
					var cardType = infoArray[i][3];
					/*折扣下拉列表*/
					var cardDiscount = 
					"<select name='cardDiscount' onchange='chgDiscount();'>"

        	<%
        	if(operFlag==true) {
        	%>

					+"<option value='6' selected>6折</option>"
					+"<option value='7'>7折</option>"
					+"<option value='8'>8折</option>"
					+"<option value='9'>9折</option>"
					+"<option value='9.5'>9.5折</option>"
					+"<option value='10'>无折扣</option>"
					
					<%}else {%>

					+"<option value='9.5'>9.5折</option>"
					+"<option value='10'>无折扣</option>"						
						
					<%}%>							
					
					+"</select>";
					/*折扣后实际单价*/
					var cardRealPrice = "";
					/*折扣后金额*/
					var cardRealMoney = "";
			
					var appendStr = "<tr>";
					
					appendStr += "<td width='20%' align='center' id='cardType'>"+cardType+"</td>"
											+"<td width='16%' align='center' id='cardPrice'>"+cardPrice+"</td>"
											+"<td width='10%' align='center' id='cardDiscount'>"+cardDiscount+"</td>"
											+"<td width='16%' align='center' id='cardRealPrice'>"+cardRealPrice+"</td>"
											+"<td width='10%' align='center' id='cardSum'>"+cardSum+"</td>"
											+"<td width='10%' align='center' id='cardRealMoney'>"+cardRealMoney+"</td>"
											+"<td width='20%' align='center' id='cardValid'>"+cardValid+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				if(infoArray.length != 0){
					chgDiscount();
					//$("#export").attr("disabled","");
					$("#configBtn").attr("disabled","");
					/*置灰流量卡查询按钮*/
					$("#qryCardBtn").attr("disabled","disabled");
					
					$("#startCardNo").attr("readonly","readonly");
					$("#startCardNo").attr("class","InputGrey");
					$("#endCardNo").attr("readonly","readonly");
					$("#endCardNo").attr("class","InputGrey");
				}
				
			}else{
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		/*2015/02/11 10:09:10 gaopeng 流量卡折扣信息变更方法*/
		function chgDiscount(){
			
			var cardDiscount = $("select[name='cardDiscount']").find("option:selected").val();
			/*折扣后实际单价*/
			var cardRealPrice = parseFloat(parseFloat($("#cardPrice").html())*cardDiscount/10);
			
			/*折扣后金额*/
			var cardRealMoney = parseFloat(parseFloat($("#cardSum").html())*cardRealPrice);
			/*赋值新的折扣信息*/
			$("#cardRealPrice").html(cardRealPrice);
			$("#cardRealMoney").html(cardRealMoney);
			
		}
		
		/*叠加包信息 查询方法*/
		function showMsg(){
			
			if(!checkElement(document.all.unitCode)){
				return false;
			}
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			var unitCode = $("#unitCode").val()
			if(unitCode.length == 0){
				rdShowMessageDialog("请输入集团编码！",1);
				return false;
			}
			
			/*拼接入参*/
			var path = "/npage/sm225/fm225GrpQry.jsp";
		  path += "?iLoginAccept="+iLoginAccept;
		  path += "&iChnSource="+iChnSource;
		  path += "&iOpCode="+iOpCode;
		  path += "&iOpName=<%=opName%>";
		  path += "&iLoginNo="+iLoginNo;
		  path += "&iLoginPwd="+iLoginPwd;
		  path += "&iPhoneNo="+iPhoneNo;
		  path += "&iUserPwd=";
		  path += "&iUnitCode="+unitCode;
		  /*打开*/
		  //alert(path);
		  retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
			

		}
		
				function doCommit()
		{
		
		var myPacket = new AJAXPacket("fm225QryAccept.jsp", "正在查询新流水信息，请稍候......");
    core.ajax.sendPacket(myPacket,doShowName);
    myPacket = null;
		
				var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            		nextStep();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
								nextStep();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
								nextStep();
        }
      }
		
		}
		
		function doShowName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var iLoginAcceptnew = packet.data.findValueByName("iLoginAcceptnew");
  if(retCode!="000000"){
    rdShowMessageDialog("取流水出错，错误代码："+retCode+"<br>错误信息："+retMsg,0);
    return false;
  }else{			
			$("#iLoginAcceptnew").val(iLoginAcceptnew);
  }
}
		
		
		 function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =$("#iLoginAcceptnew").val();             	//流水号
        var printStr = printInfo(printType);
      
	 		                      //调用printinfo()返回的打印内容
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="<%=opCode%>" ;                   			 	//操作代码
      var phoneNo="<%=activePhone%>";                  //客户电话
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+$("#iLoginAcceptnew").val()+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
    
    	var cardDiscount = $("select[name='cardDiscount']").find("option:selected").val();
			/*折扣后实际单价*/
			var cardRealPrice = parseFloat(parseFloat($("#cardPrice").html())*cardDiscount/10);
			
			/*折扣后金额*/
			var cardRealMoney = parseFloat(parseFloat($("#cardSum").html())*cardRealPrice);
			
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
			cust_info += "客户姓名：   "+$("#oCustName").val()+"|";
			cust_info += "证件号码：   "+$("#oIccidNo").val()+"|";
			cust_info += "集团客户编码：   "+$("#oCustId").val()+"|";
      opr_info += "申请业务：   "+"<%=opName%>" +"|";
      opr_info += "操作流水：   "+$("#iLoginAcceptnew").val()+"|";
      //opr_info +="流量卡开始号码："+$.trim($("#startCardNo").val())+"     流量卡结束号码："+$.trim($("#endCardNo").val())+"|";
      opr_info +="流量卡开始号码："+$.trim($("#startCardNo").val())+"|";
      opr_info +="流量卡结束号码："+$.trim($("#endCardNo").val())+"|";
      opr_info +="流量卡数量："+$("#cardSum").html()+"     流量卡有效期："+$("#cardValid").html()+"|";     
      opr_info +="销售单价："+$("#cardPrice").html()+"     折扣："+cardDiscount+"     折扣后实际单价："+cardRealPrice+"|";
      opr_info +="折扣后总金额："+cardRealMoney+"|";
 
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    } 
		
		
		/*2015/02/11 9:42:59 gaopeng 提交操作*/
		function nextStep(){
			var phoneNo = "";
			var startCardNo = $.trim($("#startCardNo").val());
			var endCardNo = $.trim($("#endCardNo").val());
			
			var cardSum = $("#cardSum").html();
			var cardPrice = $("#cardPrice").html();
			var cardValid = $("#cardValid").html();
			var cardDiscount = parseFloat($("select[name='cardDiscount']").find("option:selected").val()/10);
			var cardRealPrice = $("#cardRealPrice").html();
			var cardRealMoney = $("#cardRealMoney").html();
			var product_id = $("#product_id").val();
			var product_account = $("#product_account").val();
			
			/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm225/fm225Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = phoneNo;
			var iUserPwd = "";
			
			
			//hejwa and haoyy更改数据取值错误
			cardRealMoney = parseInt(cardSum)*parseInt(cardPrice);
			//alert("cardSum = "+cardSum+"\ncardPrice = "+cardPrice+"\ncardRealMoney = "+cardRealMoney);
			
			getdataPacket.data.add("iLoginAccept",$("#iLoginAcceptnew").val());
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			
			getdataPacket.data.add("product_id",product_id);
			getdataPacket.data.add("startCardNo",startCardNo);
			getdataPacket.data.add("endCardNo",endCardNo);
			getdataPacket.data.add("cardSum",cardSum);
			getdataPacket.data.add("cardPrice",cardPrice);
			getdataPacket.data.add("cardValid",cardValid);
			getdataPacket.data.add("cardDiscount",cardDiscount);
			getdataPacket.data.add("cardRealPrice",cardRealPrice);
			getdataPacket.data.add("cardRealMoney",cardRealMoney);
			getdataPacket.data.add("product_account",product_account);
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var oActualNum = packet.data.findValueByName("oActualNum");
			var oActualTotal = packet.data.findValueByName("oActualTotal");
			
			
			
			if(retCode == "000000"){
				
				$("#resultContent2").show();
				$("#appendBody2").empty();
				$("#configBtn").attr("disabled","disabled");
				
				var appendResultCon = "实际成功购买卡数量:"+oActualNum+",实际消费总金额:"+oActualTotal;
				$("#appendResultCon").html(appendResultCon);
				
				var appendTh = 
					"<tr>"
					+"<th width='50%'>失败卡号</th>"
					+"<th width='50%'>失败原因</th>"
					
					+"</tr>";
				$("#appendBody2").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
			
					/*失败数量*/
					var failureNum = infoArray[i][0];
					/*失败号码*/
					var failureNo = infoArray[i][1];
					
			
					var appendStr = "<tr>";
					
					appendStr += "<td width='50%' id='failureNum'>"+failureNum+"</td>"
											+"<td width='50%' id='failureNo'>"+failureNo+"</td>"
					appendStr +="</tr>";	
									
					$("#appendBody2").append(appendStr);
				}
				if(infoArray.length != 0){
					
				}
			}else{
				$("#resultContent2").hide();
				$("#appendBody2").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
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
	  		<td width="20%" class="blue">集团编码</td>
	  		<td width="30%">
	  			<input type="text" id="unitCode" name="unitCode" v_type="0_9" maxlength="10" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			<input type="button" id="qryUnitBtn" class="b_text" name="qryUnitBtn" value="查询" onclick="showMsg();"/>
	  		</td>
	  		<td width="20%" class="blue">产品ID</td>
	  		<td width="30%">
	  			<input type="text" id="product_id" readonly class="InputGrey" name="product_id" value="" />
	  			<input type="hidden" name="product_account" id="product_account" value=""/>
	  		</td>
	    </tr>
	  </table>
	 <div>
	 	
	 <div id="cardContent" style="display:none">
		<div class="title">
			<div id="title_zi">流量卡信息查询</div>
		</div>
		<table>
			 <tr>
	  		<td width="20%" class="blue">流量卡开始序列号</td>
	  		<td width="30%">
	  			<input type="text" id="startCardNo" name="startCardNo" size="30" value="" v_must="1"/>
	  		</td>
	  		<td width="20%" class="blue">流量卡结束序列号</td>
	  		<td width="30%">
	  			<input type="text" id="endCardNo" name="endCardNo" size="30" value="" v_must="1"/>
	  			&nbsp;&nbsp;
	  			<input type="button" id="qryCardBtn" class="b_text" name="qryCardBtn" value="查询" onclick="doQry();"/>
	  		</td>
	    </tr>
			
		</table>
		</div>
	 
	 <!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">流量卡信息查询结果</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
	</div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确认&打印" disabled="disabled"  onclick="doCommit();">&nbsp;&nbsp;
				<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.href='/npage/sm225/fm225Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>'">&nbsp;&nbsp;
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
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="oCustId" id="oCustId" value=""/>
	 

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
