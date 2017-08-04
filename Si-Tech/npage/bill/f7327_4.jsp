<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划配置
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept_boss.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		

	/**这两个参数是给页面标题,事前事后提示用的**/
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 	String opFlag = request.getParameter("op_flag");
 	/**这两个参数是专门给统一接触用的**/   
    String cnttOpCode = request.getParameter("opCode");
    String cnttOpName = request.getParameter("opName");
  
 	String loginName = (String)session.getAttribute("workName");
  String regCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");/* 家长号码*/
  String phoneNo = request.getParameter("srv_no"); 
  String openType = request.getParameter("opFlag");/* 操作类型*/
  
  /**这里的op_code是给服务用的**/ 
  
  String passwordFromSer="";
  String op_type ="合帐分享取消";
  String readtype="";
    
	String inputArry[] = new String[1];
	String Tmsql="select to_char(trunc(last_day(sysdate)+1),'yyyymmdd hh24:mi:ss') from dual";
	inputArry[0] = Tmsql;
%> 
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String exeTime = tempArr1[0][0].substring(0,8);
	String printAccept="";		
%>
		<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" id="sLoginAccept"/>
<%		
		printAccept = sLoginAccept;  
	
  paraAray1[0] = main_card; /* 办理号码   */ 
  paraAray1[1] = opCode;	/* 操作代码  op_code */
  paraAray1[2] = opFlag;
  
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
%>  
	<wtc:service name="s7327Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	</wtc:service>	
	<wtc:array id="result0"  start="0" length="2" scope="end"/>
	<wtc:array id="result1"  start="2" length="1" scope="end"/>
	<wtc:array id="result2"  start="3" length="1" scope="end"/>
	<wtc:array id="result3"  start="4" length="1" scope="end"/>
	<wtc:array id="result4"  start="5" length="1" scope="end"/>	
	<wtc:array id="result5"  start="6" length="1" scope="end"/>	
	<wtc:array id="result6"  start="7" length="1" scope="end"/>		
	<wtc:array id="result7"  start="8" length="3" scope="end"/>	
  <wtc:array id="result8"  start="11" length="1" scope="end"/>	
<%
  String  phone_no="",limit_pay="",begin_time="",end_time="",allpay_limit="",num_limit="";
  String bp_name="",cardId_no="",bp_add="";
  String[][] tempArr= new String[][]{};
	String[][] mainArr= new String[][]{};
  String[][] memArr= new String[][]{};
  String[][] payArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] allpayArr= new String[][]{};
  String[][] numArr= new String[][]{};
   String[][] bmArr= new String[][]{};
  tempArr = result0;
   bmArr = result7;

  String errCode = retCode1;
  String errMsg = retMsg1;
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7327Qry配置号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    mainArr = result1;// 主卡号码
	 
	    payArr = result2;//付费金额
	
	    beginTimeArr = result3;//开始日期
	 
	    endTimeArr = result4;//结束日期
	 
	    allpayArr = result5;//剩余最大金额
	
	    numArr = result6;//剩余最低用户
	    
	    memArr = result8;//副卡号码
	    
	    bp_name = bmArr[0][0]; //客户姓名
	    
	    bp_add = bmArr[0][1]; //客户地址
	    
	    cardId_no = bmArr[0][2]; //客户证件

	 } else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7327Qry配置号码基本信息失败!"+errMsg;
        }
	}
 
%>
<head>
<title>合帐分享计划配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>",0);
	 history.go(-1);
	<%}%>
<!-- 
  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }

   function frmPrint(subButton){
	//controlButt(subButton);//延时控制按钮的可用性
	//subButton.disabled = true;
	getAfterPrompt();
	setOpNote();//为备注赋值
	document.frm.action = "f7327Cfm.jsp";
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
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
   var sysAccept="<%=printAccept%>";                          // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="<%=opCode%>";                                  //操作代码
   var phoneNo="<%=main_card%>";                             //客户电话

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
  }

  function printInfo(printType)
  {
	var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
	
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
	var retInfo = "";  //打印内容
	
	cust_info+="手机号码："+"<%=main_card%>"+"|";
	cust_info+="客户姓名："+document.all.bp_name.value+"|";
	cust_info+="客户地址："+document.all.bp_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";

	opr_info+="业务类型：家庭服务计划配置之-->"+"<%=op_type%>"+"|";
	opr_info+="流水："+"<%=printAccept%>"+"|";
	opr_info+="办理号码："+"<%=main_card%>"+"|";
	opr_info+="副卡号码："+document.all.mem_num.value+"|";
	opr_info+="办理时间："+exeDate+"|";
	opr_info+="生效时间："+ "<%=exeTime%>" +"|";
	opr_info+=""+"|";
	opr_info+=""+"|";
	opr_info+=""+"|";
	note_info1+="操作备注："+"|";
	note_info1+="1.公免、公务、测试卡客户及具有托收账户的客户不能办理此业务。"+"|";
	note_info1+="2.主卡仅现金账户可以为副卡进行付费，包年等专款账户无法为副卡进行付费。"+"|";
	note_info1+="3.主卡欠费停机将引发副卡随主卡停机而停机。"+"|";
	note_info1+="4.主卡为副卡付费金额不算做主卡的底线消费内。"+"|";
	note_info1+="5.若副卡为全球通或动感地带品牌客户，主卡为副卡付费金额所引发的积分，归副卡所有。若副卡为神州行客户，则主卡为副卡付费金额不产生积分。"+"|";
	note_info1+="6.申请“合帐分享”业务，办理后立即生效，取消该业务下月生效。"+"|";
	note_info1+="7.主卡为副卡付费的金额在月底出账时一次性划拨。"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	
	return retInfo;
  }

  function setOpNote(){
	if(document.frm.opNote.value.length==0)
	  document.frm.opNote.value = "合帐分享计划变更--<%=op_type%>号码:"+document.all.mem_num.value; 
	return true;
}

 function f7327Init(obj){
 	document.all.confirm.disabled=false;
 	document.frm.main_card.value = obj.sMainCard;
	document.frm.mem_num.value = obj.slaveCard;
	document.frm.pay_fee.value = obj.payMon;
	document.frm.begin_time.value = obj.beginTime;
	document.frm.end_time.value = obj.endTime;
}
	
