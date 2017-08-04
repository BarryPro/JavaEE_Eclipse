<%
    /********************
     version v2.0
     开发商: si-tech
     sim卡激活主界面
     gaopeng 20130107
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
		
			//String opCode = (String)request.getParameter("opCode");		
			//String opName = (String)request.getParameter("opName");
			String opCode = "g412";
		String opName = "异地单卡写卡";
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    String[][] pass = (String[][])arrSession.get(4);
	    
	    String loginNo = baseInfoSession[0][2];
	    String loginName = baseInfoSession[0][3];
	    String powerCode= otherInfoSession[0][4];
	    String orgCode = baseInfoSession[0][16];
	    String ip_Addr = request.getRemoteAddr();
	    
	    String regionCode = orgCode.substring(0,2);
	    String regionName = otherInfoSession[0][5];
	    String loginNoPass = pass[0][0];
	    
	    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
	    //流水号
 			String PrintAccept = getMaxAccept();
 			String power_right = (String)session.getAttribute("power_code");
	//进行工号权限检验
	
	    String v_custPWD=request.getParameter("custPWD");//客户密码
	    String v_cardID=request.getParameter("cardID"); //证件号码
      String v_cardType=request.getParameter("cardType"); //证件类型	    
%>

<%
	//List al = null;

	String[][] cardTypeData = new String[][]{};
	String[][] vipCodeData = new String[][]{};
	
	String totalDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String tmpCurDate = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

	
	int		isGetDataFlag = 0;	//0:正确,其他错误. add by yl.
	String errorMsg ="";	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
	
	//1.SQL 证件类型
	insql.delete(0,insql.length());
	insql.append("select trim(ID_TYPENEW),trim(ID_TYPENEW)||'-->'||TYPE_NAME from oneboss.sOBIdTypeConvert  ");
	insql.append(" order by ID_TYPENEW ");
		String sql = insql.toString();
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sql%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		<%		
	//al = oneboss.getCommONESQL(regionCode,insql.toString(),2,0);
	if( result.length<=0 ){
		isGetDataFlag = 2;
		break dataLabel;
	}		
	//cardTypeData = result111;

	//2.SQL 
	insql.delete(0,insql.length());
	insql.append("select SRVLEVEL,SRVCODE,ITEMCODE,trim(ITEMNAME) from oneboss.sVipSrvCode  ");
	insql.append(" order by SRVLEVEL,SRVCODE,ITEMCODE ");
	String osql=insql.toString();
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=osql%>"/>
		</wtc:service>
		<wtc:array id="result111" scope="end"/>
		<%		
	//al = oneboss.getCommONESQL(regionCode,insql.toString(),4,0);
	if( result111.length<=0  ){
		isGetDataFlag = 2;
		break dataLabel;
	}			
	vipCodeData = result111;	
	
	isGetDataFlag = 0;
  break;
 }	

	 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    
	 //MyLog.debugLog(errorMsg);
	 
	 String phone_no=request.getParameter("phone");
	String prov=request.getParameter("prov");
	String sSimNo=request.getParameter("sSimNo");
	String sImsiNo=request.getParameter("sImsiNo"); 
	//MyLog.debugLog("yidisimkajihuo");
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<html>
<head>
<title>异地SIM卡激活</title>


<script language="JavaScript">
	onload=function()
	{		
		init();
    $("#cardType option").each(function(){
      //alert( $(this).val());
      if($(this).val()=="<%=v_cardType%>"){
        $(this).attr("selected","true");
      }
    });
	}
	function init()
	{	  		  
		$("#test").hide();
<%
	
		String power_code = (String)session.getAttribute("power_code");
		String test_sql="select a.oregtype from oneboss.DOBTRANSREGMSG a,oneboss.sobopercode b where a.bipcode=b.oper_code and b.function_code='4228' and b.oper_code='BIP2B005'";
		//String oregtype=SqlFunction.findString(test_sql);
	%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=test_sql%>"/>
		</wtc:service>
		<wtc:array id="result22" scope="end"/>
		<%	
		if(result22.length>0){
		   if(result22[0][0].equals("11")) {
			if(power_right!=null&&power_right.trim().equals("3")){
%>
				//alert(2);
				$("#test").hide();
				document.all("test_flag").length=2;
				document.all("test_flag").options[0].text="正式";
				document.all("test_flag").options[0].value="0";
				document.all("test_flag").options[1].text="测试";
				document.all("test_flag").options[1].value="1";
<%
			}
			else{
%>
				//alert(1);
				$("#test").hide();
				document.frm.test_flag.length=1;
				document.frm.test_flag.options[0].text="正式";
				document.frm.test_flag.options[0].value="0";
<%			
			
			}
			}
		}
%>	
		document.frm.confirm.disabled = true;		
		document.frm.phoneNo.focus();		
	}
	
	//---------1------RPC处理函数------------------
	function doProcess(packet){
		//使用RPC的时候,以下三个变量作为标准使用.
		error_code = packet.data.findValueByName("errorCode");
		error_msg =  packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
		//backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		//gaopeng 加入客户地址 20130116
		document.all.UserAdd.value=backArrMsg[0][15];
		//gaopeng 加入用户品牌 20130116
		document.all.Brand.value=backArrMsg[0][19];
		//gaopeng 加入用户流水 20130116
		document.all.procID.value=backArrMsg[0][22];
		//gaopeng 加入是否vip 20130116
		document.all.ifVIP.value=backArrMsg[0][24];
		
		//self.status="";

		if(verifyType=="phoneno"){
			if( parseInt(error_code) == 0 ){ 

			  if( backArrMsg.length > 0 ){
				document.frm.tmpBusyAccept.value = backArrMsg[0][22];
				
			  }
			  
			  for(var i=0; i<backArrMsg.length ; i++){
				/*if(backArrMsg1[i][0] == "115"){

					if( backArrMsg1[i][1] != "301" && backArrMsg1[i][1] != "302"){
						rdShowMessageDialog("不是金卡大客户,不能进行操作!!");
						return false;
					}else{
						document.frm.computeTotal.disabled = false;
					}
				}
							  
				if(backArrMsg1[i][0] == "116"){

					//add by jy for debug 20050525
					if( backArrMsg1[i][1] != "1"){
						rdShowMessageDialog("不是VIP用户,不能进行操作!!");
						return false;
					}
					else{
						document.frm.computeTotal.disabled = false;
					}
				}*/

        /*增加SIM卡费开始*/
				//if(backArrMsg1[i][0] == "116"){

					//add by jy for debug 20050525
					//if( backArrMsg1[i][1] != "1"){
					if(document.all.ifVIP.value=='1'){
						document.frm.simFee.value="0.00";
					}
					else
						{
							document.frm.simFee.value="15.00";
						}
					//}
					//else{
					//	document.frm.simFee.value="0.00";
					//}
				//}
				/*增加SIM卡费结束*/
				
				//if(backArrMsg1[i][0] == "101") {
					document.frm.custName.value = backArrMsg[i][14];
				//}
				//if(backArrMsg1[i][0] == "117") 
				document.frm.vipNo.value = backArrMsg[i][23];
				document.frm.confirm.disabled = false;
							  	
			  }
			  
			}else{
				rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]");
				return false;
			}
		
		}
						
	}

		function call_noCheck()
	{
		//alert(1);
 		var sqlBuf="";
		//检查数据的合法性
	 	
	 	if(!checkElement(document.getElementById("phoneNo"))){ 
	 		return false;
	 	}
	 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )
	 	  ){
	 	  	rdShowMessageDialog("必须输入'客户密码'或者'证件号码'中的一个！");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
	 	}  
	 	if( document.frm.cardID.value != "" ){
			if(document.frm.cardType.value=="00"){
			document.frm.cardID.v_type="";
			}
			else{
			document.frm.cardID.v_type="";
			}
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 	} 
		
			var myPacket = new AJAXPacket("s4226_rpc_id.jsp","正在确认，请稍候......");              		
			myPacket.data.add("verifyType","phoneno");
			myPacket.data.add("guid",document.frm.guid.value);
			myPacket.data.add("loginNo",document.frm.loginNo.value);
			myPacket.data.add("orgCode",document.frm.orgCode.value);
			myPacket.data.add("opCode","4150");
			myPacket.data.add("totalDate",document.frm.totalDate.value);
			myPacket.data.add("IDType",document.frm.IDType.value);
			myPacket.data.add("phoneNo",document.frm.phoneNo.value);
			myPacket.data.add("custPWD",document.frm.custPWD.value);
			myPacket.data.add("cardType",document.frm.cardType.value);
			myPacket.data.add("cardID",document.frm.cardID.value);
			myPacket.data.add("qryType","0");//查询类型
			myPacket.data.add("beginTime","");//查询开始时间
			myPacket.data.add("endTime","");//查询结束时间
			myPacket.data.add("businessCode","BIP2B006");//
			myPacket.data.add("test_flag",document.frm.test_flag.value);
			
			core.ajax.sendPacket(myPacket);
      myPacket = null;
	}	
	
	function doValid()
	{

		with(document.frm)
		{
						
		}
		
		return true;
	}
	
	function judge_valid()
	{
	var flag=0;
	
		//1.检查单独的域
	 	if( !doValid() ) return false;
	 	
	 	if(!checkElement(document.getElementById("phoneNo"))) return false;
	 	if(!checkElement(document.getElementById("iccid"))) return false;	 		 	
	 	if(!checkElement(document.getElementById("imsi"))) return false;	 
	 	if(!checkElement(document.getElementById("handFee"))) return false;	 
	 		 		 	
	 	if( (document.frm.custPWD.value == "" )
	 		&& (document.frm.cardID.value == "" )){
	 	  	rdShowMessageDialog("必须输入'客户密码'或者'证件号码'中的一个！");
	 	  	return false;	 	  
	 	  }
	 	
	 	if( document.frm.custPWD.value != "" ){
	 		if(!checkElement(document.getElementById("custPWD"))) return false;
	 	}  
	 	if( document.frm.cardID.value != "" ){
	 		if(!checkElement(document.getElementById("cardID"))) return false;
	 	} 

		return true;
	}

	function resetJsp()
	{
	 with(document.frm)
	 {

		phoneNo.value	= "";
		custPWD.value	= "";
		cardID.value	= "";
		iccid.value	= "";
		imsi.value	= "";
		handFee.value	= "";
				
	 }
	 
		init();	
			
	}
			
	function commitJsp()
	{
		//alert(1);
		if( !judge_valid() )
		{
			return false;
		}
		//alert(2);
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
 		
	}
	
	/*2014/04/04 11:02:20 gaopeng 校验sim卡费*/
	function s6004CheckFunc(){
			var getdataPacket = new AJAXPacket("/npage/s4000/s6004Check.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("simFee",parseFloat(document.all.simFee.value));
			core.ajax.sendPacket(getdataPacket,dos6004CheckBack);
			getdataPacket = null;
	}
	var passflag = false;
	function dos6004CheckBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		
		if(retCode == "000000"){
			$("#ifDLS").val("1");
			passflag = true;
		}else if(retCode == "PE0013"){
			$("#ifDLS").val("0");
			passflag = true;
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			$("#ifDLS").val("0");
			passflag = false;
		}
	}
	
	
	function conf(){
		
		s6004CheckFunc();
		if(passflag){
		document.frm.opCode.value="<%=opCode%>";	

		document.frm.opNote.value =  "异地SIM卡激活  " + ",手机号码:"+document.all.phoneNo.value;

		document.frm.confirm.disabled = true;
		
		page = "s4244Cfm.jsp";
		frm.action=page;
		frm.method="post";
	  frm.submit();	
		}  		
	}
	
