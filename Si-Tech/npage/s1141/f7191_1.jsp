<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 奥运手机报短信版BOSS订购7191
   * 版本: 1.0
   * 日期: 2008/01/13
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
	String opCode="7191";
	String opName="奥运手机报短信版BOSS订购";	
	String loginNo = (String)session.getAttribute("workNo");			//工号
	String loginName = (String)session.getAttribute("workName");		//工名
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String phoneNo = request.getParameter("srv_no");					//用户手机号
  	String opcode = request.getParameter("opcode");						//操作代码
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
	if (errCode.equals("000000")&&tempArr.length>0 ){
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
  //手机品牌
	String[] inParam = new String[2];
	inParam[0] = "select paper_code,paper_name,paper_money,sp_code,oper_code,award_code,award_detailcode,gift_code,to_char(consume_term),server_code from sPaperGiftCfg where region_code=:regionCode" + " and valid_flag='Y' and op_code='7191'";
	inParam[1] = "regionCode="+regionCode;
%>
	<wtc:service name="TlsPubSelCrm"  outnum="10" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg2">
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/> 
	</wtc:service>
	<wtc:array id="agentCodeStr" scope="end"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>奥运手机报短信版BOSS订购</title>
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
	out.println("arrspcode["+i+"]='"+agentCodeStr[i][3]+"';\n");
	out.println("arropercode["+i+"]='"+agentCodeStr[i][4]+"';\n");
	out.println("arrawardcode["+i+"]='"+agentCodeStr[i][5]+"';\n");
	out.println("arrawarddetailcode["+i+"]='"+agentCodeStr[i][6]+"';\n");
	out.println("arrgiftcode["+i+"]='"+agentCodeStr[i][7]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][8]+"';\n");
	out.println("arrservercode["+i+"]='"+agentCodeStr[i][9]+"';\n");
  }  
  
%>
	
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
	if(paper_code.value==""){
	  rdShowMessageDialog("请输入活动名称!");
      paper_code.focus();
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
   var h=200;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="7191" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo=<%=phoneNo%>"+
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
	
	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	opr_info+="业务类型：奥运手机报短信版BOSS订购"+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="订报类型："+document.all.paper_name.value+"|";

 
 /********liyang 20080619****/
 	if(document.all.consume_term.value=="1")
 	{
  		note_info1+="资费1元/月，20日前办理当月收费，21日（含21）至月末办理次月收费。此业务将在2008年9月30日下线，届时系统将自动取消订购关系。"+"|";
	}
	else
	{
  		note_info1+="资费1元/月，20日前办理当月收费，21日（含21）至月末办理次月收费，如中途退订，到期后系统自动将套餐未使用的费用一次性收取。业务到期后自动转包月，收取1元/月包月费。此业务将在2008年9月30日下线，届时系统将自动取消订购关系。"+"|";
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
 	document.all.sp_code.value="";
 	document.all.oper_code.value="";
 	document.all.award_code.value="";
 	document.all.award_detailcode.value="";
 	document.all.gift_code.value="";
 	document.all.consume_term.value="";
 	document.all.server_code.value="";
 	document.all.paper_name.value="";
 	
  for ( x1 = 0 ; x1 < arrpapermoney.length  ; x1++ )
   	{
      		if ( arrpapercode[x1] == document.all.paper_code.value)
      		{
        				document.all.paper_money.value=arrpapermoney[x1] ;
        				document.all.sp_code.value=arrspcode[x1] ;
        				document.all.oper_code.value=arropercode[x1] ;
        				document.all.award_code.value=arrawardcode[x1] ;
        				document.all.award_detailcode.value=arrawarddetailcode[x1] ;
        				document.all.gift_code.value=arrgiftcode[x1] ;
        				document.all.consume_term.value=arrconsumeterm[x1] ;
        				document.all.server_code.value=arrservercode[x1] ;
        				document.all.paper_name.value=arrpapername[x1] ;
      		}
   	}
 } 
 


//-->
</script>

</head>

<body>
<form name="frm" method="post" action="f7191Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">奥运手机报短信版BOSS订购</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">操作类型</td>
		<td colspan="3">奥运手机报短信版BOSS订购-申请</td>
	</tr>
	<tr> 
		<td class="blue">客户姓名</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20"> 
			<font color="orange">*</font>
		</td>
		<td class="blue">客户地址</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" > 
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
		<td colspan="3">
			<SELECT id="paper_code" name="paper_code" v_must=1  onchange="selectChange();">  
				<option value ="">--请选择--</option>
				<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
				<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
				<%}%>
			</select>
		<font color="orange">*</font>	
		</td>
		<!--
		<td >业务金额：</td>-->
		<!--  <td >-->
		<input name="paper_money" type="hidden" class="InputGrey" id="paper_money" v_type="money" v_must=1   readonly v_name="订报金额" >
		<!--  <font color="#FF0000">*</font>	
		</td>-->
		
	</tr>
     
	<tr> 
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="奥运手机报短信版BOSS订购" > 
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer">  
			<input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()"  >
			&nbsp; 
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
		</td>
	</tr>
</table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="sp_code" value="" >
	<input type="hidden" name="oper_code" value="" >
    <input type="hidden" name="award_code" value="" >  
	<input type="hidden" name="award_detailcode" value="" > 
	<input type="hidden" name="gift_code" value="" >
	<input type="hidden" name="server_code" value="" >
	<input type="hidden" name="consume_term" value="">
	<input type="hidden" name="paper_name" value="">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
