<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * 功能: 个人彩铃产品变更6712
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期2008-01-08      修改人leimd      修改目的
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>

<%
    String opCode="6712";
	String opName="个人彩铃产品变更";
	String phone_no = (String)request.getParameter("activePhone");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String power_right=(String)session.getAttribute("powerRight");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");  
    String sInOpNote  ="号码信息初始化";
    int    nextFlag=1;
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%	  
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phone_no);
	System.out.println("xxxxx================="+contactInfo);
	String password = contactInfo.getPasswdVal(2);  
	
	String sOutCustId         ="";             //客户ID_NO          
	String sOutCustName       ="";             //客户姓名           
	String sOutSmCode         ="";             //服务品牌代码       
	String sOutSmName         ="";             //服务品牌名称       
	String sOutProductCode    ="";             //主产品代码         
	String sOutProductName    ="";             //主产品名称         
	String sOutPrePay         ="";             //可用预存           
	String sOutRunCode        ="";             //运行状态代码       
	String sOutRunName        ="";             //运行状态名称       
	String sOutUsingCRProdCode="";             //已订购彩铃产品     
	String sOutUsingCRProdName="";             //已订购彩铃产品名称 
	String sOutCRColorType    ="";             //彩铃类型           
	String sOutCRColorTypeName="";             //彩铃类型名称       
	String sOutCRRunCode      ="";             //彩铃运行状态代码   
	String sOutCRRunName      ="";             //彩铃运行状态名称   
	String sOutCRBellBeginTime="";             //彩铃开通时间       
	String sOutCRBellEndTime  ="";             //彩铃结束时间 
	String sOutCustAddress ="";     //用户地址
	String sOutIdIccid     ="";     //证件号码      
	
	String action=request.getParameter("action");     
	
	if (action!=null&&action.equals("select")){
		phone_no = request.getParameter("phone_no");
		System.out.println("phone_nophone_nophone_nophone_nophone_nophone_nophone_no"+phone_no);
		String Pwd1 = Encrypt.encrypt(password);     
//		SPubCallSvrImpl callView = new SPubCallSvrImpl();
		String paramsIn[] = new String[6];
		paramsIn[0]=workno;                                 //操作工号         
		paramsIn[1]=nopass;                                 //操作工号密码     
		paramsIn[2]=opCode;                                 //操作代码         
		paramsIn[3]=sInOpNote;                              //操作描述         
		paramsIn[4]=phone_no;                               //用户手机号码     
		paramsIn[5]=Pwd1;                                   //用户密码         
		
//			ArrayList acceptList = new ArrayList();
//			acceptList = callView.callFXService("s6714Init", paramsIn, "19");
//			callView.printRetValue();
%>
	<wtc:service name="s6714Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%			
	String errCode = retCode;
	String errMsg = retMsg;     
	
	if(!errCode.equals("000000"))
	{
		%>        
	    <script language='jscript'>
	       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	       history.go(-1);
	  </script> 
	     
		<%  
	}					
	if(errCode.equals("000000")&&result.length>0)
	{
		nextFlag = 2;
/*						
		String result2  [][]	= (String[][])acceptList.get(0);
		String result3  [][]  = (String[][])acceptList.get(1);
		String result4  [][]	= (String[][])acceptList.get(2);
		String result5  [][]	= (String[][])acceptList.get(3);
		String result6  [][]	= (String[][])acceptList.get(4);
		String result7  [][]	= (String[][])acceptList.get(5);
		String result8  [][]	= (String[][])acceptList.get(6);
		String result9  [][]	= (String[][])acceptList.get(7);
		String result10 [][]	= (String[][])acceptList.get(8);
		String result11 [][]  = (String[][])acceptList.get(9);
		String result12 [][]	= (String[][])acceptList.get(10);
		String result13  [][] = (String[][])acceptList.get(11);
		String result14  [][]	= (String[][])acceptList.get(12);
		String result15  [][]	= (String[][])acceptList.get(13);
		String result16  [][]	= (String[][])acceptList.get(14);
		String result17  [][]	= (String[][])acceptList.get(15);
		String result18  [][]	= (String[][])acceptList.get(16);
		String result19 [][]  = (String[][])acceptList.get(17);
		String result20 [][]	= (String[][])acceptList.get(18);
*/
		sOutCustId          =result  [0][0];           
		sOutCustName        =result  [0][1];           
		sOutSmCode          =result  [0][2];           
		sOutSmName          =result  [0][3];           
		sOutProductCode     =result  [0][4];           
		sOutProductName     =result  [0][5];           
		sOutPrePay          =result  [0][6].trim();           
		sOutRunCode         =result  [0][7];           
		sOutRunName         =result [0][8];           
		sOutUsingCRProdCode =result [0][9];           
		sOutUsingCRProdName =result [0][10]; 
		sOutCRColorType     =result [0][11]; 
		sOutCRColorTypeName =result [0][12]; 
		sOutCRRunCode       =result [0][13]; 
		sOutCRRunName       =result [0][14]; 
		sOutCRBellBeginTime =result [0][15]; 
		sOutCRBellEndTime   =result [0][16]; 			
		sOutCustAddress  	=result [0][17];            // 用户地址
		sOutIdIccid      	=result [0][18];            // 证件号码	          				       
}
	   	 if(!sOutCRColorType.equals("00"))
		 {		   
			%>        
		    <script language='jscript'>
		       rdShowMessageDialog("只允许包月用户做变更" ,0);
		       history.go(-1);
	      </script> 	         
			<%  			
		 } 
	 }    
