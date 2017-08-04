<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: "农信通"赠礼营销活动7164
   * 版本: 1.0
   * 日期: 2009/1/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%		
	String opCode=request.getParameter("opCode");	
	String opName=request.getParameter("opName");	
	String loginNo = (String)session.getAttribute("workNo");				//操作工号
	String loginName = (String)session.getAttribute("workName");			//操作工名
	String regionCode = (String)session.getAttribute("regCode");			//城市代码
	String phoneNo = request.getParameter("srv_no");						//手机号码
  	String opcode = request.getParameter("opcode");							//操作代码
  	
	String retFlag="",retMsg="";
	String passwordFromSer="";
	String[] paraAray1 = new String[3];
	paraAray1[0] = phoneNo;		/* 手机号码   */ 
	paraAray1[1] = opcode; 	    /* 操作代码   */
	paraAray1[2] = loginNo;	    /* 操作工号   */
	
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
			paraAray1[i] = "";
		}
	}
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */
%>
	<wtc:service name="s7160Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="15" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String errCode = retCode;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
  	System.out.println("retFlagaaaaaaaaaaaaaaaaaa="+retFlag);
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s7160Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	  System.out.println("errCode="+errCode);
	  System.out.println("retFlagbbbbbbbbbbbbbbbbbbbbb="+retFlag);
	  System.out.println("errMsg="+errMsg);
	  if(!errCode.equals("000000") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000") ){
	    bp_name = tempArr[0][2];//机主姓名
	    System.out.println(bp_name);
	    bp_add = tempArr[0][3];//客户地址
	    cardId_type = tempArr[0][4];//证件类型
	    cardId_no = tempArr[0][5];//证件号码
	    sm_code = tempArr[0][6];//业务品牌
	    region_name = tempArr[0][7];//归属地
	    run_name = tempArr[0][8];//当前状态
	    vip = tempArr[0][9];//ＶＩＰ级别
	    posint = tempArr[0][10];//当前积分
	    prepay_fee = tempArr[0][11];//可用预存
	    passwordFromSer = tempArr[0][12];//可用预存
	  }
	}
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<%
//******************得到下拉框数据***************************//
  //业务类型
  String sqlAgentCode = " select opr_code,opr_name,opr_money,effect_month from sSpOprCfg where op_code='"+opcode+"' and valid_flag='Y' ";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg2">
		<wtc:sql><%=sqlAgentCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeStr" scope="end" />
<%  
  //礼品类型
  String sqlGiftCode = " select gift_code,gift_name from sAwardOprCfg where op_code='"+opcode+"' and valid_flag='Y'";
  System.out.println("sqlGiftCode====="+sqlGiftCode);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode2" retmsg="retMsg3">
		<wtc:sql><%=sqlGiftCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="giftCodeStr" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>"农信通"赠礼营销活动</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
  
  var arrpapercode =new Array();
  var arrpapername=new Array();
  var arrpapermoney=new Array();
  var arrspcode=new Array();
  var arropercode=new Array();
  var arrawardcode=new Array();
  var arrawarddetailcode=new Array();
  var arrgiftcode=new Array();
  var arrconsumeterm=new Array();
  var arrservercode=new Array();
 
<%  
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][3]+"';\n");
  }  
 
%>

