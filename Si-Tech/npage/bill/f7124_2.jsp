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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		

	/**这两个参数是给页面标题,事前事后提示用的**/
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 
 	/**这两个参数是专门给统一接触用的**/   
    String cnttOpCode = request.getParameter("opCode");
    String cnttOpName = request.getParameter("opName");
    
  String loginName = (String)session.getAttribute("workName");
  String regCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[3];
  String main_card = request.getParameter("chief_srv_no");/* 家长号码*/
  String phoneNo = request.getParameter("srv_no"); 
  String openType = request.getParameter("open_type");/* 操作类型*/
  
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*根据openType来更改opCode和opName,
  	*避免统一接触的opcode,opname记录错误
  	*避免事前提示的混乱与不显示
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 : 
	  					opCode = "7129";
	  					opName = "家庭服务计划付费关系建立";
	  					break;
	  	case 1 :
	  					opCode = "7133";
	  					opName = "家庭服务计划修改底限";
	  					break;
	  	case 2 :
	  					opCode = "7134";
	  					opName = "家庭服务计划付费关系取消";
	  					break;
	  	default:
	  					opCode = "7129";
	  					opName = "家庭服务计划付费关系建立";
	  					break;
	  }
	  System.out.println("########################################f7124_2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
  /**这里的op_code是给服务用的**/
  String op_code ="";
  if(openType.equals("0")){
	op_code="7129";
  }else if(openType.equals("1")){
	op_code="7133";
  }else{
	op_code="7134";
  }
  
  String passwordFromSer="";
  
  paraAray1[0] = main_card; /* 家长号码   */ 
  paraAray1[1] = phoneNo;	/*成员号码*/
  paraAray1[2] = op_code;	/* 操作代码  op_code */


  String op_type ="";
  String readtype="";

  if(openType.equals("0")){
	op_type="付费关系建立";
  }else if(openType.equals("1")){
	op_type="修改底限";
  }else{
	op_type="付费关系解除";
	readtype="readonly";
  }

  
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  System.out.println("main_card= "+main_card);
  System.out.println("phoneNo= "+phoneNo);
  System.out.println("op_code= "+op_code);
  
  //retList = impl.callFXService("s7129Valid", paraAray1, "38");
%>
	<wtc:service name="s7129Valid" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="36">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="29" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>

	<wtc:array id="result7"  start="32" length="1" scope="end"/>
	<wtc:array id="result8"  start="33" length="1" scope="end"/>
	<wtc:array id="result9"  start="34" length="1" scope="end"/>
	<wtc:array id="result10"  start="35" length="1" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",print_note="";
  String otherCardFlag = "",mainDisabledFlag="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] pay_name = new String[][]{};
  String[][] allow_pay = new String[][]{};
  
  tempArr = result1;
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7129Valid配置号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
	
	    bp_name = tempArr[0][3];//机主姓名
	 
	    passwordFromSer = tempArr[0][2];//密码
	
	    sm_code = tempArr[0][11];//业务类别
	 
	    sm_name = tempArr[0][12];//业务类别名称
	 
	    rate_code = tempArr[0][5];//资费代码
	
	    rate_name = tempArr[0][6];//资费名称
	 
	    next_rate_code = tempArr[0][7];//下月资费代码
	 
	    next_rate_name = tempArr[0][8];//下月资费名称
	 
	    bigCust_flag = tempArr[0][9];//大客户标志
	 
	    bigCust_name = tempArr[0][10];//大客户名称
	 
	    lack_fee = tempArr[0][15];//总欠费
	
	    prepay_fee = tempArr[0][16];//总预交
	
	    print_note = tempArr[0][27];//工单广告词
	
	  familyCodeArr = result2;//家庭号码 
	  otherCodeArr = result3;//付卡号码--成员号码
      cardTypeArr = result4;//卡类型--加入时间

     opTimeArr = result7;//操作时间--不用
	  newRateCodeArr = result8;//温馨家庭资费代码--不用
	  pay_name = result9;
	  allow_pay = result10;
	  //判断是否存在申请纪录
	  if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="该号码没有对应的申请信息!";
        }  
	  }else if(familyCodeArr.length>1){
	    otherCardFlag = "1";//判断是否存在付卡
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7129Valid配置号码基本信息失败!"+errMsg;
        }
	}
 
