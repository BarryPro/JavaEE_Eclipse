<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 入网预存领奖1455
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setDateHeader("Expires", 0);
%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%	
	String opCode="1455";
	String opName=" 入网奖品领取 ";	
	String phoneNo = request.getParameter("srv_no");
	String workNo=(String)session.getAttribute("workNo");
	String workName=(String)session.getAttribute("workName");
	String orgCode=(String)session.getAttribute("orgCode");
	String regionCode=(String)session.getAttribute("regCode");
%>

<%
	String retFlag="",retMsg="";			//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s1251Init***********************/
//  SPubCallSvrImpl impl = new SPubCallSvrImpl();
//  ArrayList retList = new ArrayList();
//	String[][] temp=new String[][]{};
//	String[][] tmpresult1= new String[][]{};
//	String[][] tmpresult2= new String[][]{};
//	String[][] tmpresult3= new String[][]{};
//	String[][] tmpresult4= new String[][]{};
//	String[][] tmpresult5= new String[][]{};

	String passwordFromSer="";
	int j=0;
	String[] paraAray1 = new String[2];
	paraAray1[0] = phoneNo;			/* 手机号码   */ 
	paraAray1[1] = workNo; 			/* 操作工号   */
	for(int i=0; i<paraAray1.length; i++)
	{		
		if( paraAray1[i] == null )
		{
			paraAray1[i] = "";
		}
	}
//  retList = impl.callFXService("s1455Init", paraAray1, "9","phone",phoneNo);
%>
	<wtc:service name="s1455Init" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<wtc:array id="tmpresult1" start="4" length="1" scope="end"/>
	<wtc:array id="tmpresult2" start="6" length="1" scope="end"/>
	<wtc:array id="tmpresult3" start="5" length="1" scope="end"/>
	<wtc:array id="tmpresult4" start="7" length="1" scope="end"/>
	<wtc:array id="tmpresult5" start="8" length="1" scope="end"/>	
<%
	String  bp_name="";
	String errCode = retCode1;
	String errMsg = retMsg1;
	if(result == null)
	{
		if(!retFlag.equals("1"))
		{
			retFlag = "1";
			retMsg = "s1455Init查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
		}
	}else if(!(result == null))
	{
		if (errCode.equals("000000") ){
//			temp=(String[][])retList.get(2);
			bp_name=result[0][2];			//机主姓名
//			temp=(String[][])retList.get(3);
			passwordFromSer=result[0][3];	//密码
		}else{
			if(!retFlag.equals("1"))
			{
				 retFlag = "1";
				 retMsg = "s1455Init查询号码基本信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
			}
		}
   }
  String handFee_Favourable = "readonly";        //a230  手续费
  /****得到打印流水****/
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>入网预存领奖</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
	  document.frm.action = "f1555_2.jsp";
	  document.frm.submit();
	  return true;
  }
  //***//校验是否选中领奖纪录
  function checkIfSelect(){
	  var radio1 = document.getElementsByName("radio1");
	  var doc = document.forms[0];
	  var flag = 0;
	  for(var i=0; i<radio1.length; i++)
	  {
	      if(radio1[i].checked)
		  {
				if(eval("doc.flag"+radio1[i].value+".value")=="已")
				{
					rdShowConfirmDialog("奖品已经领取！"); 
					return false;
				}
				document.frm.awardId.value=eval("doc.awardId"+radio1[i].value+".value");
				document.frm.flag.value=eval("doc.flag"+radio1[i].value+".value");
				document.frm.inTotal.value=eval("doc.inTotal"+radio1[i].value+".value");
				document.frm.payAccept.value=eval("doc.payAccept"+radio1[i].value+".value");

				flag=1;
				break;
		   }		   
	  }
	  if(flag==0)
	  {
	      rdShowConfirmDialog("请选择一条领奖纪录！"); 
		  return false;
	  }
	  return true;
  }

  
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  	document.frm.opNote.value = "奖品;"+document.frm.phoneNo.value+";"+document.frm.awardNo.value; 
	}
	return true;
}

