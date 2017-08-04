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
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.math.*"%>
<%@ include file="../../page/bill/getMaxAccept.jsp" %>


<%		
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
%>
<%

String retFlag="",retMsg="";
 SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept = request.getParameter("backaccept");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;	    /* 操作流水   */

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

  retList = impl.callFXService("s8612Qry", paraAray1, "17","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="";
  String vip="",posint="",prepay_fee="",sale_name="";
  String mach="",machine_type="" ,unit_id="",unit_name="",unit_contract="";
  String[][] tempArr= new String[][]{};
  int errCode = impl.getErrCode();
  String errMsg = impl.getErrMsg();
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8612Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(errCode != 0 ){%>
<script language="JavaScript">
<!--
  	alert("错误代码<%=errCode%>错误信息<%=errMsg%>");
  	 //history.go(-1);
  	//-->
  </script>
  <%}
	if (errCode == 0 ){
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
	  tempArr = (String[][])retList.get(12);
	  if(!(tempArr==null)){
	    sale_name = tempArr[0][0];//营销方案名
	  }
	  tempArr = (String[][])retList.get(13);
	  if(!(tempArr==null)){
	    machine_type = tempArr[0][0];//机器类型
	  }
	  tempArr = (String[][])retList.get(14);
	  if(!(tempArr==null)){
	    unit_contract = tempArr[0][0];//帐号
	  }
	  tempArr = (String[][])retList.get(15);
	  if(!(tempArr==null)){
	    unit_id = tempArr[0][0];//unitid
	  }
	  tempArr = (String[][])retList.get(16);
	  if(!(tempArr==null)){
	    unit_name = tempArr[0][0];//集团名称
	  }
	}else{
		
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   

  String[][] favInfo = (String[][])arrSession.get(3);   //数据格式为String[0][0]---String[n][0]
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
  if(!pwrf)
  {
     String passFromPage=Encrypt.encrypt(passTrans);
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
	   if(!retFlag.equals("1"))
	   {
	      retFlag = "1";
          retMsg = "密码错误!";
	   }
	    
    }       
  }
// **************得到冲正流水***************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>集团客户统一付费赠机营销案</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>
<script language="JavaScript">

<!--
 
  
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 
 
 function printCommit()
 
 { 
  //校验
  //if(!check(frm)) return false;
  
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
/***
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}
***/

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

/**
function printInfo(printType)
{
 	var retInfo = "";
	retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="用户号码："+document.all.phone_no.value+"|";
	retInfo+="用户姓名："+document.all.cust_name.value+"|";
	retInfo+="用户地址："+document.all.cust_addr.value+"|";
	retInfo+="证件号码："+document.all.cardId_no.value+"|";
	retInfo+="集团帐号："+document.all.unit_contract.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="业务类型：集团客户统一付费赠机营销案--冲正"+"|";
  retInfo+="业务流水："+document.all.login_accept.value+"|";
  retInfo+="手机型号: "+"<%=machine_type%>"+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";	
    return retInfo;	
}

**/
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

  	opr_info+="手机型号："+document.all.machine_type.value;


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
</head>
<body>
<form name="frm" method="post" action="f8612Cfm.jsp" onload="init()">
 
<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">集团客户统一付费赠机营销案冲正</div>
	</div>
        <table  cellspacing="0"   >
 
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
            <td class=blue>营销方案</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text"  v_must=1 readonly class="InputGrey"  id="sale_name" maxlength="20" size="40"> 
			    
			</td>
			<td  class=blue>机型名称</td>
            <td >
			  <input name="machine_type" type="text"  id="machine_type" value="<%=machine_type%>" readonly class="InputGrey" >
			  
			</td>            
          </tr>
          <tr> 
            <td  class=blue>集团ID</td>
            <td >
			  <input name="unit_id" type="text"  id="unit_id" value="<%=unit_id%>" readonly class="InputGrey"   >
			  	
			</td>
            <td class=blue>集团名称</td>
            <td>
			  <input name="unit_name" type="text"   id="unit_name" value="<%=unit_name%>" readonly class="InputGrey" >
			  
			</td>
          </tr>
          <tr> 
            
            <td class=blue>集团帐号</td>
            <td><input name="unit_contract" type="text"   id="unit_contract" value="<%=unit_contract%>" readonly class="InputGrey" >
			  		</td>
			  		<td class=blue>&nbsp;</td>
			  		<td class=blue>&nbsp;</td>
          </tr> 
          <tr> 
            <td height="32"  class=blue >备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="集团客户统一付费赠机营销案--冲正" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot_long" index="2" value="确认&打印" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot"  value="清除" >
                &nbsp; 
                <input name="back" onClick="removeCurrentTab();" class="b_foot"  type="button"  value="返回">
                &nbsp; </div></td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	  <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	  <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	  <input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	  <input type="hidden" name="point_money" value="0" > 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>