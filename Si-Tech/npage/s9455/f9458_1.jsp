<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: daixy
 * date  : 20100226
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>
<%@ page import="java.util.*"%>

<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
	String iPhoneNo =(String)request.getParameter("iPhoneNo");
	String iUserPwd = "";
	String iChnSource = "";
    String iLoginNo = (String)session.getAttribute("workNo");
    String iLoginName =(String)session.getAttribute("workName");
    String iLoginPwd = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String iLoginAccept = getMaxAccept();
    
    String [] inParas = new String[7];
    inParas[0] = iLoginAccept;
    inParas[1] = iChnSource;
    inParas[2] = opCode;
    inParas[3] = iLoginNo;
    inParas[4] = iLoginPwd;
	inParas[5] = iPhoneNo;
    inParas[6] = iUserPwd;
%>
<wtc:service name="s9458Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">			
	<wtc:param value="<%=inParas[0]%>" />
	<wtc:param value="<%=inParas[1]%>" />
	<wtc:param value="<%=inParas[2]%>" />
	<wtc:param value="<%=inParas[3]%>" />
	<wtc:param value="<%=inParas[4]%>" />
	<wtc:param value="<%=inParas[5]%>" />
    <wtc:param value="<%=inParas[6]%>" />	
</wtc:service>	
<wtc:array id="result1"  scope="end"/>
<%
	String vCustName = "";
	String vCustAddress = "";
	String vIdName = "";
	String vIdIccid = "";
	String vSmName = "";
	String vRegionName = "";
	String vRunName = "";
	String vOfferName = "";
	String vBlackBerryRunCode = "";
	String vBeginTime = "";
	String vOpNote = "";
	
	if (result1.length>0 && retCode1.equals("000000"))
	{
		vCustName = result1[0][2];
		vCustAddress = result1[0][3];
		vIdName = result1[0][4];
		vIdIccid = result1[0][5];
		vSmName = result1[0][6];
		vRegionName = result1[0][7];
		vRunName = result1[0][8];
		vOfferName = result1[0][9];
		vBlackBerryRunCode = result1[0][10];
		vBeginTime = result1[0][11];
	}else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode1%>'，错误信息：'<%=retMsg1%>'。",0);
		history.go(-1);
	</script>
<%	 
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<title>BlackBerry个人业务暂停/恢复</title>

<script language="JavaScript">
function printInfo(printType)
{
  if(document.frm.opNote.value==""){
  document.frm.opNote.value="操作员"+"<%=iLoginNo%>"+"对用户"+document.frm.phoneNo.value+"进行"+"<%=opName%>"
  }
  var retInfo = "";
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  
  cust_info+="客户姓名：" +document.frm.custName.value+"|";
  cust_info+="手机号码："+document.frm.phoneNo.value+"|";

  
  opr_info+="受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
  opr_info+="受理人工号：" +"<%=iLoginNo%>"+"  受理人名称: "+"<%=iLoginName%>" +"|";
  opr_info+="受理内容：" +"<%=opName%>"+"|";
  
  note_info1+="备注信息："+document.all.opNote.value+"|";
  document.all.cust_info.value=cust_info+"#";
  document.all.opr_info.value=opr_info+"#";
  document.all.note_info1.value=note_info1+"#";
  document.all.note_info2.value=note_info2+"#";
  document.all.note_info3.value=note_info3+"#";
  document.all.note_info4.value=note_info4+"#";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);	
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 	
  return retInfo;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=200;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          // 票价类型：1电子免填单、2发票、3收据
   var sysAccept="<%=iLoginAccept%>";                         // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="<%=opCode%>";                                  //操作代码
   var phoneNo="<%=iPhoneNo%>";                               //客户电话

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
 
   return ret;
}

function frmCfm()
{
 	frm.submit();
	return true;
}

function doprint()
{	
	getAfterPrompt();
	document.all.print.disabled=true;

	//打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
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
	document.all.print.disabled=false;
	return true;
}

</script>
</head>

<body>
<form name="frm" action="f9458_Cfm.jsp" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="printcount">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<table cellspacing="0">
	<tr>
		<td class="blue">客户姓名</td>
		<td><input name="custName" type="text" value="<%=vCustName%>" class="InputGrey" readonly></td>
		<td class="blue">手机号码</td>
		<td><input name="phoneNo" type="text" value="<%=iPhoneNo%>" class="InputGrey" readonly></td>
	</tr>

	<tr>
		<td class="blue">客户地址</td>
		<td><input name="custAddress" type="text" value="<%=vCustAddress%>" class="InputGrey" readonly></td>
		<td class="blue">业务品牌</td>
		<td><input name="smname" type="text" value="<%=vSmName%>" class="InputGrey" readonly></td>
	</tr>

	<tr>
		<td class="blue">证件类型</td>
		<td><input name="idname" type="text" value="<%=vIdName%>" class="InputGrey" readonly></td>
		<td class="blue">证件号码</td>
		<td><input name="icIccid" type="text" value="<%=vIdIccid%>" class="InputGrey" readonly></td>
	</tr>

	<tr>
		<td class="blue">归属地市</td>
		<td><input name="regionname" type="text" value="<%=vRegionName%>" class="InputGrey" readonly></td>
		<td class="blue">运行状态</td>
		<td><input name="runname" type="text" value="<%=vRunName%>" class="InputGrey" readonly></td>
	</tr>

	<tr>
		<td class="blue">当前资费</td>
		<td><input name="offerName" type="text" value="<%=vOfferName%>" class="InputGrey" readonly></td>
		<td class="blue">注册时间</td>
		<td><input name="beginTime" type="text" value="<%=vBeginTime%>" class="InputGrey" readonly></td>
	</tr>

	<tr>
		<td class="blue">选择状态</td>
		<td><select name="iNowState">
<%
			if(vBlackBerryRunCode.equals("H"))
			{
%>		
			<option value="A">恢复</option>
<%			
			}else{
%>
			<option value="H">暂停</option>
<%
			}
%>
			</select>
		</td>
		<td class="blue">备注</td>
		<td><input  name="opNote" type="text" value="<%=vOpNote%>"></td>
	</tr>

	<tr>
    	<td noWrap colspan="6" id="footer">
		<div align="center">
 		<input type="button" name="print" class="b_foot" value="确认&打印" onClick="doprint()">
              &nbsp;
        <input type="button" name="return1" class="b_foot" value="返回" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
      	</div>
   		</td>
	</tr>

<table>
	<%@ include file="/npage/include/footer.jsp" %>
<form>
</body>
</html>