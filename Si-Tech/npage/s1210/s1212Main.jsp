<%
/********************
version v2.0
开发商: si-tech
模块：用户付费计划变更
日期：2008.12.1
作者：leimd
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%
request.setCharacterEncoding("GBK");
%>
<head>
	<title>用户付费计划变更</title>
	<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	%>
	<%
	
	Logger logger = Logger.getLogger("s1212Main.jsp");
	
	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
	//String work_no = baseInfoSession[0][2];
	//String loginName = baseInfoSession[0][3];
	//String org_code = baseInfoSession[0][16];

	String op_code = "1212";
	//int error_code = 0;
	//String error_msg = "";
	
	//String[][] temfavStr=(String[][])arrSession.get(3);
	
	String loginName = (String)session.getAttribute("workName");
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	
	String iRegion_Code = org_code.substring(0,2);
	String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	boolean hfrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
	pwrf=true;
	//String  outList[][] = new String [][]{{"0","21"}, {"21","7"},{"28","5"},{"33","8"},{"41","1"}};
	//String [][]feeStr;
	String [] retStr = null;
	
	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String cus_pass=WtcUtil.repNull(request.getParameter("cus_pass"));
	String[] twoFlag =new String []{};
	String phoneNo = srv_no;
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
System.out.println("sLoginAccept=1111111111111111111112222222222222222sLoginAccept" +sLoginAccept);	
    //comImpl co=new comImpl();
	//-----------获得手续费-------------
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE="+op_code;
	
	//ArrayList handFeeArr=co.spubqry32("2",sqHf);
	
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
 <wtc:sql><%=sqHf%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="handFeeArr" scope="end"/>
<%
	
	String oriHandFee="0";
	String oriHandFeeFlag="";
	if(handFeeArr.length>0)
	{
		oriHandFee=handFeeArr[0][0];
		oriHandFeeFlag=handFeeArr[0][1];
		if(Double.parseDouble(oriHandFee) < 0.01)
		   hfrf=true;
		else
		{
			if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim()))
			  hfrf=true;
		}
	}
	else
	  hfrf=true;

	//-----------获得服务器端费用信息数组-------------
	String sq1="select trim(fee_code),trim(detail_code),trim(detail_name) from sFeecodedetail order by fee_code,detail_code";
	//feeArr=co.spubqry32("3",sq1);
	
	%>
<wtc:service name="TlsPubSelBoss" outnum="3" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
			<wtc:param value="<%=sq1%>" />
		</wtc:service>
		<wtc:array id="feeStr" scope="end"/>


	<%
	
	//feeStr=(String[][])feeArr.get(0);
	if(feeStr.length==0)
	   response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=2");

	//------------获得服务器端初始化信息数组-----------
	
	
		//S1210Impl im1210=new S1210Impl();
		//ArrayList  inputParam = new ArrayList();
		//SPubCallSvrImpl callView = new SPubCallSvrImpl();
		//initArr=im1210.s1212Init(srv_no,work_no,op_code,org_code,"phone",srv_no);
		//String [] paramsIn = new String []{work_no,srv_no,op_code,org_code};
		//inputParam.add(work_no   );
		//inputParam.add(srv_no  );
		//inputParam.add(op_code    );
		//inputParam.add(org_code   );
		//retArray = callView.callFXService("s1212Init",inputParam,"4",outList);
	%>
		<wtc:service name="s1212Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="error_code" retmsg="error_msg" outnum="42" >
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=srv_no%>"/>
		<wtc:param value="<%=op_code%>"/> 
		<wtc:param value="<%=org_code%>"/>
		</wtc:service>
		<wtc:array id="initStr_1" start="0"  length="21"  scope="end"/>
		<wtc:array id="initStr_2" start="21"  length="7"  scope="end"/>
		<wtc:array id="initStr_3" start="28"  length="5"  scope="end"/>
		<wtc:array id="initStr_4" start="33"  length="8"  scope="end"/>
		<wtc:array id="initStr_5" start="41"  length="1"  scope="end"/>
		
  <%		
	if(!error_code.equals("000000"))
	{
	System.out.println("error_code======="+error_code);
	System.out.println("error_msg"+error_msg);

	%>
	<script language="javascript">
		rdShowMessageDialog('s1212Init服务未能成功!<br>服务代码<%=error_code%><%=error_msg%>',0);
		window.location.href="s1212Login.jsp?activePhone=<%=srv_no%>";
	</script>
	<%
	return;
	}else {
		//initStr_1=(String[][])retArray.get(0);
		if(initStr_1.length==0) {
			//String [][]errStr=(String[][])retArray.get(4);
			//System.out.println("====" + errStr[0][0]);
			response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=101&errCode="+error_code+"&errMsg="+error_msg);
			//System.out.println("====" + errStr[0][0]);
			//System.out.println("====" + errStr[0][1]);
			//response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=10");
		}
	
		//twoFlag=im1210.s1210Index(srv_no,"phone",srv_no);
		
		

	        
		twoFlag = new String[2];
		twoFlag[0] = "0";
		twoFlag[1] = "SUCCESS!";
		String fStr[][] = new String[0][];
		String sq11 = "select trim(attr_code) from dcustMsg where phone_no=:srv_no and substr(run_code,2,1)<'a' and rownum<2";
		String temFlag = "";
		String [] paraIn1 = new String[2];
		paraIn1[0]=sq11;
		paraIn1[1]="srv_no="+srv_no;
		%>
<wtc:service name="TlsPubSelCrm" outnum="10" retcode="err_code" retmsg="err_message" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
  	<wtc:param value="<%=paraIn1[0]%>"/>
 	<wtc:param value="<%=paraIn1[1]%>"/>
 	</wtc:service>
	<wtc:array id="sPubQry32Arr" scope="end"/>
<%
			twoFlag[0] = err_code;
			twoFlag[1] = err_message;
			String [] paraIn2 = new String[2];
			String [] paraIn3 = new String[2];
			if (Integer.parseInt(err_code) == 0)
				fStr = sPubQry32Arr;
			if (fStr.length == 0)
				temFlag = "00000";
			else
				temFlag = fStr[0][0];
			if (!temFlag.equals(""))
			{
				String bigFlag = temFlag.substring(2, 4);
				String grpFlag = temFlag.substring(4, 5);
				String sq2 = "select trim(card_name) from sBigCardCode where card_type=:bigFlag";
				String sq3 = "select trim(grp_name) from sGrpBigFlag where grp_flag=:grpFlag";
				paraIn2[0]=sq2;
				paraIn2[1]="bigFlag="+bigFlag;
				paraIn3[0]=sq3;
				paraIn3[1]="grpFlag="+grpFlag;
				
				
%>	
<wtc:service name="TlsPubSelCrm" retcode="err_code2" retmsg="err_message2" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
  	<wtc:param value="<%=paraIn2[0]%>"/>
 	<wtc:param value="<%=paraIn2[1]%>"/>
 	</wtc:service>
	<wtc:array id="sPubMultiSelArr1" scope="end"/>	
<%
        twoFlag[0] = err_code2;
				if (Integer.parseInt(err_code2) == 0)
				{
					twoFlag[0] = sPubMultiSelArr1[0][0];
				}
%>
<wtc:service name="TlsPubSelCrm" retcode="err_code3" retmsg="err_message3" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
  	<wtc:param value="<%=paraIn3[0]%>"/>
 	<wtc:param value="<%=paraIn3[1]%>"/>
 	</wtc:service>
	<wtc:array id="sPubMultiSelArr2" scope="end"/>		
<%
System.out.println("err_message3="+err_message3);
System.out.println("err_code3="+err_code3);
				twoFlag[1] = err_message3;
				if (Integer.parseInt(err_code3) == 0)
				{
					twoFlag[1] = sPubMultiSelArr2[0][0];
				}
			}
System.out.println("1111111111111111111111111111"+twoFlag[1]);
		
		if(twoFlag==null || twoFlag.length==0)
			response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=11");
		if(Double.parseDouble(initStr_1[0][18])>0)
		{
			//response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=100&oweAccount="+initStr_1[0][17].trim()+"&oweFee="+initStr_1[0][18].trim());
		}
	
		//initStr_2=(String[][])retArray.get(1);
		System.out.println("!!!!!!!!!!!!!!!!initStr_2="+initStr_2.length);
		if(initStr_2.length==0)	{
			initStr_2 = new String[1][7];
			initStr_2[0][0] = "0";
			initStr_2[0][1] = "";
			initStr_2[0][2] = "99999999";
			initStr_2[0][3] = "0";
			initStr_2[0][4] = "0";
			initStr_2[0][5] = "N";
			initStr_2[0][6] = "Y";
		}
		//response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=12");

		//initStr_3=(String[][])retArray.get(2);
		System.out.println("@@@@@@@@@@@@@@@@initStr_3="+initStr_3.length);
		//if(initStr_3.length==0)
		//response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=13");

		//initStr_4=(String[][])retArray.get(3);
		System.out.println("#####################initStr_4="+initStr_4.length);
		if(initStr_4.length==0) {
			initStr_4 = new String[1][8];
			initStr_4[0][0] = "";
			initStr_4[0][1] = "";
			initStr_4[0][2] = "";
			initStr_4[0][3] = "";
			initStr_4[0][4] = "";
			initStr_4[0][5] = "";
			initStr_4[0][6] = "";
			initStr_4[0][7] = "";
		//response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=13");
		}
		//initStr_5=(String[][])retArray.get(4);
		System.out.println("#####################initStr_5="+initStr_5.length);
		if(initStr_5.length==0) {
		initStr_5 = new String[1][1];
		initStr_5[0][0] = "0";

	}else{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa="+initStr_5[0][0].trim());
		}
		//String [][]errStr=(String[][])retArray.get(4);
		/*if(errStr.length==0)
		response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=14");
		else
		{
		if(Integer.parseInt(errStr[0][0])!=0)
		{
		if(Integer.parseInt(errStr[0][0])==1007 || Integer.parseInt(errStr[0][0])==1008)
		{
		response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=100&oweAccount="+ new String(initStr_1[0][17].trim().getBytes("GBK"),"ISO8859_1")+"&oweFee="+initStr_1[0][18].trim());
		}
		else
		{
		response.sendRedirect("s1212Login.jsp?ReqPageName=s1212Main&retMsg=101&errCode="+errStr[0][0]+"&errMsg="+new String(errStr[0][1].getBytes("GBK"),"ISO8859_1"));
		}
		}
		}*/
		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		}
		%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="javascript">
