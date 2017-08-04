<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
 
	String opCode = request.getParameter("opcode");
	String opName = (String)request.getParameter("opName");	
	
	String loginNo =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");

%>
<%

	String retFlag="",retMsg=""; 
 
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

	//retList = impl.callFXService("s8608Qry", paraAray1, "13","phone",phoneNo);
	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="" ;
%>
 	<wtc:service name="s8608Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="13" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>	
		<wtc:param value="<%=paraAray1[3]%>"/>		
	</wtc:service>
	<wtc:array id="retList" scope="end"/>
<%  	
  	
  	String[][] tempArr= new String[][]{};
  	String errCode = retCode1;
  	String errMsg = retMsg1;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{		
	   retFlag = "1";
	   retMsg = "s8608Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {
	  if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			<!--
			rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
			 history.go(-1);
			//-->
		</script>
	  <%}
		if (errCode.equals("000000")){		
			  tempArr = retList;
			  if(tempArr!=null&&tempArr.length>0){
				    bp_name = tempArr[0][2];//机主姓名
				    System.out.println(bp_name);			 
				    bp_add = tempArr[0][3];//客户地址			 
				    cardId_type = tempArr[0][4];//证件类型			  
				    cardId_no = tempArr[0][5];//证件号码			
				    sm_code = tempArr[0][6];//业务品牌			 
				    region_name = tempArr[0][7];//归属地			 
				    run_name = tempArr[0][8];//当前状态			
				    vip = tempArr[0][9];//ＶＩＰ级别			
				    posint = tempArr[0][10];//当前积分			
				    prepay_fee = tempArr[0][11];//可用预存			
				    sale_name = tempArr[0][12];//绑定数据卡号码
			  }
		}
  }

%>
 <%  
	// **************得到冲正流水***************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
%>
<html>
<head>
<title>预存话费送笔记本</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script>
<script language="JavaScript">
<!--
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
	//显示打印对话框
	//显示打印对话框 		
	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
	var sysAccept ="<%=printAccept%>";                       // 流水号
	var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
	var mode_code=null;                        //资费代码
	var fav_code=null;                         //特服代码
	var area_code=null;                    //小区代码
	var opCode =   "<%=opcode%>";                         //操作代码
	var phoneNo = "<%=phoneNo%>";                           //客户电话		
	var h=162;
	var w=352;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    	
}

function printInfo(printType)
{ 	
  	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var retInfo = "";  //打印内容
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4 
	
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";
	
	opr_info+="业务类型：预存话费送笔记本--冲正"+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	return retInfo;	

}


//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f8608Cfm.jsp" onload="init()">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">预存话费送笔记本</div>
	</div> 
        <table   cellspacing="0" >
		<tr>
			<td class="blue">操作类型</td>
			<td colspan="3">预存话费送笔记本--冲正</td>		
		</tr>
		<tr>
			<td class="blue">客户姓名</td>
			<td>
				<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td class="blue">客户地址</td>
			<td>
				<input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey"  id="cust_addr" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
			<td>
				<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey"  id="sm_code" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td class="blue">运行状态</td>
			<td>
				<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">VIP级别</td>
			<td>
				<input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey" id="vip" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td class="blue">可用预存</td>
			<td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">预存话费</td>
			<td>
				<input name="limit_pay" type="text"   id="limit_pay" value="4700.00" readonly class="InputGrey" >
				<font class="orange">*</font>
			</td>
			<td class="blue">绑定数据卡号码</td>
			<td>
				<input name="gprs_phone" type="text"  id="gprs_phone" value="<%=sale_name%>" readonly class="InputGrey" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">备注</td>
			<td colspan="3">
				<input name="opNote" type="text" readonly class="InputGrey" id="opNote" size="60" maxlength="60" value="预存话费送笔记本--冲正" >
			</td>
		</tr>
	</table>	
	<table   cellspacing="0" >
		<tr>
			<td id="footer">
				<input name="confirm" class="b_foot_long" type="button"  index="2" value="确认&打印" onClick="printCommit()">
				&nbsp;
				<input name="reset" class="b_foot" type="reset"  value="清除" >
				&nbsp;
				<input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="返回">
				&nbsp; 
			</td>
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
	<input type="hidden" name="machine_type" value="<%=machine_type%>" >
	
	<input type="hidden" name="opName" value="<%=opName%>">
	 <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>