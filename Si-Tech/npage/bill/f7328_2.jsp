<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划变更
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String loginPwd = (String)session.getAttribute("password");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s1205Init***********************/
	String inputArry[] = new String[1];
	String Tmsql="select to_char(trunc(last_day(sysdate)+1),'yyyymmdd hh24:mi:ss') from dual";
	inputArry[0] = Tmsql;
%>
	<wtc:service name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>
	</wtc:service>
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String exeTime = tempArr1[0][0].substring(0,8);
  String[] paraAray1 = new String[7];

  String op_code = request.getParameter("op_code");
  String phoneNo = request.getParameter("parentPhoneNo"); /* 家长号码*/

  String home_no = request.getParameter("memberPhoneNo"); /* 成员号码(加入时)*/
  String home_no1 = request.getParameter("srv_no1"); /* 成员号码(退出时)*/
  System.out.println("home_no1home_no1home_no1home_no1home_no1home_no1===="+home_no1);
  String openType = request.getParameter("openType");/* 操作类型*/
  String passwordFromSer="";
  String show_phone = "";
  String trOneView = "";
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*根据openType来更改opCode和opName,
  	*避免统一接触的opcode,opname记录错误
  	*避免事前提示的混乱与不显示
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 :
	  					opCode = "7328";
	  					opName = "畅聊计划建立家庭";
	  					break;
	  	case 1 :
	  					opCode = "7329";
	  					opName = "畅聊计划加入家庭";
	  					break;
	  	case 2 :
	  					opCode = "7330";
	  					opName = "畅聊计划退出家庭";
	  					break;
	  	case 3 :
	  					opCode = "7331";
	  					opName = "畅聊计划取消家庭";
	  					break;
	  	case 4 :
	  					opCode = "7329";
	  					opName = "畅聊计划加入家庭";
	  					break;  					
	  	default:
	  					opCode = "7328";
	  					opName = "畅聊计划建立家庭";
	  					break;
	  }
	  System.out.println("########################################f7238 _2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/


  if(openType.equals("0")){
	op_code="7328";
	show_phone = phoneNo;
	trOneView = "display:none";//行可见
  }else if(openType.equals("1")){
	op_code="7329";
	show_phone = home_no;
	trOneView = "display:none";//行可见
	paraAray1[0] = home_no;		/* 手机号码   */
  }else if(openType.equals("2")){
	op_code="7330";
	if(home_no1.equals(""))
	{
		show_phone = home_no;
		paraAray1[0] = home_no;	/* 手机号码   */ 
	}
	else
	{	
		show_phone = home_no1;
		paraAray1[0] = home_no1;	/* 手机号码   */ 
	}
	trOneView = "display:none";//行不可见	
  }else if(openType.equals("4")){
	op_code="7329";
	show_phone = home_no;
	trOneView = "display:none";//行可见
	paraAray1[0] = home_no;		/* 手机号码   */
  }else{
	op_code="7331";
	show_phone = phoneNo;
	trOneView = "display:none";//行不可见
  }

  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	    /* 归属代码   */
  paraAray1[3] = op_code;		/* 操作代码   */
  paraAray1[4] = phoneNo;		/* 家长号码	*/
  paraAray1[5] = openType;		/* 申请类型	*/
  paraAray1[6] = loginPwd;		/* 工号密码	*/  

  System.out.println("show_phone === "+ show_phone);
  System.out.println("loginNo === "+ loginNo);
  System.out.println("orgCode === "+ orgCode);
  System.out.println("op_code === "+ op_code);
  System.out.println("phoneNo === "+ phoneNo);
  System.out.println("openType === "+ openType);

  for(int i=0; i<paraAray1.length; i++)
  {

	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }

  //retList = impl.callFXService("s7328Valid", paraAray1, "36");
%>
	<wtc:service name="s7328Valid" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="36">
	<wtc:param value="0"/>
	<wtc:param value="01"/>		
	<wtc:param value="<%=paraAray1[3]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>		
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=paraAray1[2]%>"/>		
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="0" length="26" scope="end"/>
	<wtc:array id="result1"  start="27" length="1" scope="end"/>
	<wtc:array id="result2"  start="28" length="1" scope="end"/>
	<wtc:array id="result3"  start="29" length="1" scope="end"/>
	<wtc:array id="result4"  start="30" length="1" scope="end"/>
	<wtc:array id="result5"  start="31" length="1" scope="end"/>
	<wtc:array id="result6"  start="32" length="1" scope="end"/>
	<wtc:array id="result7"  start="33" length="1" scope="end"/>
	<wtc:array id="result8"  start="34" length="1" scope="end"/>
	<wtc:array id="result9"  start="35" length="1" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",showflag="", password="",prod_name="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  String familyNumber="";
  String[][] familyNo= new String[][]{};
  String[][] familyName= new String[][]{};
  String[][] familyProdCode= new String[][]{};
  String[][] familyProdName= new String[][]{};
  String[][] familyParentId= new String[][]{};
  String[][] MainProduct= new String[][]{};
  String[][] OtherProduct= new String[][]{};
  String[][] MainProductName= new String[][]{};
  String[][] OtherProductName= new String[][]{};
  	familyNo = result1; /*家庭号码*/
	familyName = result2; /*家庭称谓*/
  	familyProdCode = result3;
	familyProdName = result4;
	familyParentId = result5;
	MainProduct = result6;
	OtherProduct = result7;
	MainProductName = result8;
	OtherProductName = result9;
 	System.out.println("0000000000000000  familyNo === "+ familyNo.length);
 	System.out.println("1111111111111111  familyProdCode === "+ familyProdCode.length);
 	System.out.println("2222222222222222  MainProduct === "+ MainProduct.length);
 	System.out.println("3333333333333333  familyProdCode === "+ MainProductName.length);
  System.out.println("errCode === "+ errCode);
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s7328Valid查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];//机主姓名

	    bp_add = tempArr[0][4];//客户地址

	    passwordFromSer = tempArr[0][2];//密码

	    sm_code = tempArr[0][11];//业务类别

	    sm_name = tempArr[0][12];//业务类别名称

	    hand_fee = tempArr[0][13];//手续费

	    favorcode = tempArr[0][14];//优惠代码

	    rate_code = tempArr[0][5];//资费代码

	    rate_name = tempArr[0][6];//资费名称

	    next_rate_code = tempArr[0][7];//下月资费代码

	    next_rate_name = tempArr[0][8];//下月资费名称

	    bigCust_flag = tempArr[0][9];//大客户标志

	    bigCust_name = tempArr[0][10];//大客户名称

	    lack_fee = tempArr[0][15];//总欠费

	    prepay_fee = tempArr[0][16];//总预交

	    cardId_type = tempArr[0][17];//证件类型

	    cardId_no = tempArr[0][18];//证件号码

	    cust_id = tempArr[0][19];//客户id

	    cust_belong_code = tempArr[0][20];//客户归属id

	    group_type_code = tempArr[0][21];//集团客户类型

	    group_type_name = tempArr[0][22];//集团客户类型名称

		 family_code = tempArr[0][23]; //用户家庭代码

	    next_main_stream = tempArr[0][24];//预约资费开通流水

	    showflag = tempArr[0][25];//显示信息
	 	if(result1.length!=0)
	 	{
	 		familyNumber = familyNo[0][0];
		}
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s7328Valid查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}

