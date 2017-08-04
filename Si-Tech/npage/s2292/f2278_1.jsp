<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
    String opCode = "2278";
    String opName = "无线音乐俱乐部包年(季)会员退订";
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
%>
<%
  String retFlag="",retMsg="";
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
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

  //retList = impl.callFXService("s2278Qry", paraAray1, "18","phone",phoneNo);
%>
<wtc:service name="s2278Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s2278QryCode" retmsg="s2278QryMsg" outnum="18">
	<wtc:param value="<%=paraAray1[0]%>"/> 
	<wtc:param value="<%=paraAray1[1]%>"/> 
    <wtc:param value="<%=paraAray1[2]%>"/> 
</wtc:service>
<wtc:array id="s2278QryArr" scope="end" />
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
String vUserName="",vModeName="",vGiftName="",vSpFee="",begintime="",endtime="";
  //String[][] tempArr= new String[][]{};
  String errCode = s2278QryCode;
  String errMsg = s2278QryMsg;
  if(s2278QryArr == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(s2278QryArr == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(2);
	  if(!(s2278QryArr[0][2].equals(""))){
	    bp_name = s2278QryArr[0][2];//机主姓名
	    System.out.println(bp_name);
	  }
	  //tempArr = (String[][])retList.get(3);
	  if(!(s2278QryArr[0][3].equals(""))){
	    bp_add = s2278QryArr[0][3];//客户地址
	  }
	  //tempArr = (String[][])retList.get(4);
	  if(!(s2278QryArr[0][4].equals(""))){
	    cardId_type = s2278QryArr[0][4];//证件类型
	  }
	  //tempArr = (String[][])retList.get(5);
	  if(!(s2278QryArr[0][5].equals(""))){
	    cardId_no = s2278QryArr[0][5];//证件号码
	  }
	  //tempArr = (String[][])retList.get(6);
	  if(!(s2278QryArr[0][6].equals(""))){
	    sm_code = s2278QryArr[0][6];//业务品牌
	  }
	  //tempArr = (String[][])retList.get(7);
	  if(!(s2278QryArr[0][7].equals(""))){
	    region_name = s2278QryArr[0][7];//归属地
	  }
	  //tempArr = (String[][])retList.get(8);
	  if(!(s2278QryArr[0][8].equals(""))){
	    run_name = s2278QryArr[0][8];//当前状态
	  }
	  //tempArr = (String[][])retList.get(9);
	  if(!(s2278QryArr[0][9].equals(""))){
	    vip = s2278QryArr[0][9];//ＶＩＰ级别
	  }
	  //tempArr = (String[][])retList.get(10);
	  if(!(s2278QryArr[0][10].equals(""))){
	    posint = s2278QryArr[0][10];//当前积分
	  }
	  //tempArr = (String[][])retList.get(11);
	  if(!(s2278QryArr[0][11].equals(""))){
	    prepay_fee = s2278QryArr[0][11];//可用预存
	  }
	  //tempArr = (String[][])retList.get(12);
	  if(!(s2278QryArr[0][12].equals(""))){
	    vUserName = s2278QryArr[0][12];//可用预存
	  }
	  //tempArr = (String[][])retList.get(13);
	  if(!(s2278QryArr[0][13].equals(""))){
	    vModeName = s2278QryArr[0][13];//可用预存
	  }
	  //tempArr = (String[][])retList.get(14);
	  if(!(s2278QryArr[0][14].equals(""))){
	    vGiftName = s2278QryArr[0][14];//可用预存
	  }
	  //tempArr = (String[][])retList.get(15);
	  if(!(s2278QryArr[0][15].equals(""))){
	    vSpFee = s2278QryArr[0][15];//可用预存
	  }
	  //tempArr = (String[][])retList.get(16);
	  if(!(s2278QryArr[0][16].equals(""))){
	    begintime = s2278QryArr[0][16];//可用预存
	  }
	  //tempArr = (String[][])retList.get(17);
	  if(!(s2278QryArr[0][17].equals(""))){
	    endtime = s2278QryArr[0][17];//可用预存
	  }
	}else{
		//if(!retFlag.equals("1"))
		//{
		  // retFlag = "1";
	      // retMsg = "s126bInit查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		//}
	}
  }

%>

