<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2016/11/29 关于优化现有ONT管理系统的需求
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

<%@ page import="java.util.*"%>
<%@ page import="java.util.regex.*"%>

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
		
		String pdPhone = "0"; 
		Pattern p = Pattern.compile("^1[34578](\\d{9}|\\d{10})$");
		Matcher m = p.matcher(activePhone);
		boolean isPhone = m.matches();
		String cfm_login="";
		String old_sn="";
		String cfm_name="";
		String oldsnStr="";
		String idType="";
		String idNum="";
		String jine="";
		
		if(!isPhone){
			String queryCfmlogin[] = new String[2];
			queryCfmlogin[0] = "select cfm_login from dbroadbandmsg where phone_no=:phone_no";
			queryCfmlogin[1] = "phone_no="+activePhone;
			%>
			<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsg1" retcode="retCode1" routerKey="regionCode" routerValue="<%=regionCode%>">
				<wtc:param value="<%=queryCfmlogin[0]%>" />
				<wtc:param value="<%=queryCfmlogin[1]%>" />
			</wtc:service>
			<wtc:array id="result11" scope="end"/>
			<%
			if("000000".equals(retCode1)){
				cfm_login=result11[0][0];
				String  inputParsm [] = new String[7];
				inputParsm[0] =	"";
				inputParsm[1] =	"01";
				inputParsm[2] =	opCode;
				inputParsm[3] =	loginNo;
				inputParsm[4] =	noPass;
				inputParsm[5] =	activePhone;
				inputParsm[6] =	"";
				
				%>
				<wtc:service name="sM432Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
					<wtc:param value="<%=inputParsm[0]%>"/>
					<wtc:param value="<%=inputParsm[1]%>"/>
					<wtc:param value="<%=inputParsm[2]%>"/>
					<wtc:param value="<%=inputParsm[3]%>"/>
					<wtc:param value="<%=inputParsm[4]%>"/>
					<wtc:param value="<%=inputParsm[5]%>"/>
					<wtc:param value="<%=inputParsm[6]%>"/>
				</wtc:service>
				
				<wtc:array id="result_t1" scope="end" start="0"  length="6"  />
				<wtc:array id="result_t2" scope="end" start="1"  length="1" />
				<wtc:array id="result_t3" scope="end" start="3"  length="1" />
				<wtc:array id="result_t4" scope="end" start="4"  length="1" />
				<%
				//System.out.println("length------liangyl:"+sm432qryResult.length);
				if("000000".equals(retCode)){
					for(int iii=0;iii<result_t1.length;iii++){
						oldsnStr+="<option value='"+result_t1[iii][0]+"' jine='"+result_t1[iii][2]+"' liushui='"+result_t1[iii][5]+"'>"+result_t1[iii][0]+"</option>";
					}
					cfm_name=result_t2[0][0];
					idType=result_t3[0][0];
					idNum=result_t4[0][0];
					
					if(idType.equals("0")){
						idType="身份证";
					}
					else if(idType.equals("1")){
						idType="军官证";
					}
					else if(idType.equals("2")){
						idType="户口簿";
					}
					else if(idType.equals("3")){
						idType="港澳通行证 ";
					}
					else if(idType.equals("4")){
						idType="警官证";
					}
					else if(idType.equals("5")){
						idType="台湾通行";
					}
					else if(idType.equals("6")){
						idType="外国公民护照";
					}
					else if(idType.equals("7")){
						idType="其它";
					}
					else if(idType.equals("8")){
						idType="营业执照";
					}
					else if(idType.equals("9")){
						idType="护照";
					}
					else if(idType.equals("A")){
						idType="组织机构代码";
					}
					else if(idType.equals("B")){
						idType="单位法人证书";
					}
					else if(idType.equals("C")){
						idType="介绍信";
					}
					else{
						idType="身份证";
					}

					//old_sn = sm432qryResult[0][0];
				}
				else{
					old_sn="";
					%>
					<script language="javascript">
						rdShowMessageDialog("错误代码:<%=retCode%>,错误信息:<%=retMsg%>",0);
						removeCurrentTab();
					</script>
					<%
				}
			}
			
			else{
				cfm_login="";
			}
			
		}
		else{
			cfm_login="";
		}
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
	if("<%=cfm_login%>"==""){
		rdShowMessageDialog("请输入宽带账号或209号码查询！",0);
		removeCurrentTab();
	}
	oldSnChange();
});
var jine="";
var liushui="";
function doCommit(){
	if($("#oldSn").val().trim().length == 0){
		rdShowMessageDialog("故障ONT不能为空！",0);
		return false;
	}
	if($("#newSn").val().trim().length == 0){
		rdShowMessageDialog("请扫描新ONT！",0);
		return false;
	}
	var userType=$("#userType").val();
	var isCheck=false;
	if(userType=="1"){
		if($("#zhuangjiNum").val().length == 0){
			rdShowMessageDialog("装维人工号代码不能为空！",0);
			isCheck=true;
			return false;
		}
		
		if($("#zhuangjiPhone").val().length==0){
			rdShowMessageDialog("装维手机号码不能为空！",0);
			isCheck=true;
			return false;
		}
		
		if($("#zhuangjiSn").val().length == 0){
			rdShowMessageDialog("替换ONT不能为空！",0);
			isCheck=true;
			return false;
		}
	}
	if(isCheck){
		return false;
	}
	
	var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
	if($("#userType").val()=="0"){
		sm432_show_Bill_Prt();
	}
	
	if(rdShowConfirmDialog('确认要提交宽带设备更换信息吗？')==1) {
		submitCfm();
	}
}