onload=function initLoad(){
	var op_code=<%=opcode%>;
	if(op_code=="7176"){
		document.all.type_7164.style.display="none";
		document.all.type_7176.style.display="block";
		document.all.giftcodeid.style.display="none";
		document.all.opNote.value="'大庆农信通'赠礼营销活动";
	}else{
		document.all.type_7164.style.display="block";
		document.all.type_7176.style.display="none";
		document.all.opNote.value="'农信通'赠礼营销活动";

	}
}
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***IMEI 号码校验
 
 function printCommit()
 { 
 	getAfterPrompt();
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!");
      cust_name.focus();
	  return false;
	}
	
	if(prepay_fee.value-paper_money.value<0){
		rdShowMessageDialog("预存款不够办理业务，请先缴费!");
		return false;
	}
	 }
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
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
	var opCode="7164" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phone_no.value+
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
	
	var op_code = '<%=opcode%>';
	if(op_code=="7164"){
		var opname="";
		if(document.all.op_type.value=="0"){
			opname="赠礼";
		}else{
			opname="赠话费";
		}
  
		opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
		opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		cust_info+="手机号码："+document.all.phone_no.value+"|";
		cust_info+="客户姓名："+document.all.cust_name.value+"|";
		cust_info+="客户地址："+document.all.cust_addr.value+"|";
		cust_info+="证件号码："+document.all.cardId_no.value+"|";

		opr_info+="用户品牌:"+"<%=sm_code%>" +"              业务类型：农信通"+opname+"|";
  		opr_info+="业务流水："+document.all.login_accept.value+"|";
  		if(document.all.op_type.value=="0"){
			note_info1+="礼品名称："+document.all.gift_code.options[document.all.gift_code.selectedIndex].text+"|";
		}
		opr_info+="业务操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="划转预存话费："+document.all.paper_money.value+" 元"+"|";
		opr_info+="专用预存话费期限："+document.all.consume_term.value+" 个月"+"|";

  		note_info2+="注意事项：您本次办理“农信通”业务所需费用将直接从您原有预存话费中扣除，如果您的预存话费不足请先交纳足额预存话费。您本次订购的“农信通”业务按原有梦网订购生效原则执行。本次所转费用只能冲减您本次办理的“农信通”业务所产生的费用，不能冲减其他业务所产生的费用；本次所转费用自办理业务当月算起，至第九个月末仍剩余将全部清零。本次办理的“农信通”业务提前取消，费用不退还；业务到期后请您自行取消。取消所有“农信通”业务：发送短信“00000”到12582；取消单项“农信通”业务：发送短信“0000”到12582。"+"|";	

	}else{
		opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
		opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		cust_info+="手机号码："+document.all.phone_no.value+"|";
		cust_info+="客户姓名："+document.all.cust_name.value+"|";
		cust_info+="客户地址："+document.all.cust_addr.value+"|";
		cust_info+="证件号码："+document.all.cardId_no.value+"|";

		retInfo+=" "+"|";
		opr_info+="用户品牌:"+"<%=sm_code%>" +"              业务类型：大庆农信通赠话费|";
  		opr_info+="业务流水："+document.all.login_accept.value+"|";
		opr_info+="业务操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="划转预存话费："+document.all.paper_money.value+" 元"+"|";
		opr_info+="专用预存话费期限："+document.all.consume_term.value+" 个月"+"|";

  		note_info4+="注意事项：您本次办理“农信通”业务所需费用将直接从您原有预存话费中扣除，如果您的预存话费不足请先交纳足额预存话费。您本次订购的“农信通”业务按原有梦网订购生效原则执行。本次所转费用只能冲减您本次办理的“农信通”业务所产生的费用，不能冲减其他业务所产生的费用；本次所转费用自办理业务当月算起，至第12个月末仍剩余将全部清零。大庆通业务提前取消，费用不退还；业务到期后请您自行取消。"+"|";	
	}
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange()
 {
 	document.all.paper_money.value="";
 	document.all.consume_term.value="";
 	
  for ( x1 = 0 ; x1 < arrpapermoney.length  ; x1++ )
   	{
      		if ( arrpapercode[x1] == document.all.paper_code.value)
      		{
        				document.all.paper_money.value=arrpapermoney[x1] ;
        				//alert(document.all.paper_money.value);
        				document.all.consume_term.value=arrconsumeterm[x1] ;
        				
      		}
   	}
 } 
 
 function opTypeChang(){
 	//alert(document.all.op_type.value);
 	if(document.all.op_type.value=="0"){
 		document.all.giftcodeid.style.display = "";
 		
 	}else{
 		document.all.giftcodeid.style.display = "none";
 	}
}
//-->
</script>

</head>

<body>
<form name="frm" method="post" action="f7164Cfm.jsp?opCode=<%=opCode%>&opName=<%=opName%>" onKeyUp="chgFocus(frm)" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">"农信通"赠礼营销活动</div>
	</div>
<table cellspacing="0">
	<tr id="type_7164"> 
		<td class="blue">操作类型</td>
		<td colspan="3">
			<select name="op_type" onchange="opTypeChang()">
				<option value ="0">赠礼</option>
				<option value ="1">赠话费</option>
			</select>
		</td>
	</tr>
	<tr id="type_7176"> 
		<td class="blue">操作类型</td>
		<td colspan="3">
			<select name="op_type_7176" >
				<option value ="1" >赠话费</option>
			</select>
		</td>
	</tr>
	<tr> 
		<td class="blue">客户姓名</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20"> 
			<font color="orange">*</font>
		</td>
		<td class="blue">客户地址</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" size="40"> 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">证件类型</td>
		<td>
			<input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">业务品牌</td>
		<td>
			<input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
			<font color="orange">*</font>
		</td>
		<td class="blue">运行状态</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
	<td class="blue">VIP级别</td>
	<td>
		<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
		<font color="orange">*</font>
	</td>
	<td class="blue">可用预存</td>
	<td>
		<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
		<font color="orange">*</font>
	</td>
	</tr>
	<tr> 
	<td class="blue">业务类型</td>
	<td>
		<SELECT id="paper_code" name="paper_code" v_must=1  onchange="selectChange();">  
			<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
			<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
			<%}%>
		</select>
		<font color="orange">*</font>	
	</td>
	<td class="blue">业务金额</td>
	<td >
		<input name="paper_money" type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
		<font color="orange">*</font>	
	</td>
	</tr>
	<tr id="giftcodeid"> 
		<td class="blue">礼品类型</td>
		<td colspan="3">
			<SELECT id="gift_code" name="gift_code" v_must=1>  
				<%for(int i = 0 ; i < giftCodeStr.length ; i ++){%>
				<option value="<%=giftCodeStr[i][0]%>"><%=giftCodeStr[i][1]%></option>
				<%}%>
			</select>
			<font color="orange">*</font>	
		</td>
	</tr>
     
	<tr> 
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="" > 
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()"  >
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp; </div>
		</td>
	</tr>
</table>	
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="op_type_1776"  value="">
    <input type="hidden" name="consume_term">
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<script>
	selectChange();
</script>
</html>