function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	  //alert(3);
			var h=180;
				var w=350;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				
				var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
				var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
				var sysAccept ="<%=PrintAccept%>";
				var printStr =  printInfo(printType);
				var mode_code=null;           							//资费代码
				var fav_code=null;                				 		//特服代码
				var area_code=null;             				 		//小区代码
				var opCode="<%=opCode%>" ;                   			 		//操作代码
				var phoneNo=document.all.phoneNo.value;                  	 		//客户电话
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";  
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
				path+="&mode_code="+mode_code+
					"&fav_code="+fav_code+"&area_code="+area_code+
					"&opCode="+opCode+"&sysAccept="+sysAccept+
					"&phoneNo="+phoneNo+
					"&submitCfm="+submitCfm+"&pType="+
					pType+"&billType="+billType+ "&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('确认电子免填单吗？')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('确认要提交<%=opName%>信息吗？')==1)
				{
					 conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('确认要提交<%=opName%>信息吗？')==1)
			{
				conf();
			}
		}
	 
	}
	
	function printInfo(printType)
{
  var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";

	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.custName.value+"|";
	cust_info+="客户地址："+document.all.UserAdd.value+"|";
	cust_info+="证件号码："+document.all.cardID.value+"|";
//01：全球通；02：神州行；03：动感地带；09：其他品牌
  var brand = document.all.Brand.value;
  var brandname = "";
  if(brand=="01")
  {
  	brandname="全球通";
  }
  if(brand=="02")
  {
  	brandname="神州行";
  }
  if(brand=="03")
  {
  	brandname="动感地带";
  }
  if(brand=="09")
  {
  	brandname="其他品牌";
  }
	opr_info+="用户品牌："+brandname+"  办理业务:跨区补卡"+"|";
	opr_info+="操作流水："+"<%=PrintAccept%>"+"  SIM卡费："+parseFloat(document.all.simFee.value)+"|";
	
	note_info1="备注："+"跨区补卡后3天内（不包括办理当天）暂不能办理查询详单、兑换积分、过户业务。如因客户提供的身份证件不真实而产生争议的，我公司有权对号码进行重新处置。|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	//retInfo+="哈尔滨地区用户自SIM卡售出日起30天内，由于非人为原因引起的SIM卡损坏或因机卡配合"+"|";
	//retInfo+="引起的SIM无法使用，我公司可为您免费补卡。"+"|";
    return retInfo;
}

	
	