var js_fee = new Array(new Array(),new Array(),new Array());
var js_init1=new Array(new Array());
var js_init2=new Array(new Array(),new Array(),new Array(),new Array(),new Array(),new Array(),new Array());
var js_init3=new Array(new Array(),new Array(),new Array(),new Array(),new Array());
var opFlag="add";

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function()
{
	self.status="";
	document.all.t_acc_name.focus();
	//core.rpc.onreceive = doProcess;
	//------------初始化列表------------
		var obj=document.all.l_msg.style;
		document.all.l_msg.size=8;
		obj.backgroundColor="#99ccff";
		obj.color="green";
		obj.width="100%";
		obj.fontSize="13";
		obj.borderStyle="none";
		
	<%
	//-----------获得客户端费用信息数组-------------
	for(int i=0;i<feeStr.length;i++)
	{
		for(int j=0;j<feeStr[i].length;j++)
		{
			%>
			js_fee[<%=j%>][<%=i%>]="<%=feeStr[i][j].trim()%>";
			<%
		}
	}
	
	//------------获得客户端初始化信息数组-----------
	for(int i=0;i<initStr_1.length;i++)
	{
		for(int j=0;j<initStr_1[i].length;j++)
		{
			%>
			js_init1[<%=i%>][<%=j%>]="<%=initStr_1[i][j].trim()%>";
			<%
		}
	}
	
	for(int i=0;i<initStr_2.length;i++)
	{
		for(int j=0;j<initStr_2[i].length;j++)
		{
			%>
			js_init2[<%=j%>][<%=i%>]="<%=initStr_2[i][j].trim()%>";
			//alert("js_init2(<%=j%>，<%=i%>)："+js_init2[<%=j%>][<%=i%>]);
			<%
		}
	}
	
	for(int i=0;i<initStr_3.length;i++)
	{
		for(int j=0;j<initStr_3[i].length;j++)
		{
		   System.out.println("initStr_3[i][j]==="+initStr_3[i][j]);
			%>
			 js_init3[<%=j%>][<%=i%>]="<%=initStr_3[i][j].trim()%>";
			<%
		}
	}
	%>
	initFace("FromStart");
}
</script>
<script language="javascript">
		
