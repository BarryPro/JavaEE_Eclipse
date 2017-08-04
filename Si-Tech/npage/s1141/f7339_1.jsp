<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-23 页面改造,修改样式
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%		
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	
	
	String loginNo =  (String)session.getAttribute("workNo");
	String loginName =  (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");  
%>
<%
	String retFlag="",retMsg="";	
	//ArrayList retList = new ArrayList();
	String[] paraAray1 = new String[3];
	String phoneNo = request.getParameter("srv_no");
	String opcode = request.getParameter("opcode");
	String saleType = request.getParameter("saleType");
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


	//retList = impl.callFXService("s7160Qry", paraAray1, "13","phone",phoneNo);  	  	
	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
%>
	<wtc:service name="s7160Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>	
	<wtc:array id="retList" scope="end"/>	
<%
	String[][] tempArr= new String[][]{};
	String errCode =retCode1;
	String errMsg = retMsg1;
	if(retList == null)
	{
		System.out.println("retFlagaaaaaaaaaaaaaaaaaa="+retFlag);
		if(!retFlag.equals("1"))
		{
			System.out.println("retFlag="+retFlag);
			retFlag = "1";
			retMsg = "s7160Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
		}    
	}else if(!(retList == null))
	{	
		System.out.println("errCode="+errCode);  
  		System.out.println("retFlagbbbbbbbbbbbbbbbbbbbbb="+retFlag);
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
			  tempArr=retList;			 
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
				passwordFromSer = tempArr[0][12];//可用预存
			  }		  
		}
  	}

%>
<%
	//******************得到下拉框数据***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
	String exeDate="";
	exeDate = getExeDate("1","7188");
  	//comImpl co=new comImpl();
	//手机品牌
	String sqlAgentCode = " select paper_code,paper_name,paper_money,sp_code,oper_code,award_code,award_detailcode,gift_code,consume_term,server_code from sPaperGiftCfg where region_code='" + regionCode + "' and valid_flag='Y' and op_code= '" + opcode +"'";
	//ArrayList agentCodeArr = co.spubqry32("10",sqlAgentCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="10">
		<wtc:sql><%=sqlAgentCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeStr" scope="end" />
<%
	//String[][] agentCodeStr = (String[][])agentCodeArr.get(0); 
%>
<html>
<head>
<title>手机证券类业务营销</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script> 
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
	  for(int i=0;i<agentCodeStr.length;i++)
	  {
		out.println("arrpapercode["+i+"]='"+agentCodeStr[i][0]+"';\n");
		out.println("arrpapername["+i+"]='"+agentCodeStr[i][1]+"';\n");
		out.println("arrpapermoney["+i+"]='"+agentCodeStr[i][2]+"';\n");
		out.println("arrspcode["+i+"]='"+agentCodeStr[i][3]+"';\n");
		out.println("arropercode["+i+"]='"+agentCodeStr[i][4]+"';\n");
		out.println("arrawardcode["+i+"]='"+agentCodeStr[i][5]+"';\n");
		out.println("arrawarddetailcode["+i+"]='"+agentCodeStr[i][6]+"';\n");
		out.println("arrgiftcode["+i+"]='"+agentCodeStr[i][7]+"';\n");
		out.println("arrconsumeterm["+i+"]='"+agentCodeStr[i][8]+"';\n");
		out.println("arrservercode["+i+"]='"+agentCodeStr[i][9]+"';\n");
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
	 	getAfterPrompt();
	  //校验
	  //if(!check(frm)) return false;
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
		
		if(prepay_fee.value-paper_money.value<0){
			rdShowMessageDialog("预存款不够办理业务，请先缴费!");
			return false;
		}
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
	{  //显示打印对话框
		//显示打印对话框 		
		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept ="<%=printAccept%>";                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = <%=phoneNo%>;                           //客户电话		
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
		
		opr_info+="业务类型："+document.all.login_accept.value.substring(6)+"订购"+"|";
		opr_info+="业务流水："+document.all.login_accept.value+"|";
		opr_info+="订购类型："+document.all.paper_name.value+"|";
		
		note_info1+="如未满"+document.all.consume_term.value+"个付费月提前取消"+document.all.saleType.value.substring(6)+"业务，费用不退不补。业务到期后请您自行退订，如不取消将自动定制。"+"|";	
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
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
        				document.all.sp_code.value=arrspcode[x1] ;
        				document.all.oper_code.value=arropercode[x1] ;
        				document.all.award_code.value=arrawardcode[x1] ;
        				document.all.award_detailcode.value=arrawarddetailcode[x1] ;
        				document.all.gift_code.value=arrgiftcode[x1] ;
        				document.all.consume_term.value=arrconsumeterm[x1] ;
        				document.all.server_code.value=arrservercode[x1] ;
        				document.all.paper_name.value=arrpapername[x1] ;
      		}
   	}
 } 
 