%>      
        
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>黑龙江BOSS-个人彩铃产品变更</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>

<script language="JavaScript">

onload=function()
{
	
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	//变更产品
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  }  
}
		
//确认提交
function refain()
{ 
	if(document.form.mebProdCode.value=="" )
	{   
		rdShowMessageDialog("请选择产品代码！");
		document.form.phoneNo.focus();
		return false;
	}
	
 document.all.sysNote.value = "手机["+<%=phone_no%>+"]变更彩铃业务,彩铃产品["+document.all.mebProdCode.value+"]";
	if((document.all.opNote.value).trim().length==0)
	{
         document.all.opNote.value="<%=workno%>[<%=workname%>]"+"对手机["+<%=phone_no%>+"]进行彩铃业务变更";
	} 
	    
	document.form.action="f6712_2.jsp";
	document.form.submit();
	return true;
  
}
//输入手机号和密码，查询具体信息
function doQuery()
	{		
		if(!check(form)) return false; 
		document.form.action = "f6712_1.jsp?action=select&activePhone=<%=phone_no%>";
		document.form.submit(); 
	}
	
//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //首先判断是否已经选择了服务品牌
    if(document.form.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.form.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&cust_id=" + document.all.cust_id.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|";
  if(retInfo ==undefined)      
    {   return false;   }    
  document.form.product_code.value = retInfo ;
}

function changeOthers(){
	var mebMonthFlag=document.form.mebMonthFlag.value;

	if(mebMonthFlag=="1"){
		document.form.matureProdCode.value="";
		document.form.matureFlag.value="";
		tbs2.style.display="none";
	}
	else
	{
		document.form.matureFlag.value="N";								
		tbs2.style.display="";
	}	
}