function doProcess(packet)
{
	var passFlag=packet.data.findValueByName("passFlag");
	var billFlag=packet.data.findValueByName("billFlag");
	var areaFlag=packet.data.findValueByName("areaFlag");
	var dataFlag=packet.data.findValueByName("dataFlag");
	
	if(passFlag=="n" || billFlag=="n" || areaFlag=="n" || dataFlag=="n")
	{
		if(dataFlag=="n")
		{
			rdShowMessageDialog("无此帐户！");
			if(document.all.tr_t_account.style.display=="")
			{
				document.all.t_acc_name.value="";
				document.all.t_acc_pass1.value="";
				document.all.t_acc_name.focus();
			}
			else if(document.all.tr_s_account.style.display=="")
			{
				document.all.t_acc_pass.value="";
				document.all.t_acc_pass.focus();
			}
		}
		else if(billFlag=="n")
		{
			rdShowMessageDialog("此帐户为默认帐户！");
			if(document.all.tr_t_account.style.display=="")
			{
				document.all.t_acc_name.value="";
				document.all.t_acc_pass1.value="";
				//document.all.t_acc_name.focus();
			}
			else if(document.all.tr_s_account.style.display=="")
			{
				document.all.t_acc_pass.value="";
				document.all.t_acc_pass.focus();
			}
		}
		else if(areaFlag=="n")
		{
			rdShowMessageDialog("此帐户为异地帐户！");
			if(document.all.tr_t_account.style.display=="")
			{
				document.all.t_acc_name.value="";
				document.all.t_acc_pass1.value="";
				document.all.t_acc_name.focus();
			}
			else if(document.all.tr_s_account.style.display=="")
			{
				document.all.t_acc_pass.value="";
				document.all.t_acc_pass.focus();
			}
		}
		else if(passFlag=="n")
		{
			rdShowMessageDialog("帐户密码错误！",0);
			if(document.all.tr_t_account.style.display=="")
			{
				document.all.t_acc_pass1.value="";
				document.all.t_acc_pass1.focus();
			}
			else if(document.all.tr_s_account.style.display=="")
			{
				document.all.t_acc_pass.value="";
				document.all.t_acc_pass.focus();
			}
		}
	}
	else if(passFlag=="y" && billFlag=="y" && areaFlag=="y" && dataFlag=="y")
	{
			rdShowMessageDialog("帐户信息验证成功！",2);
			document.all.b_print.disabled=false;
	}
}

//---------显示打印对话框----------------
function printCommit()
{
	getAfterPrompt();
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{
	
	if(opFlag=="add"||opFlag=="mod")
	{
		var lsLen=document.all.l_msg.options.length;
		if(document.all.r_detFlag[0].checked)
		{
			if(lsLen<=0)
			{
				rdShowMessageDialog("明细标志选‘是’时，费用代码列表不能为空！");
				return;
			}
		}
		if(!forInt(document.all.t_pay_order))
		{
			return false;
		}
		if(!forInt(document.all.t_feeLimit))
		{
			return false;
		}
	}
	
	if(document.all.assuId.value.trim().length>0)
	{
		if(document.all.assuId.value.length<5)
		{
			rdShowMessageDialog("证件号码长度有误(至少5位)！",0);
			document.all.assuId.focus();
			return false;
		}
	}

	if(check(frm))
	{
		document.all.t_sys_remark.value="用户"+"<%=initStr_1[0][0].trim()%>"+"付费计划变更";
		if(document.all.t_op_remark.value.trim().length==0)
		{
			document.all.t_op_remark.value="操作员<%=work_no%>"+"对用户"+"<%=initStr_1[0][0].trim()%>"+"进行用户付费计划变更"
		}
		if(document.all.assuNote.value.trim().length==0)
		{
			document.all.assuNote.value="操作员<%=work_no%>"+"对用户"+"<%=initStr_1[0][0].trim()%>"+"进行用户付费计划变更"
		}
		
		//显示打印对话框
		var h=210;
   		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var pType="subprint";             // 打印类型：print 打印 subprint 合并打印
		var billType="1";               //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=sLoginAccept%>";               // 流水号
		var printStr = printInfo(printType); //调用printinfo()返回的打印内容
		var mode_code=null;               //资费代码
		var fav_code=null;                 //特服代码
		var area_code=null;             //小区代码
		var opCode="<%=opCode%>" ;                   //操作代码
		var phoneNo=<%=phoneNo%>;                  //客户电话
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

		var ret=window.showModalDialog(path,printStr,prop);

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('确认电子免填单吗？')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('确认要提交用户付费计划变更信息吗？')==1)
				{
					conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('确认要提交用户付费计划变更信息吗？')==1)
			{
				conf();
			}
		}
	}
}

function printInfo(printType)
{
	 var cust_info=""; //客户信息
	 var opr_info=""; //操作信息
	 var note_info1=""; //备注1
	 var note_info2=""; //备注2
	 var note_info3=""; //备注3
	 var note_info4=""; //备注4
     var retInfo = "";  //打印内容
     
   cust_info+="手机号码："+document.all.srv_no.value+"|";
	 cust_info+="客户姓名："+document.all.cust_name.value+"|";
	 cust_info+="客户地址："+document.all.comm_addr.value+"|";
	 cust_info+="证件号码："+document.all.iccid.value+"|";
	
	opr_info+="用户付费计划变更。*手续费："+document.all.t_handFee.value+"|";
    opr_info+="业务流水："+"|";
    opr_info+="系统备注："+document.all.t_sys_remark.value+"|";
	opr_info+="用户备注："+document.all.t_op_remark.value+"|";
	opr_info+="担保人姓名："+document.all.assuName.value+"|";
	opr_info+="担保人电话："+document.all.assuPhone.value+"|";
	opr_info+="担保人地址："+document.all.assuAddr.value+"|";
	opr_info+="担保人证件号："+document.all.assuId.value+"|";
	opr_info+="担保人证件地址："+document.all.assuIdAddr.value+"|";
	note_info1+="      备注："+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

/*
	var retInfo = "";
	retInfo+=document.all.srv_no.value+"|";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+=document.all.cust_name.value+"|";
	retInfo+=" "+"|";
	retInfo+=document.all.comm_addr.value+"|";
	retInfo+=document.all.iccid.value+"|";
	retInfo+=" "+"|";
	retInfo+="用户付费计划变更。*手续费："+document.all.t_handFee.value+"|";
	retInfo+=document.all.t_sys_remark.value+"|";
	retInfo+=document.all.t_op_remark.value+"|";
		
	//sim卡号
	retInfo+=" |";
	
	//担保人信息
	retInfo+=document.all.assuName.value+"|";
	retInfo+=document.all.assuPhone.value+"|";
	retInfo+=document.all.assuAddr.value+"|";
	retInfo+=document.all.assuId.value+"|";
	retInfo+=document.all.assuIdAddr.value+"|";
*/
	return retInfo;
}

