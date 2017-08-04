<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  
	String opCode = "8609";
	String opName = "集团客户统一付费赠机营销案";

%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
 <%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>


<%		
	    
  String loginNo =    (String)session.getAttribute("workNo");  
  String loginName =  (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
String retFlag="",retMsg="";
 SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String vUnitCotract=request.getParameter("vUnitCotract");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = vUnitCotract;

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

  retList = impl.callFXService("s8609Qry", paraAray1, "19","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String vUnitAlowFee="",vUnitUsedFee="",vUnitPayFee="",vUnitName="",vUnitId="";
  String[][] tempArr= new String[][]{};
  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(errCode != 0 ){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码<%=errCode%>，错误信息<%=errMsg%>");
			history.go(-1);
		</script>
	<%}
	else
	{
	  tempArr = (String[][])retList.get(2);
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][0];//机主姓名
	    System.out.println(bp_name);
	  }
	  tempArr = (String[][])retList.get(3);
	  if(!(tempArr==null)){
	    bp_add = tempArr[0][0];//客户地址
	  }
	  tempArr = (String[][])retList.get(4);
	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][0];//证件类型
	  }
	  tempArr = (String[][])retList.get(5);
	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][0];//证件号码
	  }
	  tempArr = (String[][])retList.get(6);
	  if(!(tempArr==null)){
	    sm_code = tempArr[0][0];//业务品牌
	  }
	  tempArr = (String[][])retList.get(7);
	  if(!(tempArr==null)){
	    region_name = tempArr[0][0];//归属地
	  }
	  tempArr = (String[][])retList.get(8);
	  if(!(tempArr==null)){
	    run_name = tempArr[0][0];//当前状态
	  }
	  tempArr = (String[][])retList.get(9);
	  if(!(tempArr==null)){
	    vip = tempArr[0][0];//ＶＩＰ级别
	  }
	  tempArr = (String[][])retList.get(10);
	  if(!(tempArr==null)){
	    posint = tempArr[0][0];//当前积分
	  }
	  tempArr = (String[][])retList.get(11);
	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][0];//可用预存
	  }
	  tempArr = (String[][])retList.get(13);
	  if(!(tempArr==null)){
	    passwordFromSer = tempArr[0][0];  //密码
	  }
	  tempArr = (String[][])retList.get(14);
	  if(!(tempArr==null)){
	    vUnitId = tempArr[0][0];  //密码
	  }
	  tempArr = (String[][])retList.get(15);
	  if(!(tempArr==null)){
	    vUnitName = tempArr[0][0];  //密码
	  }
	  tempArr = (String[][])retList.get(16);
	  if(!(tempArr==null)){
	    vUnitPayFee = tempArr[0][0];  //密码
	  }
	  tempArr = (String[][])retList.get(17);
	  if(!(tempArr==null)){
	    vUnitUsedFee = tempArr[0][0];  //密码
	  }
	  tempArr = (String[][])retList.get(18);
	  if(!(tempArr==null)){
	    vUnitAlowFee = tempArr[0][0];  //密码
	  }
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   

  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
  boolean pwrf = false;//a272 密码免验证
  String handFee_Favourable = "readonly class='InputGrey' ";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	
  }
 
  String passTrans=Pub_lxd.repNull(request.getParameter("cus_pass")); 
System.out.println("passTrans==="+passTrans);
System.out.println("passwordFromSer==="+passwordFromSer);
  if(!pwrf)
  {
     if(0==Encrypt.checkpwd1(passTrans,passwordFromSer)){
	   if(!retFlag.equals("1"))
		{%>
			<script language="JavaScript">
				rdShowMessageDialog("密码验证错误，请重新输入密码！");
				history.go(-1);
			</script>
		<%}
	    
    }       
  }
 %>
 
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = sysAcceptl;
System.out.println(printAccept);

  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='16' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'C%' and is_valid='1' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  %>
 	
 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlAgentCode%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t" scope="end"/> 
  
  <%
  String[][] agentCodeStr = result_t;
  if(agentCodeStr.length==0){
  %>
			<script language="JavaScript">
				rdShowMessageDialog("这个帐号已没有可以参加营销案的金额！");
				history.go(-1);
			</script>
<%
  }
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='16' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'C%' and is_valid='1' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  %>
	<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlPhoneType%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t1" scope="end"/>   
  <%
  String[][] phoneTypeStr = result_t1;
  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.cost_price,a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='16' and valid_flag='Y' and a.spec_type like 'C%' and prepay_limit<=to_number('"+vUnitAlowFee+"')";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("5",sqlsaleType);
  %>
  <wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlsaleType%></wtc:sql>
 	  </wtc:pubselect>
	<wtc:array id="result_t2" scope="end"/>  
  
  <%
  String[][] saleTypeStr = result_t2;
  
