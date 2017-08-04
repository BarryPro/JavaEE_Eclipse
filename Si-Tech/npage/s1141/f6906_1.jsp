<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%		
String opCode = request.getParameter("opcode_cz");
System.out.println("opCodeopCode="+opCode);
String opName="";
if(opCode.equals("6906"))
{
	opName = "集团客户短期预存回馈冲正";
}
else
{
	opName="集团客户中长期预存回馈冲正";
}
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);
  

  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  String oldLoginAccept=request.getParameter("backaccept");
  String sql1 = " select to_char(count(*)) from shighlogin where login_no=:loginNo1 and op_code=:opCode2 ";

 String [] paraIn = new String[2];
  paraIn[0] = sql1;    
  paraIn[1]="loginNo1="+loginNo+",opCode2="+opCode;
  %>
  <wtc:service name="TlsPubSelCrm" routerKey="login_no" routerValue="<%=loginNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=paraIn[0]%>"/>
    <wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="logincount" scope="end" />
	<%
if(logincount[0][0].equals("0")){
	System.out.println("dddddddddddddddddddddd");
%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("此工号没有权限");
  	history.go(-1);
  	//-->
</script>
<%}%>
  <%
  String[] paraAray1 = new String[4];  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opCode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = oldLoginAccept;	    /* 旧流水   */

  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }

 
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
  String paper_code="",paper_money="";
  String payType = "";/*** tianyang add for 支票交费 ****/
 %>
		<wtc:service name="s6906Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="23" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		</wtc:service>
		<wtc:array id="s7160QryArr" scope="end"/>