//---------提交处理函数-------------------
function conf()
{
	var temFeeCode="";
	var temDetailCode="";
	var temFeeName="";
	var temRateCode="";
	var lsLen=document.all.l_msg.options.length;
	for(var i=0;i<lsLen;i++)
	{
		temFeeCode+=document.all.l_msg.options[i].text.substring(21,42).trim()+"#";
		temDetailCode+=document.all.l_msg.options[i].text.substring(43,64).trim()+"#";
		temRateCode+=document.all.l_msg.options[i].text.substring(65,86).trim()+"#";
		temFeeName+=document.all.l_msg.options[i].text.substring(97,document.all.l_msg.options[i].text.length).trim()+"#";
	}
	//document.all.b_print.disabled=true;
	document.all.b_clear.disabled=true;
	document.all.b_back.disabled=true;
	document.all.transFeeCode.value=temFeeCode;
	document.all.transDetailCode.value=temDetailCode;
	document.all.transFeeName.value=temRateCode;
	frm.action="s1212_conf.jsp";
	frm.submit();
}

function canc()
{
	frm.submit();
}

//-------3--------实收栏专用函数----------------
function ChkHandFee()
{
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length>=1)
	{
		if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
		{
			rdShowMessageDialog("实收手续费不能大于原始手续费！");
			document.all.t_handFee.value=document.all.oriHandFee.value;
			document.all.t_handFee.select();
			document.all.t_handFee.focus();
			return;
		}
	}
	
	if(document.all.oriHandFee.value.trim().length>=1 && document.all.t_handFee.value.trim().length==0)
	{
		document.all.t_handFee.value="0";
	}
}

function getFew()
{
	if(window.event.keyCode==13)
	{
		var fee=document.all.t_handFee;
		var fact=document.all.t_factFee;
		var few=document.all.t_fewFee;
		if(fact.value.trim().length==0)
		{
			rdShowMessageDialog("实收金额不能为空！");
			fact.value="";
			fact.focus();
			return;
		}
		if(parseFloat(fact.value)<parseFloat(fee.value))
		{
			rdShowMessageDialog("实收金额不足！");
			fact.value="";
			fact.focus();
			return;
		}
		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
		few.value=(tem2/100).toString();
		few.focus();
	}
}

//-------4--------点击操作类型单选框时--------------
function chg_opType(){
	if(document.all.r_acc_opType[0].checked)
	{
		opFlag="add";
		$("#t_pay_order").attr("v_must","1");
		$("#t_feeLimit").attr("v_must","1");
	}
	else if(document.all.r_acc_opType[1].checked)
	{
		if(js_init2[0].length<=1)
		{
			rdShowMessageDialog("没有可以修改的帐户！");
			document.all.r_acc_opType[0].checked=true;
			return;
		}
		if(parseInt(document.all.ccount.value,10)>0)
		{
			rdShowMessageDialog("您是托收帐户，帐户有欠费不能修改帐户！");
			document.all.r_acc_opType[0].checked=true;
			return;
		}
		$("#t_pay_order").attr("v_must","1");
		$("#t_feeLimit").attr("v_must","1");
		opFlag="mod";
	}
	else if(document.all.r_acc_opType[2].checked)
	{
		if(js_init2[0].length<=1)
		{
			rdShowMessageDialog("没有可以删除的帐户！");
			document.all.r_acc_opType[0].checked=true;
			
			if("m484"=="<%=opCode%>"){
				removeCurrentTab();
			}
		}
		if(parseInt(document.all.ccount.value,10)>0){
			rdShowMessageDialog("您是托收帐户,帐户有欠费不能删除帐户！");
			document.all.r_acc_opType[0].checked=true;
			if("m484"=="<%=opCode%>"){
				removeCurrentTab();
			}
		}		
		$("#t_pay_order").attr("v_must","0");
		$("#t_feeLimit").attr("v_must","0");
		opFlag="del";
	}
	initFace("FromStart");
}

//-------5-----------点击增加、删除按钮及双击列表时---------
function f_add()
{
	var choicedFeeCode="";
	var Fees="";
	for(var i=0;i<document.all.l_msg.options.length;i++)
	{
		choicedFeeCode=document.all.l_msg.options[i].text.substring(21,42).trim();
		Fees+=choicedFeeCode+"|";
	}
	
	var h=600;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var ret=window.showModalDialog("Dlg_s1212Add.jsp?Fees="+Fees,"",prop);
	
	
	if(typeof(ret)!="undefined")
	{
		var optNums=getTokNums(ret,"|");
		var oneOpt;
		if(opFlag=="mod" || opFlag=="add")
		{
			var existNum=document.all.l_msg.options.length;
			if(existNum==-1) existNum=0;
			var existOpt=new Array(existNum);
			for(var i=0;i<existNum;i++)
			existOpt[i]=document.all.l_msg.options[i].text;
			document.all.l_msg.options.length=0;
			document.all.l_msg.options.length=optNums+existNum;
			
			var totalOpt=new Array(optNums+existNum);
			var tem1="";
			var temSeri="";
			
			for(var i=0;i<existNum;i++)
			{
				totalOpt[i]=existOpt[i];
				tem1+=totalOpt[i].substring(0,13).trim()+totalOpt[i].substring(21,42).trim()+"#";
				temSeri+=i+"#";
			}
			
			for(var i=0;i<optNums;i++)
			{
				oneOpt=oneTok(ret,"|",i+1);
				totalOpt[i+existNum]=oneTok(oneOpt,"#",4)+thinkAdd(oneTok(oneOpt,"#",4),21)+
				oneTok(oneOpt,"#",1)+thinkAdd(oneTok(oneOpt,"#",1),22)+
				oneTok(oneOpt,"#",2)+thinkAdd(oneTok(oneOpt,"#",2),22)+
				oneTok(oneOpt,"#",5)+thinkAdd(oneTok(oneOpt,"#",5),22)+
				oneTok(oneOpt,"#",3);
				tem1+=totalOpt[i+existNum].substring(0,20).trim()+totalOpt[i+existNum].substring(21,42).trim()+"#";
				temSeri+=(existNum+i)+"#";
			}
			
			//-------------------s_order---------------------
			var tem2=orderOtherStr(tem1,temSeri,"#");
			var len2=getTokNums(tem2,"#");
			var orderArr=new Array(len2);
			for(var i=0;i<optNums+existNum;i++)
			{
				orderArr[i]=oneTok(tem2,"#",i+1);
			}
			for(var i=0;i<optNums+existNum;i++)
				document.all.l_msg.options[i].text=totalOpt[orderArr[i]];
			//-------------------e_order---------------------
		}
	}
}

