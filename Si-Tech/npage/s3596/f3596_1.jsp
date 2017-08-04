<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>
<%
//huangrong update for 关于求职通业务支撑的函  2011-8-1
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
//获取SESSION信息
String phoneNo = (String)request.getParameter("activePhone");
System.out.println("phoneNo="+phoneNo);
String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");

String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
%>
<%  
  //获取从上页得到的信息
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
	//获取系统流水
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />
<%		
		loginAccept=req;	
	}
%>
<HTML>
<HEAD>
	<TITLE><%=opName%></TITLE>
	<META content=no-cache http-equiv=Pragma>
  <META content=no-cache http-equiv=Cache-Control>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<link href="s2002.css" rel="stylesheet" type="text/css">		
	<script type="text/javascript" src="/njs/extend/jquery/portalet/interface_pack.js"></script>
</HEAD>
<SCRIPT type=text/javascript>




//调用公共界面，进行附加套餐选择
function getInfo_Mode()
{
	if ( '0' == document.all.bizcode.value  )
	{
		rdShowMessageDialog("必须选择业务名称" , 0);
		return false;
	}
	
	var retToField = "extraOption|mode_name|";
	/* zhangyan */
	if ( document.all.opFlag.value == '05' )
	{
		retToField = "d0_new_ofrId|mode_name|";
	}
	
	else if  ( document.all.opFlag.value == '03' )
	{
		retToField = "d1_new_ofrId|mode_name|";
	}
    var pageTitle = "附加套餐选择";
    var fieldName = "产品代码|产品名称|";
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";

    
   //判断是否选择SI业务信息 
	 if(document.frm.bizcode.value == "")
   {
    rdShowMessageDialog("请选择SI业务信息！",0);
    return false;
   }
    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3596/fqrymodecode.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;

	if ( document.all.opFlag.value == '03' )
	{
		path = path + "&opCode=i044" ;
	}
	else 
	{
		path = path + "&opCode=3596" ;
	}    
      
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	  path = path + "&regionCode=<%=regionCode%>";
	  path = path + "&selType=" + selType;
	  path = path + "&bizcode=" + document.all.bizcode.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "extraOption|mode_name|";

	/* zhangyan */
	if ( document.all.opFlag.value == '05' )
	{
		retToField = "d0_new_ofrId|mode_name|";
	}
	else if  ( document.all.opFlag.value == '03' )
	{
		retToField = "d1_new_ofrId|mode_name|";
	}
	
	if(retInfo ==undefined)      
	{
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
	//document.frm.payType1.value=document.frm.payType.value;
	document.frm.modeQuery.disabled=true;
	document.frm.newModeQuery.disabled=true;
	//document.frm.confirm.disabled=false;
}



//调用公共界面，进行SI信息查询
function getInfo_Si()
{
	var pageTitle = "SI信息查询";
	var fieldName = "ＳＩ编码|业务代码|业务名称|业务接入号|接入号属性|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "5|0|1|2|3|4|";
	var retToField = "ecsiid|bizcode|bizname|servcode|baseservcodeprop|";
	var ecsiId = document.frm.ecsiId.value;
	
	if(document.frm.ecsiId.value == "")
	{
		rdShowMessageDialog("请输入ＳＩ编码进行查询！",0);
		document.frm.ecsiId.focus();
		return false;
	}

	//if(document.frm.ecsiId.value != "" && forNonNegInt(frm.ecsiId) == false)
	//{
	//	frm.ecsiId.value = "";
	//	rdShowMessageDialog("必须是数字！",0);
//	return false;
	//}

	

	PubSimpSelSi(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelSi(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s3596/fqrybizcode.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&ecsiId=" + document.all.ecsiId.value;
	
	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueSi(retInfo)
{
	var retToField = "ecsiid|bizcode|bizname|servcode|baseservcodeprop|";
	//ChgCurrStep("custQuery");
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
	  document.all(obj).readOnly=true;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
	//alert("mebMonthFlag"+document.frm.mebMonthFlag.value);
	//document.frm.mebMonthFlag1.value=document.frm.mebMonthFlag.value;
	//document.frm.ecsiIdQuery.disabled=true;	
	//document.frm.confirm.disabled=false;
	document.frm.baseservcodeprop.disabled=true;
	//tochange();
	//tomaturechange();
}


function printInfo(printType)
{
    var tmpLoc="";
	  var tmpLen="";
    var phoneNo=document.frm.phoneNo.value;
    var tmpstr=phoneNo;
    var j=phoneNo.length;
	  var w=Math.round(j/11);
	  var tmpstraft="";
	  for(i=0;i<w;i++){
      tmpLoc=tmpstr.indexOf("~");
      tmpLen=tmpstr.length;
      if(tmpLoc==-1){
      	tmpstraft=tmpstr;
      }
      else{
      	tmpstraft+=tmpstr.substring(0,tmpLoc-1)+",";
      }
	    tmpstr=tmpstr.substring(tmpLoc+1,tmpLen);
	    if(tmpLoc==-1) break;
	 	}
	 	var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
    cust_info+="手机号码："+document.frm.phoneNo.value+"|";
    cust_info+="客户姓名：" +document.frm.custName.value+"|";
    cust_info+="证件号码："+document.frm.vIdIccid.value+"|";
    cust_info+="客户地址："+document.frm.vCustAddresee.value+"|";
    opr_info="用户品牌: "+document.frm.vSmName.value+" 办理业务:<%=opName%>--"+document.all.bizcode.options[document.all.bizcode.selectedIndex].text+"业务|";
    opr_info+="操作流水: "+document.frm.printAccept.value+"|";
    opr_info+="备注: "+document.frm.systemNote.value+"|";
   
    if("<%=opCode%>"=="3596")
	  {
	  	note_info1="备注:每项业务资费为1元/月，您不能重复订购同一业务，但是可以叠加订购多个不同的业务。业务当月订购，当月取消仍收取相应费用。|";
	  }
	    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;

    
}


function showPrtdlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	　var h=210;
	　var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
    
    // //var printStr = printInfo(printType);
    
     var pType="subprint";             
	   var billType="1";     
	   var sysAccept="<%=loginAccept%>";  
	   //alert(  sysAccept);
	   var printStr = printInfo(printType);            
	   var mode_code=null;              
	   var fav_code=null;                 
	   var area_code=null;            
     var opCode="<%=opCode%>"; 
     var phoneNo=document.frm.phoneNo.value;
     
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
 
 
	 return ret;
}




function refMain()
{	
	getAfterPrompt();
	  
	  var nowDate= "<%=strDate%>";
		
		
			if(  document.frm.bizcode.value == "0" )
			{
				rdShowMessageDialog("请选择业务信息!",0);
				document.frm.ecsiId.focus();
				return false;
			}	 
			if(  document.frm.phoneNo.value == "" )
			{
				rdShowMessageDialog("手机号码不能为空!",0);
				document.frm.phoneNo.focus();
				return false;
			}
			document.frm.phoneNo1.value=document.frm.phoneNo.value;
			//alert(document.frm.phoneNo1.value);
			if(  document.frm.custName.value == "" )
			{
				rdShowMessageDialog("客户名称不能为空!",0);
				return false;
			}
			if(  document.frm.runState.value == "" )
			{
				rdShowMessageDialog("运行状态不能为空!",0);
				return false;
			}
			if(document.all.opFlag.value=="01")
			{
				 
				// if(  document.frm.explog.value == "" )
				// {
				//	rdShowMessageDialog("期望日期不能为空!",0);
				//	document.frm.explog.focus();
				//	return false;
				// }
				// if(parseInt(document.frm.explog.value)<parseInt(nowDate))
				// {
				//	rdShowMessageDialog("期望日期不能小于当前日期！");
				//	return;
				// }
			 if(document.frm.extraOption.value=="")
			 {
				rdShowMessageDialog("附加套餐不能为空!");
				return;
			 }
			 
		   }	 
			
		

	document.frm.systemNote.value = "工号[<%=loginNo%>]"+"办理"+document.all.opFlag.options[document.all.opFlag.selectedIndex].text+document.all.bizcode.options[document.all.bizcode.selectedIndex].text;
	
	//alert("www-----------");
	//打印工单并提交表单
  var ret = showPrtdlg("Detail","确实要进行电子免填单打印吗？","Yes");
  //alert("ddd");
  
  if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
          {
          	document.all.printcount.value="1";
	          frmCfm();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
          {
          	document.all.printcount.value="0";
	          frmCfm();
          }
	      }
   }
   else
   {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
       	   document.all.printcount.value="0";
	       frmCfm();
       }
    }
	
	  
	
}

// 名称:全截取函数
// 功能:把指定的文本中左边和右边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function trimAll(text)
{
        return leftTrim(rightTrim(text));//先右截取,再左截取,返回
}


// 名称:左截取函数
// 功能:把指定的文本中左边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function leftTrim(text)
{
        if(text==null || text=="") return text;//如果text无内容,返回text
        var leftIndex=0;//定义最左非空格字符的索引下标(空格字符数)
        while(text.substring(leftIndex,leftIndex+1)==" ")//直至找到最左的非空格的字符,要么进行
                leftIndex++;//最右非空格字符的索引下标后移
        return text.substring(leftIndex,text.length);//返回
}

// 名称:右截取函数
// 功能:把指定的文本中右边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function rightTrim(text)
{
        if(text==null || text=="") return text;//如果text无内容,返回text
        var rightIndex=text.length;//定义最右非空格字符的索引下标
        while(text.substring(rightIndex-1,rightIndex)==" ")//直至找到最右的非空格的字符,要么进行
                rightIndex--;//最右非空格字符的索引下标前移
        return text.substring(0,rightIndex);//返回
} 



function changeOpFlag()
{	
	/*zhangyan 关于申请新增农富宝业务包年、包半年可选资费的函*/
	document.all.d0_old_ofrId.value = "";	
	document.all.d0_old_ofrNm.value = "";
	document.all.d1_ofrId.value = "";	
	document.all.d1_ofrNm.value = "";		
	document.all.d2_old_Id.value = "";
	
	document.all.d2_old_nm.value = "";
	document.all.d2_new_id.value =  "";
	document.all.d2_new_nm.value = "";
	document.all.d2_login.value = "";
	document.all.d2_time.value = "";
	
	/*zhangyan 关于申请新增农富宝业务包年、包半年可选资费的函*/
	if(document.all.opFlag.value=="02")
	{
		//alert("ww");
	 	row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").hide();	
	}
	else if (document.all.opFlag.value=="01")
	{
		row1.style.display="";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").hide();		
	}
	else if (document.all.opFlag.value=="05")
	{
		row1.style.display="none";
	 	$("#d0").show(1000);
	 	$("#d1").hide();
	 	$("#d2").hide();		
	}	
	else if (document.all.opFlag.value=="03")
	{
		row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").show(1000);
	 	$("#d2").hide();		
	}		
	else if (document.all.opFlag.value=="04")
	{
		row1.style.display="none";
	 	$("#d0").hide();
	 	$("#d1").hide();
	 	$("#d2").show(1000);		
	}		
	
	$("#bizcode").val("0");
	
}

function QryPhoneInfo()
{
	if (!checkElement(document.all.phoneNo))
	{
		document.frm.phoneNo.focus();
		return false;
	}
	
	var checkPwd_Packet = new AJAXPacket("/npage/s3596/getPhoneInfo.jsp","正在获取用户资料，请稍候......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}


function tochange()
{  
	var bizcodeadd=document.frm.bizcode.value;
	var regionCode=document.frm.vregionCode.value;
	document.frm.extraOption.value="";
	//alert(bizcodeadd);
	
	if(bizcodeadd=="0") return false;  
	
	if(document.frm.vregionCode.value=="")
	{
			rdShowMessageDialog("请先查询用户资料",1);
			document.frm.bizcode.value="0";
			return false;
	}
	
	//alert(bizcodeadd);   
	//huangrong update for 关于求职通业务支撑的函  2011-8-1
	var sqlStr = " select a.id_no from dgrpusermsg a,dgrpusermsgadd b,dcustdoc c  , dbvipadm.sCommonCode d where a.id_no=b.id_no and b.field_code='YWDM0' "+
	               " and b.field_value='"+bizcodeadd+"' "+
		             "  and a.region_code='" + regionCode + "' and a.cust_id=c.cust_id and c.id_iccid=d.field_code4 and d.op_code = '<%=opCode%>'  and d.common_code = '1004'  ";
	//alert(sqlStr);
	var myPacket = new AJAXPacket("select_rpcNew.jsp","正在获得业务信息，请稍候......");
	myPacket.data.add("retType","selectIdNo");
	myPacket.data.add("bizcodeadd",bizcodeadd);
	myPacket.data.add("region_code",regionCode);
	myPacket.data.add("opCode","<%=opCode%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

/*zhangyan 关于申请新增农富宝业务包年、包半年可选资费的函*/
function frmCfm(){
	if ( document.all.opFlag.value == "03" /*包年续签*/
		|| document.all.opFlag.value == "04" /*冲正*/
		|| document.all.opFlag.value == "05" /*资费变更*/ )
	{
		
		var inPrs = new Array();
		var svcName = "";
		/*根据不同情况,拼入参数组*/
		if ( document.all.opFlag.value == "03"  )/*包年续签*/
		{
			if ( document.all.d1_new_ofrId.value == '' )
			{
				rdShowMessageDialog("新附加资费不能为空" , 0);
				return false;
			}
			
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "01";
			inPrs[2] = "i044";
			inPrs[3] = "<%=loginNo%>";
			inPrs[4] = "<%=loginPwd%>";
			
			inPrs[5] = document.all.phoneNo.value ;
			inPrs[6] = "";
			inPrs[7] = document.all.d1_new_ofrId.value ; 
			inPrs[8] = document.all.vidNo.value;
			inPrs[9] = "AD";
			
			inPrs[10] = "<%=regionCode%>";
			inPrs[11] = "<%=ipAddress%>";
			svcName = "s221Cfm" ;
		}
		else if ( document.all.opFlag.value == "04"  )/*冲正*/
		{	
			if ( document.all.old_acc.value == '' )
			{
				rdShowMessageDialog("申请流水不能为空" , 0);
				return false;
			}					
			if ( document.all.d2_old_Id.value == '' )
			{
				rdShowMessageDialog("变更前产品ID不能为空" , 0);
				return false;
			}							
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "01";
			inPrs[2] = "i045";
			inPrs[3] = "<%=loginNo%>";
			inPrs[4] = "<%=loginPwd%>";		
			
			inPrs[5] = document.all.phoneNo.value ;
			inPrs[6] = "" ;
			inPrs[7] = document.all.old_acc.value ;	
			inPrs[8] = "<%=ipAddress%>";
			inPrs[9] = document.all.mebId.value;
			inPrs[10] = document.all.vidNo.value;
			
			svcName = "s222Cfm";	
		}
		else if ( document.all.opFlag.value == "05"  )/*资费变更*/
		{
			svcName = "s7897Cfm";
			if ( document.all.d0_new_ofrId.value == '' )
			{
				rdShowMessageDialog("新附加资费不能为空" , 0);
				return false;
			}				
			inPrs[0] = document.all.loginAccept.value ;
			inPrs[1] = "i043" ;
			inPrs[2] = "<%=loginNo%>" ;
			inPrs[3] = "<%=loginPwd%>" ;
			inPrs[4] = "<%=orgCode%>" ;
			
			inPrs[5] = document.all.systemNote.value ;
			inPrs[6] = document.all.systemNote.value ;
			inPrs[7] = "<%=ipAddress%>";
			inPrs[8] = document.all.phoneNo.value ;
			inPrs[9] = document.all.vidNo.value;
			
			inPrs[10] = "";
			inPrs[11] = document.all.d0_new_ofrId.value;
			inPrs[12] = "0~0~0~0.00~0.00~0~0~";
			inPrs[13] = "";
			inPrs[14] = "m03";
			
			inPrs[15] = "05";
		}		

		/* zhangyan: 对于服务某位入参是数组的情况,不可用.
		 * 传入ajax页面参数:
		 * ajaxType : 请求类型
		 * svcName : 服务名,字符串
		 * inPrs : 服务入参,数组
		 * ajax页面返回
		 * oRetCode : 返回代码
		 * oRetMsg : 返回信息
		 */
		var packet = new AJAXPacket("f3596_chgCfm.jsp","正在获取用户资料，请稍候......");
		packet.data.add("ajaxType","getCfmIfo");
		packet.data.add("svcName",svcName);
		packet.data.add("inPrs",inPrs);
		core.ajax.sendPacket( packet , setCfmIfo);
		checkPwd_Packet = null;
	}
	else 
	{
		frm.action="f3596Cfm.jsp";
		frm.method="post";
		frm.submit();
		$("#confirm").attr("disabled",true);
		loading();
	}
	return true;
}

function setCfmIfo( packet )
{
	var oRetCode = packet.data.findValueByName ( "oRetCode" );
	var oRetMsg = packet.data.findValueByName ( "oRetMsg" );
	
	if (oRetCode != '000000')
	{
		rdShowMessageDialog(oRetCode+":"+oRetMsg , 0);
	}
	else
	{
		rdShowMessageDialog( oRetMsg , 2 );

	}
	
	
	window.location.replace("f3596_1.jsp?activePhone=<%=phoneNo%>&activePhone=<%=phoneNo%>"
		+"&opCode=<%=opCode%>&opName=<%=opName%>");
}


function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	//alert(retMessage);
	self.status="";
	if(retType == "QryPhoneInfo")
	{
		if(retCode == "000000")
		{
			var custName = packet.data.findValueByName("custName");
			var runState= packet.data.findValueByName("runState");
			var vregionCode=packet.data.findValueByName("vregionCode");
			var vCustAddresee=packet.data.findValueByName("vCustAddresee");
			var vIdIccid=packet.data.findValueByName("vIdIccid");
			var vSmName=packet.data.findValueByName("vSmName");
			document.frm.custName.value=custName;
			document.frm.runState.value=runState;
			document.frm.vregionCode.value=vregionCode;
			document.frm.vCustAddresee.value=vCustAddresee;
			document.frm.vIdIccid.value=vIdIccid;
			document.frm.vSmName.value=vSmName;
			if(document.frm.opFlag.value=="02")
			{
				//document.frm.confirm.disabled=false;
			}
			
			//alert(document.frm.vregionCode.value);
			
		}
		else
		{
			rdShowMessageDialog(retMessage,1);
			return false;
		}
		
		
	}
	if(retType == "selectIdNo")
	{
		var retResult=packet.data.findValueByName("retResult");
		if(retCode == "000000"&&retResult=="true")
		{
			var vidNo = packet.data.findValueByName("vidNo");
			
			document.frm.vidNo.value=vidNo;
			document.frm.modeQuery.disabled = false;
			document.frm.newModeQuery.disabled = false;
			//alert(document.frm.vidNo.value);
			
			//查包年信息
			if ( document.all.opFlag.value == '02' 
				|| document.all.opFlag.value == '03' 
				|| document.all.opFlag.value == '05' )
			{
				var myPacket = new AJAXPacket("f3596_ajax.jsp","正在获得业务信息，请稍候......");
	
				myPacket.data.add("ajaxType","getIfo");
				myPacket.data.add("logacc",document.all.loginAccept.value);
				myPacket.data.add("chnSrc","01");
				myPacket.data.add("opCode","<%=opCode%>");
				myPacket.data.add("workNo","<%=loginNo%>");
				myPacket.data.add("passwd","<%=loginPwd%>");
				
				myPacket.data.add("phoneNo","<%=phoneNo%>");
				myPacket.data.add("usrpwd","");
				myPacket.data.add("iGrpId",vidNo);
				myPacket.data.add("iOpType",document.all.opFlag.value);
				
				core.ajax.sendPacket(myPacket , setIfo);
				myPacket=null;				
			}

			
		}
		else
		{
			rdShowMessageDialog("业务资料没有配置完整，请联系业务负责人！",0);
			return false;
		}
	}
	
	
	
}

function setIfo( packet )
{
	var oRetCode = packet.data.findValueByName("oRetCode");
	var oRetMsg = packet.data.findValueByName("oRetMsg");
	if ( oRetCode!="000000" )
	{
		rdShowMessageDialog( oRetCode+":"+oRetMsg ,0 );
		return false;
	}
	else
	{	
		if ( document.all.opFlag.value=="02" )
		{
			var oYearFlag = packet.data.findValueByName("oYearFlag");
			if ( 'Y' == oYearFlag )
			{
				rdShowMessageDialog("该用户包年资费未到期，提前结束将扣除全部剩余专款作为违约金，继续办理，请按确认键。");
				return false;
			}
		}
		else if (document.all.opFlag.value=="05")
		{
			document.all.d0_old_ofrId.value = packet.data.findValueByName( "oOldOfferId" );	
			document.all.d0_old_ofrNm.value = packet.data.findValueByName( "oOldOfferName" );
		}	
		else if (document.all.opFlag.value=="03")
		{
			document.all.d1_ofrId.value = packet.data.findValueByName( "oOldYearId" );	
			document.all.d1_ofrNm.value = packet.data.findValueByName( "oOldYearName" );		
		}		
		else if (document.all.opFlag.value=="04")
		{
			row1.style.display="none";
		 	$("#d0").hide();
		 	$("#d1").hide();
		 	$("#d2").show(1000);		
		}
	}
	
}

function clearWindow()
{
	location.reload();//huangrong add 刷新页面 2011-8-9 
	//document.frm.reset();
	//document.frm.ecsiIdQuery.disabled=false;
	//document.frm.modeQuery.disabled=false;
	
}



var _jspPage =
{"div1_switch":["mydiv1","f3596_list.jsp?opCode=<%=opCode%>","f"]

};
$("#divold").hide() ;
function hiddenSpider()
{
	document.getElementById("mydiv1").style.display='none';
  
}

$(document).ready(function () {
	//隐藏进度条
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent); 	
  	$("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
 

  }
);

var toggleContent = function(e)
{
	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {	  
		   targetContent.slideDown(300);
		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
		   //调用服务
		   try{
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{
		   		$("#"+tmp2[0]).load(tmp2[1],{sPhoneNo:$("#phoneNo").val()
		   			                          
		   			                          });
		   		//tmp2[2]="t";
		   	}
		   }catch(e)
		   {		   	
		   }

	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
	}
	return false;
};

function getOldIfo()
{	
	if ( '0' == document.all.bizcode.value  )
	{
		rdShowMessageDialog("必须选择业务名称" , 0);
		return false;
	}
	
	var myPacket = new AJAXPacket("f3596_ajax.jsp","正在获得业务信息，请稍候......");

	myPacket.data.add("ajaxType","getOldIfo");
	myPacket.data.add("logacc",document.all.loginAccept.value);
	myPacket.data.add("chnSrc","01");
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("workNo","<%=loginNo%>");
	myPacket.data.add("passwd","<%=loginPwd%>");
	
	myPacket.data.add("phoneNo","<%=phoneNo%>");
	myPacket.data.add("usrpwd","");
	myPacket.data.add("oldAcc" , document.all.old_acc.value);
	myPacket.data.add("vidNo" , document.all.vidNo.value);
	
	core.ajax.sendPacket(myPacket , setOldIfo);
	myPacket=null;	
}

function setOldIfo( packet )
{	
	var oRetCode = packet.data.findValueByName("oRetCode");
	var oRetMsg = packet.data.findValueByName("oRetMsg");
	if ( oRetCode!="000000" )
	{
		rdShowMessageDialog( oRetCode+":"+oRetMsg ,0 );
		return false;
	}
	else
	{
		document.all.d2_old_Id.value = packet.data.findValueByName("oOldOfferID");
		document.all.d2_old_nm.value = packet.data.findValueByName("oOldOfferName");
		document.all.d2_new_id.value = packet.data.findValueByName("oNewOfferID");
		document.all.d2_new_nm.value = packet.data.findValueByName("oNewOfferName");
		document.all.d2_login.value = packet.data.findValueByName("oLoginNo");
		document.all.d2_time.value = packet.data.findValueByName("oOpTime");
		document.all.mebId.value = packet.data.findValueByName("oMebId");

		document.all.old_acc.disabled = true;		
	}
}




</script>
<BODY>
	<FORM action="" method="post" name="frm" >
			<%@ include file="/npage/include/header.jsp" %>  
		<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- 操作流水号 -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="opCode"  value="<%=opCode%>">	<!--huangrong update for 关于求职通业务支撑的函  2011-8-1 -->
		<input type="hidden" name="opName"  value="<%=opName%>">	<!-- huangrong add for 关于求职通业务支撑的函  2011-8-1 -->
	  <input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
	  <input type="hidden" name="bizname"  value="">
	  <input type="hidden" name="mode_name"  value="">
	  <input type="hidden" name="servcode1"  value="">
	  <input type="hidden" name="phoneNo1"  value="">
	  <input type="hidden" name="vregionCode"  value="">
	  <input type="hidden" name="vidNo"  value="">
	  <input type="hidden" name="vCustAddresee"  value="">
	  <input type="hidden" name="vIdIccid"  value="">
	  <input type="hidden" name="mebId"  value="">
	  <input type="hidden" name="vSmName"  value="">
	  <input type="hidden" name="printcount">
	  <input name="printAccept" type="hidden" value="<%=loginAccept%>">
	  
	 <div class="title">
		 <div id="title_zi"><%=opName%></div>
	  </div>

	<TABLE  cellSpacing=0>
		<TR>
			<td class="blue" WIDTH = '25%'>手机号码</TD>
			<TD colspan="3">
			<input class="InputGrey"  type="text" id="phoneNo" value="<%=phoneNo%>" maxlength=11 v_must="1" v_type="mobphone2"  readOnly >
			<input class="b_text" type="button" name="query" value="查询"  onClick="QryPhoneInfo()" >   
			</TD>
		  </tr>
		<TR>
		<TR >
			<td class="blue" WIDTH = '25%' >客户名称</TD>
			<TD >
			<input class="InputGrey"  type="text" name="custName" value="" maxlength=20 v_must="1" v_type="string"  readOnly>
			</TD>
			<td class="blue" WIDTH = '25%' >运行状态</TD>
			<TD >
			<input class="InputGrey"  type="text" name="runState" value="" maxlength=11 v_must="1" v_type="string"  readOnly>
			</TD>
		  </tr>				  
		<TR>
			<td class="blue">
				操作类型
			</TD>
			<TD class="blue">
				<SELECT name="opFlag"  id="opFlag" onChange="changeOpFlag()">
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
						  SELECT FIELD_CODE3, FIELD_CODE3||'-->'|| FIELD_CODE4
						    FROM DBVIPADM.SCOMMONCODE
						   WHERE COMMON_CODE IN ('1012', '1013', '1014', '1015', '1016')
						     AND OP_CODE = '<%=opCode%>' order by FIELD_CODE3 asc
						</wtc:sql>
					</wtc:qoption>
				</SELECT>
				<font class="orange">*</font>
			</TD>
			<TD class="blue">
			业务名称
			</TD>
			<TD>
				<select name="bizcode" id = 'bizcode' v_must="1" onChange="tochange()" >
			  <option value="0" >请选择</option>  <!--huangrong update for 关于求职通业务支撑的函  2011-8-1-->
		<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>
					select a.bizcodeadd,a.product_note from sbillspcode a ,dbvipadm.scommoncode b 
				where a.enterprice_code=rpad(trim(b.field_code1),20) AND b.common_code = '1004'
				AND a.srv_code =b.field_code2 and b.op_code = '<%=opCode%>'
				</wtc:sql>
				</wtc:qoption>
		</select>
			   <!--<input name="bizcode" class="InputGrey" id="bizcode" size="24" maxlength="18" v_type="string"v_must=1v_name="业务代码" index="1" value="">-->
				<font class="orange">*</font>
			</TD>
		</TR>
		
		<!--<TR>
			<td class="blue">
			业务接入号
			</TD>
			<TD>
				<input name="servcode" class="InputGrey" id="servcode" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="业务接入号" index="3" value="">
				<font class="orange">*</font>
			</TD>
			<td class="blue">业务接入号属性</TD>
			<TD>
				<SELECT name="baseservcodeprop"  id="baseservcodeprop"  onclick="">
					<option value="01" >短信</option>
					<option value="02" >彩信 </option>
				</SELECT>
				<font class="orange">*</font>
			</TD>
		</TR>		-->						
		
		  	<TR id="row1">
		
			<TD class="blue" >
			  附加套餐
			</TD>
			<TD colspan="3">    
				<input name="extraOption"  id="extraOption" size="24" maxlength="18" v_type="string"  v_name="附加套餐" index="1" value="" readonly >
				<input name=modeQuery type=button id="modeQuery" class="b_text" onClick="getInfo_Mode();" onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=选择 disabled>
			</TD>
		</TR>
	</table>
	
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none" ch_name = '资费变更' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更前资费代码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd0_old_ofrId' NAME= 'd0_old_ofrId' ch_name = '变更前资费代码' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更前资费名称:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd0_old_ofrNm' NAME= 'd0_old_ofrNm' ch_name = '变更前资费名称' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >新附加资费:</TD>
				<TD colspan = '3'>
					<INPUT TYPE = 'text' ID = 'd0_new_ofrId' NAME= 'd0_new_ofrId' ch_name = '新附加资费' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />  
				<input name=newModeQuery type=button id="newModeQuery" class="b_text" 
					onClick="getInfo_Mode();" 
					onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=选择>					  
				</TD>    
			</TR>   			   
		</TABLE>
	</DIV>	
	
	<DIV ID = "d1" NAME = "d1" STYLE = "display:none" ch_name = '续签' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >成员资费代码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd1_ofrId' NAME= 'd1_ofrId' ch_name = '成员资费代码' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >成员资费名称:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd1_ofrNm' NAME= 'd1_ofrNm' ch_name = '成员资费名称' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >新附加资费:</TD>
				<TD colspan = '3'>
					<INPUT TYPE = 'text' ID = 'd1_new_ofrId' NAME= 'd1_new_ofrId' ch_name = '新附加资费' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />  
				<input name=newModeQuery03 type=button id="newModeQuery03" class="b_text" 
					onClick="getInfo_Mode();" 
					onClick="if(event.keyCode==13)getInfo_Mode();" style="cursorhand" value=选择>					  
				</TD>    
			</TR> 			
		</TABLE>
	</DIV>		
	
	<DIV ID = "d2" NAME = "d2" STYLE = "display:none" ch_name = '续签冲正' >
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >申请流水:</TD>
				<TD WIDTH = '25%' colspan = '3' >
					<INPUT TYPE = 'text' ID = 'old_acc' NAME= 'old_acc' ch_name = '申请流水' MAXLENGTH = '15' 
					value = '' />
					<input type = 'button' id = '' name = '' value = '查询' class = 'b_text' onclick = 'getOldIfo()' >    
				</TD>      
			</TR> 			
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更前的产品ID:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_old_Id' NAME= 'd2_old_Id' ch_name = '变更前的产品ID' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更前的产品名称:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_old_nm' NAME= 'd2_old_nm' ch_name = '变更前的产品名称' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    
			</TR>  
			<TR>
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更后的产品ID:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_new_id' NAME= 'd2_new_id' ch_name = '变更后的产品ID' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >变更后的产品名称:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_new_nm' NAME= 'd2_new_nm' ch_name = '变更后的产品名称' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>   
			</TR>  
			<TR> 				
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >营业员:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'd2_login' NAME= 'd2_login' ch_name = '营业员' MAXLENGTH = '15' 
					value = '' class = 'InputGrey' readOnly />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'left' class = 'blue' >操作时间:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'd2_time' NAME= 'd2_time' ch_name = '操作时间' MAXLENGTH = '15' 
						VALUE = '' class = 'InputGrey' readOnly />    
				</TD>    				
			</TR>  
		</TABLE>
	</DIV>		
		
	<table   cellSpacing=0>
		<TR>
			<td class="blue"  WIDTH = '25%'>系统备注</TD> 
			<TD>
				<input  name="systemNote" size="60" value="" class="InputGrey">
			</TD>
		</TR>
	</TABLE>
						

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">业务订购列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>						

				<table id="tc" cellSpacing=0>
							<TR>
								<TD align=center id="footer" colspan=4>
									<input class="b_foot" name="confirm" id="confirm" type=button value="确认" onclick="refMain()">
									<input class="b_foot" name="clear"  onClick="clearWindow()" type=button value="清除" >
									<input class="b_foot" name="colse"  onClick="removeCurrentTab()" type=button value="关闭" >
								</TD>
							</TR>
							
						</TABLE>
	
    <%@include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML>