<%
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>无线音乐俱乐部包年(季)会员</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

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

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;
  
  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  
  var arrprint1=new Array();
  var arrprint2=new Array();
  var arrprintbrand=new Array();
  var arrprinttype=new Array();
  


 

	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
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
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入用户类型!");
      agent_code.focus();
	  return false;
	}
	if(gift_code.value==""){
	  rdShowMessageDialog("请输入礼品名称!");
      gift_code.focus();
	  return false;
	}
	if(sale_code.value==""){
	
     } 
	opNote.value=phone_no.value+"办理无线音乐俱乐部高级会员退订";
	phone_typename.value=document.all.agent_code.value;
	gift_name.value=document.all.gift_code.value;
	
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
{  
   
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=printAccept%>";
   
   var mode_code = document.all.mode_code.value.trim();
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
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

  	var retInfo = "";
  	
	//retInfo+=document.all.work_no.value+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	
	opr_info+="用户品牌："+"<%=sm_code%>"+"   办理业务：无线音乐俱乐部高级会员退订"+"|";
    opr_info+="操作流水："+document.all.login_accept.value+"|";
    opr_info+="业务生效时间: 立即生效"+"|";

	
	note_info1+="注意事项：退订当月收取整月的费用，包年(季)余额不退。"+"|";
	
	//retInfo+="备注：您所缴纳的1980元中有60元为无线音乐俱乐部高级会员年费，剩余1920元为超值礼包费用，包括价值1740元的索爱W300C音乐手机一部，一张抽奖刮刮卡（每千部可中奖五部），"+"|";
	//retInfo+="价值100元的音乐背包一个，价值380元的便携式手机音箱，价值99元的彩铃包年卡，请您注意查收！"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    
    return retInfo;	
}



//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f2278_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">无线音乐俱乐部包年(季)会员退订</div>
</div>
<table cellspacing="0" >
    <tr> 
        <td class=blue>操作类型</td>
        <td colspan=3>无线音乐俱乐部包年(季)会员</td>
    </tr>
    <tr> 
        <td class=blue>客户姓名</td>
        <td>
            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名"> 
        </td>
        <td class=blue>客户地址</td>
        <td>
            <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" > 
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
        <td class=blue>可用预存</td>
        <td>
            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
        </td>
    </tr>
    <tr> 
        <td class=blue>用户类型</td>
        <td>
            <input type="text" id="agent_code" name="agent_code" v_must=1  value="<%=vUserName%>" readonly class="InputGrey">  
        </td>
        <td class=blue>资费代码</td>
        <td  id="showHitHv">
            <input type="text" name="mode_code" class="InputGrey" readonly value="<%=vModeName%>" id="mode_code" v_must=1>	
        </td>
    </tr>
    <tr> 
        <td class=blue>礼品名称</td>
        <td >
            <input type="text" name="gift_code" id="sale_code" class="InputGrey"  value="<%=vGiftName%>" readonly v_must=1 >			  
        </td>
        <td  class=blue>应付会费</td>
        <td >
            <input name="sum_money" type="text" value="<%=vSpFee%>" class="InputGrey" id="sum_money" readonly>
        </td>
    </tr>
    <tr> 
        <td  class=blue>开始时间</td>
        <td >
            <input name="begintime" type="text" value="<%=begintime%>" class="InputGrey" id="begintime" readonly>
        </td>
        <td class=blue>结束时间</td>
        <td>
            <input name="endtime" type="text" value="<%=endtime%>" class="InputGrey" id="endtime" readonly>
        </td>
    </tr> 
    <tr> 
        <td class=blue>备注</td>
        <td colspan="3">
            <input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="无线音乐俱乐部高级会员退订" > 
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
<input type="hidden" name="opcode" value="<%=opcode%>">
<input type="hidden" name="sale_type" value="7" >
<input type="hidden" name="phone_typename" >
<input type="hidden" name="gift_name" >
<input type="hidden" name="card_type" >
<input type="hidden" name="cardy" >
<input type="hidden" name="print1" >
<input type="hidden" name="print2" >

<%@ include file="/npage/include/footer_new.jsp" %>
</form>
</body>
<script language="JavaScript">
	getMidPrompt("10442",document.all.mode_code.value,"showHitHv");	
</script>	
</html>