function f_del()
{
	var newOpt=new Array();
	var nowArr=0;
	if(document.all.l_msg.selectedIndex=="-1")
	{
		rdShowMessageDialog("请先选择费用代码！");
		return;
	}
	for(var i=0;i<document.all.l_msg.options.length;i++)
	{
		if(document.all.l_msg.options[i].selected==false)
		{
			newOpt[nowArr]=document.all.l_msg.options[i].text;
			nowArr++;
		}
	}
	
	document.all.l_msg.options.length=0;
	document.all.l_msg.options.length=newOpt.length;
	for(var i=0;i<newOpt.length;i++)
	{
		document.all.l_msg.options[i].text=newOpt[i];
	}
}

function f_list()
{
	if(document.all.l_msg.selectedIndex=="-1")
	{
		//rdShowMessageDialog("费用代码列表为空！");
		return;
	}
	if(opFlag=="mod" || opFlag=="add")
	{
		var zxn=document.all.l_msg.options[document.all.l_msg.selectedIndex].text;
		var billOrder=zxn.substring(0,20).trim();
		var feeCode=zxn.substring(21,42).trim();
		var detailCode=zxn.substring(43,64).trim();
		var per=zxn.substring(65,86).trim();
		var feeName=zxn.substring(87,zxn.length).trim();
		
		var h=300;
		var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var ret=window.showModalDialog("Dlg_s1212Mod.jsp?billOrder="+billOrder+"&feeCode="+feeCode+"&detailCode="+detailCode+"&feeName="+feeName+"&per="+per,"",prop);
		
		if(typeof(ret)!="undefined"){
			billOrder=oneTok(ret,"#",1);
			per=oneTok(ret,"#",2);
			document.all.l_msg.options[document.all.l_msg.selectedIndex].text=
			billOrder+thinkAdd(billOrder,21)+
			feeCode+thinkAdd(feeCode,22)+
			detailCode+thinkAdd(detailCode,22)+
			per+thinkAdd(per,22)+
			feeName;
		}
		
		//-------------------s_order---------------------
		var chgOpt=new Array(document.all.l_msg.options.length);
		var temChg="";
		var temSeri="";
		for(var i=0;i<document.all.l_msg.options.length;i++)
		{
			chgOpt[i]=document.all.l_msg.options[i].text;
			temChg+=document.all.l_msg.options[i].text.substring(0,20).trim()+document.all.l_msg.options[i].text.substring(21,42).trim()+"#";
			temSeri+=i+"#";
		}
		var tem2=orderOtherStr(temChg,temSeri,"#");
		var len2=getTokNums(tem2,"#");
		var orderArr=new Array(len2);
		
		for(var i=0;i<len2;i++)
		{
			orderArr[i]=oneTok(tem2,"#",i+1);
		}
		document.all.l_msg.options.length=0;
		document.all.l_msg.options.length=len2;
		for(var i=0;i<len2;i++)
			document.all.l_msg.options[i].text=chgOpt[orderArr[i]];
		//-------------------e_order---------------------
	}
}

function f_chgAccount()
{
	//initFace("noFromStart");
	//document.all.b_print.disabled=true;
	document.all.t_acc_pass.value="";
	document.all.t_acc_pass.focus();
}