%>
<head>
<title>集团客户统一付费赠机营销案</title>
<script language="JavaScript">
 
 function doProcess(packet)
 {
 
 		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg =  packet.data.findValueByName("errorMsg");
		var retType = packet.data.findValueByName("retType");
		var retResult =  packet.data.findValueByName("retResult");
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		
		ret_code =  parseInt(errorCode);
		if(retResult == "000000")
		{
			rdShowMessageDialog("IMEI号校验成功1！");
			document.frm.IMEINo.readonly =true;
			document.frm.IMEINo.className="InputGrey" 
			document.frm.confirm.disabled=false;
			return ;

		}else if(retResult == "000001")
		{
			rdShowMessageDialog("IMEI号校验成功2！");
			document.frm.IMEINo.readonly =true;
			document.frm.IMEINo.className="InputGrey" 
			document.frm.confirm.disabled=false;
			return ;

		}else if(retResult == "000003"){
			rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
			document.frm.confirm.disabled=true;
			return false;
		}else{
			rdShowMessageDialog("IMEI号不存在或者已经使用！");
			document.frm.confirm.disabled=true;
			return false;
		}
		
 }

function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}


 


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
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaletype=new Array();
  var arrsalebrand=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsalebrand["+l+"]='"+saleTypeStr[l][3]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][4]+"';\n");
	
	
  }  
%>
	
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***IMEI 号码校验
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     } 
	
	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null; 
    
}
 function printCommit()
 { 
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      sale_code.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
    if(parseFloat(vUnitAlowFee.value)<parseFloat(cost_price.value)){
      rdShowMessageDialog("手机成本价不能大于可用金额!");
      return false;
    }
    
	 document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
/*************
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}

*******/


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
	 var pType="subprint";
	 var billType="1";
	 var sysAccept = document.all.login_accept.value;
   var printStr = printInfo(printType);

   var mode_code=null;
	 var fav_code=null;
	 var area_code=null

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
   var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opcode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   //alert(path);
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

/***
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="print";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="8609" ;                   			 		//操作代码
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

***/
/****
function printInfo(printType)
{
  
	var month_fee ;
	
  
	var retInfo = "";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="用户号码："+document.all.phone_no.value+"|";
	retInfo+="用户姓名："+document.all.cust_name.value+"|";
	retInfo+="用户地址："+document.all.cust_addr.value+"|";
	retInfo+="证件号码："+document.all.cardId_no.value+"|";
	retInfo+="集团帐号: "+document.all.vUnitCotract.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="业务类型：集团客户统一付费赠机营销案"+"|";
  	retInfo+="业务流水："+document.all.login_accept.value+"|";
  	retInfo+="手机型号: "+document.all.phone_typename.value+"      IMEI码："+document.frm.IMEINo.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="      备注："+document.all.opNote.value+"|";
  return retInfo;	
}
********/

function printInfo(printType)
{
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 var retInfo = "";

	cust_info+= "手机号码：     "+document.all.phone_no.value+"|";
	cust_info+= "客户姓名：     "+document.all.cust_name.value+"|";
	opr_info+="用户品牌："+document.all.sm_code.value+" 办理业务：<%=opName%>"+"|";
  	opr_info+="操作流水："+document.all.login_accept.value+"|";//14

  	opr_info+="手机型号："+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text
  				+"      IMEI码："+document.frm.IMEINo.value+"|";


   //var jkinfo="";
	//if(parseInt(document.all.card_money.value,10)==0){
		//jkinfo="缴款合计："+document.all.sum_money.value+"元 含:预存话费 "+document.all.pay_money.value+"元";
	//}else{
		//jkinfo+="缴款合计："+document.all.sum_money.value+"元 含:预存话费 "+document.all.pay_money.value+"元，"+document.all.cardy.value;
	//}

	//jkinfo="缴款额："+document.all.sum_money.value+"元 激活后赠费";
	//opr_info+=jkinfo+"|";
	//retInfo+=jkinfo+"|";//16
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";//20
	retInfo+=" "+"|";



		//retInfo+="注意事项：本次活动中赠送您的预存款不退不转。如您当前的资费为包年资费，"+"|";
		//retInfo+="在包年期间，包年所含项目费用优先从包年款中扣除，包年以外的费用可以从"+"|";
		//retInfo+="赠送的预存款(专款)中支付。赠送的预存款不能用于办理其他专款类业务"+"|";
		//retInfo+="(如包年、赠机类活动等)。赠送的预存款未消费完，不能办理销户业务。"+"|";
		//retInfo+="本次活动中的手机仅适用中国移动业务。"+"|";

		//retInfo+="业务到期前若申请取消，按违约规定您以优惠价购买的手机将按手机原价补交差额，"+"|";
		//retInfo+="并按剩余预存款的30%交纳违约金。"+"未涉及的资费，按现行的移动电话资费标准执行。"+"|";
		//retInfo+="本次活动手机适用中国移动业务。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";



	note_info1 =retInfo;
	note_info1+="      备注："+document.all.opNote.value+"|";
	//if(document.all.spec_fee.value!="0"){

		//note_info3+="您所定制的手机报业务到期日期为:"+document.all.used_date.value+",到期后如不想继续使用，请自行取消；如提前取消，费用不退不补。"+"|";
	//}else{
		retInfo+=" "+"|";
		note_info3+=" "+"|";
	//}
	//retInfo+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动"+"|"+"拆分的条数收费。"+"|";

	//note_info3+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动"+"|"+"拆分的条数收费。"+"|";
	
		//#23->#
		retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}




//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values
    
   myEle = document.createElement("option") ;
    myEle.value = "";
        myEle.text ="--请选择--";
        controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   
   
 } 
 function typechange(){
 
 	var myEle1 ;
   	var x1 ;
 
       document.all.sale_code.value="";
   	for ( x1 = 0 ; x1 < arrsalecode.length  ; x1++ )
   	{		
      		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebrand[x1] == document.all.agent_code.value)
      		{
        		document.all.sale_code.value=arrsalecode[x1];
        		document.all.cost_price.value=arrsalePrice[x1];
      		}
   	}
   	
			
 }
 


 
