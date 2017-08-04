 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-08 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
  String loginNo = (String)session.getAttribute("workNo");    //工号 		   
	String regionCode = (String)session.getAttribute("regCode"); 
	String orgCode=(String)session.getAttribute("orgCode"); 
	
	String opCode = "1297";
	String opName = "12580移动秘书台开户";
%>
<%
  	String retFlag="",retMsg="";//用于判断页面刚进入时的正确性  
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String passwordFromSer="";

 	paraAray1[0] = loginNo; 		/* 操作工号   */
 	paraAray1[1] = phoneNo;		/* 手机号码   */
  	paraAray1[2] = "1297";		/* 操作代码   */
  	paraAray1[3] = orgCode;		/* 归属代码   */
	for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
	  }

  	//String[] ret = impl.callService("s1297_Valid",paraAray1,"24","phone",phoneNo);
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
  	String run_code="",bp_name="",hand_fee="",should_hand_fee="",sm_code="",idNo="",cmd_right="",favourCode="",cardId_type ="", cardId_no="",contract_phone="",cust_address="",print_note="",prepay_fee="",highFlag="",belong_code="";
  	String errCode=retCode1;
  	String errMsg = retMsg1;  	
	  if(!errCode.equals("000000"))
	  {	  	
		if(!retFlag.equals("1"))
		{		 
		   retFlag = "1";
		   retMsg = "s1297_Valid查询号码基本信息为空!<br>errCode: " + errCode + "<br>" + errMsg;
	    }
	  }else if(ret!=null)
	  {
	  	 
		if (errCode.equals("000000") ){
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
		  highFlag = ret[0][23];//中高端标志
		  belong_code = ret[0][10];//用来取用户归属
		}else{
		  if(!retFlag.equals("1"))
		  {
		    retFlag = "1";
		    retMsg = "s1297_Valid查询号码基本信息失败!<br>errCode: " + errCode + "<br>" + errMsg;
	      }
		}
	  }

	  	if(retFlag.equals("1")){  	
	  %>	 
	  	<script type="text/javascript"> 
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	  <%
	  	    return;
	  	}

	//********************设置营业员优惠权限*****************************//
	   //优惠信息	 
	  String[][]  favInfo = (String[][])session.getAttribute("favInfo");
	  boolean pwrf = false;//a272 密码免验证
	  //解析营业员优惠权限
	  String handFee_Favourable = "readonly";        //a230  手续费
	  String choiceFee_Favourable = "readonly";       //a006  选号费
	  int infoLen = favInfo.length;
	  String tempStr = "";
	  for(int i=0;i<infoLen;i++)
	  {
	    tempStr = (favInfo[i][0]).trim();
	    if(tempStr.compareTo(favourCode) == 0)
	    {
	      handFee_Favourable = "";
	    }
	    if(tempStr.compareTo("a006") == 0)
	    {
	      choiceFee_Favourable = "";
	    }
		if(tempStr.compareTo("a272") == 0)
	    {
	      pwrf = true;
	    }
	  }	  
	
	//******************得到下拉框数据***************************//	
	  //寻呼代码
	  System.out.println("belong_code=========="+belong_code);
	  String sqlFunctionCode = "SELECT function_code||'~'||month_limit||'~'||function_type,function_code||'--'||function_name,sm_code,to_char(add_months(sysdate,12),'YYYYMM')||'01' FROM sFuncList where  region_code='"  + belong_code.substring(0,2) + "' and sm_code='" + sm_code + "' and function_name like '%1258%' ";
	  System.out.println("sqlFunctionCode=========="+sqlFunctionCode);
	  //ArrayList functionCodeArr = co.spubqry32("4",sqlFunctionCode);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="4">
	<wtc:sql><%=sqlFunctionCode%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="functionCodeStr" scope="end" />
<%
	 // String[][] functionCodeStr = (String[][])functionCodeArr.get(0);	
	
	  /****得到打印流水****/
	  String printAccept="";
	  printAccept = getMaxAccept();
	  