<%
	  int errCode = retCode1==""?999999:Integer.parseInt(retCode1);
	  String errMsg = retMsg1;

  	if(errCode != 0){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
	  	 	history.go(-1);
	  	//-->
	  </script>
  <%
  		return;
  	}
  	
  	if(s7160QryArr!=null&&s7160QryArr.length>0){
				bp_name = s7160QryArr[0][2];//机主姓名
				bp_add = s7160QryArr[0][3];//客户地址
				cardId_type = s7160QryArr[0][4];//证件类型
				cardId_no = s7160QryArr[0][5];//证件号码
				sm_code = s7160QryArr[0][6];//业务品牌
				region_name = s7160QryArr[0][7];//归属地
				run_name = s7160QryArr[0][8];//当前状态
				vip = s7160QryArr[0][9];//ＶＩＰ级别
				posint = s7160QryArr[0][10];//当前积分
				prepay_fee = s7160QryArr[0][11];//可用预存
				paper_code = s7160QryArr[0][12];//集团ID
				paper_money= s7160QryArr[0][13];//集团名称
				vUnitId= s7160QryArr[0][14];//单位地址
				vUnitName= s7160QryArr[0][15];//单位邮编
				vUnitAddr= s7160QryArr[0][16];//集团工号
				vUnitZip= s7160QryArr[0][17];//集团工号名称
				vServiceNo= s7160QryArr[0][18];//集团工号
				vServiceName= s7160QryArr[0][19];//集团工号名称
				vContactPhone= s7160QryArr[0][20];//联系电话
				vContactPost= s7160QryArr[0][21];//个人邮编
				
				/********************** tianyang add for 支票缴费 start *********************************/
				if(s7160QryArr[0][22] != null && s7160QryArr[0][22].trim().length() > 0){
					payType = s7160QryArr[0][22].trim();
				}else{
					payType = "0";
				}
				System.out.println("---------------- payType ------------------" + payType);
				/********************** tianyang add for 支票缴费 end *********************************/
				
				
				
  	}else{
 	%>
				<script language="JavaScript">
					<!--
			  		rdShowMessageDialog("s7160Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg);
			  	 	parent.removeTab("<%=opCode%>");
			  	//-->
			  </script>
<%    		
  	}

			String printAccept="";
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=phoneNo%>" id="sLoginAccept"/>
<%
			printAccept = sLoginAccept;
%>
			
<html>
<head>
<title>"<%=opName%>"</title>
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
 

	
  //***
  function frmCfm(){
	 	frm.submit();
		return true;
  }
 //***IMEI 号码校验
 
 function printCommit()
 { 
  getAfterPrompt();//add by qidp
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
		
		/*if(prepay_fee.value-paper_money.value<0){
			rdShowMessageDialog("预存款不够办理业务，请先缴费!");
			return false;
		}*/
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
  }else{
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
	var pType="subprint";   
	var billType="1";  
	var sysAccept = document.all.login_accept.value;   
   var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="集团编号："+"<%=vUnitId%>"+"|";
	cust_info+="集团名称："+"<%=vUnitName%>"+"|";

	opr_info+="办理业务："+"<%=opName%>"+"|";
    opr_info+="业务流水："+document.all.login_accept.value+"|";
    
        
    
    
    /*opr_info+="客户预存款："+document.all.paper_money.value+"|";*/
    if("<%=payType%>"=="9"){//tiangyang add for 支票
    	opr_info+="客户预存款：支票"+document.all.paper_money.value+"元|";
    }else{
    	opr_info+="客户预存款：现金"+document.all.paper_money.value+"元|";
    }
    
    
       
    
    
    
	opr_info+="赠送礼品："+document.all.prepay_code.value+"|";
	/*opr_info+="赠送时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";*/
  	note_info1="备注："+document.all.opNote.value+"|";
  	
  
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
   return retInfo;	
}
//-->
</script>


</head>

<body>
		<form name="frm" method="post" action="f6906Cfm.jsp" onKeyUp="chgFocus(frm)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">操作类型：<%=opName%> </div>
			</div>

			<table cellspacing="0">
				<tr>
			        <td class="blue" width="15%">集团ID</td>
			        <td width="35%">
			            <input name="vUnitId" value="<%=vUnitId%>" type="text" class="InputGrey" v_must=1 readonly id="vUnitId">
			        </td>
			        <td class="blue" width="15%">集团名称</td>
			        <td width="35%">
			            <input name="vUnitName" size="60" value="<%=vUnitName%>" type="text" class="InputGrey" v_must=1 readonly id="vUnitName">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue" width="15%">客户姓名</td>
			        <td width="35%">
			            <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name">
			        </td>
			        <td class="blue" width="15%">客户地址</td>
			        <td width="35%">
			            <input name="cust_addr" size="60" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">证件类型</td>
			        <td>
			            <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20">
			        </td>
			        <td class="blue">证件号码</td>
			        <td>
			            <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">业务品牌</td>
			        <td>
			            <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code">
			
			        </td>
			        <td class="blue">运行状态</td>
			        <td>
			            <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type">
			
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">VIP级别</td>
			        <td>
			            <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20">
			
			        </td>
			        <td class="blue">可用预存</td>
			        <td>
			            <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee">
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">业务类型</td>
			        <td>
			            <input name="prepay_code" value="<%=paper_code%>" type="text" class="InputGrey" v_must=1 readonly id="paper_code">
			        </td>
			        <td class="blue">业务金额</td>
			        <td>
			            <input name="paper_money" value="<%=paper_money%>"  type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
			        </td>
			    </tr>
			    <tr>
			        <td class="blue">备注</td>
			        <td colspan="3">
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="<%=opName%>" readonly >
			        </td>
			    </tr>
			    <tr>
			        <td colspan="4" id="footer">
			            <input class="b_foot" name="confirm" type="button" index="2" value="确认&打印" onClick="printCommit()">
			            <input class="b_foot" name="reset" type="reset" value="清除">
			            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			        </td>
			    </tr>
			</table>		
       <%@ include file="/npage/include/footer.jsp" %>
		<input type="hidden" name="phone_no" value="<%=phoneNo%>">
		<input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opcode" value="<%=opCode%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="sp_code" value="" >
		<input type="hidden" name="oper_code" value="" >
		<input type="hidden" name="award_code" value="" >  
		<input type="hidden" name="award_detailcode" value="" > 
		<input type="hidden" name="gift_code" value="" >
		<input type="hidden" name="server_code" value="" >
		<input type="hidden" name="consume_term" value="">
		<input type="hidden" name="paper_name" value="">
		<input type="hidden" name="op_name" value="<%=opName%>">
		<input type="hidden" name="old_accept" value="<%=oldLoginAccept%>">
		<input type="hidden" name="payType"  value="<%=payType%>" ><!-- tianyang add for 支票缴费 -->
	</form>
</body>
</html>



