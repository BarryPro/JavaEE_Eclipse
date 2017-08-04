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
String opCode = request.getParameter("opcode_new");
System.out.println("opCodeopCode="+opCode);
String opName="";
if(opCode.equals("6905"))
{
	opName = "集团客户短期预存回馈";
}
else
{
	opName="集团客户中长期预存回馈";
}
	    
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");  
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);

  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  String sql1 = " select to_char(count(*)) from shighlogin where login_no=:loginNo1 and op_code=:opCode2";
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
  String[] paraAray1 = new String[3];  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opCode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */

  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }
  

  //retList = impl.callFXService("s7160Qry", paraAray1, "22","phone",phoneNo);
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
 %>
		<wtc:service name="s2294Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="22" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
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
				vUnitId = s7160QryArr[0][12];//集团ID
				vUnitName= s7160QryArr[0][13];//集团名称
				vUnitAddr= s7160QryArr[0][14];//单位地址
				vUnitZip= s7160QryArr[0][15];//单位邮编
				vServiceNo= s7160QryArr[0][16];//集团工号
				vServiceName= s7160QryArr[0][17];//集团工号名称
				vContactPhone= s7160QryArr[0][18];//联系电话
				vContactPost= s7160QryArr[0][19];//个人邮编
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
		  String sqlAgentCode = " select paper_code,paper_name,paper_money,award_code,award_detailcode,gift_code,to_char(consume_term) from sPaperGiftCfg where region_code=:regionCode1 and valid_flag='Y' and op_code=:opCode1";
		  System.out.println("sqlAgentCode====="+sqlAgentCode);
		   System.out.println("regionCode1====="+regionCode);
		   System.out.println("opCode1====="+opCode);
			paraIn[0] = sqlAgentCode;    
			paraIn[1]="regionCode1="+regionCode+",opCode1="+opCode;
%>
			<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="7">
				<wtc:param value="<%=paraIn[0]%>"/>
        		<wtc:param value="<%=paraIn[1]%>"/>
        	</wtc:service>
			<wtc:array id="agentCodeStr" scope="end" />		
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
 
<%  
System.out.println("agentCodeStr.lengthagentCodeStr.length="+agentCodeStr.length);
  for(int i=0;i<agentCodeStr.length;i++)
  {
	out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
	out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
	out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
	out.println("arrawardcode["+i+"]='"+agentCodeStr[i][3]+"';\n");
	out.println("arrawarddetailcode["+i+"]='"+agentCodeStr[i][4]+"';\n");
	out.println("arrgiftcode["+i+"]='"+agentCodeStr[i][5]+"';\n");
	out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][6]+"';\n");
	System.out.println("agentCodeStr[i][5]="+agentCodeStr[i][5]);
	System.out.println("agentCodeStr[i][6]="+agentCodeStr[i][6]);

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
  getAfterPrompt();//add by qidp
  
	/********* tianyang add for 支票缴费 start ************/
	with(document.frm){
		if (payTypeSelect.value=="9")
		{
			if(currentMoney.value=="")
			{
				rdShowMessageDialog("请校验支票号码！");
				checkNo.focus();
				return false;
			}
			if (parseFloat(currentMoney.value)<parseFloat(paper_money.value))
			{
				rdShowMessageDialog("请注意，支票金额不足！");
				checkNo.focus();
				return false;
			}
		}
	}
	/********* tianyang add for 支票缴费 end ************/
	
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
    if(document.all.payTypeSelect.value=="9"){//tianyang add for 支票
    	opr_info+="客户预存款：支票"+document.all.paper_money.value+"元|";
    }else{
    	opr_info+="客户预存款：现金"+document.all.paper_money.value+"元|";
    }
	opr_info+="赠送礼品："+document.all.paper_name.value+"|";
	opr_info+="赠送时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  	note_info1="备注："+document.all.opNote.value+"|";
	if(document.all.payTypeSelect.value=="9"){//tianyang add for 支票
 	 	note_info2="通过支票缴费方式办理的集团客户预存话费赠机（集团预存赠礼）业务，只能当日冲正|";//tianyang add for 支票
	}
  
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
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
	  				document.all.award_code.value=arrawardcode[x1] ;
	  				document.all.award_detailcode.value=arrawarddetailcode[x1] ;
	  				document.all.gift_code.value=arrgiftcode[x1] ;
	  				document.all.consume_term.value=arrconsumeterm[x1] ;
	  				document.all.paper_name.value=arrpapername[x1] ;
			}
 	}
 } 
 
 