//-->
</script>

</head>

<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
            <td class="blue">操作类型</td>
            <td colspan="3">
			  <input name="op_name" type="text" class="InputGrey" id="op_name" size="30" value="<%=op_type%>" readonly>
			</td>
          </tr>
          <tr> 
		    <td class="blue">主卡号码</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" readonly >
			</td>
            <td class="blue">副卡号码</td>
            <td>
			  <input name="mem_num" type="text" class="InputGrey" v_maxlength=16 id="mem_num"  readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">付费金额</td>
            <td>
			  <input name="pay_fee" type="text" class="InputGrey" id="pay_fee" size="30" readonly>
			</td>
			<td>
				<input name="op_flag" type="hidden" class="InputGrey" id="op_flag"  value="d">
			</td>
			<td>
				<input name="1" type="hidden" class="InputGrey" id="1" >
			</td>
		</tr>
			<tr>
			<td class="blue">开始日期</td>
            <td>
			  <input name="begin_time" type="text" class="InputGrey" id="begin_time" size="30"   readonly>
			</td>             
		    <td class="blue">结束日期</td>
            <td>
			  <input name="end_time" type="text" class="InputGrey" id="end_time" readonly >
			</td>
          </tr>
		</table>
		</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">付费信息</div>
</div>
		<TABLE border=0 align="center" cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr align="middle">
		      <th width="10%" align=center>选择</th>	
		      <th width="10%"align=center>主卡号码</th>
			  <th width="10%"align=center>副卡号码</th>
			  <th width="20%" align=center>付费金额</th>
			  <th width="25%" align=center>开始时间</th>
			  <th width="25%" align=center>结束时间</th>
			</tr>
			<% 
			 if(errCode.equals("000000"))
			{
			 for(int j=0;j<memArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
			%>
		    <tr>
		      <tr>
		      <td class="Grey" align=center>
		      	<input type="radio" name="radio" sMainCard="<%=mainArr[j][0]%>" slaveCard="<%=memArr[j][0]%>" payMon="<%=payArr[j][0]%>" beginTime="<%=beginTimeArr[j][0]%>" endTime="<%=endTimeArr[j][0]%>" onclick="f7327Init(this)">
		      	</td> 
			  <td class="<%=tdClass%>" align=center><%=mainArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=memArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=payArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=beginTimeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=endTimeArr[j][0]%></td>
			</tr>				
			<%
			}
		}	
%>
		</table>
	    <TABLE cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="frmPrint(this)" disabled>
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; 
				</div>
			</td>
          </tr>
       </table>
  <input type="hidden" name="exe_time" value="<%=exeTime%>">
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
  <input type="hidden" name="stream" value="<%=printAccept%>">
	<input type="hidden" name="opCode" value="7389">
  <input type="hidden" name="op_note" value="<%=openType%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name= "opNote" value="" >
  <input name="bp_name" type="hidden" id="bp_name" value="<%=bp_name%>">	<!--客户姓名-->
  <input name="bp_addr" type="hidden"  id="bp_addr" value="<%=bp_add%>">	<!--客户地址-->
  <input name="cardId_no" type="hidden"  id="cardId_no" value="<%=cardId_no%>">	<!--客户证件-->
  <input type="hidden" name="return_page" value="/npage/bill/f7327.jsp?activePhone=<%=main_card%>&opName=<%=opName%>">
  <!--以下这两个参数是专门给统一接触用的-->
   <input type="hidden" name= "cnttOpCode" value="<%=cnttOpCode%>">
    <input type="hidden" name= "cnttOpName" value="<%=cnttOpName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

