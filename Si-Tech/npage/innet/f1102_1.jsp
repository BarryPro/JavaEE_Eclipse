<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
开发商: si-tech
模块:账户开户
 update zhaohaitao at 2008.12.23
********************/
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="/npage/public/hwObject.jsp" %> 

<%        
    Logger logger = Logger.getLogger("f1102_1.jsp");
	ArrayList retArray = new ArrayList();
	String printAccept = ""; 
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String belongCode = Department.substring(0,7);
    String rowNum = "1000";
    String sys_Date = "";
	
%>


<HEAD><TITLE>帐户开户</TITLE>
</HEAD>

<SCRIPT type=text/javascript>

onload=function()
{
 		 
    document.all.idIccid.focus();		
	if(typeof(frm1102.accountId)!="undefined") 
	{	if(frm1102.accountId.value != "")            ////恢复到提交前的获得帐户ID按钮显示状态
		{	frm1102.accountIdQuery.disabled = true; }
	}		
	
}
//---------1------RPC处理函数------------------
function doProcess(packet)
{	
    //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("调用"+retType+"服务时失败！");
       return false;
	}
  	if(retType == "AccountId")
	{
        var retnewId = packet.data.findValueByName("retnewId");
    	if(retCode=="000000")
    	{
       		//document.all.accountName.focus();			 		
    	    document.frm1102.accountId.value = retnewId;
	        document.frm1102.accountIdQuery.disabled = true; 		    	 
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}	
	}
    //-----------------------------------------
    if(retType == "checkPwd")
    {
        //进行密码校验
        var retResult = packet.data.findValueByName("retResult");
		frm1102.checkPwd_Flag.value = retResult; 
	    if(frm1102.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	    	frm1102.custPwd.value = "";
	    	frm1102.custPwd.focus();
	    	frm1102.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }		
		else
		{
 		   rdShowMessageDialog("客户密码校验成功！",2);
 		   frm1102.newPwd.value=frm1102.custPwd.value;
   		   frm1102.cfmPwd.value=frm1102.custPwd.value;
		   document.all.accountIdQuery.disabled=false;	      
		}

     } 	
	//------------------------------------
	if(retType == "getInfo_withID")
	{
	    clear_CustInfo();
	    if(retCode == "000000")
	    {
	       var retInfo = packet.data.findValueByName("retInfo");
	       if(retInfo != "")
           {
                for(i=0;i<7;i++)
               {   	   
        	        var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr
                }
	        }
	    }	        
	    else
	    {
	        retMessage = retMessage + "[errorCode2:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
	    }
	}
	if(retType=="chkX")
	{
        var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000")
        {
         // document.all.print.disabled=false;
		}
        else
        {
             retMessage = "错误" + retCode + "："+retMessage;			 
             rdShowMessageDialog(retMessage,0);
			 document.all.print.disabled=true;
			 document.all(retObj).focus();
			 return false;
        }
	}
}

//--------------------------------------------
//清空上级客户信息
function clear_CustInfo()
{
        for(i=0;i<6;i++)
        {          
                var obj = "in" + i;
                document.all(obj).value = "";
        }
}
//-----------------------------------------------------
function choiceSelWay()
{	//选择客户信息的查询方式
	
	if(frm1102.custId.value != "")
	{	//按客户ID进行查询
		getInfo_withId();	
		return true;
	}
	 document.all.accountIdQuery2.disabled=false;
	if(frm1102.idIccid.value != "")
	{	
		getInfo_IccId();
		return true;
	}
	if(frm1102.custName.value != "")
	{	
		getInfo_withName();
		return true;
	}
	
	rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！",0);
	 
}
//-----------------------------------------------------
function getInfo_withId()
{
    //根据客户ID得到相关信息
    
    if(document.frm1102.custId.value == "")
    {
        rdShowMessageDialog("请输入客户ID！",0);
        return false;
    }
    if(forInt(frm1102.custId) == false)
    {	
    	frm1102.custId.value = "";
    	return false;	
    }    
    
    var getIdPacket = new AJAXPacket("fpsb_rpc.jsp","正在获得客户信息，请稍候......");
	getIdPacket.data.add("retType","getInfo_withID");
	getIdPacket.data.add("fieldNum","7");
	getIdPacket.data.add("sqlStr",document.frm1102.custId.value);
    
	core.ajax.sendPacket(getIdPacket);
	getIdPacket=null;  
	
} 