function f_chk()
{
	if(document.all.t_acc_pass.value.trim().length==0)
	{
		rdShowMessageDialog("帐户密码不能为空！");
		document.all.t_acc_pass.focus();
		return false;
	}
	var acc_name = document.all.s_acc_name.options[document.all.s_acc_name.selectedIndex].value.trim();
	var acc_pass = document.all.t_acc_pass.value.trim();
	var acc_area = document.all.acc_area.value.trim();
	var user_id = document.all.cust_id.value.trim();
	var myPacket = new AJAXPacket("chk_pass.jsp","正在验证帐户信息，请稍候......");
		myPacket.data.add("acc_name",acc_name);
		myPacket.data.add("acc_pass",acc_pass);
		myPacket.data.add("user_id",user_id);
		myPacket.data.add("acc_area",acc_area);
		myPacket.data.add("srv_no","<%=srv_no%>");
		if(document.all.r_acc_opType[2].checked)
			myPacket.data.add("choice_type","d");
		else
			myPacket.data.add("choice_type","nd");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function f_chk1()
{
	if(document.all.t_acc_name.value.trim().length==0)
	{
		rdShowMessageDialog("付费帐户不能为空！");
		document.all.t_acc_name.focus();
		return false;
	}
	
	if(document.all.t_acc_pass1.value.trim().length==0)
	{
		rdShowMessageDialog("帐户密码不能为空！");
		document.all.t_acc_pass1.focus();
		return false;
	}
	
	var acc_name = document.all.t_acc_name.value.trim();
	var acc_pass = document.all.t_acc_pass1.value.trim();
	var acc_area = document.all.acc_area.value.trim();
	var user_id = document.all.cust_id.value.trim();
	var myPacket = new AJAXPacket("chk_pass.jsp","正在验证帐户信息，请稍候......");
		myPacket.data.add("acc_name",acc_name);
		myPacket.data.add("acc_pass",acc_pass);
		myPacket.data.add("user_id",user_id);
		myPacket.data.add("acc_area",acc_area);
		myPacket.data.add("srv_no","<%=srv_no%>");
		myPacket.data.add("choice_type","nd");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function chgAcc()
{
	document.all.b_print.disabled=true;
}

function chg_DetailFlag()
{
	if(document.all.r_detFlag[0].checked)
	{
		document.all.b_add.disabled=false;
	}
	else if(document.all.r_detFlag[1].checked)
	{
		document.all.b_add.disabled=true;
		rdShowMessageDialog("明细标志选‘否’时，不能增加费用代码！");
	}
}

function m_feeLimit()
{
	if(document.all.t_feeLimit.value.trim().length>0)
	{
		if(1*(document.all.t_feeLimit.value)<0.01)
		{
			rdShowMessageDialog('限额为"0"表示无限额！');
		}
	}
}

$(document).ready(function (){
	
	if("m484"=="<%=opCode%>"){
		$("input[name='r_acc_opType'][value='a']").hide();
		$("input[name='r_acc_opType'][value='u']").hide();
		$("input[name='r_acc_opType'][value='d']").click();

		$("input[name='b_print']").removeAttr("disabled");
		$("#td_s_account1").hide();
		$("#td_s_account2").hide();
		
	}else{
		$("input[name='r_acc_opType'][value='a']").attr("checked","checked");
	}
	
});

</script>
</head>
<body>
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Main">
<input type="hidden" name="cust_name" id="cust_name" value="<%=initStr_1[0][3].trim()%>">
<input type="hidden" name="iccid" id="iccid" value="<%=initStr_1[0][14].trim()%>">
<input type="hidden" name="comm_addr" id="comm_addr" value="<%=initStr_1[0][11].trim()%>">
<input type="hidden" name="cust_id" id="cust_id" value="<%=initStr_1[0][0].trim()%>">
<input type="hidden" name="srv_no" id="srv_no" value=<%=srv_no%>>
<input type="hidden" name="transFeeCode" id="transFeeCode">
<input type="hidden" name="transDetailCode" id="transDetailCode">
<input type="hidden" name="transFeeName" id="transFeeName">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=initStr_1[0][20].trim()%>">
<input type="hidden" name="acc_area" id="acc_area" value="<%=initStr_4[0][0].trim()%>">
<input type="hidden" name="ccount" id="ccount" value="<%=initStr_5[0][0].trim()%>">
<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">  


<div class="title">
<div id="title_zi">客户资料</div>
</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" nowrap>大客户标志</td>
			<td nowrap><b><font color="#FF0000"><%=twoFlag[0]%></font></b></td>
			<td nowrap class="blue">集团标志</td>
			<td nowrap><%=twoFlag[1]%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>当前预存</td>
			<td nowrap><%=initStr_1[0][16]%></td>
			<td nowrap class="blue">当前欠费</td>
			<td nowrap><%=initStr_1[0][15]%></td>
		</tr>
		<tr>
			<td class="blue" nowrap>客户名称</td>
			<td nowrap><%=initStr_1[0][3]%></td>
			<td nowrap class="blue">客户地址</td>
			<td nowrap><%=initStr_1[0][11]%></td>
		</tr>
	</table>
</div>

<div id="Operation_Table">																		
<div class="title">
<div id="title_zi">担保人资料</div>
 </div>
<table cellspacing="0">
	<tr id="tr_r_opType">
		<td class="blue" nowrap>担保人姓名</td>
		<td nowrap>
			<input name=assuName  v_maxlength=30 v_type="string"  maxlength="30" size=20 index="0" value="<%=initStr_4[0][1].trim()%>">
		</td>
		<td nowrap class="blue">担保人电话</td>
		<td nowrap>
			<input name=assuPhone   v_maxlength=20 v_type="string"  maxlength="20" size=20 index="1" value="<%=initStr_4[0][2].trim()%>">
		</td>
	</tr>																						
		<tr id="tr_r_opType">
			<td class="blue" nowrap>担保人证件类型</td>
			<td nowrap>
			<select name="assuIdType" id="assuIdType"  index="2">
			<%
			//得到输入参数
			try
			{
				String sqlStr ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
				//retArray = co.spubqry32("3",sqlStr,"phone",srv_no);
				%>
				<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
 <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
				<%
				//int recordNum = Integer.parseInt((String)retArray.get(0));
				//result = (String[][])retArray.get(1);
				//result = (String[][])retArray.get(0);
				int recordNum = result.length;
				for(int i=0;i<recordNum;i++){
				if(result[i][0].trim().equals(initStr_4[0][3].trim()))
				   out.println("<option class='button' value='" + result[i][0] + "' selected>" + result[i][1] + "</option>");
				else
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
			}
			}catch(Exception e){
				logger.error("Call sunView is Failed!");
			}
			%>
			</select>
			</td>
			<td nowrap class="blue">担保人证件号码</td>
			<td nowrap>
				<input name=assuId   v_type="string" maxlength="18" size=20 index="3" value="<%=initStr_4[0][4].trim()%>">
			</td>
		</tr>
		<tr id="tr_r_opType">
			<td nowrap class="blue">担保人证件地址</td>
			<td colspan="3" nowrap>
				<input name=assuIdAddr  v_maxlength=60 v_type="string"  maxlength="60" size=60 index="4" value="<%=initStr_4[0][5].trim()%>">
			</td>
		</tr>
		<tr id="tr_r_opType">
			<td nowrap class="blue">担保人联系地址</td>
			<td colspan="3" nowrap>
				<input name=assuAddr   v_maxlength=60 v_type="string" maxlength="60" size=60 index="5" value="<%=initStr_4[0][6].trim()%>">
			</td>
		</tr>
		<tr id="tr_r_opType" style="display='none'">
			<td nowrap class="blue">担保人备注信息</td>
			<td colspan="3" nowrap>
				<input name=assuNote0   v_maxlength=60 v_type="string" maxlength="60" size=60 index="6" value="<%=initStr_4[0][7].trim()%>">
			</td>
		</tr>
	</table>
</div>

																			
<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">操作信息</div>
 </div>
  <table cellspacing="0">
	<tr>
		<td class="blue">帐号操作类型</td>
		<td colspan="5" nowrap class="blue">
			<%
			if("m484".equals(opCode)){
			%>
			<input type="radio" name="r_acc_opType" checked value="a" onclick="chg_opType()" index="0">
			<input type="radio" name="r_acc_opType" value="u" onclick="chg_opType()"  index="1">
		
			<input type="radio" name="r_acc_opType" value="d" onclick="chg_opType()" checked index="2">
		      	删除
			<%
			}else{
			%>
				<input type="radio" name="r_acc_opType" checked value="a" onclick="chg_opType()" index="0">
				增加
				<input type="radio" name="r_acc_opType" value="u" onclick="chg_opType()"  index="1">
				修改
			<%
			}
			%>
			
		 </td>
	</tr>
	<tr id="tr_t_account">
		 <td nowrap class="blue">付费帐户</td>
		 <td nowrap colspan="2">
				<input type="text" size="21" name="t_acc_name" value="" onchange="chgAcc()" maxlength=22 index="3">
				<font class="orange">*</font> </td>
				<td nowrap class="blue">帐户密码</td>
				<td nowrap colspan="2">
					<input   type="password" size="8" name="t_acc_pass1" id="t_acc_pass1" maxlength="6" v_type=0_9 index="4" onkeyup="if(event.keyCode==13)f_chk1()" >
					<font class="orange">*</font>
					<input class="b_text" type="button" name="b_chk2" value="验证" onClick="f_chk1()">
				</td>																																																	
		  </td>
	</tr>
	 <tr  id="tr_s_account">																															
			<td nowrap class="blue">付费帐户</td>
			<td nowrap colspan="2">
				<select name="s_acc_name" onchange="f_chgAccount()" index="5">
				</select>
			</td>
			<td nowrap class="blue"  id="td_s_account1"> >帐户密码</td>
			<td nowrap colspan="2" id="td_s_account2">
				<input   type="password" size="8" name="t_acc_pass" id="t_acc_pass" maxlength="6" v_type=0_9 index="6" onkeyup="if(event.keyCode==13)f_chk()">
				<font class="orange">*</font>
				<input class="b_text" type="button" name="b_chk2" value="验证" onClick="f_chk()">
			</td>
		</tr>																																															
		
	     <tr id="tr_add"> 																				
				<td nowrap class="blue">前一帐单</td>
				<td nowrap>
					<select name="s_pre_account" index="7">
					</select>
				</td>
				<td nowrap class="blue">冲销顺序</td>
				<td nowrap>
					<input   type="text" size="10" name="t_pay_order" id="t_pay_order" v_must=1 index="8">
					<font class="orange">*</font>
				</td>
				<td nowrap class="blue">限额</td>
			  <td nowrap>
					<input   type="text" name="t_feeLimit" id="t_feeLimit" v_must=1 index="9" onblur="if(checkElement(this)){m_feeLimit();}">
					<font class="orange">*</font>
				</td>
			</tr>
			<tr id="tr_add1">
				<td nowrap class="blue">明细标志</td>
				<td nowrap colspan="5" class="blue">
					<input type="radio" name="r_detFlag" value="Y" index="10" onclick="chg_DetailFlag();">
										是
					<input type="radio" name="r_detFlag" value="N" index="11" onclick="chg_DetailFlag();">
										否
				</td>
			 </tr>	
     </table>
 </div>																									

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">业务处理</div>
 </div>
 <table id="tr_list">
   <tr class="blue" align="center">																																																
	<th>		
		  冲销顺序
			<input type="hidden" name="r_stopFlag" value="Y" index="12">	
	</th>
    <th nowrap>
		  费用代码
	</th>
	<th nowrap >
		 明细代码
	</th>
	<th nowrap >
          费用比率
	</th>
	<th nowrap colspan="2">
           费用名称
	</th>
</tr>
<tr >
	<td colspan="6">
			<select name="l_msg" size="1" multiple="multiple" ondblclick="f_list()" index="14">
			</select>
	</td>
</tr>
<tr>
	<td  id="footer" colspan="6">
		<div align="center">
			<input class="b_foot" type="button" name="b_add" value="增加" onmouseup="f_add()"  onkeyup="if(event.keyCode==13)f_add()" index="15">
			<input class="b_foot" type="button" name="b_del" value="删除" onmouseup="f_del()"  onkeyup="if(event.keyCode==13)f_del()" index="16">
		</div>
	</td>
</tr>
</table>
 </div>

<div id="Operation_Table">
	<div class="title">
  <div id="title_zi">账户信息</div>
 </div>		
  <table>			
	<tr id="tr_def">
		<td nowrap class="blue">默认付费帐户</td>
		<td class=Lable nowrap colspan="5"><%=initStr_1[0][19]%></td>
	</tr>
				
	<tr>
		<td nowrap class="blue">手续费</td>
		<td nowrap>
				<input type="text"  name="t_handFee" id="t_handFee" size="16"
				value="<%=(initStr_1[0][20].trim().equals(""))?("0"):(initStr_1[0][20].trim()) %>" v_type=float <%if(hfrf){%>readonly<%}%> onblur="if(checkElement(this)){ChkHandFee()}" index="17">
		</td>
		<td nowrap class="blue">实收</td>
		<td nowrap>
			<input type="text"  name="t_factFee" id="t_factFee" size="16" index="18" onKeyUp="getFew()" v_type=float  
				<%
				if(hfrf)
				{
				%>
				readonly
				<%
				}
				%>
			>
		</td>
		<td nowrap class="blue">找零</td>
		<td nowrap>
			<input type="text"  name="t_fewFee" id="t_fewFee" size="16" readonly>
		</td>
	</tr>
	<tr style="display:none">
		<td nowrap class="blue">备注</td>

		<td nowrap colspan="5">
				<input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
		</td>
	</tr>
	<tr style="display:none">
		<td nowrap class="blue">用户备注</td>
		<td nowrap colspan="5">
				<input type="text"  name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  maxlength=60 readonly>
		</td>
	</tr>
	<tr>
		<td nowrap class="blue">备注</td>
		<td nowrap colspan="5">
			<input name=assuNote   v_maxlength=60 v_type="string"  maxlength="60" size=60  index="19" value="">
		</td>
	</tr>
</table>
<!-- ningtn 2011-8-3 10:51:52 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=sLoginAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
	<tr>
		<td id="footer" nowrap align="center" colspan="6">
			<input class="b_foot_long" type="button" name="b_print" value="确认&打印" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="20">
			<input class="b_foot" type="button" name="b_clear" value="清除" onClick="frm.reset();" index="21">
			<input class="b_foot" type="button" name="b_back" value="关闭" onClick="removeCurrentTab()" index="22">
		</td>
	</tr>
   </table>
	 <%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
<!-- ningtn 2011-8-3 10:52:18 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

<script>
//-------1----------公用函数----------------------
function addSpc(num)
{
	var ret="";
	for(var i=0;i<num;i++)
	ret+=" ";
	return ret;
}

function thinkAdd(str,len)
{
	var existLen=0;
	var one="";
	var ret="";

	for(var i=0;i<str.length;i++)
	{
		existLen++;
		if(str.charCodeAt(i)>127)
		existLen++;
	}

	for(var i=0;i<len-existLen;i++)
	ret+=" ";
	return ret;
}

function initFace(startFlag)
{
	if(opFlag=="mod")
	{
		if(startFlag=="FromStart")
		{
			//使打印按钮变为不可用
			document.all.b_print.disabled=true;
			//填充付费帐户下拉框
			document.all.s_acc_name.options.length=0;
			//document.all.s_acc_name.options.length=js_init2[0].length;
			//从所有帐户中去掉bill_order='99999999'的帐户，因此，下拉框长度应减1
			document.all.s_acc_name.options.length=js_init2[0].length-1;
			var seLoc=0;
			for(var i=0;i<js_init2[0].length;i++)
			{
				if(js_init2[2][i]!="99999999")
				{
					document.all.s_acc_name.options[seLoc].text=js_init2[0][i];
					document.all.s_acc_name.options[seLoc].value=js_init2[0][i];
					seLoc++;
				}
			}
			//填充前一账单下拉框
			document.all.s_pre_account.options.length=0;
			//document.all.s_pre_account.options.length=js_init2[0].length+1;
			//从所有帐户中去掉bill_order='99999999'的帐户，因此，下拉框长度应减1
			document.all.s_pre_account.options.length=js_init2[0].length;
			document.all.s_pre_account.options[0].text="";
			document.all.s_pre_account.options[0].value="-1";
			var seLoc=1;
			for(var i=0;i<js_init2[0].length;i++)
			{
				if(js_init2[2][i]!="99999999")
				{
					document.all.s_pre_account.options[seLoc].text=js_init2[0][i];
					document.all.s_pre_account.options[seLoc].value=js_init2[0][i];
					seLoc++;
				}
			}
		}
	
		//根据当前帐户填充冲销顺序、限额、明细标志、停机标志
		var preFlag=js_init2[2][document.all.s_acc_name.selectedIndex];
		
		if(preFlag=="-1")
			document.all.s_pre_account.options[0].selected=true;
		else
		{
			for(var i=0;i<document.all.s_pre_account.options.length;i++)
			{
				if(document.all.s_pre_account.options[i].text==preFlag)
				{
					document.all.s_pre_account.options[i].selected=true;
					break;
				}
			}
		}
	
		document.all.t_pay_order.value=js_init2[3][document.all.s_acc_name.selectedIndex];
		document.all.t_feeLimit.value=js_init2[4][document.all.s_acc_name.selectedIndex];
		if(document.all.r_detFlag[0].value==js_init2[5][document.all.s_acc_name.selectedIndex])
			document.all.r_detFlag[0].checked=true;
		if(document.all.r_detFlag[1].value==js_init2[5][document.all.s_acc_name.selectedIndex])
			document.all.r_detFlag[1].checked=true;
	
		//填充列表
		var listItem="";
		var listItemNums=0;
		var nowItem=0;
		var temFeeName="";
		for(var i=0;i<js_init3[0].length;i++)
		{
			//alert(i+":"+js_init3[0][i]+"_"+js_init3[1][i]+"_"+js_init3[2][i]+"_"+js_init3[3][i]);
			if(js_init3[0][i]==document.all.s_acc_name.options[document.all.s_acc_name.options.selectedIndex].value)
			{
				listItemNums++;
			}
		}
		
		document.all.l_msg.options.length=0;
		document.all.l_msg.options.length=listItemNums;
		for(var i=0;i<js_init3[0].length;i++)
		{
			if(js_init3[0][i]==document.all.s_acc_name.options[document.all.s_acc_name.options.selectedIndex].value)
			{
				for(var j=0;j<js_fee[0].length;j++)
				{
					if(js_fee[0][j]==js_init3[2][i])
					{
						temFeeName=js_fee[2][j];
						break;
					}
				}
				document.all.l_msg.options[nowItem].text=js_init3[1][i]+thinkAdd(js_init3[1][i],21)+js_init3[2][i]+thinkAdd(js_init3[2][i],22)+js_init3[3][i]+thinkAdd(js_init3[3][i],22)+js_init3[4][i]+thinkAdd(js_init3[4][i],22)+temFeeName;
				//alert(document.all.l_msg.options[nowItem].text);
				nowItem++;
			}
		}
	
		//控制行的可见性
		//以下为不可见项
		document.all.tr_t_account.style.display="none";
		//以下为可见项
		document.all.tr_s_account.style.display="";
		document.all.tr_add.style.display="";
		document.all.tr_add1.style.display="";
		document.all.tr_list.style.display="";
	}
	else if(opFlag=="add")
	{
		//使打印按钮变为不可用
		document.all.b_print.disabled=true;

		//清空列表
		document.all.l_msg.length=0;

		//清空冲销顺序及限额、密码
		document.all.t_pay_order.value="";
		document.all.t_feeLimit.value="";
		document.all.t_acc_pass1.value="";

		//填充前一账单下拉框
		document.all.s_pre_account.options.length=0;

		//document.all.s_pre_account.options.length=js_init2[0].length+1;
		//从所有帐户中去掉bill_order='99999999'的帐户，因此，下拉框长度应减1
		document.all.s_pre_account.options.length=js_init2[0].length;

		document.all.s_pre_account.options[0].text="";
		document.all.s_pre_account.options[0].value="-1";
		var seLoc=1;
		for(var i=0;i<js_init2[0].length;i++)
		{
			if(js_init2[2][i]!="99999999")
			{
				document.all.s_pre_account.options[seLoc].text=js_init2[0][i];
				document.all.s_pre_account.options[seLoc].value=js_init2[0][i];
				seLoc++;
			}
		}

		//设置两个标志
		document.all.r_detFlag[0].checked=true;

		//控制行的可见性
		//以下为不可见项
		document.all.tr_s_account.style.display="none";

		//以下为可见项
		document.all.tr_t_account.style.display="";
		document.all.tr_add.style.display="";
		document.all.tr_add1.style.display="";
		document.all.tr_list.style.display="";
	}
	else if(opFlag=="del")
	{
		//alert("-----flag--------");
		//使打印按钮变为不可用
		document.all.b_print.disabled=true;
		//填充付费帐户下拉框
		document.all.s_acc_name.options.length=0;
		//document.all.s_acc_name.options.length=js_init2[0].length;
		//从所有帐户中去掉bill_order='99999999'的帐户，因此，下拉框长度应减1
		document.all.s_acc_name.options.length=js_init2[0].length-1;
		var seLoc=0;
		for(var i=0;i<js_init2[0].length;i++)
		{
			if(js_init2[2][i]!="99999999")
			{
				document.all.s_acc_name.options[seLoc].text=js_init2[0][i];
				document.all.s_acc_name.options[seLoc].value=js_init2[0][i];
				seLoc++;
			}
		}
		//控制行的可见性
		//以下为不可见项
 	  document.all.tr_t_account.style.display="none";
	  document.all.tr_add.style.display="none";
	  document.all.tr_add1.style.display="none";
	  document.all.tr_list.style.display="none";

      //以下为可见项
 	  document.all.tr_s_account.style.display="";
	}
}
</script>
