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
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  System.out.println("=================fg333_2.jsp=============");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
  String regionCode = orgCode.substring(0,2);
  String flag = "false";
%>
<%
  String retFlag="",retMsg="";//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
  String[] paraAray1 = new String[4];

  String main_card = request.getParameter("chief_srv_no");
  String op_code = request.getParameter("opCode");
  String openType = request.getParameter("open_type");/* 操作类型*/
  String TmpPhoneNo = main_card.substring(0,3);
  String passwordFromSer="";

  paraAray1[0] = main_card;		/* 手机号码   */
  paraAray1[1] = loginNo; 	/* 操作工号   */
  paraAray1[2] = orgCode;	/* 归属代码   */
  paraAray1[3] = op_code;	/* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s7328Qry", paraAray1, "39", "phone",main_card);
%>
	<wtc:service name="s7328Qry" routerKey="phone" routerValue="<%=main_card%>" retcode="retCode1" retmsg="retMsg1" outnum="39">
		<wtc:param value="0"/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
		<wtc:param value="<%=paraAray1[2]%>"/>		
	</wtc:service>
	<wtc:array id="result1"  start="0" length="25" scope="end"/>
	<wtc:array id="result0"  start="26" length="1" scope="end"/>
	<wtc:array id="result9"  start="27" length="1" scope="end"/>
	<wtc:array id="result10" start="28" length="1" scope="end"/>
	<wtc:array id="result2"  start="29" length="1" scope="end"/>
	<wtc:array id="result3"  start="30" length="1" scope="end"/>
	<wtc:array id="result4"  start="31" length="1" scope="end"/>
	<wtc:array id="result5"  start="32" length="1" scope="end"/>
	<wtc:array id="result6"  start="33" length="1" scope="end"/>
	<wtc:array id="result7"  start="34" length="1" scope="end"/>
	<wtc:array id="result8"  start="35" length="1" scope="end"/>

<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",prodId="",prodNote="";
  String otherCardFlag = "",mainDisabledFlag="",print_note="",bp_add="",cardId_no="",parent_prod="",prod_name="";
  String[][] tempArr= new String[][]{};
  String[][] familyCodeArr= new String[][]{};
  String[][] otherCodeArr= new String[][]{};
  String[][] cardTypeArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] opTimeArr= new String[][]{};
  String[][] newRateCodeArr= new String[][]{};
  String[][] FamilyProdArr= new String[][]{};
  String[][] FamilyNoteArr= new String[][]{};
  String[][] ParentProdArr= new String[][]{};

  String errCode = retCode1;
  String errMsg = retMsg1;
  tempArr = result1;
  FamilyProdArr = result0;  /*产品代码*/
  ParentProdArr = result10;	/*产品标志（'0'——家庭主产品，其余都是附加产品）*/
  System.out.println("errCode======"+errCode);
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7328Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }
  }else if(errCode.equals("000000") && result1.length>0)
  {

	    bp_name = tempArr[0][3];//机主姓名

	     bp_add = tempArr[0][4];//客户地址

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

	    cardId_no = tempArr[0][19];//证件号码

	  if(result0.length!=0||result10.length!=0)
	  {
	  	  prodId = FamilyProdArr[0][0];
	   	  parent_prod = ParentProdArr[0][0];
	  }
	  FamilyNoteArr = result9;	//产品详情
	  familyCodeArr = result2;//家庭号码
	  otherCodeArr = result3;//付卡号码--成员号码
      cardTypeArr = result4;//卡类型--加入时间
      beginTimeArr = result5;//开始时间--办理工号
      endTimeArr = result6;//结束时间--办理流水
      opTimeArr = result7;//操作时间--不用
	  newRateCodeArr = result8;//温馨家庭资费代码
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
	       retMsg="s7328Qry查询号码基本信息失败!"+errMsg;
        }
	}



  //******************得到下拉框数据***************************//
  String sqlRateCode = "";
    //资费信息

	sqlRateCode = "select a.offer_id,a.offer_id||'--'||a.offer_name from product_offer a,region b, sregioncode c  where a.offer_id=b.offer_id and a.offer_attr_type = 'YnEb' and b.group_id = c.group_id and c.region_code='"+regionCode +"'" ;
	System.out.println("sqlRateCode="+sqlRateCode);
	String[] paramIn = new String[2];
	/*
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	*/
	paramIn[0] = "select a.offer_id,a.offer_id||'--'||a.offer_name from product_offer a,region b, sregioncode c  where a.offer_id=b.offer_id and a.offer_attr_type = 'YnEb' and b.group_id = c.group_id and c.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
	//ArrayList rateCodeArr = co.spubqry32("2",sqlRateCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=paramIn[0]%>"/>
	<wtc:param value="<%=paramIn[1]%>"/>
	</wtc:service>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);
  /****得到打印流水****/
  String op_note="";
  op_note="家庭产品申请";
  String printAccept="";
  printAccept = getMaxAccept();