//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   
   //优惠信息
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
  boolean pwrf = false;//a272 密码免验证
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
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 	  
 // if(!pwrf)
 // {
	   String passFromPage=Encrypt.encrypt(passTrans);
       if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage)){
		  if(!retFlag.equals("1"))
	      {
	         retFlag="1";
	         retMsg="密码错误!";
          }
	   }	       
		 
 // }
  
  //******************得到下拉框数据***************************//
  /**
  comImpl co=new comImpl();
  //资费代码 
  String sqlNewRateCode2  = "";  
  sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.mode_name from sRegionNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + orgCode.substring(0,2) + "'";
  ArrayList newRateCodeArr2  = co.spubqry32("2",sqlNewRateCode2 );
  String[][] newRateCodeStr2  = (String[][])newRateCodeArr2.get(0);
  **/	
	
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<head>
<title>家庭服务计划配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>",0);
	 window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	<%}%>
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
  //***//校验one
  function checkOne(){    
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);//卡号码
		card_type = oneTokSelf(radio1[i].value,"~",2);//卡类型
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("请选择要取消的号码!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("请选择新套餐代码!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }
  //
 
  /*根据卡类型动态改变行的可见性*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//卡类型
	var phoneNo = oneTokSelf(str,"~",1);//卡号码
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2Tr.style.display="";
	}else
	{
	    document.all.newRateCode2Tr.style.display="none";
	}
	return true;
  }

   function frmPrint(subButton){
   	getAfterPrompt();
	//controlButt(subButton);//延时控制按钮的可用性
	subButton.disabled = true;
	if(document.frm.limit_pay.value.length==0 && document.frm.op_code.value !="7134")
	{
	  rdShowMessageDialog("请输入底线金额!");
	  document.frm.limit_pay.focus();
      return false;
	}
	setOpNote();//为备注赋值
	frm.action = "f7124_3_Cfm.jsp";
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
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
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
	cust_info+="客户姓名："+document.frm.bp_name.value+"|";
	
	opr_info+="业务类型：家庭服务计划配置"+"<%=op_type%>"+"|";
	opr_info+="流水："+"<%=printAccept%>"+"|";
	opr_info+="开通号码："+"<%=main_card%>"+"|";
	opr_info+="开始时间："+exeDate+"|";
	opr_info+="工单广告词："+"<%=print_note%>"+"|"; 
	
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	
	return retInfo;
  }
  //提交处理 
  /*function printCommit(subButton){
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	setOpNote();//为备注赋值
    //提交表单
    frmCfm();	
	return true;
  }*/
  function setOpNote(){
	if(document.frm.opNote.value.length==0)
	  document.frm.opNote.value = "家庭服务计划变更--<%=op_type%>号码:"+"<%=phoneNo%>"; 
	return true;
}

function goBack(){
	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
		    <td class="blue">家长号码</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">业务类型</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr>
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		  <tr >
		  <td class="blue">底限金额</td>
		  <td colspan="3">
			  <input name="limit_pay" type="text" id="limit_papy" value=""  <%=readtype%> >
		  </td>
		  </tr>
		</table>
		</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">业务明细</div>
</div>
		<TABLE border=0 align="center" cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr align="middle">
		      <th align=center>家庭代码</th>
			  <th align=center>家庭身份</th>
			  <th align=center>家庭成员</th>
			  <th align=center>开始时间</th>
		
			  <th align=center>家长付费</th>
			  <th align=center>底限金额</th>
			</tr>
			<% 
			 for(int j=0;j<otherCodeArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";
                if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
				  mainDisabledFlag = "disabled";
				}else{
				  mainDisabledFlag = "";
				}
			%>
		    <tr> 
			  <td class="<%=tdClass%>" align=center><%=familyCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=newRateCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=otherCodeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=cardTypeArr[j][0]%></td>

			  <td class="<%=tdClass%>" align=center><%=pay_name[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=allow_pay[j][0]%></td>
			</tr>				
			<%
}
%>
		</table>
	<!-- ningtn 2011-8-3 09:58:25 扩大电子工单 -->
	<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	</jsp:include>
	    <TABLE cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="frmPrint(this)" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="goBack()" type="button" class="b_foot" value="返回">
                &nbsp; 
				</div>
			</td>
          </tr>
       </table>
  
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
  <input type="hidden" name="op_code" value="<%=op_code%>" >
  <input type="hidden" name="op_note" value="<%=openType%>" >
  <input type="hidden" name="home_no" value="<%=phoneNo%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name= "opNote" value="">
  <!--以下这两个参数是专门给统一接触用的-->
   <input type="hidden" name= "cnttOpCode" value="<%=cnttOpCode%>">
    <input type="hidden" name= "cnttOpName" value="<%=cnttOpName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<!-- ningtn 2011-8-3 09:59:10 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

