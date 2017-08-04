<%
  /*
   * 功能: 关于优化客服CRM系统功能六月份第一次需求的函
   * 版本: 1.0
   * 日期: 2014/08/11 9:23:54
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
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String newTime=sdf1.format(new Date());
		
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		var printButFlag=true;
		function checkInv(phoneNo){
			var returnVal = false;
			var phoneHead = phoneNo.substring(0,3);
			var phoneHead10648 = phoneNo.substring(0,5);
			var pLength = phoneNo.length;
			/*
			if( (pLength == 11 && (phoneHead == "147" || phoneHead == "205" || phoneHead == "206")) ||  (pLength == 13 && phoneHead10648 == "10648")){
				returnVal = true;
			}else{
				rdShowMessageDialog("号码必须是以‘205’、‘206’、‘147‘开头的11位号码或者以‘10648’开头的13位号码！",1);
				returnVal = false;
			}*/
			returnVal = true;
			return returnVal;
		}
		
		function doQry(){
			if(!check(f1)){
				return false;
			}
			var opType = $("input[name='opType'][checked]").val();
			
			var phoneNo = $.trim($("#phoneNo").val());
			var startCust = $.trim($("#startCust").val());
			var startphoneNo = $.trim($("#startphoneNo").val());
			var endphoneNo = $.trim($("#endphoneNo").val());
			var accepts = $.trim($("#accepts").val());
			
			if(opType == "0"){
				if(phoneNo.length == 0){
					rdShowMessageDialog("请输入手机号码！",1);
					return false;
				}
				if(startCust.length == 0){
					rdShowMessageDialog("请选择月份！",1);
					return false;
				}
				if(!checkInv(phoneNo)){
					return false;
				}
				
			var getdataPacket = new AJAXPacket("/npage/sm239/fm239Qry.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("startCust",startCust);
			
			getdataPacket.data.add("opType",opType);
			getdataPacket.data.add("startphoneNo",startphoneNo);
			getdataPacket.data.add("endphoneNo",endphoneNo);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;				
				
			}else if(opType == "1"){
				if(startphoneNo.length == 0 || endphoneNo.length == 0){
					rdShowMessageDialog("请输入开始号码和结束号码！",1);
					return false;
				}
				if(startphoneNo > endphoneNo){
						rdShowMessageDialog("开始号码不能大于结束号码！",1);
						return false;
					}
				if(!checkInv(startphoneNo)){
					return false;
				}
				if(!checkInv(endphoneNo)){
					return false;
				}
				
				
			var getdataPacket = new AJAXPacket("/npage/sm239/fm239Qry.jsp","正在获得数据，请稍候......");
			
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
			getdataPacket.data.add("startCust",startCust);
			
			getdataPacket.data.add("opType",opType);
			getdataPacket.data.add("startphoneNo",startphoneNo);
			getdataPacket.data.add("endphoneNo",endphoneNo);
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
			}else if(opType == "2"){
				
				if(accepts.length == 0){
					rdShowMessageDialog("请输入查询流水",1);
					return false;
				}
				
			var getdataPacket = new AJAXPacket("/npage/sm239/fm239Qry.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = accepts;
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = "";
			var iUserPwd = "";
			
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("startCust","");
			
			getdataPacket.data.add("opType",opType);
			getdataPacket.data.add("startphoneNo","");
			getdataPacket.data.add("endphoneNo","");
			
			
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;				
				
			}else if(opType == "3"){
				if(accepts.length == 0){
					rdShowMessageDialog("请输入查询流水",1);
					return false;
				}
				caozuoLiushui=accepts;
				var getdataPacket = new AJAXPacket("/npage/sm239/fm239Qry_plyx.jsp","正在获得数据，请稍候......");
				var iLoginAccept = accepts;
				var iChnSource = "01";
				var iOpCode = "<%=opCode%>";
				var iLoginNo = "<%=loginNo%>";
				var iLoginPwd = "<%=noPass%>";
				var iPhoneNo = "";
				var iUserPwd = "";
				
				
				getdataPacket.data.add("iLoginAccept",iLoginAccept);
				getdataPacket.data.add("iChnSource",iChnSource);
				getdataPacket.data.add("iOpCode",iOpCode);
				getdataPacket.data.add("iLoginNo",iLoginNo);
				getdataPacket.data.add("iLoginPwd",iLoginPwd);
				getdataPacket.data.add("iPhoneNo",iPhoneNo);
				getdataPacket.data.add("iUserPwd",iUserPwd);
				getdataPacket.data.add("startCust","");
				
				getdataPacket.data.add("opType",opType);
				getdataPacket.data.add("startphoneNo","");
				getdataPacket.data.add("endphoneNo","");
				core.ajax.sendPacket(getdataPacket,doRetRegionplyx);
				getdataPacket = null;				
				
			}
			else if(opType == "4"){
				if(accepts.length == 0){
					rdShowMessageDialog("请输入查询流水",1);
					return false;
				}
				caozuoLiushui=accepts;
				var getdataPacket = new AJAXPacket("/npage/sm239/fm239Qry_plgh.jsp","正在获得数据，请稍候......");
				var iLoginAccept = accepts;
				var iChnSource = "01";
				var iOpCode = "<%=opCode%>";
				var iLoginNo = "<%=loginNo%>";
				var iLoginPwd = "<%=noPass%>";
				var iPhoneNo = "";
				var iUserPwd = "";
				getdataPacket.data.add("iLoginAccept",iLoginAccept);
				getdataPacket.data.add("iChnSource",iChnSource);
				getdataPacket.data.add("iOpCode",iOpCode);
				getdataPacket.data.add("iLoginNo",iLoginNo);
				getdataPacket.data.add("iLoginPwd",iLoginPwd);
				getdataPacket.data.add("iPhoneNo",iPhoneNo);
				getdataPacket.data.add("iUserPwd",iUserPwd);
				getdataPacket.data.add("startCust","");
				getdataPacket.data.add("opType",opType);
				getdataPacket.data.add("startphoneNo","");
				getdataPacket.data.add("endphoneNo","");
				core.ajax.sendPacket(getdataPacket,doRetRegionplgh);
				getdataPacket = null;				
			}
		}
		var prt_flag  = "";	
		function doRetRegion(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var infoArray = packet.data.findValueByName("infoArray");
		if(retCode == "000000"){
			prt_flag  = packet.data.findValueByName("prt_flag");
				$("#resultContent").show();
				$("#appendBody").empty();
				$("#phoneNo").attr("readonly","readonly");
				$("#phoneNo").attr("class","InputGrey");
				var opType = $("input[name='opType'][checked]").val();
				var styleInit = opType=="0"?"none":"block";
				if("2"==opType){
					$("#accepts").attr("readOnly","readOnly");
				}else{
					$("#accepts").removeAttr("readOnly");
				}
				var style_2_Init = opType=="2"?"block":"none";
				var appendTh = 
					"<tr>"
					+"<th width='12%'style='display:"+styleInit+"'>手机号码</th>"
					+"<th width='12%'>当前处理状态</th>"
					+"<th width='12%'>操作编码</th>"
					+"<th width='12%'>操作名称</th>"
					+"<th width='12%'>操作时间</th>"
					+"<th width='12%'>标识</th>"
					+"<th width='12%'>失败原因</th>"
					+"<th width='12%'>集团oprseq流水</th>"
					+"<th width='12%' style='display:"+style_2_Init+"'>操作流水</th>"
					+"<th width='12%' style='display:"+style_2_Init+"'>操作工号</th>"
					+"</tr>";
				$("#appendBody").append(appendTh);	
				
				for(var i=0;i<infoArray.length;i++){
					var msg0 = infoArray[i][0];
					var msg1 = infoArray[i][1];
					var msg2 = infoArray[i][2];
					var msg3 = infoArray[i][3];
					var msg4 = infoArray[i][4];
					var msg5 = infoArray[i][5];
					var msg6 = infoArray[i][6];
					var msg7 = infoArray[i][7];
					var appendStr = "<tr>";
					if(msg1=="m277"||msg1=="m278"){
						printButFlag=false;
					}
					appendStr += "<td width='12%' style='display:"+styleInit+"'>"+msg7+"</td>"
					+"<td width='12%'>"+msg0+"</td>"
					+"<td width='12%'>"+msg1+"</td>"
					+"<td width='12%'>"+msg2+"</td>"
					+"<td width='12%'>"+msg3+"</td>"
					+"<td width='12%'>"+msg4+"</td>"
					+"<td width='12%'>"+msg5+"</td>"
					+"<td width='12%'>"+msg6+"</td>"
					+"<td width='12%' style='display:"+style_2_Init+"'>"+infoArray[i][9]+"</td>"
					+"<td width='12%' style='display:"+style_2_Init+"'>"+infoArray[i][8]+"</td>"
					+"<td width='12%' style='display:none'>"+infoArray[i][10]+"</td>";
					appendStr +="</tr>";	
					$("#appendBody").append(appendStr);
				}
				if(infoArray.length>0&&opType=="2"&&printButFlag){
					$("#go_print_tab").show();
				}else{
					$("#go_print_tab").hide();
				}
			}else{
				$("#accepts").removeAttr("readOnly");
				prt_flag = "";
				$("#resultContent").hide();
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			}
		}
	function doRetRegion1(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var infoArray = packet.data.findValueByName("infoArray");
		
	if(retCode == "000000"){

		prt_flag  = packet.data.findValueByName("prt_flag");
		
		
			$("#resultContent").show();
			$("#appendBody").empty();
			$("#phoneNo").attr("readonly","readonly");
			$("#phoneNo").attr("class","InputGrey");
			var opType = $("input[name='opType'][checked]").val();
			var styleInit = opType=="0"?"none":"block";
			
			if("2"==opType){
				$("#accepts").attr("readOnly","readOnly");
			}else{
				$("#accepts").removeAttr("readOnly");
			}
			var style_2_Init = opType=="2"?"block":"none";
			
			
			var appendTh = 
				"<tr>"
				+"<th width='12%'style='display:"+styleInit+"'>手机号码</th>"
				+"<th width='12%'>当前处理状态</th>"
				+"<th width='12%'>操作编码</th>"
				+"<th width='12%'>操作名称</th>"
				+"<th width='12%'>操作时间</th>"
				+"<th width='12%'>标识</th>"
				+"<th width='12%'>失败原因</th>"
				+"<th width='12%'>集团oprseq流水</th>"
				+"<th width='12%' style='display:"+style_2_Init+"'>操作流水</th>"
				+"<th width='12%' style='display:"+style_2_Init+"'>操作工号</th>"
				+"</tr>";
			$("#appendBody").append(appendTh);	
			
			if(infoArray.length>0&&opType=="2"){
				$("#go_print_tab").show();
			}else{
				$("#go_print_tab").hide();
			}
		for(var i=0;i<infoArray.length;i++){
		
				var msg0 = infoArray[i][0];
				var msg1 = infoArray[i][1];
				var msg2 = infoArray[i][2];
				var msg3 = infoArray[i][3];
				var msg4 = infoArray[i][4];
				var msg5 = infoArray[i][5];
				var msg6 = infoArray[i][6];
				var msg7 = infoArray[i][7];
		
		
				var appendStr = "<tr>";
				
				appendStr += "<td width='12%' style='display:"+styleInit+"'>"+msg7+"</td>"
										+"<td width='12%'>"+msg0+"</td>"
										+"<td width='12%'>"+msg1+"</td>"
										+"<td width='12%'>"+msg2+"</td>"
										+"<td width='12%'>"+msg3+"</td>"
										+"<td width='12%'>"+msg4+"</td>"
										+"<td width='12%'>"+msg5+"</td>"
										+"<td width='12%'>"+msg6+"</td>"
										+"<td width='12%' style='display:"+style_2_Init+"'>"+infoArray[i][9]+"</td>"
										+"<td width='12%' style='display:"+style_2_Init+"'>"+infoArray[i][8]+"</td>"
										+"<td width='12%' style='display:none'>"+infoArray[i][10]+"</td>";
				appendStr +="</tr>";	
								
				$("#appendBody").append(appendStr);
			}
			if(infoArray.length != 0){
				//$("#export").attr("disabled","");
			}
			
		}else{
			$("#accepts").removeAttr("readOnly");
			prt_flag = "";
			$("#resultContent").hide();
			$("#appendBody").empty();
			//$("#export").attr("disabled","disabled");
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			
		}
	}
	
	
	
	
		/*叠加包信息 查询方法*/
		function showMsg(productId){
			//alert(productId);
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("#phoneNo").val());
			var iUserPwd = "";
			
			/*拼接入参*/
			var path = "/npage/sm202/fm202Qry_2.jsp";
		  path += "?iLoginAccept="+iLoginAccept;
		  path += "&iChnSource="+iChnSource;
		  path += "&iOpCode="+iOpCode;
		  path += "&iOpName=<%=opName%>";
		  path += "&iLoginNo="+iLoginNo;
		  path += "&iLoginPwd="+iLoginPwd;
		  path += "&iPhoneNo="+iPhoneNo;
		  path += "&iUserPwd=";
		  path += "&iProductId="+productId;
		  /*打开*/
		  //alert(path);
		  window.open(path,"newwindow","height=350, width=500,top=50,left=200,scrollbars=no, resizable=no,location=no, status=no");
			

		}
		
		function showAndHideFun(){
		
			$("#phoneNo").val("");
			$("#startCust").val("");
			$("#startphoneNo").val("");
			$("#endphoneNo").val("");
			$("#accepts").val("");
			
			$("#go_print_tab").hide();
			$("#appendBody").empty();
			prt_flag = "";
			
			$("#phoneNo").removeAttr("readOnly");
			$("#phoneNo").removeClass("InputGrey");
			$("#accepts").removeAttr("readOnly");
			
			var opType = $("input[name='opType'][checked]").val();
			$("#showAndHide1").hide();
			$("#showAndHide2").hide();
			$("#showAndHide3").hide();
			$("#showFont").hide();
			
 			if(opType == "0"){
				$("#showAndHide1").show();
			}else if(opType == "1"){
				$("#showAndHide2").show();
			}else if(opType == "2"){
				$("#showAndHide3").show();
				$("#showFont").show();
			}else if(opType == "3"){
				$("#showAndHide3").show();
			}
			else if(opType == "4"){
				$("#showAndHide3").show();
			}
		}
function go_print(){
			if(prt_flag=="1"){
		 		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
			 	var pactket2 = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
				pactket2.data.add("id_no","0");
				pactket2.data.add("paySeq",$("#accepts").val().trim());
				core.ajax.sendPacket(pactket2,doserv);
				pactket2=null;
				
			}else if(prt_flag=="0"){
				rdShowMessageDialog("集团未全部反馈，暂时无法打印");
			}else if(prt_flag=="2"){
				rdShowMessageDialog("已存在打印数据，若需补打请到m088进行操作");
			}
}	

		function doserv(packet)
		{
			var s_ret_code = packet.data.findValueByName("s_ret_code");
			var s_ret_msg = packet.data.findValueByName("s_ret_msg");
		//	alert("s_ret_code is "+s_ret_code);
			if(s_ret_code!="000000")
			{
				//rdShowMessageDialog("更新电子工单状态失败!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
			}else{
				location = location;
			}
		}
		
		
   function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =$("#accepts").val().trim();             	//流水号
      var printStr = printInfo(printType);
      
	 		                      //调用printinfo()返回的打印内容
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="i067" ;                   			 	//操作代码
      var phoneNo="";                  //客户电话
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=i067&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
    
    var print_info_arr = new Array();
    /*
     输出参数：
				客户名称
				证件类型
				证件号码
				经办人姓名
				经办人证件号码
				主资费名称
				主资费描述
出参。下标从0开始
*/

		//打印模板id为：93
    function printInfo(printType){
    	go_sm239PaperQry();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      
      var print_info_arr_0_0 = "";
      var print_info_arr_0_1 = "";
      var print_info_arr_0_2 = "";
      var print_info_arr_0_3 = "";
      var print_info_arr_0_4 = "";
      var print_info_arr_0_5 = "";
      var print_info_arr_0_6 = "";
      var print_info_arr_0_7 = "";
      var print_info_arr_0_8 = "";
      
      if(print_info_arr.length>0){
      	  print_info_arr_0_0 = print_info_arr[0][0];
		      print_info_arr_0_1 = print_info_arr[0][1];
		      print_info_arr_0_2 = print_info_arr[0][2];
		      print_info_arr_0_3 = print_info_arr[0][3];
		      print_info_arr_0_4 = print_info_arr[0][4];
		      print_info_arr_0_5 = print_info_arr[0][5];
		      print_info_arr_0_6 = print_info_arr[0][6];
		      print_info_arr_0_7 = print_info_arr[0][7];
		      print_info_arr_0_8 = print_info_arr[0][8];
      }
      cust_info+="客户姓名："+print_info_arr_0_0+"|";
      cust_info+="证件类型："+print_info_arr_0_1+"|";
      cust_info+="证件号码："+print_info_arr_0_2+"|";
      cust_info+="经办人姓名：   "+print_info_arr_0_3+"|";
      cust_info+="经办人证件号码：   "+print_info_arr_0_4+"|";
      
      var su_size = 0;
      var temp_oprinfo = "";
      $("#exportExcel tr:gt(0)").each(function(){
      	var pp_flag = $(this).find("td:last").text().trim();
      	if(pp_flag!="pp"){
      		temp_oprinfo += $(this).find("td:eq(0)").text().trim()+"、";
      		su_size++;
      		if(su_size%59==0){
      			temp_oprinfo += "|";
      		}
      	}
      });
      
      
            
 			opr_info += "办理业务：批量开户"+"    号码个数："+su_size+"    操作流水："+$("#accepts").val().trim()+"|";
 			opr_info += "业务受理时间："+print_info_arr_0_7+"|"
      opr_info += "|";
      opr_info += "主资费："+print_info_arr_0_5+"    生效时间："+print_info_arr_0_8+"|"
      opr_info += "主资费描述："+print_info_arr_0_6+"|";
      
      opr_info += "|";

      
      if(temp_oprinfo.length>0){
      	temp_oprinfo = temp_oprinfo.substring(0,temp_oprinfo.length-1);
      }
      
      opr_info += temp_oprinfo+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

function go_sm239PaperQry(){
 		var packet = new AJAXPacket("fm239_get_print_info.jsp","请稍后...");
        packet.data.add("accepts",$("#accepts").val());//客户姓名
    core.ajax.sendPacket(packet,do_sm239PaperQry);
    packet =null;	
}
function do_sm239PaperQry(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	print_info_arr =  packet.data.findValueByName("retArray");
    }else{
    	rdShowMessageDialog("获取免填单数据错误："+error_code+"，"+error_msg);
    	location = location;
    } 
}




//2017-01-16 liangyl 关于物联卡功能优化的需求
var caozuoLiushui="";
var dayinFlag="N";
function go_checkm239Print(){
	dayinFlag="N";
	var pactket2 = new AJAXPacket("fm239_ChkPrint.jsp","正在进行电子工单状态修改，请稍候......");
	pactket2.data.add("iLoginAccept",caozuoLiushui);
	core.ajax.sendPacket(pactket2,do_checkPrint);
	pactket2=null;
}
function do_checkPrint(packet){
	
	var s_ret_code = packet.data.findValueByName("retCode");
	var s_ret_msg = packet.data.findValueByName("retMsg");
	if(s_ret_code=="000000")
	{
		dayinFlag=packet.data.findValueByName("dayinFlag");
	}
	else{
		rdShowMessageDialog("错误代码："+s_ret_code+",错误信息："+s_ret_msg,1);
		return false;
	}
}
var printJbrName="";
var printJbrIdCard ="";
var printUserName="";
var printIdCard="";
var printCardType="";
var printStatus="";
 

function doRetRegionplyx(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var infoArray = packet.data.findValueByName("infoArray");
	printJbrName="";
	printJbrIdCard="";
	printUserName="";
	printIdCard="";
	printCardType="";
	if(retCode == "000000"){
		prt_flag  = packet.data.findValueByName("prt_flag");
			$("#resultContent").show();
			$("#appendBody").empty();
			$("#phoneNo").attr("readonly","readonly");
			$("#phoneNo").attr("class","InputGrey");
			var appendTh = 
				"<tr>"
				+"<th width='12%'>手机号码</th>"
				+"<th width='12%'>当前处理状态</th>"
				+"<th width='12%'>操作编码</th>"
				+"<th width='12%'>操作名称</th>"
				+"<th width='12%'>操作时间</th>"
				+"<th width='12%'>标识</th>"
				+"<th width='12%'>失败原因</th>"
				+"<th width='12%'>集团oprseq流水</th>"
				+"</tr>";
			$("#appendBody").append(appendTh);	
			var dyPhone="";
			var geshu=0;
			
			for(var i=0;i<infoArray.length;i++){
				var msg0 = infoArray[i][0];
				var msg1 = infoArray[i][1];
				var msg2 = infoArray[i][2];
				var msg3 = infoArray[i][3];
				var msg4 = infoArray[i][4];
				if( infoArray[i][4] == "处理成功"){
					dyPhone+=infoArray[i][7]+",";
					geshu++;
				}
				
				var msg5 = infoArray[i][5];
				var msg6 = infoArray[i][6];
				var msg7 = infoArray[i][7];
				if(printJbrName==""&&printUserName==""){
					if(infoArray[i][12]!=""){
						printJbrName = infoArray[i][12].split("|")[0];
						printJbrIdCard = infoArray[i][12].split("|")[3];
					}
					printUserName = infoArray[i][13];
					printCardType = infoArray[i][14];
					printIdCard = infoArray[i][15];
					printStatus = infoArray[i][11];
				}
				
				
				
				var appendStr = "<tr>";
				appendStr += "<td width='12%'>"+msg7+"</td>"
				+"<td width='12%'>"+msg0+"</td>"
				+"<td width='12%'>"+msg1+"</td>"
				+"<td width='12%'>"+msg2+"</td>"
				+"<td width='12%'>"+msg3+"</td>"
				+"<td width='12%'>"+msg4+"</td>"
				+"<td width='12%'>"+msg5+"</td>"
				+"<td width='12%'>"+msg6+"</td>"
				appendStr +="</tr>";
				$("#appendBody").append(appendStr);
			}
			if(dyPhone!=""){
				dyPhone=dyPhone.substring(0,dyPhone.length-1);
			}
			if(infoArray.length>0){
				var footStr = "<tr>";
				footStr += "<td colspan='8'  align='center'><input type='hidden' id='phoneNums' name='phoneNums' value='"+dyPhone+"'><input type='hidden' id='geshu' name='geshu' value='"+geshu+"'><input class='b_foot' type='button' value='打印免填单' onclick='daYinplyx()'></td>"
				footStr +="</tr>";
				$("#appendBody").append(footStr);
			}
			else{
				var footStr = "<tr>";
				footStr += "<td colspan='8'  align='center'>无查询内容</td>"
				footStr +="</tr>";
				$("#appendBody").append(footStr);
			}
		}else{
			$("#accepts").removeAttr("readOnly");
			prt_flag = "";
			$("#resultContent").hide();
			$("#appendBody").empty();
			//$("#export").attr("disabled","disabled");
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		}
}

function daYinplyx(){
	go_checkm239Print();
	if("N"==dayinFlag&&printStatus=="1"){
		if($.trim($("#phoneNums").val())!=""){
			var returnflag=showPrtDlgplyx("Detail","确实要进行电子免填单打印吗？","Yes");
			if(returnflag!=undefined){
				var pactket2 = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
				pactket2.data.add("id_no","0");
				pactket2.data.add("paySeq",caozuoLiushui);
				core.ajax.sendPacket(pactket2,doserv);
				pactket2=null;
			}
		}
		else{
			rdShowMessageDialog("当前执行结果不可打印!只有全部执行完成才可打印,且只打印成功号码!");
		}
	}
	else if(printStatus=="0"){
		rdShowMessageDialog("集团未全部反馈，暂时无法打印");
	}else if(printStatus=="2"){
		rdShowMessageDialog("已存在打印数据，若需补打请到m088进行操作");
	}
	else{
		rdShowMessageDialog("不可以重复打印免填单!");
	}
}

function showPrtDlgplyx(printType,DlgMessage,submitCfm){  //显示打印对话框 
    var h=180;
    var w=350;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;		   	   
    var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
    var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
    var sysAccept =caozuoLiushui;             	//流水号
    var printStr = printInfoplyx(printType);
	 	//调用printinfo()返回的打印内容
    var mode_code=null;           							  //资费代码
    var fav_code=null;                				 		//特服代码
    var area_code=null;             				 		  //小区代码
    var opCode="m239";                   			 	//操作代码
    var phoneNo="";                  //客户电话
    
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    path+="&mode_code="+mode_code+
    	"&fav_code="+fav_code+"&area_code="+area_code+
    	"&opCode=m239&sysAccept="+sysAccept+
    	"&phoneNo="+phoneNo+
    	"&submitCfm="+submitCfm+"&pType="+
    	pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;
}
//打印模板id为：93
function printInfoplyx(printType){
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  var retInfo = "";
  cust_info+="客户姓名："+printUserName+"|";
  cust_info+="证件号码："+printIdCard+"|";
  cust_info+="证件类型："+printCardType+"|";
  cust_info+="经办人姓名："+printJbrName+"|";
	cust_info+="经办人证件号码："+printJbrIdCard+"|";
  
	opr_info+="办理业务：批量预销";
	opr_info+="号码个数："+$("#geshu").val()+"      ";
	opr_info+="操作流水："+caozuoLiushui+"|";
	opr_info+="业务受理时间：<%=newTime%>|";
	var phoneNums=$("#phoneNums").val().split(",");
	var showPhones="";
	for(var i=0;i<phoneNums.length;i++){
		showPhones+=phoneNums[i]+",";
		if((i+1)%5==0){
			showPhones+="|";
		}
	}
	opr_info+=showPhones.substring(0,showPhones.lastIndexOf(","))+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

function doRetRegionplgh(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var infoArray = packet.data.findValueByName("infoArray");
	if(retCode == "000000"){
		prt_flag  = packet.data.findValueByName("prt_flag");
			$("#resultContent").show();
			$("#appendBody").empty();
			$("#phoneNo").attr("readonly","readonly");
			$("#phoneNo").attr("class","InputGrey");
			
			var appendTh = 
				"<tr>"
				+"<th width='12%'>手机号码</th>"
				+"<th width='12%'>当前处理状态</th>"
				+"<th width='12%'>操作编码</th>"
				+"<th width='12%'>操作名称</th>"
				+"<th width='12%'>操作时间</th>"
				+"<th width='12%'>标识</th>"
				+"<th width='12%'>失败原因</th>"
				+"<th width='12%'>集团oprseq流水</th>"
				+"</tr>";
			$("#appendBody").append(appendTh);	
			var dyPhone="";
			var geshu=0;
			for(var i=0;i<infoArray.length;i++){
				var msg0 = infoArray[i][0];
				var msg1 = infoArray[i][1];
				var msg2 = infoArray[i][2];
				var msg3 = infoArray[i][3];
				var msg4 = infoArray[i][4];
				if( infoArray[i][4] == "处理成功"){
					dyPhone+=infoArray[i][7]+",";
					geshu++;
				}
				var msg5 = infoArray[i][5];
				var msg6 = infoArray[i][6];
				var msg7 = infoArray[i][7];
				var appendStr = "<tr>";
				appendStr += "<td width='12%'>"+msg7+"</td>"
				+"<td width='12%'>"+msg0+"</td>"
				+"<td width='12%'>"+msg1+"</td>"
				+"<td width='12%'>"+msg2+"</td>"
				+"<td width='12%'>"+msg3+"</td>"
				+"<td width='12%'>"+msg4+"</td>"
				+"<td width='12%'>"+msg5+"</td>"
				+"<td width='12%'>"+msg6+"</td>"
				appendStr +="</tr>";	
				$("#appendBody").append(appendStr);
			}
			if(dyPhone!=""){
				dyPhone=dyPhone.substring(0,dyPhone.length-1);
			}
			var footStr = "<tr>";
			footStr += "<td colspan='8'  align='center'><input type='hidden' id='phoneNums' name='phoneNums' value='"+dyPhone+"'><input type='hidden' id='geshu' name='geshu' value='"+geshu+"'><input class='b_foot' type='button' value='打印免填单' onclick='daYinplgh()'></td>"
			footStr +="</tr>";
			$("#appendBody").append(footStr);
		}else{
			$("#accepts").removeAttr("readOnly");
			prt_flag = "";
			$("#resultContent").hide();
			$("#appendBody").empty();
			//$("#export").attr("disabled","disabled");
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		}
}

function daYinplgh(){
	go_checkm239Print();
	if("N"==dayinFlag){
		if($.trim($("#phoneNums").val())!=""){
			var returnflag=showPrtDlglkh("Detail","确实要进行电子免填单打印吗？","Yes");
			if(returnflag!=undefined){
				var pactket2 = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
				pactket2.data.add("id_no","0");
				pactket2.data.add("paySeq",caozuoLiushui);
				core.ajax.sendPacket(pactket2,doserv);
				pactket2=null;
			}
		}
		else{
			rdShowMessageDialog("当前执行结果不可打印!只有全部执行完成才可打印,且只打印成功号码!");
		}
	}
	else{
		rdShowMessageDialog("不可以重复打印免填单!");
	}
}

function showPrtDlgplgh(printType,DlgMessage,submitCfm){  //显示打印对话框 
    var h=180;
    var w=350;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;		   	   
    var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
    var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
    var sysAccept =caozuoLiushui;             	//流水号
    var printStr = printInfoplgh(printType);
	 	//调用printinfo()返回的打印内容
    var mode_code=null;           							  //资费代码
    var fav_code=null;                				 		//特服代码
    var area_code=null;             				 		  //小区代码
    var opCode="m239";                   			 	//操作代码
    var phoneNo="";                  //客户电话
    
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    path+="&mode_code="+mode_code+
    	"&fav_code="+fav_code+"&area_code="+area_code+
    	"&opCode=m110&sysAccept="+sysAccept+
    	"&phoneNo="+phoneNo+
    	"&submitCfm="+submitCfm+"&pType="+
    	pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;
  }	
//打印模板id为：93
function printInfoplgh(printType){
	var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="客户姓名："+printUserName+"|";
	  cust_info+="证件号码："+printIdCard+"|";
	  cust_info+="证件类型："+printCardType+"|";
	  cust_info+="经办人姓名："+printJbrName+"|";
		cust_info+="经办人证件号码："+printJbrIdCard+"|";
	  
		opr_info+="办理业务：批量过户";
		opr_info+="号码个数："+$("#geshu").val()+"      ";
		opr_info+="操作流水："+caozuoLiushui+"|";
		opr_info+="业务受理时间：<%=newTime%>|";
		var phoneNums=$("#phoneNums").val().split(",");
		var showPhones="";
		for(var i=0;i<phoneNums.length;i++){
			showPhones+=phoneNums[i]+",";
			if((i+1)%5==0){
				showPhones+="|";
			}
		}
		opr_info+=showPhones.substring(0,showPhones.lastIndexOf(","))+"|";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
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
				<td width="20%" class="blue">操作类型</td>
				<td colspan="3">
						<input type="radio" name="opType" value="0" checked onclick="showAndHideFun();"/>单个号码&nbsp;
						<input type="radio" name="opType" value="1" onclick="showAndHideFun();"/>批量号码
						<input type="radio" name="opType" value="2" onclick="showAndHideFun();"/>流水查询
						<input type="radio" name="opType" value="3" onclick="showAndHideFun();"/>物联网批量预销
						<!-- <input type="radio" name="opType" value="4" onclick="showAndHideFun();"/>物联网批量过户 -->
				</td>
			</tr>
	    <tr id="showAndHide1">
	  		<td width="20%" class="blue">手机号码</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" v_type="0_9" maxlength="13" value="" />
	  		</td>
	  		<td class="blue" width="20%">月份</td>
				<td width="30%">
						<input type="text" id="startCust"  name="startCust" readOnly onclick="WdatePicker({el:'startCust',startDate:'%y%M',dateFmt:'yyyyMM',alwaysUseStartDate:true})"/>
							<img id = "imgCustStart" 
								First. onclick="WdatePicker({el:'startCust',startDate:'%y%M',dateFmt:'yyyyMM',alwaysUseStartDate:true})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

				</td>
	    </tr>
	    <tr id="showAndHide2" style="display:none">
	  		<td width="20%" class="blue">开始号码</td>
	  		<td width="30%">
	  			<input type="text" id="startphoneNo" name="startphoneNo" v_type="0_9" maxlength="13"  value="" />
	  		</td>
	  		<td width="20%" class="blue">结束号码</td>
	  		<td width="30%">
	  			<input type="text" id="endphoneNo" name="endphoneNo" v_type="0_9" maxlength="13"  value="" />
	  		</td>
	    </tr>
	    	    <tr id="showAndHide3" style="display:none">

	    	<td width="20%" class="blue">操作流水</td>
	  		<td  colspan="3">
	  			<input type="text" id="accepts" name="accepts" v_type="0_9" maxlength = "14" value="" /> <font id="showFont" class="red">流水查询仅支持m277,m278,i067和i068的反馈流水进行查询！</font>
	  		</td>
	  	</tr>
	  	
			<td align=center colspan="4" id="footer">
				<input class="b_foot" name="sure"  type="button" value="查询"  onclick="doQry();">&nbsp;&nbsp;
				<input class="b_foot" name="sure"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
				<input class="b_foot" name="excelExport"  type="button" value="导出EXCEL表格"  onclick="printTable();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				
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
		
		<table id="go_print_tab" style="display:none"> 
			 <tr>
			<td align=center  id="footer">
				<input class="b_foot" name="sure"  type="button" value="打印"  onclick="go_print();"> 
			</td>
		</tr>
		</table>
		
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
