 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-08 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = "1298";	
	String opName = "12580移动秘书台销户";		//header.jsp需要的参数     
	String loginNo = (String)session.getAttribute("workNo");    //工号 		   
	String regionCode = (String)session.getAttribute("regCode"); 
	String orgCode=(String)session.getAttribute("orgCode"); 
	
%>
<%
  	String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
	/************************由移动号码得到密码、机主姓名等基本信息 s1297_Valid*******************************************/
  	
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String passwordFromSer="";

  	paraAray1[0] = loginNo; 	/* 操作工号   */
  	paraAray1[1] = phoneNo;		/* 手机号码   */
  	paraAray1[2] = "1298";		/* 操作代码   */
  	paraAray1[3] = orgCode;	/* 归属代码   */
	  for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
  	}

  	//String[] ret = impl.callService("s1297_Valid",paraAray1,"23","phone",phoneNo);
  %>
  	<wtc:service name="s1297_Valid" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="24" >
			<wtc:param value=""/>
			<wtc:param value="01"/>		
			<wtc:param value="<%=paraAray1[2]%>"/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[1]%>"/>
			<wtc:param value=""/>  		
			<wtc:param value="<%=paraAray1[3]%>"/>	
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
  <%
  	String run_code="",bp_name="",hand_fee="",should_hand_fee="",sm_code="",idNo="",cmd_right="",favourCode="",cardId_type ="", cardId_no="",contract_phone="",cust_address="",print_note="",prepay_fee="",year_flag="";	
  	String errCode=retCode1;
  	String errMsg=retMsg1;
  if(ret == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1297_Valid查询号码基本信息为空!<br>errCode: " + errCode + "<br>" + errMsg;
    }
  }else if(!(ret == null))
  {
	if (errCode.equals("000000")){
	  run_code = ret[0][8];//运行状态
     	  bp_name = ret[0][5];//机主姓名
          hand_fee = ret[0][9];//手续费
	  should_hand_fee = ret[0][9];//应收手续费
	  sm_code = ret[0][3];//业务类型
	  idNo = ret[0][2];//用户id
	  cmd_right = ret[0][16];//cmd_right
	  passwordFromSer = ret[0][6];//密码
	  favourCode = ret[0][17];//手续费优惠代码
	  cardId_type = ret[0][18];//证件类型
	  cardId_no = ret[0][19];//证件号码
	  contract_phone = ret[0][21];//联系电话
	  cust_address = ret[0][20];//地址
	  prepay_fee = ret[0][22];//预存款
	  print_note = ret[0][13];//广告词
	}else{
	  if(!retFlag.equals("1"))
	  {
	    retFlag = "1";
	    retMsg = "s1297_Valid查询号码基本信息失败!<br>errCode: " + errCode + "<br>" + errMsg;
      }
	}
  }

	//********************得到营业员权限，核对密码，并设置优惠权限*****************************//
   	//优惠信息 	 
 		String[][]  favInfo = (String[][])session.getAttribute("favInfo");
  	boolean pwrf = false;//a272 密码免验证
  	String handFee_Favourable = "readonly";        //a230  手续费优惠
  	int infoLen = favInfo.length;
	  String tempStr = "";
	  for(int i=0;i<infoLen;i++)
	  {
	    tempStr = (favInfo[i][0]).trim();
	    if(tempStr.compareTo(favourCode) == 0)
	    {
	      handFee_Favourable = "";
	    }
	  }
	  //2011/9/2  diling 添加 对密码权限整改 start
  	String pubOpCode = opCode;
  %>
  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
  <%
  	System.out.println("===第二批=====f1298.jsp==== pwrf ="+pwrf);
    //2011/9/2  diling 添加 对密码权限整改 end
    
  	/****************由phoneNo bp_flag得到客户开户的相关信息****************************/
	  String bp_type = "1258";
	  String bp_flag = "1";//bp_type2
	  String function_code = "";
	  String[] paraAray2 = new String[3];

	  paraAray1[0] = loginNo; 	/* 操作工号   */
	  paraAray1[1] = phoneNo;		/* 手机号码   */
	  paraAray1[2] = bp_flag;		/* 寻呼代码   */
	  for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
	  }

  	 // String[] ret2 = impl.callService("s1298_Func",paraAray1,"11","phone",phoneNo);
