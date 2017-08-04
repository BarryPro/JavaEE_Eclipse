<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		
  String OpCode = "8679";
  String opCode = "8679";
  String opName = "积分换G3上网本冲正";	 
  
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");   
  String groupId = (String)session.getAttribute("groupId");
  String orgCode = (String)session.getAttribute("orgCode");
  String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;

  /*****王梅 添加 20060605*****/
  
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		
  //retArray = callView.sPubSelect("1",sqlStr);
 %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
 <% 
  //result = (String[][])retArray.get(0);
  if(result != null && result.length > 0)
  	awardName = result[0][0];	
    System.out.println("awardName="+awardName);
    
  if(!awardName.equals("")){
 %>
  //rdShowMessageDialog("此用户为已中奖用户，中奖奖品为："<%=awardName%>", 请用户完好无损返回奖品，再继续办理冲正业务！");
   if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
	{	
		location='f8678_login.jsp';
	}
	  
	</script>
  
<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		
  //retArray = callView.sPubSelect("1",sqlStr);
%>
   <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
     <wtc:sql><%=sqlStr%>
     </wtc:sql>
     </wtc:pubselect>
   <wtc:array id="result2" scope="end"/>  
<%  
  if(result2 != null && result2.length > 0)
  {
	  awardName = result2[0][0];		  
	  System.out.println("awardName2="+awardName);
  	  if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		  	rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			location='f8678_login.jsp';
		  </script>
<%	  }
  }
	String IMEINo="";
	sqlStr="select imei_no from wMachSndOprhis where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept; 
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
  	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	if(retArray!=null&& retArray.length > 0){
		IMEINo = retArray[0][0];
		System.out.println("IMEINo="+IMEINo);
	}
/*****王梅 添加 20060605*******/

  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别 ，当前积分，用户预存，
 			营销方案名，应付金额，卡金额，卡张数串，赠送话费，销费积分数
 */
  //retList = impl.callFXService("s8679Qry", paraAray1, "24","phone",phoneNo);
%>  
  <wtc:service name="s8679Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="26" >
	<wtc:param value="<%=paraAray1[0]%>"/>
    <wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",phone_money="",net_money="",pay_money="",used_point="",consume_term="",type_name="";
  String active_term="";

  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(tempArr == null))
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
  	if(!errCode.equals("000000")){%>
    	<script language="JavaScript">
    	<!--
  	  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);  	  	
  	  	history.go(-1);
  		//-->
        </script>
  <%}
	if (errCode.equals("000000")){
	 
	    bp_name = tempArr[0][2];                //机主姓名
	    bp_add = tempArr[0][3];                 //客户地址	 
	    cardId_type = tempArr[0][4];            //证件类型	 
	    cardId_no = tempArr[0][5];              //证件号码	
	    sm_code = tempArr[0][6];                //业务品牌	
	    region_name = tempArr[0][7];            //归属地	
	    run_name = tempArr[0][8];               //当前状态	 
	    vip = tempArr[0][9];                    //ＶＩＰ级别	 
	    posint = tempArr[0][10];                //当前积分	 
	    prepay_fee = tempArr[0][11];            //可用预存	 
	    sale_name = tempArr[0][12];             //营销方案名	
	    sum_money = tempArr[0][13];             //应付金额	 
	    phone_money = tempArr[0][14];           //上网本费	 
	    net_money = tempArr[0][15];             //上网费	 
	    pay_money = tempArr[0][16];             //赠送话费	 
	    used_point = tempArr[0][17];            //消费积分数 
	    consume_term = tempArr[0][18];          //话费消费期限	  
	    type_name = tempArr[0][19];             //上网本型号	 
	    active_term = tempArr[0][20];            //上网费消费期限	   
	    ///////<!-- ningtn add for pos start @ 20100722 -->
		if(tempArr[0][21] != null && tempArr[0][21].trim().length() > 0){
			payType = tempArr[0][21].trim();
		}else{
			payType = "0";
		}
		Response_time = tempArr[0][22].trim();
		TerminalId = tempArr[0][23].trim();
		Rrn = tempArr[0][24].trim();
		Request_time = tempArr[0][25].trim();
		
		System.out.println("payType : " + payType);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Rrn : " + Rrn);
		System.out.println("Request_time : " + Request_time);
		///////<!-- ningtn add for pos end @ 20100722 -->
	}
  }