//-----------------------------------------------------
/*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
*/
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   //公共查询

    var path = "../../npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
     if(typeof(retInfo)=="undefined")    
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
}
//-------------------------------------------------
function getInfo_withName()
{ 
  	////根据客户名称得到相关信息
    
  	
  	if(document.frm1102.custName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！",0);
        return false;
    }
    
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "CUST_NAME="+document.frm1102.custName.value;
    var selType = "S";              //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);     	       	   
}
//-----------------------------------------------------
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    //var path = "../../page/public/fPubSimpSel.jsp";   //密码显示
    var path = "psbgetCustInfo3.jsp";   //密码为* 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
   
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
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
		if(obj=="in4")
		  document.all.accountName.value=valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");        
    }
    
	rpc_chkX("idType","idIccid","A");
}
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }
	
  if((obj_no.value).trim().len()>0)
  {
    if((obj_no.value).trim().len()<5)
	{
      rdShowMessageDialog("证件号码长度有误（至少5位）！");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="身份证")
	  {
        if(checkElement(obj_no)==false) return false;
	  }
	}
  }
  else 
	return;
 
  var myPacket = new AJAXPacket("../../npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
  myPacket.data.add("retType","chkX");
  myPacket.data.add("retObj",x_no);
  myPacket.data.add("x_idType",getX_idno(idname));
  myPacket.data.add("x_idNo",obj_no.value);
  myPacket.data.add("x_chkKind",chk_kind);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
  
}
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="身份证") return "0";
  else if(xx=="军官证") return "1";
  else if(xx=="驾驶证") return "2";
  else if(xx=="警官证") return "4";
  else if(xx=="学生证") return "5";
  else if(xx=="单位") return "6";
  else if(xx=="校园") return "7";
  else if(xx=="营业执照") return "8";
  else return "0";
}
//-------------------------------------------------
function getInfo_IccId()
{ 
  	//根据客户证件号码得到相关信息
  	if((document.frm1102.idIccid.value).trim().len() == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！",0);
        return false;
    }
	else if((document.frm1102.idIccid.value).trim().len() < 5)
	{
        rdShowMessageDialog("证件号码长度有误（最少五位）！",0);
        return false;
	}
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "ID_ICCID="+(document.frm1102.idIccid.value).trim(); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);       	       	   
}

//----------------------------------------------------------
function printCommit()
{   
	//if(encrypt(frm1102.custPwd.value) != frm1102.in1.value)
	/* if(frm1102.custPwd.value == "")
	{
		rdShowMessageDialog("请输入客户密码！",0);
		frm1102.custPwd.focus();
		return false;		
	} */
	getAfterPrompt();
	if((frm1102.payCode.value).indexOf("托收") > 0)
	{
	    var jfbancode = frm1102.rpt_type.value;
    	frm1102.bankCode.value =jfbancode;
    	var jfbancode1 = frm1102.rpt_type1.value;
    	frm1102.postCode.value =jfbancode1;
		if((frm1102.accountNo.value == "")||(frm1102.bankCode.value == "")||(frm1102.postCode.value == ""))
		{
			rdShowMessageDialog("托收相关的帐号、银行信息不能为空！",0);
			return false;
		}		
	}
	//
	if(check(frm1102))
	{
	    if((document.all.newPwd.value).trim().len()>0)
		{
		  if(document.all.newPwd.value.length!=6)
		  {
		    rdShowMessageDialog("帐户密码长度有误！");
		    document.all.custPwd.focus();
		    return false;
		  }
          if(checkPwd(document.frm1102.newPwd,document.frm1102.cfmPwd)==false)
		  return false;
		}

    	sysNote = "帐户开户:" + "客户ID[" + document.frm1102.custId.value + "]帐户ID[" +
    	         document.frm1102.accountId.value + "]" + "操作员[<%=workName%>]"+"对客户["+(document.all.custName.value).trim()+"]进行帐户开户业务。";
    	         //":帐号[" + document.frm1102.accountNo.value + "]"; 
    	document.frm1102.sysNote.value = sysNote;
		
    	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");    	    
    }    
}
//---------------------------------------------------
function getId()
{
    //得到帐户ID
    var getAccountId_Packet = new AJAXPacket("f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;
	
	
	document.all.print.disabled=false;	
	
}
//----------------------------------
function checkPwd(obj1,obj2)
{
	//密码一致性校验
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1 != pwd2)
	{
		var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
}
//-----------------------------------
function change_custPwd()
{   //验证密码（密码）
    check_HidPwd(frm1102.custPwd.value,"show",(frm1102.in1.value).trim(),"hid");
   	
}
//------------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:密码
  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
  	
	}*/

    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2);
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;		
}
//-------------------------------------
function payWayChange()
{
    var payWay = document.frm1102.payCode.value;
    var chPos = payWay.indexOf("托收");
    var obj = "tbBank" + 0;
    if(chPos > 0)
    {
        document.all(obj).style.display = "";
    }
    else
    {
        document.all(obj).style.display = "none";
        frm1102.bankCode.value = "";
        frm1102.postCode.value = "";
    }
}

function getBankCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "银行代码查询";
    var fieldName = "银行代码|银行名称|";
    var sqlStr = "select BANK_CODE,BANK_NAME from sBankCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'" +
                " and DISTRICT_CODE ='" + document.frm1102.unitCode.value.substring(2,4) + "'";
    if(document.frm1102.bankName.value != "")
    {
        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.bankName.value + "%'";
    }
    //sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "bankCode|bankName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);        	       	   
}

function getPostCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "局方银行代码查询";
    var fieldName = "银行代码|银行名称|";
    var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'";
    if(document.frm1102.postName.value != "")
    {
        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.postName.value + "%'";
    }
   // sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
    sqlStr = sqlStr + "  order by POST_BANK_CODE " ;
	var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "postCode|postName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);   	       	   
}
 
function jspReset()
{
        var obj = null;
        var t = null;
    	var i;   	
        for (i=0;i<document.frm1102.length;i++)
        {    
    		obj = document.frm1102.elements[i];		 		 		 
    		packUp(obj); 
    	    obj.disabled = false;
         }        
        document.frm1102.commit.disabled = "none"; 
}
//---------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {	
<%
        //取得打印流水
        try
        {
                //String sqlStr ="select sMaxSysAccept.nextval as accept from dual";
                //retArray = callView.view_spubqry32("1",sqlStr);
%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
                printAccept = seq;
                //System.out.println("sysAccept======"+seq);
        }catch(Exception e){
                out.println("rdShowMessageDialog('取电子免填单打印流水失败！',0);");
                
        }              
%>          
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		
		cust_info+="客户姓名："+frm1102.custName.value+"|";
		cust_info+="客户地址："+frm1102.custAddr.value+"|";
		cust_info+="证件号码："+frm1102.idIccid.value+"|";
							
		opr_info+="帐户ID："+frm1102.accountId.value+"|";
		opr_info+="帐户名称："+frm1102.accountName.value+"|";
		opr_info+="付款方式："+frm1102.payCode.value+"|";
		opr_info+="打印流水："+"<%=printAccept%>"+"|";
		
		note_info1+="备注："+document.all.sysNote.value+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

	}  
    if(printType == "Bill")
    {	//打印发票
	}
	return retInfo;	
}
//-----------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=200;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType = "print";                   					  // 打印类型：print 打印 subprint 合并打印 printstore 打印存储
   var billType="1";                                          //票价类型：1电子免填单、2发票、3收据
   var sysAccept="<%=printAccept%>";                          //流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="<%=opCode%>";                                  //操作代码
   var phoneNo="";                                            //客户电话

var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
	+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		




   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm    +"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   path = path+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;

   var ret=window.showModalDialog(path,printStr,prop);
   
    //if(typeof(ret)!="undefined")
   {
       //if((ret=="confirm")&&(submitCfm == "Yes"))
       {
	       if(rdShowConfirmDialog("确认要提交帐户开户信息吗？")==1)
	       {
		       frm1102.action="f1102_2.jsp";
		       frm1102.submit();
		   }
		}		        
   }
}