%>
	 <wtc:service name="s1298_Func" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="12" >
			<wtc:param value=""/>
			<wtc:param value=""/>		
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[1]%>"/>
			<wtc:param value=""/>  		
			<wtc:param value="<%=paraAray1[2]%>"/>	
	</wtc:service>
	<wtc:array id="ret2" scope="end"/>
<%
          String bp_title="",bp_title_name="",eng_chi="",eng_chi_name="",add_no="";	
	  errCode=retCode2;
	  errMsg=retMsg2;
  if(ret2==null){
    if(!retFlag.equals("1"))
	{
	    retFlag = "1";
	    retMsg = "s1298_Func该号码没有对应的开户信息!(空)<br>errCode: " + errCode + "<br>" + errMsg;
    }
  }else if(!(ret2 == null))
  {
 	if(errCode.equals("000000"))
	{
      bp_title = ret2[0][5];//用户称谓标识
      if(!(bp_title==null)){
	    if(bp_title.equals("0")){
          bp_title_name="女士";
	    }else if(bp_title.equals("1")){
	      bp_title_name="先生";
	    }
	  }
      eng_chi = ret2[0][4];//中英文标识
	  if(!(eng_chi==null)){
	    if(eng_chi.equals("0")){
          eng_chi_name="英文";
	    }else if(eng_chi.equals("1")){
	      eng_chi_name="中文";
	    }
	  }
	  add_no = ret2[0][6];//附加号码
	  function_code = ret2[0][8];//特服类型
      	  year_flag = ret2[0][10];//业务类型

    }else{
	  if(!retFlag.equals("1"))
	  {
	    retFlag = "1";
	    retMsg = "s1298_Func查询号码开户信息失败!<br>errCode: " + errCode + "<br>" + errMsg;
      }
	}
  }

  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>