function printCommit()
{ 
	getAfterPrompt();
	with(document.frm)
	{
	  if(awardNo.value=="")
	  {
	      rdShowConfirmDialog("请输入奖品"); 
		  awardNo.focus();
		  return false;
	  }
	}
	if(!(checkIfSelect())) return false;
	setOpNote();//备注赋值
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
//---------------------------------------------------
function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间

	opr_info+='<%=workName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.frm.phoneNo.value+"|";
	cust_info+="客户姓名：" +document.frm.bp_name.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	
	opr_info+="业务类型:       入网预存领奖"+"|";
	opr_info+="奖项:           "+document.frm.awardInfo.value+"|";
	opr_info+="流水:             "+"<%=printAccept%>"+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
}
//-----------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="1455" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}
/**查询奖品**/
function getAwardInfo()
{ 
  	//调用公共js得到奖品
    var pageTitle = "奖品代码查询";
    var fieldName = "奖品级别|奖品代码|奖品名称|";//弹出窗口显示的列、列名
   	var sqlStr ="select award_id,award_no,award_info from sOpenAwardInfo where region_code = substr('"+document.all.orgCode.value+"',1,2) and award_id >= '"+document.frm.awardId.value+"' order by award_id,award_no";
	//	alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|1|2|";//返回字段
    var retToField = "awardNo|awardInfo|";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
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
//-->
</script>
</head>
<body>
<form name="frm" method="post"    >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">手机号码</td>
		<td>
			<input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
		<td class="blue">客户名称</td>
		<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" size="40" value="<%=bp_name%>" readonly> 
		</td>  
	</tr>
</table>
</div>
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">奖品信息</div>
	</div>
<table cellSpacing="0">
	<tr align="center">
		<th>选择</th>
		<th>奖项</th>
		<th>领取标志</th>
		<th>奖品名称</th>
		<th>中奖日期</th>
		<th>交费流水</th>
	</tr>
	<% 
		String[] tmpresult6= new String[]{};
		String[] tmpresult7= new String[]{};
		String[] tmpresult8= new String[]{};
		String[] tmpresult9= new String[]{};
		String[] tmpresult0= new String[]{};
		for(j=0;j<tmpresult1.length;j++)
		{
			tmpresult6=tmpresult1[j];
			tmpresult7=tmpresult1[j];
			tmpresult8=tmpresult1[j];
			tmpresult9=tmpresult1[j];
			tmpresult0=tmpresult1[j];
		}
		 for(j=0;j<tmpresult1.length;j++)
		 {
	%>
	<tr align="center">
		<td><input type="radio"  name="radio1" value="<%=j%>"></td>
		<TD><%=tmpresult1[j][0]%></TD>
		<TD><%=tmpresult2[j][0]%></TD>
		<TD><%=tmpresult3[j][0]%></TD>
		<TD><%=tmpresult4[j][0]%></TD>
		<TD><%=tmpresult5[j][0]%></TD>
		
		<input name="awardId<%=j%>" type="hidden" value="<%=tmpresult1[j][0]%>">
		<input name="flag<%=j%>" type="hidden" value="<%=tmpresult2[j][0]%>">
		<input name="inTotal<%=j%>" type="hidden" value="<%=tmpresult4[j][0]%>">
		<input name="payAccept<%=j%>" type="hidden" value="<%=tmpresult5[j][0]%>">
	</tr>				
	<%}%>  		
</table>
</div>
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">奖品查询</div>
	</div>			 
<table cellspacing="0">
	<tr> 
		<td class="blue">奖品名称</td>
		<td>
			<input type="text" class="button" name="awardNo" size="8" maxlength="8" v_must=1>
			<input type="text" class="button" name="awardInfo" size="30" v_must=1>&nbsp;&nbsp;
			<font color="orange">*</font>
			<input name=awardInfoQuery type=button class="b_text"  style="cursor:hand" onClick="if(checkIfSelect()) getAwardInfo()" value=查询> 
		</td>
	</tr>
	<tr> 
		<td class="blue">备注</td>
		<td colspan="3" height="32">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" onFocus="setOpNote();"> 
		</td>
	</tr>
	<tr> 
		<td colspan="2" align="center" id="footer"> 
			<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="printCommit()" >
			&nbsp;  
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp; 
			<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
			&nbsp; 				
		</td>
	</tr>
</table>    
  <input type="hidden" name="awardId" value="">
  <input type="hidden" name="flag" value="">
  <input type="hidden" name="inTotal" value="">
  <input type="hidden" name="payAccept" value="">
  <input type="hidden" name="orgCode" value="<%=orgCode%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