%>
<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept); 
%>
<head>
<title>积分换G3上网本冲正</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language=javascript>
 
  onload=function()
  {		
  }  
 </script>
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
  var arrsaleName =new Array();
  var arrsalebarnd=new Array();
  var arrsaletype =new Array();
	
  //***
  function frmCfm(){
	document.frm.confirm.disabled=true;
 	/* ningtn add for pos start @ 20100722 */
		if(document.all.payType.value=="BX")
		{
			/*set 输入参数*/
			var transerial    = "000000000000";  	                  	//交易唯一号 ，将会取消
			var trantype      = "01";                                  	//交易类型
			var bMoney        = "<%=sum_money%>";					 		//缴费金额
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                        	//交易操作员
			var orgid         = "<%=groupId%>";                        	//营业员归属机构
			var trannum       = "<%=phoneNo%>";                    		//电话号码
			getSysDate();       /*取boss系统时间*/
			var respstamp     = document.all.Request_time.value;       	//提交时间
			var transerialold = "<%=Rrn%>";			    				//原交易唯一号,在缴费时传入空
			var org_code      = "<%=orgCode%>";                        	//营业员归属						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "04";																	/*交易类型 */         
			var bMoney        = "<%=sum_money%>";							/*交易金额 */         
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var response_time = "<%=Response_time%>";                 	/*原交易日期 */       
			var rrn           = "<%=Rrn%>";                           	/*原交易系统检索号 */ 
			var instNum       = "";                                   	/*分期付款期数 */     
			var terminalId    = "<%=TerminalId%>";                    	/*原交易终端号 */
			getSysDate();       //取boss系统时间                                            
			var request_time  = document.all.Request_time.value;      	/*交易提交日期 */     
			var workno        = "<%=loginNo%>";                       	/*交易操作员 */       
			var orgCode       = "<%=orgCode%>";                       	/*营业员归属 */       
			var groupId       = "<%=groupId%>";                       	/*营业员归属机构 */   
			var phoneNo       = "<%=phoneNo%>";                   		/*交易缴费号 */       
			var toBeUpdate    = "";						          		/*预留字段 */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		/* ningtn add for pos end @ 20100722 */
  }
  /* ningtn add for pos start @ 20100722 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
 /* ningtn add for pos start @ 20100722 */
 //***
 function printCommit()
 { 
  getAfterPrompt();
  with(document.frm){
	opNote.value=phone_no.value+"办理积分换G3上网本冲正业务";
	//phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
	else{
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
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          // 票价类型：1电子免填单、2发票、3收据
   var sysAccept=document.all.login_accept.value;             // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="8679";                                         //操作代码
   var phoneNo=document.all.phone_no.value;                   //客户电话
 
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
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
    
    cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	
	opr_info+="业务类型：积分换G3上网本冲正"+"|";
    opr_info+="业务流水："+document.all.login_accept.value+"|";
    opr_info+="上网本品牌型号: "+document.all.type_name.value+"|";
    opr_info+="IMEI码： "+"<%=IMEINo%>"+"|";

	var jkinfo="";

	jkinfo+="退款合计："+document.all.sum_money.value+"元　其中：话费"+document.all.pay_money.value+"元，上网费"+document.all.net_money.value+"元，退积分"+document.all.used_point.value+"分|";

	opr_info+=jkinfo+"|";
    note_info1="备注："+document.all.opNote.value+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");	
    return retInfo;	
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f8679_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">积分换G3上网本冲正</div>
		</div>
        <table cellspacing="0">
		  <tr> 
            <td class="blue">操作类型</td>
            <td colspan="3">积分换G3上网本冲正</td>         
          </tr>
          <tr> 
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name"> 
            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" size="40"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type"> 
            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code"> 
            </td>
            <td class="blue">运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">当前积分</td>
            <td>
			  <input name="posint" value="<%=posint%>" type="text" Class="InputGrey" v_must=1 readonly id="posint"> 
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee"> 
            </td>
          </tr>                   
          <tr>          
            <td class="blue">营销方案</td>
            <td>
			  <input type="text" name="sale_code" Class="InputGrey" readonly id="sale_code" value="<%=sale_name%>" >			            
			</td>
			<td class="blue">购上网本款</td>
			<td>
			  <input type="text" name="phone_money" Class="InputGrey" readonly id="phone_money" value="<%=phone_money%>" >			            
			</td>             
          </tr>
          <tr> 
            <td class="blue">赠送话费</td>
            <td>
			  <input name="pay_money" type="text" Class="InputGrey" id="pay_money" v_type="0_9" v_must=1 readonly value="<%=pay_money%>">
			</td>
			<td class="blue">话费消费期限</td>
             <td>
			  <input name="consume_term" type="text" Class="InputGrey" id="consume_term" v_type="money" v_must=1 readonly value="<%=consume_term%>">
			</td>
          </tr>          
          <tr>           
            <td class="blue">赠送上网费</td>
            <td>
			  <input type="text" name="net_money" Class="InputGrey" id="net_money"  readonly value="<%=net_money%>">			  
			</td>                      
            <td class="blue">上网费消费期限</td>
            <td>
			  <input type="text" name="active_term" Class="InputGrey" id="active_term" value="<%=active_term%>" readonly>			  
			</td>
		  </tr>          
          <tr> 
          	 <td class="blue">退积分</td>
            <td>
			  <input name="used_point" type="text" Class="InputGrey" id="used_point" readonly value="<%=used_point%>">
			</td>
            <td class="blue">应付金额</td>
            <td>
			  <input name="sum_money" type="text" Class="InputGrey" id="sum_money" readonly value="<%=sum_money%>">
			</td>           
          </tr> 
          <tr style="display:none"> 
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="积分换G3上网本冲正"> 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> 
            	<div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">              
                <input name="reset" type="reset" class="b_foot" value="清除" >            
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="返回">
                </div>
            </td>
          </tr>
        </table>
  
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="sale_type" value="0" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="type_name" value="<%=type_name%>">
    <input type="hidden" name="IMEINo" value="<%=IMEINo%>" >
    <!-- ningtn add for pos start @ 20100722 -->
	<input type="hidden" name="payType"  value="<%=payType%>" ><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->
	<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
	<input type="hidden" name="MerchantId"  value="">
	<input type="hidden" name="TerminalId"  value="">
	<input type="hidden" name="IssCode"  value="">
	<input type="hidden" name="AcqCode"  value="">
	<input type="hidden" name="CardNo"  value="">
	<input type="hidden" name="BatchNo"  value="">
	<input type="hidden" name="Response_time"  value="">
	<input type="hidden" name="Rrn"  value="">
	<input type="hidden" name="AuthNo"  value="">
	<input type="hidden" name="TraceNo"  value="">
	<input type="hidden" name="Request_time"  value="">
	<input type="hidden" name="CardNoPingBi"  value="">
	<input type="hidden" name="ExpDate"  value="">
	<input type="hidden" name="Remak"  value="">
	<input type="hidden" name="TC"  value="">
	<!-- ningtn add for pos start @ 20100722 -->
    <%@ include file="/npage/include/footer.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>