/********* tianyang add for 支票缴费 start ************/
function selType()
{
	with(document.frm)
	{
		if ( payTypeSelect.value=="9" ){
			CheckId.style.display="block";
			CheckId2.style.display="block";
		}else{
			CheckId.style.display="none";
			CheckId2.style.display="none";
		}
	}
}
function getBankCode()
{
 		 var h=480;
		 var w=650;
		 var t=screen.availHeight/2-h/2;
		 var l=screen.availWidth/2-w/2;

	      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
          var returnValue=window.showModalDialog('/npage/public/getBankCode.jsp?region_code=<%=orgCode.substring(0,2)%>&district_code=<%=orgCode.substring(2,4)%>&bank_name='+frm.BankName.value+'&bank_code='+frm.BankCode.value,"",prop);

          document.frm.currentMoney.value='';
 		  if(returnValue==null)
	     {
					rdShowMessageDialog("你输入的条件没有查到相应的银行！");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }

 		  if(returnValue=="")
	     {
					rdShowMessageDialog("您没有选择银行！");
					document.frm.BankCode.value="";
					document.frm.BankName.value="";
					return false;
		  }
		 else
		 {
			 var chPos_str = returnValue.indexOf(",");
			 document.frm.BankCode.value=returnValue.substring(0,chPos_str);
			 document.frm.BankName.value=returnValue.substring(chPos_str+1);
   		 }
}
function getcheckfee()
{
	var bankcode = document.all.BankCode.value;
	var checkno = document.all.checkNo.value;
	if (bankcode=="")
	{
		rdShowMessageDialog("请输入或查询银行!");
 	    return false;
	}
	if (checkno=="")
	{
		rdShowMessageDialog("请输入支票号码!");
		document.all.checkNo.value="";
	    document.all.checkNo.focus();
	     return false;
    }
 	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str=window.showModalDialog('/npage/public/getcheckfee.jsp?bankcode='+bankcode+'&checkno='+checkno,"",prop);
	if( str==null )
		{
 	   		rdShowMessageDialog("没有找到该支票的余额！");
		    document.frm.currentMoney.value = "";
	   		document.frm.checkNo.focus();
	   		return false;
		}

		document.frm.currentMoney.value = str;
	    return true;
 }
 /********* tianyang add for 支票缴费 end ************/
//-->
</script>
</head>

<body>
		<form name="frm" method="post" action="f6905Cfm.jsp" onKeyUp="chgFocus(frm)">
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
			            <SELECT id="paper_code" name="paper_code" v_must=1 onchange="selectChange();">
			                <option value="">--请选择--</option>
			                <%for (int i = 0; i < agentCodeStr.length; i++) {%>
			                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%>
			                </option>
			                <%}%>
			            </select>
			        </td>
			        <td class="blue">业务金额</td>
			        <td>
			            <input name="paper_money" type="text" class="InputGrey" id="paper_money" v_type="money" v_must=1 readonly>
			        </td>
			    </tr>
			    <!-- tianyang add for 支票缴费 start -->
				<tr>
					<td class="blue">缴费方式</td>
					<td colspan="3">
					<select name="payTypeSelect" onClick="selType()">
						<option value="0">现金缴费</option>
						<option value="9">支票缴费</option>
					</select>
					</td>
				</tr>
				<tr id="CheckId" style="display:none">
					<td class="blue" noWrap>银行代码</td>
					<td noWrap>
					<input name="BankCode" size="12" maxlength="12">
					<input name="BankName" size="13" onKeyDown="if(event.keyCode==13)getBankCode();" >
					<input name="bank1CodeQuery" type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value="查询" >
					</td>
					<td class="blue" noWrap>支票号码</td>
					<td noWrap>
					<input type="text" name="checkNo" maxlength="20" value="" onKeyDown="if(event.keyCode==13)getcheckfee();" onChange="document.frm.currentMoney.value=''">
					<input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getcheckfee()" value="查询">
					</td>
		
				</tr>
				<tr id="CheckId2" style="display:none">
					<td class="blue" noWrap>可用金额</td>
					<td noWrap colspan="3">
					<input type="textarea" readonly name="currentMoney">
					</td>
				</tr>
				<!-- tianyang add for 支票缴费 end -->
			    <tr>
			        <td class="blue">备注</td>
			        <td colspan="3">
			            <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="<%=opName%>" readonly >
			        </td>
			    </tr>
			</table>

			<table cellspacing="0">
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
	</form>	
</body>

</html>