//-->
</script>


</head>
<body>
<form name="frm" method="post" action="f7339Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
			<div id="title_zi">手机证券类业务营销</div>
	</div>   
        <table  cellspacing="0" >
		<tr> 
			<td class="blue">操作类型</td>
			<td colspan="3">sp业务-申请</td>		
		</tr>
		<tr> 
			<td class="blue">客户姓名</td>
			<td>
				<input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" > 
				<font class="orange">*</font>
			</td>
			<td class="blue">证件类型</td>
			<td>
				  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly  class="InputGrey" id="cardId_type" maxlength="20" > 
				  <font class="orange">*</font>
			</td>
		</tr>
		<tr style="display:none"> 
			<td class="blue">&nbsp;</td>
			<td>
				<input name="cust_addr" value="<%=bp_add%>" type="hidden" v_must=1 readonly  class="InputGrey" id="cust_addr" maxlength="20" > 
			</td>
			<td class="blue">&nbsp;</td>
			<td>
				  <input name="cardId_no" value="<%=cardId_no%>" type="hidden" v_must=1 readonly  class="InputGrey" id="cardId_no" maxlength="20" > 
			</td>
		</tr>
		<tr> 
			<td class="blue">业务品牌</td>
			<td>
				<input name="sm_code" value="<%=sm_code%>" type="text" v_must=1 readonly  class="InputGrey" id="sm_code" maxlength="20" > 
				<font class="orange">*</font>
			</td>
			<td class="blue">运行状态</td>
			<td>
				<input name="run_type" value="<%=run_name%>" type="text" v_must=1 readonly  class="InputGrey" id="run_type" maxlength="20" > 
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td class="blue">VIP级别</td>
			<td>
				<input name="vip" value="<%=vip%>" type="text" v_must=1 readonly  class="InputGrey" id="vip" maxlength="20" > 
				<font class="orange">*</font>
			</td>
			<td class="blue">可用预存</td>
			<td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text" v_must=1 readonly  class="InputGrey" id="prepay_fee" maxlength="20" > 
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td class="blue">业务类型</td>
			<td >
				<SELECT id="paper_code" name="paper_code" v_must=1  onchange="selectChange();" >  
					<option value ="">--请选择--</option>
					<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
					<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
					<%}%>
				</select>
				<font class="orange">*</font>	
			</td>
			<td class="blue">业务金额</td>
			<td>
				<input name="paper_money" type="text" id="paper_money" v_type="money" v_must=1   readonly  class="InputGrey">
				<font class="orange">*</font>	
			</td>
		</tr>     
		<tr> 
			<td   class="blue">备注</td>
			<td colspan="3" >
				<input name="opNote" type="text" id="opNote" readOnly  class="InputGrey" size="60" maxlength="60" value="<%=saleType.substring(6)%>订购" > 
			</td>
		</tr>
	</table>
	<table  cellspacing="0" >
		<tr> 
			<td id="footer"> 
				<input name="confirm" class="b_foot_long" type="button" index="2" value="确认&打印" onClick="printCommit()"  >
				&nbsp; 
				<input name="reset" class="b_foot" type="reset" value="清除" >
				&nbsp; 
				<input name="back" class="b_foot" onClick="history.go(-1)" type="button" value="返回">
				&nbsp; 
			</td>
		</tr>
	</table>
  
	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="sp_code" value="" >
	<input type="hidden" name="oper_code" value="" >
	<input type="hidden" name="award_code" value="" >  
	<input type="hidden" name="award_detailcode" value="" > 
	<input type="hidden" name="gift_code" value="" >
	<input type="hidden" name="server_code" value="" >
	<input type="hidden" name="consume_term" value="">
	<input type="hidden" name="paper_name" value="">
	<input type="hidden" name="saleType" value="<%=saleType%>">	
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	
	<%@ include file="/npage/include/footer.jsp" %>     
</form>
</body>
</html>