if(openType.equals("1"))
{
	String passTrans_2=WtcUtil.repNull(request.getParameter("password"));
		String passFromPage_2=Encrypt.encrypt(passTrans_2);
		 if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage_2))
		 {
			 if(!retFlag.equals("1"))
			 {
				retFlag = "1";
				retMsg = "密码错误!";
		}
	}
}

	String[] paramIn = new String[2];
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=paramIn[0]%>"/>
	<wtc:param value="<%=paramIn[1]%>"/>
	</wtc:service>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);

 String op_note="";
  if(openType.equals("0")){
	op_note="建立家庭";
  }else if(openType.equals("1")){
	op_note="加入家庭";
  }else if(openType.equals("2")){
	op_note="退出家庭";
  }else if(openType.equals("3")){
	op_note="取消家庭";
  }else{
	op_note="短信模式成员加入";
  }
    /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>家庭服务计划变更</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  onload=function()
  {
  }


  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //校验
  function check()
  {
 		with(document.frm)
		{
		var now_rate_code = "<%=rate_code%>";
		var next_rate_code = "<%=next_rate_code%>";
		return true;
    }
  }

  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }

 function printCommitOne(subButton){
 	getAfterPrompt();
	//controlButt(subButton);//延时控制按钮的可用性
	subButton.disabled = true;
	//alert(document.all.show_phone.value);
	//document.frm.new_rate_code.value=document.frm.add_mode.value.substring(0,8);
	setOpNote();//为备注赋值
 	document.frm.action = "f7328Cfm.jsp";
	var openType =document.all.open_type.value;
 	var ret1 = document.all.show_flag.value;
 	if((typeof(ret1)!="undefined")&&openType=="2")
 	{
		if((ret1=="Y"))
		{
			if(rdShowConfirmDialog('该成员退出后，家庭成员数小于3人，家庭将解散，是否继续？')==1)
			{
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
			}
			else
			{
				document.all.confirm.disabled=false;
			}
		}
		else
		{
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
		}
  	}
  	else
  	{
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
		var sysAccept=<%=printAccept%>;                            // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=op_code%>";                                  //操作代码
		var phoneNo=document.frm.show_phone.value;                 //客户电话

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		var count=0;
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容

		cust_info+="手机号码："+"<%=show_phone%>"+"|";
		cust_info+="客户姓名："+"<%=bp_name%>"+"|";


		opr_info+="用户品牌："+document.all.sm_name.value+"   "+"办理业务：畅聊家庭之--<%=op_note%>"+"|";

		opr_info+="操作流水："+"<%=printAccept%>"+"|";
		if("<%=openType%>"== "2")
		{
			opr_info+="家长号码："+"<%=familyNumber%>"+"   "+"本次办理号码："+"<%=show_phone%>"+"|";
	
		}
		else
		{
			opr_info+="家长号码："+"<%=phoneNo%>"+"   "+"本次办理号码："+document.frm.show_phone.value+"|";

		}
		if("<%=openType%>"== "1"||"<%=openType%>"== "2"||"<%=openType%>"== "3" || "<%=openType%>"== "4")
		{
			<%
			if(familyNo.length >= 1)
			{%>
				opr_info+="截止目前家庭已有成员："+"|";
			<%
				for(int j=0;j<familyNo.length;j++)
				{%>
					opr_info+="<%=familyName[j][0]%>：<%=familyNo[j][0]%>";
					count ++;
					if(count > 3)
					opr_info+=""+"|";
				<%}%>
			<%}
			else
			{%>
				opr_info+="截止目前家庭已有成员："+"0";
			<%}%>
		}
		else
		{
			 opr_info+=""+"|";
			 opr_info+="截止目前家庭已有成员："+"0" +"|";
		}
		if("<%=openType%>"== "1"||"<%=openType%>"== "2"||"<%=openType%>"== "3" || "<%=openType%>"== "4")
		{
			<%
			if(familyProdCode.length >= 1 )
			{%>
				opr_info+=""+"|";
				opr_info+="截止目前家庭已有产品："+"|";
			<%
				for(int i=0;i<familyProdCode.length;i++)
				{
					if(familyParentId[i][0].equals("0"))
					{
						prod_name="家庭基本包";
					}
					else
					{
						prod_name="家庭优惠包";
					}
			%>
					opr_info+="  <%=MainProduct[i][0]%>   <%=MainProductName[i][0]%>  ";
					opr_info+="  <%=OtherProduct[i][0]%>   <%=OtherProductName[i][0]%>  (<%=prod_name%>)"+"|";
			 <%}%>
		<%}
			else
			{%>
				opr_info+=""+"|";
				opr_info+="截止目前家庭已有产品："+"0"+"|";
	  	<%}%>
	  }
	  else
	  {

	  	opr_info+="截止目前家庭已有产品："+"0"+"|";
	  }
		if("<%=openType%>"== "0"||"<%=openType%>"== "1"||"<%=openType%>"== "2")
		{
			opr_info+="业务生效时间： "+"当日"+"|";
		}
		else if("<%=openType%>"== "3")
		{
			opr_info+="业务生效时间： "+"次月"+"|";
		}
		else 
		{
			opr_info+="畅聊家庭业务申请成功。您已经邀请<%=show_phone%>加入该家庭。被邀请成员在24小时内回复确认短信才能成功加入该家庭，若不回复则加入失败。请您尽快通知被邀请的家庭成员并告知其业务优惠内容。"+"|";
		}		
		note_info1+="备注："+document.all.opNote.value+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }
  //提交处理
  function printCommit(subButton){
  	getAfterPrompt();
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	setOpNote();//为备注赋值
    //提交表单
    frmCfm();
	return true;
  }


function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path);
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
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "家庭服务计划变更之--<%=op_note%> 号码:"+document.frm.show_phone.value; 
	}
	return true;
}
//-->
//事中提示

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
			  <input name="op_type" type="text" class="InputGrey" id="op_type" value="<%=op_note%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="show_phone" type="text" class="InputGrey" id="show_phone" value="<%=show_phone%>" readonly>
			</td>
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
          </tr>
          <tr>
		    <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>
          </tr>
		  <tr>
			<td class="blue">家庭代码</td>
            <td colspan="<%=(trOneView=="display:none"?"3":"1")%>">
			  <input type="text" name="family_code" id="family_code"  v_must=1 value = "<%=family_code%>" readonly class="InputGrey">
			   <font color="orange"></font>
			</td>
			<TD class="blue" style=<%=trOneView%>> 家庭套餐代码</TD>
			<TD style="<%=trOneView%>" id="ipTd">
			  <select  name="add_mode" id="add_mode" onChange="controlFlagCodeTdView();">
				<option value="">--请选择--</option>
				<%for(int i = 0 ; i < rateCodeStr.length ; i ++){%>
				<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>
				<%}%>
			  </select>
			  <font color="orange">*</font>
			</TD>
          </tr>

          <tr>
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" readonly size="60" class="InputGrey">
            </td>
          </tr>
		  <tr>
            <td colspan="4" id="footer"> <div align="center">
                &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="printCommitOne(this)" >
                &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;
				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="favorcode">
  <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--客户地址-->
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="open_type" value="<%=openType%>">
  <input type="hidden" name="home_no" value="<%=home_no%>">
  <input type="hidden" name="home_no1" value="<%=home_no1%>">
  <input type="hidden" name="new_rate_code" value=""><!--待定，可选资费代码-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
  <input type="hidden" name="show_flag" value="<%=showflag%>"><!--打印工单广告-->
  <input type="hidden" name="op_code" value="<%=op_code%>"><!--操作代码-->
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>"><!--打印工单广告-->
   <input type="hidden" name="return_page" value="/npage/bill/f7328_login.jsp?activePhone=<%=phoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