function showPrtDlg(printType, DlgMessage, submitCfn){//显示打印对话框 
	var h=210;
	var w=400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var opCode="m432";
	var pType="subprint";
	var billType="1";
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var sysAccept = "<%=sysAcceptl%>";
    var printStr = printInfo(printType);
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
}

//打印免填单
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
		cust_info += "客户姓名：<%=cfm_name%> |";
		
		opr_info += "故障ONT：" + $("#oldSn").val()+ "|";
		opr_info += "新领ONT：" + $("#newSn").val()+ "|";
		if($("#userType").val()=="1"){
			opr_info += "替换ONT：" + $("#zhuangjiSn").val()+ "|";
			opr_info += "装维人工号代码：" + $("#zhuangjiNum").val()+ "|";
			opr_info += "装维手机号码：" + $("#zhuangjiPhone").val()+ "|";
		}
		opr_info += "业务名称：宽带设备更换|";
		opr_info += "操作流水：" + <%=sysAcceptl%> + "|";
		
		note_info1 += "备注：" + "|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	}
    return retInfo;
}

//打印发票
function sm432_show_Bill_Prt(){
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=loginNo%>");     //工号
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","客户名称");   //客户名称
	$(billArgsObj).attr("10006","宽带设备更换");    //业务类别
	
	$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
	$(billArgsObj).attr("10015", jine);   //本次发票金额
	$(billArgsObj).attr("10016", jine);   //大写金额合计
	$(billArgsObj).attr("10017",jine);        //本次缴费：现金
	/*10028 10029 不打印*/
	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
	$(billArgsObj).attr("10029","");	 //营销代码	
	$(billArgsObj).attr("10030","<%=sysAcceptl%>");   //流水号：--业务流水
	$(billArgsObj).attr("10036","m432");   //操作代码
	/**/
	/*型号不打*/
	$(billArgsObj).attr("10061","");	       //型号
	$(billArgsObj).attr("10062","");	//税率
	$(billArgsObj).attr("10063","");	//税额	   
  	$(billArgsObj).attr("10071","6");	//
	$(billArgsObj).attr("10076",jine);	//大写金额合计
		
	$(billArgsObj).attr("10083","<%=idType%>"); //证件类型
	$(billArgsObj).attr("10084","<%=idNum%>"); //证件号码
	$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。"); //备注
	$(billArgsObj).attr("10065", "<%=cfm_login%>"); //宽带账号
	$(billArgsObj).attr("10087", "000000"); //imei号码
	
	$(billArgsObj).attr("10041", "宽带设备更换");           //品名规格
	$(billArgsObj).attr("10042","台");                   //单位
	$(billArgsObj).attr("10043","1");	                   //数量
	$(billArgsObj).attr("10044",jine);	                //单价
	 			
	$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
	$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票
	$(billArgsObj).attr("10088","m432"); //收据模块
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
//	$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
//	var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";
	var loginAccept = "<%=sysAcceptl%>";
	var path = path +"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);		

} 