//调用公共界面，进行产品选择
function getmebProdCodeQuery()
{
    var pageTitle = "彩铃产品选择";
    var fieldName = "产品代码|产品名称|";
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "mebProdCode|mebProdName|";

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    //getMidPrompt('10442',codeChg(document.all.mebProdCode.value),'ipTd');

}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
	var mebMonthFlag = document.form.mebMonthFlag.value;
	var mode_type="";
	var month_num=1;
	if(mebMonthFlag=="1")
	{
		mode_type="CR01";
		month_num=1;
	}else if(mebMonthFlag=="2"){
		mode_type= "CR02";
		month_num=12;
	}
	else if(mebMonthFlag=="3"){
		mode_type= "CR02";
		month_num=6;
	}
	else if(mebMonthFlag=="4"){
		mode_type= "CR02";
		month_num=3;
	}
	
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubmebProdCode_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	path = path + "&op_code=" + document.all.opCode.value;
	path = path + "&mode_type=" + mode_type; 
	path = path + "&month_num=" + month_num;
	path = path + "&UsingCRProdCode=" + document.all.UsingCRProdCode.value;
	path = path + "&power_right=" +document.all.power_right.value;
	path = path + "&regionCode=<%=regionCode%>"
	path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "mebProdCode|mebProdName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
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
	document.form.mebMonthFlag1.value=document.form.mebMonthFlag.value;
	document.form.mebMonthFlag.disabled=true;
	getMidPrompt('10442',codeChg(document.all.mebProdCode.value),'ipTd');
}

//包年转产品选择
function getmatureProdCodeQuery()
 {  
 	  var pageTitle = "包年到期转包月产品选择";
    var fieldName = "产品属性代码|产品属性|";    
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "matureProdCode|matureProdName|";
	if(PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
 }
 
function PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
    var path = "<%=request.getContextPath()%>/npage/s6712/fpubmatureProdCode_sel.jsp"; 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&op_code=" + document.all.opCode.value;
	  path = path + "&UsingCRProdCode=" + document.all.UsingCRProdCode.value;
	  path = path + "&power_right=" +document.all.power_right.value;
	  path = path + "&regionCode=<%=regionCode%>"
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	
    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;	
}
function getmatureProd(retInfo)
{ 
	var retToField = "matureProdCode|matureName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
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
}
//根据产品类型进行产品变更
function tochange()
{  
		var mebMonthFlag = document.form.mebMonthFlag.value;
		var mode_type="";
		var month_num=1;
		if(mebMonthFlag=="1")
		{
			mode_type="CR01";
			month_num=1;
		}else if(mebMonthFlag=="2"){
			mode_type= "CR02";
			month_num=12;
		}
		else if(mebMonthFlag=="3"){
			mode_type= "CR02";
			month_num=6;
		}
		else if(mebMonthFlag=="4"){
			mode_type= "CR02";
			month_num=3;
		}
		//var sqlStr = "select mode_code,mode_code||'->'||mode_name from sbillmodecode where  mode_code like 'CR%' and mode_type='"+mode_type+"' and start_time<sysdate  and stop_time>sysdate  and power_right<=" + "<%=power_right%>" + " and mode_status='Y' and region_code='" + "<%=regionCode%>" + "' and mode_code !='<%=sOutUsingCRProdCode%>'";	
		/**
		**var sqlStr = "select a.mode_code,a.mode_code||'->'||mode_name from sbillmodecode a,scolormode b "+
		**		" where a.mode_code like 'CR%' and a.start_time<sysdate  and a.stop_time>sysdate "+
		**		" and a.power_right<=" + "<%=power_right%>" + " and a.mode_status='Y' "+
		**		" and a.region_code='" + "<%=regionCode%>" + "' and a.mode_type='"+mode_type+"'"+
		**		" and a.region_code = b.region_code and a.MODE_CODE = b.PRODUCT_CODE"+
		**		" and a.mode_code !='<%=sOutUsingCRProdCode%>'"+
		**		" and b.mode_bind='0'"+
		**		" and b.month_num = "+month_num;
		**var myPacket = new RPCPacket("select_rpc.jsp","正在获得业务模式信息，请稍候......");
		**myPacket.data.add("retType","changProd");
		**myPacket.data.add("sqlStr",sqlStr);
		**core.rpc.sendPacket(myPacket);
		**delete(myPacket);
		**/
}

