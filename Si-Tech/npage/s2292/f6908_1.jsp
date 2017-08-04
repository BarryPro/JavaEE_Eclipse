<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangjya @ 2009-04-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>

<%		
    String opCode = "6908";
    String opName = "号簿管家包月申请冲正";
	    
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
%>
<%
	String retFlag="",retMsg="";
	String[] paraAray1 = new String[4];
	String phoneNo = request.getParameter("srv_no");
	String opcode = request.getParameter("opcode");
	String passwordFromSer="";
	String backAccept=request.getParameter("backaccept");
	paraAray1[0] = phoneNo;		/* 手机号码   */ 
	paraAray1[1] = loginNo;	    /* 操作工号   */
	paraAray1[2] = opcode; 	    /* 操作代码   */
	paraAray1[3] = backAccept;    /* 冲正流水   */
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	}
 /* 输出参数： 返回码，返回信息，客户姓名, 客户地址,证件类型,证件号码,业务品牌
        归属地，当前状态，VIP级别 ，当前积分, 用户预存 
        用户当前状态,用户原状态
 */
 
%>
<wtc:service name="s6908Query" routerKey="phone" routerValue="<%=phoneNo%>" retcode="errCode" retmsg="errMsg" outnum="14">
	<wtc:param value="<%=paraAray1[0]%>"/> 
	<wtc:param value="<%=paraAray1[1]%>"/> 
    <wtc:param value="<%=paraAray1[2]%>"/> 
    <wtc:param value="<%=paraAray1[3]%>"/>
</wtc:service>
<wtc:array id="s6908QueryArr" scope="end" />
<%
	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
	String vCurLevel="",vOldLevel="";
	String vCurLevelName="",vOldLevelName="";
  
	  if(!errCode.equals("000000"))
	  {%>
		<script language="JavaScript">
		<!--
		  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
		  	 //history.go(-1);
		  	 window.location.href="f6907_login.jsp?activePhone=<%=phoneNo%>&opCode=6908&opName=号簿管家包月申请冲正";
		  	//-->
		  </script>
	  <%}
	 else
	 {
		if(!(s6908QueryArr[0][2].equals("")))
		{
			bp_name = s6908QueryArr[0][2];//机主姓名
			System.out.println(bp_name);
		}
		if(!(s6908QueryArr[0][3].equals("")))
		{
			bp_add = s6908QueryArr[0][3];//客户地址
		}
		if(!(s6908QueryArr[0][4].equals("")))
		{
			cardId_type = s6908QueryArr[0][4];//证件类型
		}
		if(!(s6908QueryArr[0][5].equals("")))
		{
			cardId_no = s6908QueryArr[0][5];//证件号码
		}
		if(!(s6908QueryArr[0][6].equals("")))
		{
			sm_code = s6908QueryArr[0][6];//业务品牌
		}
		
		if(!(s6908QueryArr[0][7].equals("")))
		{
			region_name = s6908QueryArr[0][7];//归属地
		}
		
		if(!(s6908QueryArr[0][8].equals("")))
		{
			run_name = s6908QueryArr[0][8];//当前状态
		}
		
		if(!(s6908QueryArr[0][9].equals("")))
		{
			vip = s6908QueryArr[0][9];//ＶＩＰ级别
		}
		if(!(s6908QueryArr[0][10].equals("")))
		{
			posint = s6908QueryArr[0][10];//当前积分
		}
		
		if(!(s6908QueryArr[0][11].equals("")))
		{
			prepay_fee = s6908QueryArr[0][11];//可用预存
		}
	  
		if(!(s6908QueryArr[0][12].equals("")))
		{
			vCurLevel = s6908QueryArr[0][12];//用户当前状态
			switch(Integer.parseInt(vCurLevel.trim()))//（1：免费包月用户，2：正常包月用户，3：包年用户）
			{
				case 1:
			    	vCurLevelName="免费包月用户";
			    	break;
				case 2:
					vCurLevelName="正常包月用户";
					break;
				case 3:
			    	vCurLevelName="包年用户";
			    	break;
				default:
					vCurLevelName="未知状态用户";
					break;	    	
			}
		}
	 
		if(!(s6908QueryArr[0][13].equals("")))
		{
			vOldLevel = s6908QueryArr[0][13];//用户原状态
			switch(Integer.parseInt(vOldLevel.trim()))//（0：非号簿管家用户，1：免费包月用户，2：正常包月用户，3：包年用户,5:当月免费包月下月退订的用户9:在梦网订购后再来申请包月或包年的）
			{
				case 5:
				case 0:
			    	vOldLevelName="非号簿管家用户";
			    	break;
				case 1:
			    	vOldLevelName="免费包月用户";
			    	break;
			    case 9:
				case 2:
					vOldLevelName="正常包月用户";
					break;
				case 3:
			    	vOldLevelName="包年用户";
			    	break;
				default:
					vOldLevelName="未知状态用户";
					break;	    	
			}
		}
	  }
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>号簿管家包月申请冲正</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">