function jspCommit()
{
 		document.frm1102.commit.disabled = "none";
		with(document.frm1102)
		{
				action="f1102_2.jsp"
				submit();
		}		
}
</SCRIPT>
<!--**************************************************************************************-->
 
<body>
<FORM method=post name="frm1102" action="f1102_2.jsp" onKeyUp="chgFocus(frm1102)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
    
              <TABLE cellspacing="0">
                <TBODY> 
                <TR> 
                  <TD class="blue"> 
                    <div align="left">客户证件号码</div>
                  </TD>
                  <TD> 
                    <input id='in2' name=idIccid v_must=1 v_type="string" onKeyup="if(event.keyCode==13)getInfo_IccId();" index="2">
                    <font color="orange">*</font> 
                    <input name=custIdQuery type=button onClick="choiceSelWay();" class="b_text" style="cursor:hand" id="custIdQuery" value=客户查询>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">客户密码</div>
                  </TD>
                  <TD> 
				    <jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"  />
	                <jsp:param name="width2" value="34%"  />
	                <jsp:param name="pname" value="custPwd"  />
	                <jsp:param name="pwd" value="12345"  />
 	                </jsp:include>
                    <input name=accountIdQuery2 type=button onClick="change_custPwd();" class="b_text" value="校验" disabled >
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">客户名称</div>
                  </TD>
                  <TD> <font color="orange"> 
                    <input id='in4' name=custName onKeyup="if(event.keyCode==13)getInfo_withName();">
                    *</font> </TD>
                  <TD class="blue"> 
                    <div align="left">客户证件类型</div>
                  </TD>
                  <TD> 
                    <input id='in3' class="InputGrey" name=idType v_type="string" v_must="1" readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">客户ID</div>
                  </TD>
                  <TD> <font color="orange"> 
                    <input id='in0' name=custId v_type=int v_must=1 onKeyup="if(event.keyCode==13)getInfo_withId();">
                    *</font> </TD>
                  <TD class="blue"> 
                    <div align="left">客户地址</div>
                  </TD>
                  <TD> 
                    <input id='in5' class="InputGrey" name=custAddr readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">帐户ID</div>
                  </TD>
                  <TD> 
                    <input class="InputGrey" name=accountId v_must=1 v_type="0_9" readonly>
                    <font color="orange">*</font> 
                    <input name=accountIdQuery type=button onmouseup="getId()" onkeyup="if(event.keyCode==13)getId()" class="b_text" value=获得 index="4" disabled >
                    <br>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">帐户名称</div>
                  </TD>
                  <TD> 
                    <input name=accountName v_must=1 v_maxlength=60 v_type="string" index="5">
                    <font color="orange">*</font> </TD>
                </TR>
				 <TR>      
			
				   <jsp:include page="/npage/common/pwd_2.jsp">
			 
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="newPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 
				   </jsp:include>
			    </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">帐户类型</div>
                  </TD>
                  <TD> 
                    <select align="left" name=accountType width=50  index="8">
                      <%
    //得到输入参数帐户类型
 	try
 	{
      		String sqlStr ="select trim(ACCOUNT_TYPE), TYPE_NAME from sAccountType where account_type=any('0','1','A') order by ACCOUNT_TYPE"; 
      		//retArray = callView.view_spubqry32("2",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
<%
      		int recordNum = result2.length;
      		System.out.println("recordNum="+recordNum);
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result2[i][0] + "'>" + result2[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}          
%>
                    </select>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">付款方式</div>
                  </TD>
                  <TD> 
                    <select align="left" name=payCode onchange="payWayChange()" width=50 index="9">
                      <%
    //得到输入参数帐户类型
 	try
 	{
      		//String sqlStr ="select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE= '" + regionCode.substring(0,2) +"' order by PAY_CODE";
      		String[] inParam = new String[2];
      		inParam[0] = "select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE=:regCode order by PAY_CODE";
      		inParam[1] = "regCode="+regionCode.substring(0,2);
      		//retArray = callView.view_spubqry32("2",sqlStr);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
			<wtc:param value="<%=inParam[0]%>"/>	
			<wtc:param value="<%=inParam[1]%>"/>
			</wtc:service>	
			<wtc:array id="result2"  scope="end"/>
<%
      		int recordNum = result2.length;
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result2[i][0] + "'>" + result2[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}          
%>
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>  
                   
            
              <TABLE id=tbBank0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR> 
                  <TD class="blue"> 
                    <div align="left">帐号</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=accountNo index="10">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">银行代码模糊查询</div>
                  </TD>
                  <TD> 
                    
                    <!--<input name=bankName size=13 class="button" onkeyup="if(event.keyCode==13)getBankCode();" readonly index="11">
                    <input name=bankCodeQuery type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询 index="12">
										-->
										<input type="text" id="searchTextrpt" name="searchTextrpt"  value="请输入查询条件"  size="40" style="padding-top:3px;" onFocus="frm1102.searchTextrpt.value='';clearResults();"  onpropertychange="blurSearchFunc('rpt_type','searchTextrpt','->')" />
										<input type="hidden" name=bankCode size=5 class="button" maxlength="12" readonly >
                  </TD>
                  <TD class="blue"> 
                    <div align="left">局方银行代码模糊查询</div>
                  </TD>
                  <TD> 
                    <!--
                    <input name=postName size=13 class="button" onkeyup="if(event.keyCode==13)getPostCode();" index="13">
                    <input name=postCodeQuery type=button class="b_text" id="postCodeQuery" style="cursor:hand" onClick="getPostCode()" value=查询 index="14">
                    -->
                    <input type="text" id="searchTextrpt1" name="searchTextrpt1"  value="请输入查询条件"  size="40" style="padding-top:3px;" onFocus="frm1102.searchTextrpt1.value='';clearResults();"  onpropertychange="blurSearchFunc('rpt_type1','searchTextrpt1','->')" />
                    <input type="hidden" name=postCode size=5 class="button" maxlength="12" readonly>
                  </TD>
                </TR>
                <tr>
                		<td class="blue">银行列表</td>
								<td>
									<select name=rpt_type  style="width:250px;">
										<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select BANK_CODE,BANK_CODE||'->'||BANK_NAME from sBankCode where REGION_CODE = '<%=Department.substring(0,2)%>' and DISTRICT_CODE ='<%=Department.substring(2,4)%>'</wtc:sql>
										</wtc:qoption>
									</select>
								</td>
             
                		<td class="blue">局方银行列表</td>
								<td>
									<select name=rpt_type1  style="width:250px;">
										<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select POST_BANK_CODE,POST_BANK_CODE||'->'||BANK_NAME from sPostCode where REGION_CODE = '<%=Department.substring(0,2)%>' order by POST_BANK_CODE</wtc:sql>
										</wtc:qoption>
									</select>
								</td>
                </tr>
                </TBODY> 
              </TABLE>  

              <TABLE cellSpacing="0">
                <TBODY> 
                <TR > 
                  <TD class="blue"> 
                    <div align="left">开始日期</div>
                  </TD>
                  <TD> 
                     <input class="InputGrey" name=beginDate v_type="date" v_must=1 value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" readonly>
                     <input class="InputGrey" name=endDate date v_name="结束日期" v_must=1 maxlength="20" value="20501231" readonly style="display:none">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                              
              <TABLE cellSpacing="0">
                <tr style="display:none"> 
                  <td class="blue"> 
                    <div align="left">系统备注</div>
                  </td>
                  <td> 
                    <input class="InputGrey" name=sysNote readonly>
                  </td>
                </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
              </TABLE>     

                         
        <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
                    <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=确认&打印 index="16" disabled>
			        <input class="b_foot" name=reset1   type=button onClick="frm1102.reset();" value=清除 index="17">
			        <input class="b_foot" name=back   onclick="removeCurrentTab()" type=button value=关闭 index="18">
			  </TD>
            </TR>
          </TBODY>
        </TABLE>

 
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">  <!--客户加密后的密码-->
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>
  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
  <input type="hidden" name="workName" value=<%=workName%> >
  <input type="hidden" name="opCode" value="<%=opCode%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
   <jsp:include page="/npage/common/pwd_comm.jsp"/>
   	<%@ include file="/npage/public/pubSearchText.jsp" %>
   <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