function changeMatureFlag(){
	var matureFlag=document.form.matureFlag.value;
	if(matureFlag=="Y"){
	 document.form.matureProdCode.value="";
	 document.form.matureName.value="";	 
	 document.form.matureProdCode.readonly=true;
	 document.form.matureProdCodeQuery.disabled=false;
   }else{
   document.form.matureProdCode.value=""; 
   document.form.matureName.value="";	 
   document.form.matureProdCode.readonly=false;
   document.form.matureProdCodeQuery.disabled=true;
   }	
}

function refain1() {
	getAfterPrompt();
	showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
		if (rdShowConfirmDialog("是否提交确认操作？")==1){
			refain();
		}
}
function showPrtDlg(printType,DlgMessage,submitCfm) {  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=document.all.mebProdCode.value+"~";           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="6712" ;                   			 		//操作代码
	var phoneNo="<%=phone_no%>";                  	 		//客户电话
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.form.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo(printType) { 
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	
	opr_info+='<%=workname%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="证件号码："+document.all.sOutIdIccid.value+"|";
	cust_info+="客户地址："+document.all.sOutCustAddress.value+"|";
	opr_info+="业务品牌:"+document.all.sm_name.value+"|";
	opr_info+="办理业务:"+"彩铃业务变更"+"|";
	opr_info+="操作流水:"+'<%=loginAccept%>'+"|";
	opr_info+="操作时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="变更前产品:"+document.all.UsingCRProdCode.value+"->"+document.all.UsingCRProdName.value+"|";
	opr_info+="变更后产品:"+document.all.mebProdName.value+"|";
	opr_info+="生效时间:"+"次月"+"|";

	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}	


</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">个人彩铃产品变更</div>
	</div>
 <table cellspacing="0">
    <input type="hidden" name="opCode" value="<%=opCode%>"> 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">  
    <input type="hidden" name="power_right" value="<%=power_right%>">  
    <input type="hidden" name="mebMonthFlag1" value="">  
    <input type="hidden" name="mebProdCode" value="">               		          
    <input type="hidden" name="matureProdCode" value="">          		          
	<%
	if(nextFlag==1)
	{
%>
	<TR>   
		<td class="blue">服务号码</td>                                 
		<td >                     
			<input class="InputGrey" readOnly type="text" v_type="mobphone" v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
	</TR>

	<tr>
		<td colspan="2" align="center" id="footer">
			<input class="b_foot" name=sure22 type=button value="确定" onClick="doQuery();" style="cursor:hand">
			<input class="b_foot" name=close22 type=button value="关闭" onclick="removeCurrentTab()">
		</td>
	</tr>
<%
	}
%>
    <%
     if(nextFlag==2)//查询后结果
     {
    %> 
	<tr style=display="none"> 
		<td  class="blue" width="15%"> 服务号码</td>
		<td width="35%">
			<input class="InputGrey" readOnly type="text" name="phoneNo" maxlength="11" class="button"  value="<%=phone_no%>">
		</td>
		<td class="blue" width="15%">客户ID</td>
		<td width="35%"> 
			<input type="text" name="cust_id" maxlength="6" class="InputGrey" readOnly value="<%=sOutCustId%>">
			<input type="hidden" readonly name="sOutCustAddress" class="InputGrey" value="<%=sOutCustAddress%>">
			<input type="hidden" readonly name="sOutIdIccid" class="InputGrey" value="<%=sOutIdIccid%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">客户名称</td>
		<td> 
			<input type="text" name="cust_name" class="InputGrey" readOnly value="<%=sOutCustName%>" >
		</td>
		<td class="blue">业务品牌 </td>
		<td> 
			<input type="hidden" readonly name="sm_code" class="InputGrey" value="<%=sOutSmCode%>">
			<input type="text" readonly name="sm_name" class="InputGrey" value="<%=sOutSmName%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">主产品</td>
		<td> 
			<input type="hidden" readonly name="ProductCode" maxlength="5" class="InputGrey" value="<%=sOutProductCode%>">
			<input type="text"   readonly name="ProductName" maxlength="5" class="InputGrey" value="<%=sOutProductName%>" size="30">
		</td>
		<td class="blue">运行状态</td>
		<td> 
			<input type="hidden" readonly name="RunCode" class="InputGrey" value="<%=sOutRunCode%>">
			<input type="text" readonly name="RunName" class="InputGrey" value="<%=sOutRunName%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">业务类型</td>
		<td> 
			<input type="hidden" readonly name="CRColorType" maxlength="5" class="InputGrey" value="<%=sOutCRColorType%>">
			<input type="text"   readonly name="CRColorTypeName" maxlength="5" class="InputGrey" value="<%=sOutCRColorTypeName%>">
		</td>
		<td class="blue">开户时间 </td>
		<td> 
			<input type="text" readonly  name="CRBellBeginTime" class="InputGrey" maxlength="20" value="<%=sOutCRBellBeginTime%>">
		</td>
	</tr>
	
	<tr> 
		<td class="blue">已订购彩铃产品</td>
		<td> 
			<input type="hidden" readonly name="UsingCRProdCode" maxlength="5" class="InputGrey" value="<%=sOutUsingCRProdCode%>">
			<input type="text"   readonly name="UsingCRProdName" maxlength="5" class="InputGrey" value="<%=sOutUsingCRProdName%>">
		</td>
		<td class="blue">彩铃运行状态 </td>
		<td> 
			<input type="text" readonly  name="CRRunName" class="InputGrey" maxlength="20" value="<%=sOutCRRunName%>">
		</td>
	</tr>
	
	<TR>
		<TD class="blue">业务类型</TD>
		<TD class="blue">
			<SELECT name="mebMonthFlag" class="button" id="mebMonthFlag" onclick="changeOthers()">
				<option value="2" >包年类</option>
				<option value="3" >包半年类</option>
				<option value="4" >包季类</option>
				<option value="1" selected>包月类</option>
			</SELECT>
			<font color="orange">*</font>									
		</TD>
		<TD class="blue">彩铃产品</TD>
		<TD id="ipTd">
			<input type="text" id="mebProdName"  name="mebProdName" size="20" value=""  readonly>
			<input name="mebProdCodeQuery" type="button" id="mebProdCodeQuery" class="b_text" onMouseUp="getmebProdCodeQuery(); " onKeyUp="if(event.keyCode==13)getmebProdCodeQuery();" value="选择">
			<font color="orange">*</font>
		</TD>				
	</TR>
	
   <tbody id=tbs2 style="display:none">
	   <TR span=1>
		<TD class="blue">包年到期转包月</TD>
		<TD class="blue">
			<SELECT name="matureFlag" class="button" id="change_year" onChange="changeMatureFlag()" >
				<option value="Y" >是</option>
				<option value="N" selected>否 </option>
			</SELECT>
				<input type="text" id="matureName"  name="matureName" size="30" value="" readonly>
				<input name="matureProdCodeQuery" type="button" id="matureProdCodeQuery"  class="b_text" onMouseUp="getmatureProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmatureProdCodeQuery();" value="选择" disabled> 		
				<font color="orange">*</font>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>                
	</TR>
</tbody>
        
	<tr style="display:none"> 
		<td class="blue">系统备注</td>
		<td>
			<input class="button" readonly name=sysNote value="" size=60 maxlength="60">
		</td>
	</tr>
	<tr  style="display:none"> 
		<td class="blue">备注</td>
		<td colspan="3"> 
			<input class="button" name=opNote size=60 value="" maxlength="60">
		</td>
	</tr>
                
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input class="b_foot" name=sure type="button" value=确认 onclick="refain1()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=返回 onClick="history.go(-1);">
			&nbsp;
			<input class="b_foot" name=reset type=button value=关闭 onClick="removeCurrentTab()">
		</td>
	</tr>                
	    <%
	    }//end   if(nextFlag==2)    
	   %>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

