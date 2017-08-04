<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangjya @ 2009-04-16
 ********************/
%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>

<%		
    String opCode = (String)request.getParameter("opcode");
    String opName = "号簿管家包年申请";
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
    
    System.out.println("opName="+opName);
%>
<%
    String retFlag="",retMsg="";

    String[] paraAray1 = new String[3];
    String phoneNo = request.getParameter("srv_no");
    
    paraAray1[0] = phoneNo;		/* 手机号码   */ 
    paraAray1[1] = loginNo;	    /* 操作工号   */
    paraAray1[2] = opCode; 	    /* 操作代码   */
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	}

 /* 输出参数： 0返回码，1返回信息 2 客户姓名，3客户地址，4证件类型，5证件号码，6业务品牌，
 			7归属地，8当前状态，9VIP级别 ，10当前积分,11 用户预存
 			12,应扣预存款, 13当前用户状态 14用户下一个状态
 */

 
%>
	<wtc:service name="s6909Query" routerKey="phone" routerValue="<%=phoneNo%>" retcode="errCode" retmsg="errMsg"  outnum="15">
		<wtc:param value="<%=paraAray1[0]%>"/> 
		<wtc:param value="<%=paraAray1[1]%>"/> 
	    <wtc:param value="<%=paraAray1[2]%>"/> 
	</wtc:service>
	<wtc:array id="s6909QryArr" scope="end" />
