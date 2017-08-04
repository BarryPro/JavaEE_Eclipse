<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 彩铃信息费业务受理1465
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
  response.setDateHeader("Expires", 0);
%>
<%		
	String opCode="1465";
	String opName="彩铃信息费业务受理";
	String phoneNo =(String)request.getParameter("phoneNo");
	String loginNo = (String)session.getAttribute("workNo");			//工号
	String loginName = (String)session.getAttribute("workName");		//工名
	String ip_Addr = (String)session.getAttribute("ipAddr");  		//IP地址
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
%>
<%
  	String retFlag="";//用于判断页面刚进入时的正确性
//  SPubCallSvrImpl impl = new SPubCallSvrImpl();
//  ArrayList retList = new ArrayList();
 
	String strUserPassword = "";
	String func_type = request.getParameter("func_type");
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
	String passFromPage = contactInfo.getPasswdVal (2);
	System.out.println("passFromPage====================="+passFromPage);
	String[] paraAray1 = new String[5];
	paraAray1[0] = loginNo;					/* 登录工号*/ 
	paraAray1[1] = passFromPage; 			/*用户密码   */
	paraAray1[2] = "1465";	    			/*操作代码*/
	paraAray1[3] = phoneNo;	    			/*手机号码*/
	paraAray1[4] = func_type;	    		/*彩铃功能类型*/
  
	for(int i=0; i<paraAray1.length; i++){		
	if( paraAray1[i] == null ){
			paraAray1[i] = "";
		}
	}
//	retList = impl.callFXService("s5510Init", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s5510Init" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String  phone_no="";	/*手机号码*/
	String  user_name="";	/*用户姓名*/
	String  run_type="";	/*用户状态*/  
	String  sm_name="";	/*用户品牌*/   
	String  id_type="";	/*证件类型*/  
	String  id_name="";	/*证件号码*/ 
	String  prepayfee="";	/*预存款*/   
	String  unpayfee="";	/*未出帐话费*/  
  
  String sm_code="",family_code="",rate_code="",bigCust_flag="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="",contract_flag="",high_flag="";
