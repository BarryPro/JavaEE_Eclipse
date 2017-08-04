<%
/********************
 version v2.0
开发商: si-tech
update:huangrong@2010-09-20
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "b578";     
  String opName = "预存话费赠黑莓终端冲正"; 

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String op_code=request.getParameter("opCode");
  String groupId = (String)session.getAttribute("groupId");
%>
<%
  String retFlag="",retMsg="";
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept1= request.getParameter("backaccept1");//业务流水
  String userpass="";
  String sqlUserPass = " select  unique trim(user_passwd) from dcustmsg  where phone_no='"+phoneNo+"'";
%>

<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlUserPass%></wtc:sql>
</wtc:pubselect>
<wtc:array id="userPassStr" scope="end"/>
<%
if(code1.equals("000000") || code1.equals("0"))
{
	if(userPassStr!= null && userPassStr.length > 0)
	{
		userpass=userPassStr[0][0];
	}
}
else
{  
%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=code1%>错误信息：<%=msg1%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%
}
%>
	
<wtc:service  name="sB578Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="27"  retcode="errCode" retmsg="errMsg">	
	<wtc:param  value="<%=backaccept1%>"/>
	<wtc:param  value="<%=op_code%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=phoneNo%>"/>	
	<wtc:param  value="01"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=userpass%>"/>	
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%

 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，当前状态，VIP级别 ，可用预存
 			营销方案名，手机品牌型号，购机款，话费消费期限，IMEINo码，手机品牌，手机类型
 			购机款，话费消费期限，预存总金额，每月预存
 */
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",run_name="",vip="",prepay_fee="";
  String sale_name="",phone_typeno="",IMEINo="",agent_code="",phone_type="";
  String phone_fee="",consume_Term="",baseFee="",monBaseFee="";

  if(retList == null)
  {
		if(!retFlag.equals("1"))
		{
		 System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")&&!errCode.equals("0") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000")||errCode.equals("0")){
	  bp_name =retList[0][1];
	  bp_add = retList[0][2];	  
	  sm_code = retList[0][8];
	  prepay_fee = retList[0][10];/*可用预存*/
	  cardId_type = retList[0][11];
	  cardId_no = retList[0][12];
	  sale_name = retList[0][26];
	  phone_typeno = retList[0][16];
	  phone_fee =retList[0][17];   /*购机款*/
	  consume_Term =retList[0][18];   /*话费消费期限*/
	  baseFee =retList[0][19];   /*预存总金额*/
	  monBaseFee =retList[0][20];   /*每月预存*/
	  vip = retList[0][21];
	  run_name = retList[0][22];
	  agent_code = retList[0][23]; /*手机品牌*/
	  phone_type = retList[0][24]; /*手机型号*/
	  IMEINo = retList[0][25]; /*手机型号*/
	}
  }

%>

<%
String printAccept="";
printAccept = getMaxAccept();
System.out.println("=====================AAAAAAAAAAAAAAAAAAAAAAAAaaaaaa"+printAccept);
%>
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language=javascript>

 
 </script>
<script language="JavaScript">

<!--
  function frmCfm(){
		var pingchuan="";
  	pingchuan+=document.all.sale_code.value+"|"; 
  	pingchuan+=document.all.agent_code.value+"|"; 
  	pingchuan+=document.all.phone_type.value+"|"; 
  	pingchuan+=document.all.baseFee.value+"|"; 
  	pingchuan+=document.all.monBaseFee.value+"|"; 
  	pingchuan+=document.all.consume_Term.value+"|"; 
  	pingchuan+=document.all.phone_fee.value+"|"; 
  	pingchuan+=document.all.IMEINo.value+"|";   	  	
  	var chuan=document.getElementById("chuan");
  	chuan.value=pingchuan;
		frm.submit();
		return true;
	}


 function printCommit()
 {
	 	getAfterPrompt();
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
	var h=188;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; //1免填单 3收据 2发票
	var printStr = printInfo(printType);
	var sysAccept = document.all.login_accept.value;

	var mode_code=null;
	var fav_code=null;
	var area_code=null

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr ;
	var ret=window.showModalDialog(path,printStr,prop);
	//alert(path);
	return ret;
}

