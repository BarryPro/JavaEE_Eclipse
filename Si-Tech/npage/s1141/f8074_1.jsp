<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = request.getParameter("opcode");
	String opName = (String)request.getParameter("opName");		
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String regionCode= (String)session.getAttribute("regCode");
	String loginPwd    = (String)session.getAttribute("password");
%>
<%
	String retFlag="",retMsg=""; 	
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


 	//retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);
 %>
 	<wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >
			
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>		
				
	</wtc:service>
	<wtc:array id="retList" scope="end"/>
 <%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  	String[][] tempArr= new String[][]{};
	String errCode = retCode1;
	String errMsg = retMsg1;
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{		
	   retFlag = "1";
	   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
  	
	if(!errCode.equals("000000") ){%>
		<script language="JavaScript">
			alert("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
		tempArr=retList;
	  	//tempArr = (String[][])retList.get(2);
	  if(tempArr!=null&&tempArr.length>0){
	    	bp_name = tempArr[0][2];//机主姓名
	    	System.out.println(bp_name);	
	  	//tempArr = (String[][])retList.get(3);
	    	bp_add = tempArr[0][3];//客户地址	
	  	//tempArr = (String[][])retList.get(4);	
	    	cardId_type = tempArr[0][4];//证件类型	
	  	//tempArr = (String[][])retList.get(5);	 
	    	cardId_no = tempArr[0][5];//证件号码	 
	  	//tempArr = (String[][])retList.get(6);	
	    	sm_code = tempArr[0][6];//业务品牌	 
	  	//tempArr = (String[][])retList.get(7);	  
	    	region_name = tempArr[0][7];//归属地	
	  	//tempArr = (String[][])retList.get(8);	  
	    	run_name = tempArr[0][8];//当前状态
	 	//tempArr = (String[][])retList.get(9);	 
	    	vip = tempArr[0][9];//ＶＩＰ级别	 
	 	//tempArr = (String[][])retList.get(10);	 
	    	posint = tempArr[0][10];//当前积分	 
	  	//tempArr = (String[][])retList.get(11);	
	    	prepay_fee = tempArr[0][11];//可用预存	 
	  	//tempArr = (String[][])retList.get(13);	  
	    	passwordFromSer = tempArr[0][13];  //密码
	  }
	}
  }

%>
<%
	String printAccept="";
	printAccept = getMaxAccept();
%>

<html>
<head>
<title>预存话费送笔记本</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script>
<script language="JavaScript">
<!--
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		//自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
	


//***
 function getInfo_code()
 {
  	var regionCode = "<%=regionCode%>";

    var pageTitle = "营销案选择";
    var fieldName = "方案代码|方案名称|预存金额|绑定资费代码|GPRS卡包年|";//弹出窗口显示的列、列名
    var sqlStr = "";
    	sqlStr = "SELECT   a.order_code, TRIM (a.order_name), a.prepay_fee, a.bind_mode,TO_CHAR (b.offer_attr_value) "+
				 "FROM sprepaycompute a, product_offer_attr b "+
				 "WHERE b.offer_attr_seq = '5070' AND a.region_code = '01' "+
				 "AND SYSDATE BETWEEN a.begin_time AND a.end_time "+
				 "AND a.bind_mode = TO_CHAR (b.offer_id) "+
				 "order by a.order_code";
    //alert("sqlStr="+sqlStr);
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "5|0|1|2|3|4|";//返回字段
    var retToField = "order_code|order_name|pay_money|bind_mode|prepay_least|";//返回赋值的域
    MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50);
 }
function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");

    }
	return true;
} 
function frmCfm(){
	frm.submit();
	return true;
}
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
	if (gprs_phone.value.length == 0) {
      rdShowMessageDialog("绑定数据卡号码不能为空，请重新输入 !!");
      gprs_phone.focus();
	  return false;
     }
	if(parseFloat(prepay_fee.value) < parseFloat(pay_money.value))
	{
		rdShowMessageDialog("预存款不足,请缴费后重新办理!");
		return;
	}
	if(phone_no.value == gprs_phone.value)
	{
		rdShowMessageDialog("办理业务号码和绑定号码不能相同!");
		return;
	}
	prepay_all.value=parseFloat(pay_money.value)+parseFloat(prepay_least.value);
  }
	document.all.confirm.disabled=true;
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

	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;
	    
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
	
	opr_info+="业务类型：预存话费送笔记本"+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	
	note_info1+="说明：用户交纳"+document.all.prepay_all.value+"元预存款，获得GPRS包年上网费（每月可使用省内700M、省际300M GPRS上网流量，"+"|";
	note_info2+="不区分CMWAP和CMNET，超出流量按0.005元/kb另行收取。包年到期后自动转为普通50元月租资费。）"+"|";
	note_info3+="和笔记本一台。其中,GPRS包年费"+document.all.prepay_least.value+"元；余"+document.all.pay_money.value+"元为通话费,自受理之日起,两年内消费完毕,到期未用完自动作废。"+"|";	
	note_info4+="备注："+document.all.opNote.value+"|";
	
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	return retInfo;	
}



//-->
</script>


</head>
<body>
<form name="frm" method="post" action="f8074Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">预存话费送笔记本</div>
	</div> 
	<table cellspacing="0" >
		<tr>
			<td class="blue">操作类型</td>
			<td colspan="3">预存话费送笔记本--申请</td>
		</tr>
		<tr>
			<td class="blue">客户姓名</td>
			<td>
				<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">客户地址</td>
			<td nowrap>
				<input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="30" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">证件类型</td>
			<td>
				<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">证件号码</td>
			<td>
				<input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" >
				<font class="orange">*</font>
			</td>
           	</tr>
		<tr>
			<td  class="blue">业务品牌</td>
			<td>
				<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey" id="sm_code" maxlength="20" >
				<font class="orange">*</font>	
			</td>
			<td  class="blue">运行状态</td>
			<td>
				<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">VIP级别</td>
			<td>
				<input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly class="InputGrey" id="vip" maxlength="20" >
				<font class="orange">*</font>
			</td>
			<td  class="blue">可用预存</td>
			<td>
				<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" >
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td  class="blue">预存话费</td>
			<td>
              <input class="button"  type="text" name="pay_money" id="pay_money" v_name="预存话费" readonly>
			  <input class="b_text" type="button" name="qry_mode" value="查询" onClick="getInfo_code()" >
			</td>
			<td  class="blue">绑定数据卡号码</td>
			<td>
				<input   type="text" size="12" name="gprs_phone" id="gprs_phone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0">
				<font class="orange">*</font>
			</td>
		</tr>		
		<tr>
			<td class="blue" >备注</td>
			<td colspan="3" >
				<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="预存话费送笔记本" readonly class="InputGrey">
			</td>
		</tr>
	</table>
	<table cellspacing="0" >
		<tr>
			<td id="footer">
				<input name="confirm" type="button"  index="2" class="b_foot_long" value="确认&打印" onClick="printCommit()" >
				&nbsp;
				<input name="reset" type="reset" class="b_foot" value="清除" >
				&nbsp;
				<input name="back" onClick="history.go(-1)" class="b_foot" type="button"  value="返回">
				&nbsp;
			</td>
		</tr>
	</table>
 
	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
	<input type="hidden" name="used_point" value="0" >
	<input type="hidden" name="point_money" value="0" >
	<input type="hidden" name="order_code" >
	<input type="hidden" name="order_name" >
	<input type="hidden" name="bind_mode" >
	<input type="hidden" name="prepay_least" >
	<input type="hidden" name="prepay_all" >	
	<input type="hidden" name="opName" value="<%=opName%>">
	
	 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
