<%
/********************
 version v2.0
 开发商: si-tech
 模块：统一领奖
 update zhaohaitao at 2009.1.4
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%		
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");	
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>

<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 R1444Init***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String award_type= request.getParameter("award_type");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;				/* 手机号码   */ 
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;				/* 归属代码   */
  paraAray1[3] = "1444";	   		/* 操作代码   */
  
  for(int i=0; i<paraAray1.length; i++)
  {
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }
  
  //retList = impl.callFXService("s1444Init", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s1444InitEx" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="9">			
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
	</wtc:service>
	<wtc:array id="tempArr"  start="0" length="4" scope="end"/>
<%
  
  String id_no="";				//用户ID
  String pwd="";					//用户密码
  String bp_name="";			//机主姓名
  String bp_addr="";			//机主地址
  String cardId_type="";	//证件类型
  String cardId_no="";		//证件号码
  String sm_name="";			//业务品牌
  String total_point="";	//上月彩信积分
  String last_time="";		//最近兑奖时间

  String errCode = retCode1;
  String errMsg = retMsg1;
  
  if(tempArr.length==0)
  {
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
		   retMsg = "s1444Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
	  }
	}
  else if(tempArr.length>0)
  {
	  if(errCode.equals("000000")) {		
		    id_no = tempArr[0][0];					//用户ID
		 
		    pwd = tempArr[0][1];					//用户密码
		 
		    bp_name = tempArr[0][2];				//机主姓名
		 
		    bp_addr = tempArr[0][3];				//机主地址
		 
		    cardId_type = tempArr[0][4];		//证件类型
		 
		    cardId_no = tempArr[0][5];			//证件号码
		 
		    sm_name = tempArr[0][6];				//业务品牌
		 
		    total_point = tempArr[0][7];		//上月彩信积分
		
		    last_time = tempArr[0][8];			//最近兑奖时间
	  }	
	  else{
			if(!retFlag.equals("1"))
			{
			   retFlag = "1";
		       retMsg = "s1444Init查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
			}
		}
  }
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept(); 
   
  /*********************验证用户上次兑奖时间*******************************/
  String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());

	if(null!=last_time && !"".equals(last_time)){
	  if(dateStr.equals(last_time.substring(0,6))){
	  	retFlag = "1";
	    retMsg = "您本月已经兑换过奖品!";
	  	
	  }
	 }
    
%>


<head>
<title>彩信风暴兑奖</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
	
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}
	else{
  %>
  	if("<%=total_point%>"=="" || "<%=total_point%>"==null){
			rdShowMessageDialog("您本月的点数为零！");
			history.go(-1);
		}
		else if("<%=total_point%>"<10){
			rdShowMessageDialog("您本月的点数小于10，不足以进行兑奖！");
			history.go(-1);
		}
	<%}%>

</script>

</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>   
  	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>