/**********页面的提交***************/
function submitCfm(){	
	var myPacket = new AJAXPacket("fm432Cfm.jsp", "正在提交，请稍候......");
	var iLoginAccept = "<%=sysAcceptl%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo ="<%=activePhone%>";
	var iUserPwd = "";
	
	myPacket.data.add("iLoginAccept",iLoginAccept);
	myPacket.data.add("iChnSource",iChnSource);
	myPacket.data.add("iOpCode",iOpCode);
	myPacket.data.add("iLoginNo",iLoginNo);
	myPacket.data.add("iLoginPwd",iLoginPwd);
	myPacket.data.add("iPhoneNo",iPhoneNo);
	myPacket.data.add("iUserPwd",iUserPwd);
	
	myPacket.data.add("userType", $("#userType").val());
	myPacket.data.add("oldSn",$("#oldSn").val().trim());
	myPacket.data.add("newSn", $("#newSn").val().trim());
	myPacket.data.add("zhuangjiNum", $("#zhuangjiNum").val()); 
	myPacket.data.add("zhuangjiSn", $("#zhuangjiSn").val());
	myPacket.data.add("kuandaiNum",$("#kuandaiNum").val());
	
	myPacket.data.add("liushui",liushui);
	myPacket.data.add("jine",jine);
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
function checkuserType(){
	var userType=$("#userType").val();
	if(userType=="1"){
		$("#zhuangweiShow").show();
	}
	else{
		$("#zhuangweiShow").hide();
	}
}
function oldSnChange(){
	jine=$("#oldSn option:selected").attr("jine");
	liushui=$("#oldSn option:selected").attr("liushui");
}

function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree2.jsp?grpType=f1";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

	</script>
</head>
<body>
	<form action="" method="post" id="f1" name="f1">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<table>
			<tr>
				<td width="8%" class="blue" align="center">宽带账号</td>
				<td width="25%">
					<input type="text" id="kuandaiNum" name="kuandaiNum" value="<%=cfm_login%>" maxlength="15" readonly="readonly"/>
				</td>
				<td width="8%" class="blue" align="center">用户类型</td>
				<td width="25%">
					<select id="userType" name="userType" onchange="checkuserType()">
						<option value="0">个人用户</option>
						<option value="1">装维人员</option>
					</select>
				</td>
				<td width="8%"></td>
				<td width="25%"></td>
			</tr>
			<tr>
				<td class="blue" align="center">宽带终端</td>
				<td>
					<select name="kdZd" id="kdZd">
						<option value="ONT">ONT</option>
					</select>
					<font class="orange">*</font>
				</td>
				<td class="blue" align="center">故障ONT</td>
				<td>
					<select  name="oldSn" id="oldSn" style="width: 150px" onchange="oldSnChange()">
						<%=oldsnStr%>
					</select>
				</td>
				<td class="blue" align="center">新领ONT</td>
				<td>
					<input type="text" name="newSn" id="newSn" maxlength="30" value="" size="35" v_must ="1" v_type="" class='required'/>
					<font class="orange">*</font>
				</td>
			</tr>
			<tr id="zhuangweiShow" style="display:none">
				<td class="blue" align="center">装维人工号代码</td>
				<td>
					<input type="text" name="groupName" id="zhuangjiName" maxlength="30" value="" v_must ="1" v_type="" readonly="readonly" class='InputGrey' onclick="showMenu();"/>
					<input type="hidden" name="groupId" id="zhuangjiNum" maxlength="30" value="" v_must ="1" v_type="" class='required'/>
					
					
					<input name="addButton" class="b_text"  type="button" value="选择" onClick="select_groupId()" >
					<font class="orange">*</font>
				</td>
				<td class="blue" align="center">装维手机号码</td>
				<td>
					<input type="text" name="zhuangjiPhone" id="zhuangjiPhone" maxlength="15" value="" size="35" v_must ="1" v_type="" class='required'/>
					<font class="orange">*</font>
				</td>
				<td class="blue" align="center">替换ONT</td>
				<td>
					<input type="text" name="zhuangjiSn" id="zhuangjiSn" maxlength="30" value="" size="35" v_must ="1" v_type="" class='required'/>
					<font class="orange">*</font>
				</td>
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