%>
<html>
	<head>
	<title>12580开户</title>	
	 <script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
  	<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>

	  
	<script type="text/javascript">
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
	  //
	  function printCommit(){
	  	getAfterPrompt();
		//校验
	    if(!checkElement(document.frm.phoneNo)) return false;
		if(!checkElement(document.frm.hand_fee)) return false;
		if(!checkElement(document.frm.begin_time)) return false;
	    if(!checkElement(document.frm.end_time)) return false;
		with(document.frm){
		  if(function_code.value==""){
		    rdShowMessageDialog("请选择寻呼代码!",0);
	        function_code.focus();
			return false;
		  }
		  if(ask_type.value==""){
		    rdShowMessageDialog("请选择申请类型!",0);
	        ask_type.focus();
			return false;
		  }
		  if(bp_name.value==""){
		    rdShowMessageDialog("请输入机主姓名!",0);
	        bp_name.focus();
			return false;
		  }
		  if(bp_title.value==""){
		    rdShowMessageDialog("请选择机主称谓!",0);
	        bp_title.focus();
			return false;
		  }
		  if(eng_chi.value==""){
		    rdShowMessageDialog("请选择语言标识!",0);
	        eng_chi.focus();
			return false;
		  }
		}
	
	    if(document.frm.begin_time.value == document.frm.system_time.value){//是否当日标识
		  document.frm.system_time_flag.value = "0";
		}else{
		  document.frm.system_time_flag.value = "1";
		}
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
	  {  
	  		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	     		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=printAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = <%=phoneNo%>;                           //客户电话		  
	  
		  	//显示打印对话框
		    	var h=200;
		    	var w=410;
		     	var t=screen.availHeight/2-h/2;
		     	var l=screen.availWidth/2-w/2;
		     	
		     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);     	
	  }
	
	  function printInfo(printType)
	  {
		  var retInfo = "";
		  var sm_name = "";
	      	  if("<%=sm_code%>"=="zn"){
			sm_name="神州行";
		  }else if("<%=sm_code%>"=="gn"){
			sm_name = "全球通";
		  }else {
			sm_name="动感地带";
		  }
		  if(document.frm.ask_type.value=="02"){
			opType="包年";
		  }else{
			opType="包月";
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
	       
	       	opr_info+="用户品牌："+sm_name+"      "+"办理业务：12580移动秘书 开户"+"|";
	      	opr_info+="操作流水:"+"<%=printAccept%>"+"|";
		opr_info+="业务类型："+opType+"      "+"生效时间:"+document.frm.begin_time.value+"|";		
		note_info1+="      1、移动秘书台开户，业务24小时之内生效，业务有效期12个月，生效当月按整月计算。业务到期后，自动取消（销户），如需继续使用，须重新进行开户申请。                    2、业务未到期前，用户主动申请移动秘书台销户，业务24小时之内生效，剩余的12580移动秘书台业务包年专款不退不转。"+"|";		
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      	return retInfo;			  
	  }
	//-->
	</script>
	<script type="text/javascript"> 
	<!--
	/************************动态为优惠月数赋值  bp_flag 特服类型functionType*************************/
	function setFavourMonth(){
	  var strValue = document.frm.function_code.value;
	  var functionCodeValue = oneTokSelf(strValue,"~",1);
	  var favourMonth = oneTokSelf(strValue,"~",2);
	  var functionType = oneTokSelf(strValue,"~",3);
	  document.frm.favour_month.value = favourMonth;
	  document.frm.function_code_value.value = functionCodeValue;
	  document.frm.function_type.value = functionType;
	  if(functionCodeValue == "21" || functionCodeValue == "j0" ){
		  document.frm.bp_flag.value = "1";
	  }
	  else {
	      document.frm.bp_flag.value = "0";
	  }
	  //alert("functionCodeValue = " + functionCodeValue);
	  if(document.frm.bp_flag.value == "1")
		  document.frm.opNote.value = document.frm.phoneNo.value + "办理12580包年业务."
	  else
		  document.frm.opNote.value = "号码: " + document.frm.phoneNo.value  + ",12580开户";
	
	  selectChange(null,document.frm.ask_type,null,null);
	
	}
	
	/****************根据 function_code 动态生成 ask_type 下拉框************************/
	   /****************根据 function_code 动态生成 ask_type 下拉框************************/
	 function selectChange(control, controlToPopulate, itemArray, valueArray)
	 {
	   var functionCodeValue = document.frm.function_code_value.value;
	
	   var myEle ;
	   var x ;
	   // Empty the second drop down box of any choices
	   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
	   if(functionCodeValue=="21")
	   {
	       myEle = document.createElement("option") ;
	       myEle.value = "01" ;
	       myEle.text = "01--按月收费" ;
		   document.frm.opNote.value = "号码: " + document.frm.phoneNo.value  + ",12580开户";
	       controlToPopulate.add(myEle) ;
		   document.frm.end_time.value = "20500101";
		   document.frm.year_fee.value="0";
	   }else if(functionCodeValue=="j0")
	   {
			document.frm.year_fee.value="45";
			var prepay_fee = document.frm.prepay_fee.value;
			var year_fee   = document.frm.year_fee.value;
			if((year_fee-prepay_fee)>0){
				rdShowMessageDialog("当前金额小于包年金额，请先交费!",0);
				return false;
			}
	       myEle = document.createElement("option") ;
	       myEle.value = "02" ;
	       myEle.text = "02--按年收费" ;
		   document.frm.opNote.value = document.frm.phoneNo.value + "办理12580包年业务。" ;
			<%if (functionCodeStr.length>0){%>
				document.frm.end_time.value = "<%=functionCodeStr[0][3]%>";
			<%}%>
	       controlToPopulate.add(myEle) ;
	
	   }else
	   {
	      myEle = document.createElement("option") ;
	      myEle.value = "" ;
	      myEle.text = "--请选择--" ;
	      controlToPopulate.add(myEle) ;
	   }
	 }
	//-->
	</script>
</head>
<body>
<form name="frm" method="post" action="f1297_confirm.jsp" onKeyUp="chgFocus(frm)">	
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">12580开户</div>
		</div>
        <table  cellspacing="0" >
          	<tr>
            		<td class="blue">移动号码</td>
	            	<td>
				<input name="phoneNo" type="text"  id="phoneNo"   value="<%=phoneNo%>" readonly>
	            	</td>
            		<td class="blue">寻呼代码</td>
            		<td>
		              <select  name="function_code"  onChange="setFavourMonth()" >
					    <option value="">--请选择--</option>
		                <%for(int i = 0 ; i < functionCodeStr.length ; i ++){%>
		                <option value="<%=functionCodeStr[i][0]%>"><%=functionCodeStr[i][1]%></option>
		                <%}%>
		              </select>
			  	<font class="orange">*</font>
			</td>
          	</tr>
          	<tr>
            		<td class="blue">优惠月数</td>
            		<td>
			  	<input name="favour_month" type="text"  id="favour_month" readonly>
			</td>
            		<td class="blue">运行状态</td>
            		<td>
			  	<input name="run_code" type="text"  id="run_code" value="<%=run_code%>" readonly >
			</td>
          	</tr>
          	<tr>
	            	<td class="blue">申请类型</td>
	            	<td >
				  <select size=1 name="ask_type" >
				    	<option value="">--请选择--</option>
	              		  </select>
				  <font class="orange">*</font>
			</td>
	            	<td class="blue">语言标志</td>
	            	<td>
				  <select name="eng_chi"  >
				   	<option value="">--请选择--</option>
	                		<option value="1">中文</option>
	                		<option value="0">英文</option>
	              		  </select>
				  <font class="orange">*</font>
			</td>
          	</tr>
          	<tr>
		    	<td class="blue">机主姓名</td>
            		<td>
			  	<input name="bp_name" type="text"  id="bp_name" value="<%=bp_name%>" readonly>
			  	<font class="orange">*</font>
			</td>
            		<td class="blue">机主称谓</td>
            		<td>
			  	<select name="bp_title"  >
			    		<option value="">--请选择--</option>
                			<option value="1">先生</option>
                			<option value="0">女士</option>
              			</select>
			  	<font class="orange">*</font>
			</td>
          	</tr>
		<tr>
            		<td class="blue">生效时间</td>
            		<td>
			  	<input name="begin_time" value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" type="text"  id="begin_time" v_must=1 v_type="date"  onKeyPress="return isKeyNumberdot(0)" maxlength="8" readonly class="InputGrey">
			  	<font class="orange">*</font>yyyymmdd
			</td>
	            	<td class="blue">结束时间</td>
	            	<td>
				  <input name="end_time"   type="text"  id="end_time" v_must=1 v_type="date"  onKeyPress="return isKeyNumberdot(0)" maxlength="8" value="<%=functionCodeStr[0][3]%>" readonly class="InputGrey">
				  <font class="orange">*</font>yyyymmdd
			</td>
          	</tr>
		<tr>
	            	<td class="blue">可用预存款</td>
	            	<td>
				  <input name="hand_fee" type="hidden"  id="hand_fee" v_type="money"  <%=handFee_Favourable%> value="<%=hand_fee%>">
				  <input name="prepay_fee" type="text"  id="prepay_fee" v_type="money" v_must=1  value="<%=prepay_fee%>" readonly class="InputGrey">
				</td>
	            	<td class="blue" >包年金额</td>
	            	<td>
				  <input name="year_fee" type="text"  id="year_fee" v_type="money" v_must=1  value="0" readonly class="InputGrey">
			</td>
	        </tr>
	          <tr>
		            <td height="32"  class="blue">备注</td>
		            <td colspan="3" height="32">
		             	<input name="opNote" type="text"  id="opNote" size="60" readonly class="InputGrey">
		            </td>
	          </tr>
	          </table>
	          <table>
		          <tr>
		            	<td id="footer"> 
			                <input name="confirm" class="b_foot" type="button"  index="2" value="确认" onClick="printCommit()">
			                &nbsp;
			                <input name="reset" class="b_foot" type="reset"  value="清除" >
			                &nbsp;
			                <input name="back" class="b_foot" onClick="history.go(-1)" type="button"  value="返回">
			                &nbsp; 
		               </td>
		          </tr>
        	</table>
  		<%@ include file="/npage/include/footer.jsp" %>
		  <input type="hidden" name="idNo" value="<%=idNo%>"><!-- 用户id -->
		  <input type="hidden" name="sm_code" value="<%=sm_code%>"><!-- 业务类型 -->
		  <input type="hidden" name="bp_flag" ><!-- bp_flag -->
		  <input type="hidden" name="function_code_value" ><!-- 寻呼代码 -->
		  <input type="hidden" name="should_hand_fee" value="<%=should_hand_fee%>"><!-- 应收手续费 -->
		  <input type="hidden" name="system_time" value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>">   <!-- 系统时间 -->
		  <input type="hidden" name="system_time_flag"  >   <!-- 当天使用标识 -->
		  <input type="hidden" name="cmd_right" value="<%=cmd_right%>"><!-- cmd_right -->
		  <input type="hidden" name="function_type" ><!-- 特服类型 -->
		  <input type="hidden" name="fic_no" value="000000" ><!--虚拟号码，已不用-->
		  <input type="hidden" name="choice_fee" value="0"><!--选号费，已不用-->
		  <input type="hidden" name="should_choice_fee" value="0" ><!-- 应收选号费，已不用 -->
		  <input type="hidden" name="add_no" value="1258"><!--寻呼代码，已不用-->
		  <input type="hidden" name="printAccept" value="<%=printAccept%>" >
		  <input type="hidden" name="opCode" value="<%=opCode%>">
		  <input type="hidden" name="opName" value="<%=opName%>">
	</form>
	</body>
	<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
	<script language="JavaScript">
	  <%if((highFlag.trim()).equals("Y")){%>
	    rdShowMessageDialog('提示: 请注意,该用户为中高端用户！');
	  <%}%>
	</script>

