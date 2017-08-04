<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2016/10/31 关于协助开发、优化BOSS系统宽带业务功能的函
   * 作者: liangyl
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>

<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*"%>
<%@ page import="javax.crypto.*;"%>
<%@ page import="com.sitech.util.*"%>



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
		//String loginAccept = getMaxAccept();和标签一样
	//	String accountType = (String)session.getAttribute("accountType");
		String dateStr =  new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>

<html>
<head>
<title><%=opName%></title>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js"></script>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<%@ include file="/npage/include/header.jsp"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" />
<script language="javascript">
		$(document).ready(function(){
			
		});
		function doCommit(){			
			if($("#kuandaiNum").val().length == 0){
				rdShowMessageDialog("请输入宽带账号！",0);
				return false;
			}
			if($("#kdZdFee").val().length == 0){
				rdShowMessageDialog("请输入宽带终端费用！",0);
				return false;
			}
			if(!forMoney($("#kdZdFee")[0],false)){
				rdShowMessageDialog("输入格式不正确请修改！",0);
				return false;
			}
			
			var getdataPacket = new AJAXPacket("fm419getPP.jsp","正在获取品牌，请稍候......");
			getdataPacket.data.add("kuandaiNum",$("#kuandaiNum").val());
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
		}
		var ppName="";
		var phoneNum="";
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				ppName = packet.data.findValueByName("ppName");
				phoneNum = packet.data.findValueByName("phoneNum");
				//alert(ppName);
				if("kf"==ppName){
					if(!printCommit()){
				    	return false;
				    }
				}
				else{
					rdShowMessageDialog("该号码不是kf品牌不允许办理该业务！",0);
					return false;
				}
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			}
		}
		function printCommit(){
			go_getUserInfo();
		}
		function go_getUserInfo(){
			var getdataPacket = new AJAXPacket("fm419getUserInfo.jsp","正在获取用户信息，请稍候......");
			getdataPacket.data.add("kuandaiNum",$("#kuandaiNum").val());
			core.ajax.sendPacket(getdataPacket,do_getUserInfo);
			getdataPacket = null;
		}
		var userName="";
		var userAddr="";
		var idType = "";
		var idIccid = "";
		function do_getUserInfo(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				userName = packet.data.findValueByName("userName");
				userAddr = packet.data.findValueByName("userAddr");
				idType = packet.data.findValueByName("idType");
				idIccid = packet.data.findValueByName("idIccid");
				//alert(userName+"-"+userAddr+"-"+idType+"-"+idIccid);
				getAfterPrompt();
				var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
				showBroadKdZdBill("Bill","确实要进行宽带终端发票打印吗？","Yes");
				if(rdShowConfirmDialog('确认要提交押金补收吗？')==1) {
					submitCfm();
				   return false;
				  }
			}else{
				userName="";
				userAddr="";
				idType = "";
				idIccid = "";
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			}
		}
		function showPrtDlg(printType, DlgMessage, submitCfn){//显示打印对话框 
			var h=210;
			var w=400;
		    var t = screen.availHeight / 2 - h / 2;
		    var l = screen.availWidth / 2 - w / 2;
		    var opCode="<%=opCode%>";
			var pType="subprint";
			var billType="1";
			var mode_code=null;
			var fav_code=null;
			var area_code=null;
			var sysAccept = "<%=sysAcceptl%>";
		    var printStr = printInfo(printType);
		    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNum+"&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		    var ret = window.showModalDialog(path, printStr, prop);
		}
		
		function printInfo(printType){
			var retInfo = "";
		    if (printType == "Detail"){
				var cust_info="";
				var opr_info="";
				var note_info1="";
				var note_info2="";
				var note_info3="";
				var note_info4="";        
				cust_info += "宽带帐号：" + $("#kuandaiNum").val() + "|";
				cust_info += "客户姓名：" + userName + "|";
				cust_info += "客户地址：" + userAddr + "|";
				
				opr_info += "业务受理时间：<%=dateStr%>" + "|";
				opr_info += "办理业务办理名称：光猫押金补收" + "      ";
				opr_info += "操作流水：" + <%=sysAcceptl%> + "|";
				opr_info += "光猫押金："+$("#kdZdFee").val()+ "元|";
				
				note_info1 += "备注：尊敬的用户，如果您办理销户、撤单时，请携带ONT设备、押金发票及|";
				note_info1 += "有效证件，到移动指定自有营业厅办理返还押金，宽带终端押金返还截止|";
				note_info1 += "日期：用户离网90天内（包括90天）。|";
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			}
		    return retInfo;
		}
		
		//打印收据
		//showBroadKdZdBill("Bill","确实要进行宽带终端发票打印吗？","Yes");
			function showBroadKdZdBill(printType,DlgMessage,submitCfm){
				var printInfo = "";
				var prtLoginAccept = "<%=sysAcceptl%>";
				var zhengjianType = ["身份证","军官证","户口簿","港澳通行证","警官证","台湾通行证","外国公民护照","其它","营业执照","护照"];
				zhengjianType["A"]="组织机构代码";
				zhengjianType["B"]="单位法人证书";
				zhengjianType["C"]="单位证明";
				
				var iccidtypess=zhengjianType[idType];
				var iccidnoss=idIccid;
				var  billArgsObj = new Object();
				
				var custName = userName;
				var phoneNo = $("#kuandaiNum").val();
				var feeName = "押金补收";
			  
		 		/*2014/09/11 15:18:07 gaopeng 宽带资费展现及终端管理等七项系统支撑优化需求
			  		加入 宽带设备终端款 
			  	*/
		  		var kdZdFee = $("#kdZdFee").val();
				$(billArgsObj).attr("10001","<%=loginNo%>");     //工号
				$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10005",custName);   //客户名称
				$(billArgsObj).attr("10006","押金补收");    //业务类别
				$(billArgsObj).attr("10008",phoneNo);    //用户号码
				$(billArgsObj).attr("10015", kdZdFee+"");   //本次发票金额
				$(billArgsObj).attr("10016", kdZdFee+"");   //大写金额合计
				$(billArgsObj).attr("10017","*");        //本次缴费：现金
				/*10028 10029 不打印*/
			  	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
				$(billArgsObj).attr("10029","");	 //营销代码	
				$(billArgsObj).attr("10030",prtLoginAccept);   //流水号：--业务流水
				$(billArgsObj).attr("10036","e916");   //操作代码
				$(billArgsObj).attr("10042","台");                   //单位
				$(billArgsObj).attr("10043","1");	                   //数量
				$(billArgsObj).attr("10044",kdZdFee+"");	                //单价
				/*10045不打印*/
				$(billArgsObj).attr("10045","");	       //IMEI
				/*型号不打*/
				$(billArgsObj).attr("10061","");	       //型号
	 			$(billArgsObj).attr("10078", ppName); //宽带品牌		
	 			$(billArgsObj).attr("10071","6");
	 			
	 			$(billArgsObj).attr("10083", iccidtypess); //证件类型
	 			$(billArgsObj).attr("10084", iccidnoss); //证件号码
	 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式
	 			$(billArgsObj).attr("10086", "尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票、有效证件，到移动指定自有营业厅办理返还押金。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。"); //备注
	 			$(billArgsObj).attr("10041", "宽带终端押金费用");           //品名规格 实际是宽带终端类型
	 			$(billArgsObj).attr("10065", $("#kuandaiNum").val()); //宽带账号
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
				var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？"+"&feeName="+feeName;
				var loginAccept = prtLoginAccept;
				var path = path +"&loginAccept="+loginAccept+"&opCode=e916"+"&submitCfm=submitCfm";
				var ret = window.showModalDialog(path,billArgsObj,prop);		

			}
		
		
		
		/**********页面的提交***************/
		function submitCfm(){	
			var myPacket = new AJAXPacket("fm419Cfm.jsp", "正在提交，请稍候......");
			var iLoginAccept = "<%=sysAcceptl%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo ="";
			var iUserPwd = "";
			
			myPacket.data.add("iLoginAccept",iLoginAccept);
			myPacket.data.add("iChnSource",iChnSource);
			myPacket.data.add("iOpCode",iOpCode);
			myPacket.data.add("iLoginNo",iLoginNo);
			myPacket.data.add("iLoginPwd",iLoginPwd);
			myPacket.data.add("iPhoneNo",iPhoneNo);
			myPacket.data.add("iUserPwd",iUserPwd);
			
			myPacket.data.add("yajinType", $("#yajinType").val());
			myPacket.data.add("yewuType", $("#yewuType").val());
			myPacket.data.add("kuandaiNum",$("#kuandaiNum").val().trim());
			myPacket.data.add("kdZd", $("#kdZd").val()); 
			myPacket.data.add("fysqfs", $("#fysqfs").val()); 
			myPacket.data.add("kdZdFee", $("#kdZdFee").val());
			myPacket.data.add("snNumber", $("#snNumber").val());
			//core.ajax.sendPacket(myPacket);
			core.ajax.sendPacket(myPacket,do_submitCfm);
		    myPacket=null;
			   
		}
		
		function do_submitCfm(packet){
			var code = packet.data.findValueByName("retCode"); 
			var msg = packet.data.findValueByName("retMsg"); 
			if(code=="000000"){
				rdShowMessageDialog("添加成功",2);
				location=location;
			}else{
				rdShowMessageDialog("操作失败"+code+"："+msg,0);
			}
		}
	</script>