<%
	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",favour_name="";
	String pay_fee="",curlevel_name="",nextlevel_name="",cur_type="",next_type="";
 	if(!errCode.equals("000000"))
 	{ %>
		<script language="JavaScript">
		  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
		    history.go(-1);
		</script>
  <%}
    else
	{
	  if(!(s6909QryArr[0][2].equals("")))
	  {
	    bp_name = s6909QryArr[0][2];//机主姓名
	    System.out.println(bp_name);
	  }
	  if(!(s6909QryArr[0][3].equals("")))
	  {
	    bp_add = s6909QryArr[0][3];//客户地址
	  }
	  if(!(s6909QryArr[0][4].equals("")))
	  {
	    cardId_type = s6909QryArr[0][4];//证件类型
	  }
	  if(!(s6909QryArr[0][5].equals("")))
	  {
	    cardId_no = s6909QryArr[0][5];//证件号码
	  }

	  if(!(s6909QryArr[0][6].equals("")))
	  {
	    sm_code = s6909QryArr[0][6];//业务品牌
	  }

	  if(!(s6909QryArr[0][7].equals("")))
	  {
	    region_name = s6909QryArr[0][7];//归属地
	  }

	  if(!(s6909QryArr[0][8].equals("")))
	  {
	    run_name = s6909QryArr[0][8];//当前状态
	  }
	
	  if(!(s6909QryArr[0][9].equals("")))
	  {
	    vip = s6909QryArr[0][9];//ＶＩＰ级别
	  }

	  if(!(s6909QryArr[0][10].equals("")))
	  {
	    posint = s6909QryArr[0][10];//当前积分
	  }	
	  if(!(s6909QryArr[0][11].equals("")))
	  {
	    prepay_fee = s6909QryArr[0][11];//可用预存
	  }
	  if(!(s6909QryArr[0][12].equals("")))
	  {
	  	pay_fee = s6909QryArr[0][12];//应扣预存款 
	  }
	  if(!(s6909QryArr[0][13].equals("")))
	  {
	  	cur_type = s6909QryArr[0][13];
	  	switch(Integer.parseInt(s6909QryArr[0][13].trim())) //13当前用户状态 
	  	{
			//（0:非号簿管家用户 1：免费包月用户，2：正常包月用户，3：包年用户 9:梦网订购的正常包月）
			case 0:
				curlevel_name="非号簿管家用户";
				break;
			case 1:
		    	curlevel_name="免费包月用户";
		    	break;
		    case 9:
			case 2:
				curlevel_name="正常包月用户";
				break;
			case 3:
		    	curlevel_name="包年用户";
		    	break;		   		
			default:
				curlevel_name="未知状态用户";
				break;	    	
	  	}
	  }
	  if(!(s6909QryArr[0][14].equals("")))
	  {
	  	 //14用户下一个状态
	  	 next_type = s6909QryArr[0][14];
		  	switch(Integer.parseInt(s6909QryArr[0][14].trim())) 
			{
				//（0:非号簿管家用户 1：免费包月用户，2：正常包月用户，3：包年用户 9:梦网订购的正常包月）
				case 0:
					nextlevel_name="非号簿管家用户";
					break;
				case 1:
			    	nextlevel_name="免费包月用户";
			    	break;
			    case 9:
				case 2:
					nextlevel_name="正常包月用户";
					break;
				case 3:
			    	nextlevel_name="包年用户";
			    	break;		   		
				default:
					nextlevel_name="未知状态用户";
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
<title>号簿管家包年申请</title>
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
 		opNote.value=phone_no.value+"号簿管家包年用户申请";
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


	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";

	
	opr_info+="用户品牌："+document.all.sm_code.value+ "  "+"办理业务：号簿管家12元包年"+"|";
	opr_info+="操作流水："+document.all.login_accept.value+"|";
	opr_info+="业务办理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	<% if(cur_type.equals("0"))//立即生效
	{
	%>
	opr_info+="业务生效时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";                           
	<%	
	}
	else
	{		//下月一号生效
		String strDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
		String strYear = strDate.substring(0,4);
		String strMonth = strDate.substring(5,7);
		
		if(12 == Integer.valueOf(strMonth).intValue())
		{
			strYear = String.valueOf(Integer.valueOf(strYear).intValue() + 1);
			strMonth="01";
		}
		else
		{
			strMonth = String.valueOf(Integer.valueOf(strMonth).intValue() + 1);
			if(1 == strMonth.length())
			{
				strMonth = "0" + strMonth;
			}
		}
		String strTime = strYear + "-" + strMonth + "-01 00:00:00"; 
	%>
		opr_info+="业务生效时间："+'<%=strTime%>'+"|";
	<%
	}%>
	opr_info+="业务到期规则 业务到期转包月" + "|";
	

	
//	note_info1+="指定资费描述："+"|";

	//note_info2+="号簿管家12元包年业务办理后形成专款，专款一次性从用户的预存款扣除，不显示在用户的预存款中，业务取消后，专款于次月全部收回，专款不退不转，包年到期转包月。" +"|";                           
	
	
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
//	document.all.note_info1.value=note_info1+"#";
//	document.all.note_info2.value=note_info2+"#";

//	retInfo = strcat(cust_info,opr_info,note_info1,note_info2);
	retInfo = strcat(cust_info,opr_info);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}



//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f6909_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">号簿管家包年申请</div>
</div>

<table cellspacing="0" >
    <tr> 
        <td class=blue>操作类型</td>
        <td colspan=3>号簿管家包年申请</td>
        </tr>
        <tr> 
        <td class=blue>客户姓名</td>
        <td>
            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名"> 
        </td>
        <td class=blue>客户地址</td>
        <td>
            <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="30" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>证件类型</td>
        <td>
            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
        </td>
        <td class=blue>证件号码</td>
        <td>
            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>业务品牌</td>
        <td>
            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
        </td>
        <td class=blue>运行状态</td>
        <td>
            <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>VIP级别</td>
        <td>
            <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
        </td>
        <td class=blue>可用积分</td>
        <td>
            <input name="posint" value="<%=posint%>" type="text" class="InputGrey" v_must=1 readonly id="posint" maxlength="20" > 
        </td>
    </tr>
    <tr> 
    	<td class=blue>可用预存</td>
        <td>
            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
        </td>
        <td class=blue>应扣预存</td>
        <td>
            <input name="user_type" value="<%=pay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="user_type" maxlength="20" > 	
        </td>
        
    </tr>    
    <tr> 
    	<td class=blue>用户当前类型</td>
        <td><%=curlevel_name%></td>
    	<td class=blue>用户下月类型</td>
        <td><%=nextlevel_name%></td>
    </tr>    
    <tr> 
        <td class=blue>备注</td>
        <td colspan="3" >
            <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="号簿管家包年申请" > 
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
<input type="hidden" name="card_dz" >
<input type="hidden" name="used_point" value="0" >
<input type="hidden" name="point_money" value="0" >
<input type="hidden" name="opcode" value="<%=opCode%>">
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
<input type="hidden" name="cur_level" value="<%=cur_type%>">
<input type="hidden" name="next_level" value="<%=next_type%>">
<input type="hidden" name="pay_fee" value="<%=pay_fee%>">
<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