//  String[][] tempArr= new String[][]{};
	String errCode = retCode;
	String errMsg = retMsg;

  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s5510Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null)){
  	System.out.println("errCode                          ="+errCode);
	if (errCode.equals("000000") ){
	    phone_no = tempArr[0][0];					//手机号码
	    user_name = tempArr[0][3];					//用户姓名
	    run_type = tempArr[0][2];					//用户状态
	    sm_name = tempArr[0][1];					//用户品牌
	    id_type = tempArr[0][4];					//证件类型
	    id_name = tempArr[0][5];					//证件号码
	    prepayfee = tempArr[0][6];					//预存款
	    unpayfee = tempArr[0][7];					//未出帐话费
	    strUserPassword = tempArr[0][8];			//用户密码
	  }	  	  	
      else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1460Init查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s1460Init查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
	System.out.println("retFlag==========================================="+retFlag);
	if(retFlag.equals("1"))
	{
    %>
			<script language="JavaScript">
				rdShowMessageDialog(retMsg,0);
				history.go(-1);
			</script>
      <%
      }
  String handFee_Favourable = "readonly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
 
//******************得到下拉框数据***************************//
//  comImpl co=new comImpl();
  //机器类型 
//  String sqlMachineType  = "";  
//  sqlMachineType  = "select machine_type ,flag from sPrepaySendMarkCode where region_code='"+ regionCode +"' and op_code='1460'" ;
//  System.out.println("sqlMachineType==" + sqlMachineType);
//  ArrayList machineTypeArr  = co.spubqry32("2",sqlMachineType );
 // String[][] machineTypeStr  = (String[][])machineTypeArr.get(0);
  //方案代码 
//  String sqlOrderCode  = "";  
//  sqlOrderCode  = "select a.order_code||'~'||a.prepay_fee||'~'||a.base_fee||'~'||a.free_fee||'~'||a.consume_term||'~'||a.mon_base_fee||'~'||a.mode_code||'~'||a.machine_fee||'~'||nvl(b.flag_code,'xxxx'),  a.order_code||'~'||a.order_name,a.machine_type,a.flag  from sMachOrderCode a, (select region_code,mode_code,flag_code from sModeFlagCode where region_code='"+regionCode+"' and op_code='1460') b  where a.region_code='"+regionCode +"' and a.op_code='1460' and (a.flag='9' or (a.flag='0' and a.mode_code in (select new_mode from cBillBbChg where op_code='1460' and old_mode='"+rate_code+"' and region_code='"+regionCode+"'))  ) and  a.mode_code=b.mode_code(+) order by a.flag,a.machine_type,a.order_code";
//  System.out.println("sqlOrderCode==" + sqlOrderCode);
//  ArrayList orderCodeArr  = co.spubqry32("4",sqlOrderCode );
//  String[][] orderCodeStr  = (String[][])orderCodeArr.get(0);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>彩铃业务受理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

   onload=function()
  {		
	 	
  } 

  //---------1------RPC处理函数------------------
  function doProcess(packet){
	//使用RPC的时候,以下三个变量作为标准使用.
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	var flag_code =  packet.data.findValueByName("flag_code");
	var flag_code_name =  packet.data.findValueByName("flag_code_name");
	var rate_code =  packet.data.findValueByName("rate_code");
	self.status="";
	if(verifyType=="confirm"){
	  if( parseInt(errorCode) == 0 ){
		 //rdShowMessageDialog("信息返回，请确认!");
		 document.frm.flag_code.value=flag_code;
		 document.frm.flag_code_name.value=flag_code_name;
		 document.frm.rate_code.value=rate_code;
	  }else{
			rdShowMessageDialog("<br>错误代码："+errorCode+"</br>错误信息："+errorMsg);
			location="/bill/f1465.jsp";
			//return false;
	  }		
    }				
  }
  /**************/
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check()
  {
 	with(document.frm)
	{
	}
	return true;
  }


  function printCommitTwo(subButton){

	//校验
	if(!check()) 
	{
	 //   document.frm.next.disabled=false;
        return false;
	}
	setOpNote();//为备注赋值
	frm.action = "f1465Confirm_1.jsp";
    //打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
        {
          document.all.printcount.value="1";
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
          document.all.printcount.value="0";
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       { 
       	 document.all.printcount.value="0";
	     frmCfm();
       }
    }	
	return true;
  }

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="1465" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;   
  }

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
  	cust_info+="客户姓名："+document.all.user_name.value+"|";
	cust_info+="手机号码："+document.frm.phoneNo.value+"|";
	cust_info+="客户品牌："+document.frm.sm_name.value+"|";
  	cust_info+="证件类型：: "+document.frm.id_type.value+"|";
  	cust_info+="证件号码：: "+document.frm.id_name.value+"|";
	
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.sm_name.value+ "|";

	if ("01" == document.frm.func_type.value){      
  	opr_info+="办理业务："+"彩铃功能"+"  操作流水："+'<%=printAccept%>'+"|";
  }else if ("02" == document.frm.func_type.value){  
  	opr_info+="办理业务："+"2元彩铃信息费包月"+"  操作流水："+'<%=printAccept%>'+"|";
	}else if ("03" == document.frm.func_type.value){
		opr_info+="办理业务："+"12元彩铃信息费包年"+"  操作流水："+'<%=printAccept%>'+"|";
	}else if ("04" == document.frm.func_type.value){
		opr_info+="办理业务："+"0元彩铃包月"+"  操作流水："+'<%=printAccept%>'+"|";
	}else if ("05" == document.frm.func_type.value){
		opr_info+="办理业务："+"0元彩铃信息费"+"  操作流水："+'<%=printAccept%>'+"|";
	} 	
 
  
  if ("02" == document.frm.func_type.value||"03" == document.frm.func_type.value){
  	note_info1+="移动公司每月推荐22首彩铃铃音，当月可免费下载其中5首，5首以外按铃音正常价格收取。"+"|";
  	note_info1+="非推荐铃音按正常价格收费。"+"|";

   }
 
  
	note_info2=" "+"|";
	note_info2+="备注："+document.frm.opNote.value+"|"; 
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}


 /******为备注赋值********/