//-->
</script>


</head>


<body>
<form name="frm" method="post" action="f8609Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">集团客户统一付费赠机营销案</div>
	</div>
        <table cellspacing="0"  >
		 
          <tr> 
            <td class=blue>客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="cust_name" maxlength="20" v_name="姓名"> 
			  
            </td>
            <td class=blue>客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey"  id="cust_addr" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey"  id="cardId_type" maxlength="20" > 
			  
            </td>
            <td class=blue>证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey"  id="cardId_no" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey"  id="sm_code" maxlength="20" > 
			  
            </td>
            <td class=blue>运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="run_type" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>VIP级别</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey"  id="vip" maxlength="20" > 
			  
            </td>
            <td class=blue>可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey"  id="prepay_fee" maxlength="20" > 
			  
            </td>
            </tr>
             <tr> 
            <td class=blue>集团ID</td>
            <td>
			  <input name="vUnitId" value="<%=vUnitId%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitId" maxlength="20" > 
			  
            </td>
            <td class=blue>集团名称</td>
            <td>
			  <input name="vUnitName" value="<%=vUnitName%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitName" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>付费金额</td>
            <td>
			  <input name="vUnitPayFee" value="<%=vUnitPayFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitPayFee" maxlength="20" > 
			  
            </td>
            <td class=blue>已用金额</td>
            <td>
			  <input name="vUnitUsedFee" value="<%=vUnitUsedFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitUsedFee" maxlength="20" > 
			  
            </td>
            </tr>
            <tr> 
            <td class=blue>可用金额</td>
            <td>
			  <input name="vUnitAlowFee" value="<%=vUnitAlowFee%>" type="text"  v_must=1 readonly class="InputGrey"  id="vUnitAlowFee" maxlength="20" > 
			 
            </td>
            <td></td>
            <td>
			  
            </td>
            </tr>
             <tr> 
            <td class=blue>手机品牌</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">  
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class="orange">*</font>	
			</td>
	 <td class=blue>手机型号</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">	
			  	  
              </select>
			  <font class="orange">*</font>
			</td>
          </tr>
          <tr> 
         
         <td class=blue>手机成本价
            </td>
            <td>
			  <input type="text" name="cost_price" id="cost_price" readonly class="InputGrey"  v_name="手机成本价" >			  
             
			  
			</td>
            <td>
            </td>
            <td>
            	 <input type="hidden" name="sale_code" id="sale_code" v_name="营销代码" >	
			</td>
          </tr>
         <TR > 
			<TD  nowrap  class=blue> 
				<div align="left">IMEI码</div>
            </TD>
            <TD > 
				<input name="IMEINo"  type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
                <font class="orange">*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>
		  <TR  id=showHideTr > 
			<TD  nowrap> 
				<div align="left" class=blue>付机时间</div>
            </TD>
			<TD > 
				<input name="payTime"  type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font class="orange">*</font>                  
			</TD>
			<TD  nowrap class=blue> 
				<div align="left">保修时限</div>
			</TD>
			<TD > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm()">
				(个月)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr> 
            <td height="32"   class=blue>备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="集团客户统一付费赠机营销案" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()" disabled >
                &nbsp; 
                <input name="reset" type="reset"  class="b_foot"  value="清除" >
                &nbsp; 
                <input name="back"  class="b_foot"  onClick="history.go(-1)" type="button"  value="返回">
                &nbsp; </div></td>
          </tr>
        </table>
 
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="vUnitCotract" value="<%=vUnitCotract%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="16" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>