function printInfo(printType)
{

	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";

	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";
	

	opr_info+="用户品牌："+document.all.sm_code.value+"          办理业务：预存话费赠黑莓终端冲正"+"|";
	opr_info+="操作流水："+document.all.login_accept.value+"|"; 	
  opr_info+="手机型号："+document.all.phone_typeno.value+"      IMEI码："+document.frm.IMEINo.value+"|";		


  var jkinfo="";
  jkinfo+="退款合计："+document.all.baseFee.value+"元  含：预存话费 "+document.all.baseFee.value+"元"+"|";
		
	opr_info+=jkinfo+"|";
	
	note_info1 =retInfo;
  note_info1+="备注；"+document.all.opNote.value+"|";

		retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="fb578_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
    <table cellspacing="0" >
		  <tr>
	        <td class="blue">操作类型</td>
	        <td>预存话费赠黑莓终端冲正</td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	</tr>
	<tr>
          <td class="blue">客户姓名</td>
          <td>
				<input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名">
          </td>
          <td class="blue">客户地址</td>
          <td>
				<input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" size='40' maxlength="40" >
          </td>
	</tr>
	<tr>
           <td class="blue">证件类型</td>
           <td>
				<input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
           </td>
	         <td class="blue">证件号码</td>
	         <td>
				<input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
           </td>
	</tr>
	<tr>
           <td class="blue">业务品牌</td>
           <td>
				<input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
           </td>
           <td class="blue">运行状态</td>
			 <td>
				<input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
             </td>
	</tr>
	<tr>
            <td class="blue">VIP级别</td>
            <td>
			    <input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
            </td>
            <td class="blue">可用预存</td>
            <td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >				
            </td>
	</tr>
	</table>
	</div>
	<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">业务办理</div>
	</div>
	<table cellspacing="0">
	<tr>
            <td class="blue">营销方案 </td>
            <td>
					<input type="text" name="sale_code"  v_name="营销代码" Class="InputGrey" id="sale_code"  value="<%=sale_name%>" readonly>
			</td>
			<td class="blue" >每月预存 </td>
            <td>
			     <input name="monBaseFee" type="text" v_name="每月预存" Class="InputGrey"  id="monBaseFee"  value="<%=monBaseFee%>" readonly>
            </td>
	</tr>
	<tr>
             <td class="blue">手机品牌型号 </td>
             <td>
					<input name="phone_typeno" type="text" v_name="手机品牌型号" Class="InputGrey" id="phone_typeno"  value="<%=phone_typeno%>" readonly>
					
			</td>
            <td class="blue">话费消费期限 </td>
            <td>
					<input name="consume_Term" type="text" v_name="话费消费期限" Class="InputGrey"  id="consume_Term"  value="<%=consume_Term%>" readonly>				
			</td>
	</tr>
	<tr>
          <td class="blue">购机款 </td>
            <td>
			  		<input name="phone_fee" type="text" v_name="购机款"  Class="InputGrey" id="phone_fee"  value="<%=phone_fee%>" readonly>
					</td>
          <td class="blue">预存总金额 </td>
            <td>
					<input name="baseFee" type="text" v_name="预存总金额"  Class="InputGrey" id="baseFee" value="<%=baseFee%>" readonly>
			</td>
	</tr>
	<tr>
            <td class="blue" >IMEI码</td>
            <td>
			     			 <input name="IMEINo"  type="text" v_name="IMEI码" Class="InputGrey"  value="<%=IMEINo%>" readonly>
            </td>
            <td class="blue" >备注</td>
            <td >
			     			 <input name="opNote" type="text" Class="InputGrey" id="opNote" size="60" value="预存话费赠黑莓终端冲正" readonly>
            </td>
	</tr>
	<tr>
            <td colspan="4" align="center">
                 <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                 <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
            </td>
	</tr>

    </table>
    
    <input type="hidden" name="userpass" value="<%=userpass%>">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept1" value="<%=backaccept1%>">
    <input type="hidden" name="chuan" id="chuan">
    <input type="hidden" name="opcode" value="<%=opcode%>">
	  <input type="hidden" name="op_code" value="<%=op_code%>" >
	  <input type="hidden" name="phone_type" value="<%=phone_type%>" >
	  <input type="hidden" name="agent_code" value="<%=agent_code%>" >
	  
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