function setOpNote(){

	for(var i = 0 ; i < document.frm.r_cus.length ; i ++){
		if(document.frm.r_cus[i].checked)
		{
			if (i == 0){
				if ("01" == document.frm.func_type.value){      
  				document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"开通彩铃业务";
				}else if ("02" == document.frm.func_type.value){  
  				document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"开通2元彩铃信息费包月";
				}else if ("03" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"开通12元彩铃信息费包年";  
				}else if ("04" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"开通0元彩铃包月";  
				}else if ("05" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"开通0元彩铃信息费";  
				} 
			}else{
				if ("01" == document.frm.func_type.value){      
			  	document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"取消彩铃业务";
				}else if ("02" == document.frm.func_type.value){  
  				document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"取消2元彩铃信息费包月";
				}else if ("03" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"取消12元彩铃信息费包年";  
				}else if ("04" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"取消0元彩铃包月";  
				}else if ("05" == document.frm.func_type.value){
					document.frm.opNote.value = "手机号码"+document.frm.phoneNo.value+"取消0元彩铃信息费";  
				} 
			}
		}
	}
	
	return true;
}
//-->
</script>

</head>

<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">业务受理</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">操作类型</td>
		<td class="blue" colspan="3">
			<input type="radio" name="r_cus" index="0" value="05" checked >开通
			<input type="radio" name="r_cus" index="1" value="06" >取消  
		</td>
	</tr>
	
	<tr>
		<td class="blue">手机号码</td>
		<td class="blue">
			<input name="phone_no" type="text" class="InputGrey" id="phone_no" value="<%=phone_no%>" readonly>			  
		</td> 
		<td class="blue">用户名称</td>
		<td>
			<input name="user_name" type="text" class="InputGrey" id="user_name" value="<%=user_name%>" readonly>			  
		</td> 
	</tr>
	
	<tr>
		<td class="blue">用户状态</td>
		<td>
			<input name="run_type" type="text" class="InputGrey" id="run_type" value="<%=run_type%>" readonly>
		</td>            
		<td class="blue">品牌类型</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>			  
		</td> 
	</tr>
	
	<tr> 
		<td class="blue">证件类型</td>
		<td>
			<input name="id_type" type="text" class="InputGrey" id="id_type" value="<%=id_type%>" readonly>
		</td>            
		<td class="blue"> 证件号码</td>
		<td>
			<input name="id_name" type="text" class="InputGrey" id="id_name" value="<%=id_name%>" readonly>
		</td>
	</tr>

	<tr> 
		<td class="blue">预存款</td>
		<td>
			<input name="prepayfee" type="text" class="InputGrey" id="prepayfee" value="<%=prepayfee%>" readonly>
		</td>  
		<td class="blue">未出帐话费</td>
		<td>
			<input name="unpayfee" type="text" class="InputGrey" id="unpayfee" value="<%=unpayfee%>" readonly>
		</td>
	</tr>

	<tr> 
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" onfocus="setOpNote()"> 
		</td>
	</tr> 
          
	<tr> 
		<td colspan="4" id="footer" align="center">
			&nbsp; 
			<input name="commit" id="commit" type="button" class="b_foot" value="确认&打印" onClick="printCommitTwo(this)">
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp; 
		</td>
	</tr>
  
</table>
	  <input type="hidden" name="iOpCode">
	  <input type="hidden" name="iAddStr">
	  <input type="hidden" name="belong_code">
	  <input type="hidden" name="ip">
	  <input type="hidden" name="ipassword">
	  <input type="hidden" name="group_type">
	  <input type="hidden" name="favorcode">
	  <input type="hidden" name="maincash_no">
	  <input type="hidden" name="imain_stream">
	  <input type="hidden" name="next_main_stream">
	  <input type="hidden" name="new_rate_code">
	  <input type="hidden" name="pay_type">
	  <input type="hidden" name="flag_code_1">
	  <input type="hidden" name="order_code">
	  <input type="hidden" name="print_note" value="<%=print_note%>">
	  <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
	  <input type="hidden" name="func_type" value="<%=func_type%>">
	  <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
	  <input type="hidden" name="printAccept" value="<%=printAccept%>">
	  <input type="hidden" name="cust_info">
	  <input type="hidden" name="opr_info">
	  <input type="hidden" name="note_info1">
	  <input type="hidden" name="note_info2">
	  <input type="hidden" name="note_info3">
	  <input type="hidden" name="note_info4">
	  <input type="hidden" name="printcount">
	  <input type="hidden" name="passFromPage">
  	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language="JavaScript">
  <%if((high_flag.trim()).equals("Y")){%>
    rdShowMessageDialog('提示: 请注意,该用户为中高端用户！');
  <%}%>
</script>                       