%>


<%
	String sqlstrTD = "select no_type from dcustres where phone_no='"+main_card+"'";
	 System.out.println(main_card);
	String phoneHead = main_card.substring(0,3);
%>
	<wtc:pubselect name="sPubSelect" retcode="retc" retmsg="retm" outnum="1">
			<wtc:sql><%=sqlstrTD%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultTD" scope="end" />
<%
		System.out.println("===================="+resultTD[0][0]);
		if(resultTD.length > 0){
			String no_type = resultTD[0][0];
			if("147".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";
			}
			else if ("157".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";	
			}
			/*2014/12/12 16:50:23 gaopeng R_CMI_HLJ_xueyz_2014_1933493@关于申请制作万号段号源类型数字转TD数据的请示
				加入184号段
			*/
			else if ("184".equals(phoneHead) && "0000h".equals(no_type)){
				flag = "true";	
			}
			else 
			{
				flag = "false";
			}
		}
			else
		{
			flag = "false";	
		}
		
		
		
%>
<head>
<title>畅聊家庭信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>
 onload=function()
 {
	
 }
 function doProcess(packet)
 {
 		retType = packet.data.findValueByName("retType");

 		if(retType == "getModeInfo")
 		{
 			var errCode = packet.data.findValueByName("errCode");
	  		var errMsg = packet.data.findValueByName("errMsg");

			var Main_Prod = packet.data.findValueByName("MainProd");
 			var Main_ProdName = packet.data.findValueByName("MainName");
 			var Other_Prod = packet.data.findValueByName("OtherProd");
 			var Other_ProdName = packet.data.findValueByName("OtherProdName");
 			var Note = packet.data.findValueByName("note");
 			var Note1 = packet.data.findValueByName("note1");
 			if(errCode == 000000)
 			{
 				document.all.main_prod.value = Main_Prod;
 				document.all.main_prod_name.value = Main_ProdName;
 				document.all.other_prod.value = Other_Prod;
 				document.all.other_prod_name.value = Other_ProdName;
 				document.all.main_prod_note.value = Note;
 				document.all.other_prod_note.value = Note1;
 			}
 			else
			{
				rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
				return false;
			}
 		}
}
</script>
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
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

   function frmCfm()
  {
 		frm.submit();
		return true;
  }
 //***
  function printfrmCfm(){
  	getAfterPrompt();
  	var radioArr = document.all.radios ;
 	for(var i=0;i<radioArr.length;i++){
 		if(document.all.radios[i].checked == true){
 			radio = document.all.radios[i].value;
 		}
 	}
 	if(radio == "1"){
 	   	var len = $("#village option").length;
 		if((len > 1) && ($("#village option:selected").val() == "0")){
 			rdShowMessageDialog("请选择小区信息！");
 			return;
 		}
 	}
  	//alert(document.all.parent_prod_id.value);
  	if(document.all.parent_prod_id.value =="附加产品" && document.all.friend_no.value=="")
  	{
  		rdShowConfirmDialog('请输入亲情号码!')
  		document.all.friend_no.focus();
  	}
  	else
  	{
	  	setOpNote();//为备注赋值
	  	document.frm.action="f7333Cfm.jsp";	  	
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
		var mode_code=codeChg(document.all.main_prod.value)+"~"+codeChg(document.all.other_prod.value);          //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=op_code%>";                                  //操作代码
		var phoneNo=document.frm.main_card.value;                 //客户电话

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.main_card.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
		var prod_name = "";

		cust_info+="手机号码："+"<%=main_card%>"+"|";
		cust_info+="客户姓名："+"<%=bp_name%>"+"|";

		opr_info+="用户品牌："+document.all.sm_name.value+"  "+"办理业务：畅聊家庭产品管理之<%=op_note%>"+"|";

		opr_info+="操作流水："+"<%=printAccept%>"+"|";

		if(document.all.parent_prod_id.value =="主产品")
		{
			prod_name="（家庭基本包）";
		}
		else
		{
			prod_name="（优惠亲情包）";
		}
		opr_info+="本次办理套餐：  "+"|";
		opr_info+="  "+document.all.main_prod.value+"  "+document.all.main_prod_name.value+"|";		
		opr_info+="  "+document.all.other_prod.value+"  "+document.all.other_prod_name.value+"  "+prod_name+"|";
		/**********描述类*********/
		note_info1+="本次申请的资费信息描述："+"|";
		note_info1+=" "+codeChg(document.all.main_prod_note.value)+"|";
		
		note_info2+= " " +"|";
    	note_info2+=" "+codeChg(document.all.other_prod_note.value)+"|";
    	
    	if(document.all.main_prod.value.trim()=="35687") {
    	
    	note_info3+="免责条款：客户办理该资费当日办理“移动e家”之有线电视活动，且活动未到期，家长不可解散家庭，家庭成员不可退出家庭。" +"|";
    	}
    	
		if(document.all.friend_no.value.length !=0)
		{
			opr_info+="设定号码: "+document.all.friend_no.value+"|";
		}
		opr_info+="资费生效时间： "+"当日"+"|";

		note_info4+="备注："+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }

 function queryProdCode()
 {
 	document.all.confirm.disabled=false;
 	// add by wanglma 20110815
 	var radioArr = document.all.radios ;
 	var radio = "2" ;
 	for(var i=0;i<radioArr.length;i++){
 		if(document.all.radios[i].checked == true){
 			radio = document.all.radios[i].value;
 		}
 	}
 	
 	var parentprod="<%=prodId%>";
 	var Parent_prod_id;
 	var sqlStr;
 	if((parentprod=="")||(parentprod=="0"))
 	{
 		parentprod="0";
 		Parent_prod_id = "主产品";
 	}
 	else if(parentprod!="0")
 	{
    	document.getElementById("friendno").style.display="";
    	document.all.friend_no.value="";
    	Parent_prod_id = "附加产品";
  }
    //alert(parentprod);
 	var regioncode="<%=regionCode%>";
 	var pageTitle = "产品查询";
    var fieldName = "产品代码|产品名称|产品标识|资费代码";//弹出窗口显示的列、列名 
    if(radio == "0"){
            if("<%=flag%>"=="true")
   			 {
   			 	//alert(1);
    			sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','主产品','附加产品') parent_prod_id ,main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='TDGH' and sysdate between begin_time and end_time"; 
   			 }
   		    else
            {	
            	//alert(2)
        	   sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','主产品','附加产品') parent_prod_id , main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and nvl(trim(fam_type),'T')<>'TDGH' and sysdate between begin_time and end_time"; 
	        }
    }else{
	   if(((radio == "1") && ("<%=flag%>"=="true")) ){
	    	sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','主产品','附加产品') parent_prod_id , main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='TDTF' and sysdate between begin_time and end_time"; 
	   }else{
	        sqlStr ="select fam_prod_id,trim(fam_prod_note),decode(trim(parent_prod_id),'0','主产品','附加产品') parent_prod_id ,main_product from sFamilyProduct where region_code='"+regioncode+"' and parent_prod_id='"+parentprod+"' and fam_type='XXXX' and sysdate between begin_time and end_time"; 
	   }
    }
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1|2|3";//返回字段
    var retToField = "fam_prod_id|fam_prod_note|Parent_prod_id|main_product";//返回赋值的域
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if(document.all.fam_prod_id.value=="")
    {

    	document.getElementById("friendno").style.display="none";
    	document.all.confirm.disabled=true;
    }
    else
    {
    	document.all.confirm.disabled=false;
    	if(radio == "1"){
    	   getVillage();
        }
    	qryMode();
 		}
 }
 function getVillage(){
 	var myPacket = new AJAXPacket("getVillage.jsp","正在获取小区信息，请稍候......");
	myPacket.data.add("offerId",document.all.main_product.value);
	core.ajax.sendPacketHtml(myPacket,doMsg);
	myPacket=null;
 }
 function doMsg(data){
 	$("#village").empty().append(data);
 	setVillage();
 }
 function setVillage(){
 	var len = $("#village option").length;
 	if(len == 1){
 	  $("#village").empty().append("<option value='' >无小区属性</option>");
 	}
 }
 function checkShow(flag){
    if(flag == "0"){
    	$("#villageTr").hide();
    }else{
    	$("#villageTr").show();
    }
 }
function qryMode()
{
	var myPacket = new AJAXPacket("qryMode.jsp","正在获取资费信息，请稍候......");
	myPacket.data.add("retType","getModeInfo");
	myPacket.data.add("fam_prod_id",(document.all.fam_prod_id.value).trim());
	myPacket.data.add("regionCode","<%=regionCode%>");
	myPacket.data.add("phone_no","<%=main_card%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function setOpNote(){
	if(document.all.opNote.value=="")
	{
	  document.all.opNote.value = "家庭产品管理--<%=op_note%> 家长号码:"+document.all.main_card.value;
	}
	return true;
}

  /***其他函数中要用到的过滤函数**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
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
            <td colspan="3">申请</td>
            <input name="op_type" type="hidden" class="InputGrey" id="op_type" value="<%=openType%>" >
          </tr>
          <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
            <td class="blue">业务类型</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
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
		</table>
		</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">业务明细</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY>
		  <tr>
			<tr>
		      <th align=center>家庭代码</th>
			  <th align=center>家庭身份</th>
			  <th align=center>手机号码</th>
			  <th align=center>开始时间</th>
			  <th align=center>操作工号</th>
			  <th align=center>操作流水</th>
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
			  <TD align=center class="<%=tdClass%>"><%=familyCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=newRateCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=otherCodeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=cardTypeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=endTimeArr[j][0]%></TD>
			</tr>				
			<%
			 }
			%>
		</table>
	</div>
<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">当前家庭产品信息</div>
	</div>
	    <TABLE  cellSpacing="0">
          <TBODY>
          <tr>
			<tr align="middle" >
		      <th align=center>家庭产品代码</th>
			  <th align=center>产品明细</th>
			  <th align=center>产品类型</th>
			</tr>
				<%
				 for(int i=0;i<FamilyProdArr.length;i++){
				 	String TdClass = (i%2==0)?"Grey":"";
				 	if(ParentProdArr[i][0].equals("0"))
				 	{
				 		prod_name="家庭主产品";
				 	}
					else if(ParentProdArr[i][0].equals(""))
					{
						prod_name="";
					}
					else
					{
						prod_name="附加产品";
					}
				%>
			<tr>
				<TD align=center class="<%=TdClass%>"><%=FamilyProdArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=FamilyNoteArr[i][0]%></TD>
			   	<TD align=center class="<%=TdClass%>"><%=prod_name%></TD>
			</tr>
			<%}%>
		</tr>
		</table>
	 </div>
<div id="Operation_Table">
	<div class="title">
	<div id="title_zi">申请家庭产品信息</div>
	</div>
		<TABLE cellSpacing="0">
          <TBODY>
          <tr>
          	<td class="blue">
				家庭产品类型
          	</td>
          	<td class="blue" colspan="3">
				<input type="radio" name="radios" value= "0" onclick='checkShow("0")' /> 普通畅聊家庭
				<input type="radio" name="radios" value= "1" onclick='checkShow("1")' /> 大庆特殊畅聊家庭
          	</td>
          </tr>
          <tr>
			<td class="blue">
				家庭产品代码
			</td>
            <td>
				<input name="fam_prod_id" type="text" class="InputGrey" id="fam_prod_id" maxlength=8 >
				<input class="b_text" type="button" name="query_prodcode" onclick="queryProdCode()" value="查询" >
			</td>
			<td class="blue">产品明细</td>
			<td>
				<input name="fam_prod_note" type="text" class="InputGrey" id="fam_prod_note" maxlength=255 size="60" v_must=1 v_minlength=1 v_maxlength=30 >
        		<input name="parent_prod_id" type="hidden" class="InputGrey" id="parent_prod_id" >
        		<input name="main_product" type="hidden" class="InputGrey" id="main_product" >
        	</td>
        	<tr style="display:none" id="villageTr">
        		<td class="blue" >小区</td>
        	   <td colspan="3">
        	      <select name="village" id="village">
        	  </select>	
        	   </td>	
        	</tr>
        </tr>
        <tr></tr>
        <tr id="friendno" style="display:none">
        	<td class="blue">
              <div align="left">亲情号码</div>
            </td>
        	<td colspan="3">
        		<input name="friend_no" type="text" class="button" maxlength=12 size="12" v_must=1 v_minlength=1 v_maxlength=12 >
        	</td>
		</tr>
		  <tr>
		  	 <tr></tr>
		  	 <tr></tr>
		  	 <tr></tr>
            <td id="footer" colspan="4"> <div align="center">
            	 &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="printfrmCfm(this)" disabled >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;

				</div>
			</td>
          </tr>
       </table>
 <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--客户地址-->
 <input name="cardId_no" type="hidden" id="cardId_no" value="<%=cardId_no%>"> <!--证件号码-->
  <input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
  <input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
   <input type="hidden" name="print_note" value="<%=print_note%>"><!--打印工单广告-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
  <input type="hidden" name="phoneNo" value="<%=main_card%>">
  <input type="hidden" name="op_code" value="<%=opCode%>">
  <input type="hidden" name="main_prod" >
  <input type="hidden" name="main_prod_name" >
  <input type="hidden" name="other_prod" >
  <input type="hidden" name="other_prod_name" >
  <input type="hidden" name="main_prod_note" >
  <input type="hidden" name="other_prod_note" >
  <input type="hidden" name="parent_prod">
  <input name="opNote" type="hidden" id="opNote" value="" onFocus="setOpNote();" >
  <input type="hidden" name="return_page" value="/npage/bill/f7333_login.jsp?activePhone=<%=main_card%>&opName=<%=opName%>&opCode=<%=opCode%>">
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