<html>
	<head>
	<title>12580销户</title>
	<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
	  <%
	  	if(retFlag.equals("1")){  	
	  %>	 
	  	<script type="text/javascript"> 
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	  <%
	  	    return;
	  	}
	  %>
	  
	<script type="text/javascript">
		<!--
		  //定义应用全局的变量
		  var SUCC_CODE	= "0";   		//自己应用程序定义
		  var ERROR_CODE  = "1";			//自己应用程序定义
		  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
		
		  var oprType_Add = "a";
		  var oprType_Upd = "u";
		  var oprType_Del = "d";
		  var oprType_Qry = "q";		 
		  onload=function()
		  {
		  }
		  //***
		  function frmCfm(){
		 	frm.submit();
			return true;
		  }
		  //***
		  function printCommit(){
		  	getAfterPrompt();
			//校验
			if(!checkElement(document.frm.hand_fee)) return false
		    //打印工单并提交表单
		    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		    if(typeof(ret)!="undefined")
		    {
		      if((ret=="confirm"))
		      {
		        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
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
			var sm_name = "";
		       	if("<%=sm_code%>"=="zn"){
				sm_name="神州行";
			  }else if("<%=sm_code%>"=="gn"){
				sm_name = "全球通";
			  }else {
				sm_name="动感地带";
			  }	  
			  
			var cust_info=""; //客户信息
	      	var opr_info=""; //操作信息
	      	var retInfo = "";  //打印内容
	      	var note_info1=""; //备注1
	      	var note_info2=""; //备注2
	      	var note_info3=""; //备注3
	      	var note_info4=""; //备注4 
					 
			 cust_info+="客户姓名：   "+document.frm.bp_name.value+"|";
	         cust_info+="手机号码：   "+document.frm.phoneNo.value+"|";
	         cust_info+="客户地址：   "+"<%=cust_address%>"+"|";
	         cust_info+="证件号码：   "+"<%=cardId_no%>"+"|";
			 
			 opr_info+="用户品牌："+sm_name+"      "+"办理业务：12580移动秘书 销户"+"|";
			 opr_info+="操作流水："+"<%=printAccept%>"+"|";
			 opr_info+="业务类型："+document.frm.year_flag.value+"|" ;
			 opr_info+="失效时间："+"<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
			 
			 note_info1+="      1、移动秘书台开户，业务24小时之内生效，业务有效期12个月，生效当月按整月计算。业务到期后，自动取消（销户），如需继续使用，须重新进行开户申请。                    2、业务未到期前，用户主动申请移动秘书台销户，业务24小时之内生效，剩余的12580移动秘书台业务包年专款不退不转。"+"|";
			 
			 retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	     retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	    	 return retInfo;	
		}
		//-->
	</script>

</head>
	<body>
		<form name="frm" method="post" action="f1298_confirm.jsp" onKeyUp="chgFocus(frm)">
			<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi">12580销户</div>
			</div>
		        <table  cellspacing="0" >
		          	<tr>
		            		<td class="blue">移动号码</td>
			           	<td>
						<input name="phoneNo" type="text"  id="phoneNo"   value="<%=phoneNo%>" readonly class="InputGrey">
			            	</td>
		            		<td class="blue">寻呼类型</td>
		            		<td>
					  	<input name="bp_type" type="text"  id="bp_type" value="<%=bp_type%>" readonly class="InputGrey">
					</td>
		          	</tr>
		          	<tr>
		            		<td class="blue">运行状态</td>
		            		<td>
					  	<input name="run_code" type="text"  id="run_code" value="<%=run_code%>" readonly class="InputGrey">
					</td>
		            		<td class="blue">语言标志</td>
		            		<td>
					  	<input name="eng_chi_name" type="text"  id="eng_chi_name" value="<%=eng_chi_name%>" readonly class="InputGrey">
					</td>
		          	</tr>
		          	<tr>
		            		<td class="blue">机主姓名</td>
		            		<td>
					  	<input name="bp_name" type="text"  id="bp_name" value="<%=bp_name%>" readonly class="InputGrey">
					</td>
		            		<td class="blue">机主性别</td>
		            		<td>
					  	<input name="bp_title_name" type="text"  id="bp_title_name" value="<%=bp_title_name%>" readonly class="InputGrey">
					</td>
		          	</tr>
		          	<tr>
		            		<td class="blue">手续费</td>
		            		<td>
		            			<input name="hand_fee" type="text"  id="hand_fee" v_type="money" v_must=1 value="<%=hand_fee%>"  <%=handFee_Favourable%> class="InputGrey" >
						<font class="orange">*</font>
					</td>
		            		<td class="blue">业务类型</td>
		            		<td>
		            			<input name="year_flag" type="text"  id="year_flag" value="<%=year_flag%>" readonly class="InputGrey">
					</td>
		          	</tr>
		          	<tr>
		            		<td class="blue">备注</td>
		            		<td colspan="3" >
		             			<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="<%="用户：" + phoneNo +"，销户"%>" readonly class="InputGrey">
		            		</td>
		          	</tr>
		         <table>
		         <table  cellspacing="0" >
		          	<tr>
		            		<td id="footer"> 
				                <input name="confirm" type="button" class="b_foot" index="2" value="确认" onClick="printCommit()">
				                &nbsp;
				                <input name="reset" type="reset" class="b_foot" value="清除" >
				                &nbsp;
				                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
				                &nbsp; 
		             		</td>
		          	</tr>
		        </table>
		         <%@ include file="/npage/include/footer.jsp" %>
			  <input type="hidden" name="idNo" value="<%=idNo%>"><!-- 用户id -->
			  <input type="hidden" name="sm_code" value="<%=sm_code%>" ><!-- 业务类型 -->
			  <input type="hidden" name="bp_flag" value="<%=bp_flag%>" ><!-- bp_flag -->
			  <input type="hidden" name="should_hand_fee" value="<%=should_hand_fee%>" ><!-- 应收手续费 -->
			  <input type="hidden" name="cmd_right" value="<%=cmd_right%>" ><!-- cmd_right -->
			  <input type="hidden" name="function_code" value="<%=function_code%>" ><!-- 寻呼代码 -->
			  <input type="hidden" name="eng_chi" value="<%=eng_chi%>" ><!-- 中英文标识--代码 -->
			  <input type="hidden" name="bp_title" value="<%=bp_title%>" ><!-- 用户称谓--代码 -->
			  <input type="hidden" name="add_no" value="<%=add_no%>" ><!-- 附加代码，已不用 -->
			  <input type="hidden" name="printAccept" value="<%=printAccept%>" >
			  <input type="hidden" name="opCode" value="<%=opCode%>">
		      <input type="hidden" name="opName" value="<%=opName%>">
			</form>
	</body>
</html>