//-->
</script>


</head>


<body >
<form name="frm" method="post" >

 			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">异地SIM卡激活</div>
			</div>    

        <table >

		  <tr  id="test" style="display:none"> 
            <td  class="blue">开通方式</td>
            <td colspan="3">
				<select name="test_flag" id="test_flag">
					<option value='0'>正式</option>
				</select>
			</td>
		  </tr>
          <tr > 
            <td  class="blue">客户标识类型</td>
            <td><select name="IDType" id="IDType">
                <option value="01">01--&gt;手机号码</option>
              </select></td>
            <td  class="blue">客户标识</td>
            <td><input name="phoneNo" type="text" class="button" id="phoneNo" index="1" maxlength="11" v_must=1 v_type="mobphone" v_minlength=11  value="<%=(phone_no==null)?"":phone_no%>"  v_name="手机号码"> 
               <font class='orange'>*</font></td>
          </tr>
          <tr > 
            <td  class="blue">客户密码</td>
            <td colspan="3"><input name="custPWD" type="password" class="button" index="2" id="custPWD" maxlength="8" v_must=1 v_type=0_9 v_minlength=1  v_name="客户密码" value="<%=v_custPWD%>" />
           <font class='orange'>*(客户密码和证件号码二选一)</font></td>
          </tr>
          <tr > 
            <td class="blue">证件类型</td>
            <td ><select name="cardType" id="cardType">
                <option value="00">00--&gt;身份证</option>
                <option value="01">01--&gt;VIP卡</option>
                <option value="02">02--&gt;护照</option>
                <option value="04">04--&gt;军官证</option>
                <option value="05">05--&gt;武装警察身份证</option>
                <option value="99">99--&gt;其它</option>
              </select></td>
            <td class="blue">证件号码</td>
            <td><input name="cardID" type="text" class="button" id="cardID" index="3" maxlength="20" v_must=1 v_type=0_9 v_minlength=1  v_name="证件号码" value="<%=v_cardID%>" /> 
              <font class='orange'>*</font>
              <input name="noCheck" type="button" class="b_text" id="noCheck" index="4" value="验证" onClick="call_noCheck()"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">客户姓名</td>
            <td><input name="custName" type="text" class="button" id="custName"  ></td>
            <td class="blue">VIP卡号</td>
            <td><input name="vipNo" type="text" class="button" id="vipNo" disabled></td>
          </tr>
	      <input name="custName1" type="hidden" class="button" id="custName1" >
          <tr > 
            <td class="blue">IMSI</td>
            <td><input name="imsi" type="text" class="button" id="imsi" index="7" maxlength="15" v_must=1 v_type="string" v_minlength=15  v_name="IMSI" value="<%=(sImsiNo==null)?"":sImsiNo%>">
               <font class='orange'>*</font></td>
            <td class="blue">ICCID</td>
            <td><input name="iccid" type="text" class="button" id="iccid" index="6" maxlength="20" v_must=1 v_type="string" v_minlength=20  v_name="ICCID"  value="<%=(sSimNo==null)?"":sSimNo%>">
              <font class='orange'>*</font></td>
          </tr>
          <tr >           
            <td class='orange'>手续费</td>
            <td><input name="handFee" type="text" class="button" id="handFee" index="8" maxlength="12" value=0 v_must=1 v_type="float" v_minlength=1  v_name="手续费" readonly>
              <font class='orange'>*</font></td>

             <td class='orange'>SIM卡费</td>
            <td><input name="simFee" type="text" class="button" id="simFee" maxlength="9" v_type=cfloat v_maxlength=9 v_name="SIM卡费" >  <font color="#FF0000" colspan="3">*大客户卡费为0</font></td>
            <td></td>
          </tr>          
          <tr > 
            <td class='orange'>操作备注</td>
            <td height="32" colspan="3"> <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60"> 
            </td>
          </tr>
          <tr>
          	<td class="blue">备注</td>
          	 <td colspan="3"><font color="red">若同一个号码当天办理失败超过6次，此号码当天不再允许办理!</font></td>
          </tr>
          <tr > 
            <td colspan="4" id="footer" class="blue" align='center'> 
                <input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">
                &nbsp; 
                <input name="reset" type="button" class="b_foot" value="清除" onClick="resetJsp()">
                </td>
          </tr>
        </table>


	<input type="hidden" name="guid" id="guid" value="<%=loginNo%>">
  <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  <input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>">	
  <input type="hidden" name="loginName" id="loginName" value="">
  <input type="hidden" name="opCode" id="opCode" value="">
  <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
  <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">                                                                 
  <input type="hidden" name="totalDate" id="totalDate" value="<%=totalDate%>">                                                              
  <input type="hidden" name="tmpBusyAccept" id="tmpBusyAccept" value="">   	
	<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value=""> 	
	<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value="">	
	<input name="opType" type="hidden" class="button" id="opType" value="异地SIM卡激活">
	<!-- 是否代理商  1是 0否 不是代理商则不用调用扣费功能-->
	<input name="ifDLS" type="hidden"  id="ifDLS" value="1">
	<!--客户地址-->
	<input name="UserAdd" type="hidden" value=""/>
	<!--用户品牌-->
	<input name="Brand" type="hidden" value=""/>
	<!--用户流水(免填单用)-->
	<input name="procID" type="hidden" value=""/>
	<!--是否vip-->
	<input name="ifVIP" type="hidden" value=""/>
		<%@ include file="/npage/include/footer.jsp" %>		
</form>
</body>
</html>