<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
		</td> 
		<td class="blue">业务品牌</td>
		<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue">客户名称</td>
		<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>	
			<input name="award_type" type="hidden" value=<%=award_type%>> 		  
		</td> 
		<td class="blue">客户地址</td>
		<td>
			<input name="bp_addr" type="text" class="InputGrey" id="bp_addr" value="<%=bp_addr%>" size="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">证件类型</td>
		<td>
			<input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">当前点数</td>
		<td colspan="3">
			<input name="total_point" type="text" class="InputGrey" id="cardId_type" value="<%=total_point%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">兑换明细</td>
		<td colspan="3"></td>
	</tr>
	<tr>
		<th>
			奖品类型
		</th>
		<th align="center">
			10元礼品券
		</th>
		<th align="center">
			20元礼品券									
		</th>
		<th align="center">
			50元礼品券
		</th>
		<th align="center">
			100元礼品券									
		</th>
		<th align="center">
			200元礼品券									
		</th>
	</tr>
	<tr>
		<td>
			数量
		</td>
		<td align="center">
			<input type="text" name="num1" value="0" class="button" v_name="10元礼品券数量" v_type="0_9" v_must="1" size="8" maxlength="2" onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num2" value="0" class="button" v_name="20元礼品券数量" v_type="0_9" size="8" v_must="1" maxlength="2"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num3" value="0" class="button" v_name="50元礼品券数量" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center"> 
			<input type="text" name="num4" value="0" class="button" v_name="100元礼品券数量" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
		<td align="center">
			<input type="text" name="num5" value="0" class="button" v_name="200元礼品券数量" v_type="0_9" size="8" v_must="1" maxlength="1"  onchange="if(chk(this)) comp()">
		</td>
	</tr>
			
	<tr>
	<td colspan="3"></td>
	<td align="center">使用点数总计:
		<input name="usePoint" type="text" class="button" value="0" readonly size="8">
		<input name="leavePoint" type="hidden" >
		<input name="id_no" type="hidden" value="<%=id_no%>">
		</td>
	</tr>
	
	<tr> 
		<td id="footer" colspan="5"> 
			<div align="center"> 
				<input class="b_foot" type=button name="confirm1" value="确认&打印" onClick="printCommit()" index="2" disabled="true">    
				<input class="b_foot" type=button name=back value="重置" onClick="rst()">
			    <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()();">
			    <input class="b_foot" type=button name=goback value="返回" onClick="history.go(-1);">
			</div>
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
   <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script language='javascript'>
	function chk(obj){
		if(for0_9(obj)){
			document.all.confirm1.disabled=false;
			return true;
		}
		else{
			document.all.confirm1.disabled=true;
			obj.value="0";
			return false;
		}
	}
	
	function rst(){
			document.all.num1.value="0";
			document.all.num2.value="0";
			document.all.num3.value="0";
			document.all.num4.value="0";
			document.all.num5.value="0";
			document.all.usePoint.value="0";
	}
	
	function doCfm(){		
		document.frm.action="f1444_Cfm.jsp";
		document.frm.submit();
	}
	
	function comp(){
		var psum = 0;
		psum += 10 * document.all.num1.value;
		psum += 20 * document.all.num2.value;
		psum += 50 * document.all.num3.value;
		psum += 100 * document.all.num4.value;
		psum += 200 * document.all.num5.value;
		document.all.usePoint.value = psum;
	}
	
function printInfo(printType)
{
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
	var retInfo = "";  //打印内容
	
	cust_info+="手机号码："+"<%=phoneNo%>"+"|";
	cust_info+="客户姓名："+"<%=bp_name%>"+"|";
    //cust_info+="客户地址："+"<%=bp_addr%>"+"|";
	//cust_info+="证件号码："+"<%=cardId_no%>"+"|";
	
	opr_info+="用户品牌："+"<%=sm_name%>"+"|";
    opr_info+="办理业务："+"彩信风暴兑奖"+"|";
    opr_info+="兑奖明细："+"|";
    opr_info+="10元礼品券："+document.all.num1.value+"个"+"|";
    opr_info+="20元礼品券："+document.all.num2.value+"个"+"|";
    opr_info+="50元礼品券："+document.all.num3.value+"个"+"|";
    opr_info+="100元礼品券："+document.all.num4.value+"个"+"|";
    opr_info+="200元礼品券："+document.all.num5.value+"个"+"|";
    opr_info+="使用点数："+document.all.usePoint.value+"点"+"|";
   
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=200;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";                                     
	var billType="1";                                         
	var sysAccept=<%=printAccept%>;                           
	var printStr=printInfo(printType);                        
	var mode_code=null;                                        
	var fav_code=null;                                         
	var area_code=null;                                       
	var opCode="<%=opCode%>";                                
	var phoneNo=document.frm.phoneNo.value;                    
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	return ret;    
}

function printCommit()
{  
	getAfterPrompt();
	if(parseInt("<%=total_point%>") >= 200){
		if(document.all.usePoint.value != "200"){
			rdShowMessageDialog("您本月只可以兑换200点！");
			return false;
		}
		document.all.leavePoint.value = parseInt("<%=total_point%>")-200;
	}
	else{
		if(parseInt(document.all.usePoint.value) > parseInt("<%=total_point%>")){
			rdShowMessageDialog("使用点数大于用户上月总点数！");
			return false;
		}
		else if((parseInt("<%=total_point%>")-10) > parseInt(document.all.usePoint.value)){
			rdShowMessageDialog("您使用的点数小于最低兑奖限额！");
			return false;
		}
		document.all.leavePoint.value = 0;
	}
  
     var ret = showPrtDlg("确实要进行电子免填单打印吗？","Yes"); 
     if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
	          doCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
          {
	          doCfm();
          }
	      }
	   }
	   else
	   {
	       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	       {
		       doCfm();
	       }
	   }
		 return true; 	    
}

</script>