</head>
<body>
	<form action="" method="post" name="f1">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<table>
			<tr>
				<td width="8%" class="blue" align="center">押金类型</td>
				<td width="20%">
					<select id="yajinType" name="yajinType">
						<option value="0">光猫押金</option>
					</select>
				</td>
				<td width="8%" class="blue" align="center">业务类型</td>
				<td width="20%">
					<select id="yewuType" name="yewuType">
						<option value="0">宽带</option>
					</select>
				</td>
				<td width="8%" class="blue" align="center">宽带账号</td>
				<td>
					<input type="text" id="kuandaiNum" name="kuandaiNum" value="" maxlength="15"/>
					<font color="orange">*</font>
				</td>
			</tr>
			<tr>
				<td class="blue" align="center">宽带终端</td>
				<td>
					<select name="kdZd" id="kdZd">
						<option value="ONT">ONT</option>
					</select>
					<font class="orange">*</font>
				</td>
				<td class="blue" align="center">费用收取方式</td>
				<td>
					<select id="fysqfs" name="fysqfs">
						<option value="0">押金</option>
					</select>
					<font class="orange">*</font></td>
				<td class="blue" align="center">宽带终端费用</td>
				<td id="kdzdfydisplay">
					<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must="0" v_type="money" class='forMoney required' v_minvalue="50" v_maxvalue="200" onblur="forMoney(this,false)"/>
					<font class="orange">*</font>
					<span id="yjfwxianshi">押金范围50-200元</span>
				</td>
			</tr>
			<tr>
				<td class="blue" id="sntitletd" align="center">S/N码</td>
	        	<td id="sntexttd">
	        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="40" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
	        	</td>
	        	<td></td>
	        	<td></td>
	        	<td></td>
	        	<td></td>
	     	</tr>
		</table>
		<div>
			<table>
				<tr>
					<td align=center colspan="6" id="footer">
						<input type="button" class="b_foot" id="configBtn2" name="configBtn2" value="确认" onclick="doCommit();"/>
					</td>
				</tr>
			</table>
		</div>
		
		<%@ include file="/npage/include/footer.jsp"%>
	</form>
</body>
</html>