<!--
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function printCommit()
 { 
   getAfterPrompt();

	with(document.frm)
	{
  		opNote.value=phone_no.value+"办理号簿管家包月申请冲正";
	}
 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
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
{    
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   var mode_code = null;
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);
   var phoneno = "<%=phoneNo%>";
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;

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
	var jkinfo="";

	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";

	
	opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.sm_code.value+ "|";
	
	opr_info+="办理业务：号簿管家包月申请冲正"+"  业务流水："+document.all.login_accept.value+"|";
  	opr_info+="原流水："+document.all.back_accept.value+"|";
  	
	
	note_info1+="备注："+document.all.opNote.value+"|";
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

    return retInfo;	
}
//-->
</script>
</head>

<body>
<form name="frm" method="post" action="f6908_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">号簿管家包月申请冲正</div>
</div>

<table cellspacing="0" >
    <tr> 
        <td class="blue">操作类型</td>
        <td colspan=3>号簿管家包月申请冲正</td>
    </tr>
    <tr> 
        <td class="blue">客户姓名</td>
        <td>
            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名"> 
        </td>
        <td class="blue">客户地址</td>
        <td>
            <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="30" > 
        </td>
    </tr>
    <tr> 
        <td class="blue">证件类型</td>
        <td>
            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
        </td>
        <td class="blue">证件号码</td>
        <td>
            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class="blue">业务品牌</td>
        <td>
            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
        </td>
        <td class="blue">运行状态</td>
        <td>
            <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class="blue">VIP级别</td>
        <td>
            <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
        </td>
        <td class="blue">可用预存</td>
        <td>
            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
        </td>
    </tr>
    <tr > 
        <td class="blue">用户当前类型</td>
        <td>
            <input type="text"  value="<%=vCurLevelName%>" readonly class="InputGrey" v_name="用户当前类型">  
        </td>
        <td class="blue">用户原类型</td>
        <td>
            <input type="text"  value="<%=vOldLevelName%>" readonly class="InputGrey" v_name="用户原类型" >	
        </td>
    </tr>
    <tr> 
        <td  class="blue">备注</td>
        <td colspan="3">
            <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="号簿管家包月申请冲正" > 
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()"  >
            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
        </td>
    </tr>
</table>

<input type="hidden" name="phone_no" value="<%=phoneNo%>">
<input type="hidden" name="work_no" value="<%=loginNo%>">
<input type="hidden" name="login_accept" value="<%=printAccept%>">
<input type="hidden" name="back_accept" value="<%=backAccept%>">
<input type="hidden" name="card_dz" >
<input type="hidden" name="used_point" value="0" >
<input type="hidden" name="point_money" value="0" >
<input type="hidden" name="opcode" value="<%=opcode%>">
<input type="hidden" name="sale_type" value="7" >
<input type="hidden" name="phone_typename" >
<input type="hidden" name="gift_name" >
<input type="hidden" name="card_type" >
<input type="hidden" name="cardy" >
<input type="hidden" name="print1" >
<input type="hidden" name="print2" >
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="cur_level" value="<%=vCurLevel%>">
<input type="hidden" name="old_level" value="<%=vOldLevel%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


