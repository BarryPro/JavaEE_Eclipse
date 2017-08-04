<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<!-------------------------------------------->
<!---日期:  2008-11-14 14:56:27    ---->
<!---作者:  jiangqing                       ---->
<!---代码:  f1847                         ---->
<!---功能：多媒体彩铃                       ---->
<!---修改：办理服务开通，主动暂停，主动暂停恢复和注销业务         ---->
<!-------------------------------------------->

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<!-------------------以下是自动调用查询WTC函数------------------------>
<%
String opCode = "1847";
String opName = "多媒体彩铃";
String op_name="";
String regionCode = (String)session.getAttribute("regCode");
String phone_no=request.getParameter("phone_no");
String work_no =(String)session.getAttribute("workNo");
String loginName =(String)session.getAttribute("workName");
//arrSession = (ArrayList)session.getAttribute("allArr");
//baseInfoSession = (String[][])arrSession.get(0);
//work_no = baseInfoSession[0][2];
%>

<wtc:service name="s1847Qry" outnum="9" routerKey="phone" routerValue="<%=phone_no%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result"  start="0" length="9"  scope="end" />
<%
String return_code="";
String return_msg="";
String id_no = "";
String cust_name="";
String run_code="";
String run_name="";
String opr_code="";
String cust_address="";
String id_iccid="";

return_code = result[0][0].trim();
return_msg = result[0][1].trim();
id_no = result[0][2].trim();
cust_name = result[0][3].trim();
run_code = result[0][4].trim();
run_name = result[0][5].trim();
opr_code = result[0][6].trim();
cust_address = result[0][7].trim();
id_iccid = result[0][8].trim();
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>


<html>
<head>
<title>多媒体彩铃</title>

<script type="text/javascript">
core.loadUnit("debug");
core.loadUnit("rpccore");
onload=function()
{
	//core.rpc.onreceive = doProcess;	
	var runcode = "<%=run_code%>";
	var opr_code = "<%=opr_code%>"==""?"00":"<%=opr_code%>";
	var return_code="<%=return_code%>";
	var return_msg="<%=return_msg%>";
	
	if(return_code=="000000")
	{
  		if(runcode != 'A' && runcode != 'K')
  		{
  			document.getElementById("kt").disabled=true;
        	document.getElementById("zt").disabled=true;
        	document.getElementById("hf").disabled=true;
        	document.getElementById("zx").disabled=true;
       	 	rdShowMessageDialog("该用户运行状态不正常，不能办理业务！");
			parent.removeTab('<%=opCode%>');
     	}
		else
		{
     		if(opr_code=="00")
			{
				document.getElementById("kt").disabled=false;
	        	document.getElementById("zt").disabled=true;
	        	document.getElementById("hf").disabled=true;
	        	document.getElementById("zx").disabled=true;
			}
			else
			{
				document.getElementById("kt").disabled=true;
				if(opr_code=="01")
				{
		        	document.getElementById("zt").disabled=false;
		        	document.getElementById("hf").disabled=true;
		        	document.getElementById("zx").disabled=false;
				}
				if(opr_code=="21")
				{
		        	document.getElementById("zt").disabled=true;
		        	document.getElementById("hf").disabled=false;
		        	document.getElementById("zx").disabled=false;
				}
				if(opr_code=="02")
				{
		        	document.getElementById("zt").disabled=true;
		        	document.getElementById("hf").disabled=true;
		       		document.getElementById("zx").disabled=true;
		        	rdShowMessageDialog("该用户已经注销了，请下月一号再来办理业务！");
		        	parent.removeTab('<%=opCode%>');
				}
			}	
		}
	}
	
	else
	{
		rdShowMessageDialog("错误:"+return_code+return_msg);
		history.go(-1);
	}
}

function doCfm()
{
	getAfterPrompt();
	var count = 0;
	var oprcode;
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
	if(count == 0)
	{
		rdShowMessageDialog("请至少选择一项操作！");
		return;	
	}
	
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
  	if(typeof(ret)!="undefined")
  	{
    	if((ret=="confirm"))
    	{
      		if(rdShowConfirmDialog('确认电子免填单吗？')==1)
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

function frmCfm(){
	
	var oprcode;
	var count = 0;
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
 	var myPacket = new AJAXPacket("f1847_cfm.jsp","操作正在处理，请稍候......");
	var phone_no="<%=phone_no%>";
	var work_no="<%=work_no%>";
	myPacket.data.add("work_no",work_no);
	myPacket.data.add("phone_no", phone_no);
	myPacket.data.add("opr_code",oprcode);
	myPacket.data.add("login_accept",document.frm.login_accept.value);
	core.ajax.sendPacket(myPacket);
	myPacket=null; 
  }
  
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//alert("ccccccccccccc");
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
 	var sysAccept = document.all.login_accept.value;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phone_no%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 var opr_name="";
	 var oprcode="";
	 var count=0;
  
	 var retInfo = "";
	cust_info+="手机号码：   "+"<%=phone_no%>"+"|";
	cust_info+="客户姓名：   "+"<%=cust_name%>"+"|";
	cust_info+="客户地址：   "+"<%=cust_address%>"+"|";
	cust_info+="证件号码：   "+"<%=id_iccid%>"+"|";
	for(var i = 0 ; i < document.frm.opr_code.length ; i ++)
	{
		if(document.all.opr_code[i].checked)
		{
			count += 1;
			oprcode = document.frm.opr_code[i].value;
		} 
	}
	if(oprcode=="01")
	{
		opr_name="开通";
	}else if(oprcode=="02")
	{	opr_name="注销";
	}else if(oprcode=="21")
	{	opr_name="主动暂停";
	}else if(oprcode=="22")
	{	opr_name="主动恢复";
	}
	opr_info+="业务类型：多媒体彩铃"+opr_name+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}

function doProcess(packet)
{
	
	var code=packet.data.findValueByName("code");
	var msg=packet.data.findValueByName("msg");
	if(code!="000009")
	{
		rdShowMessageDialog(code+","+msg);
		window.location.reload("f1847.jsp?phone_no=<%=phone_no%>&op_code=1847");
	}
	else 
	{
		rdShowMessageDialog("000000,"+msg);
		parent.removeTab('<%=opCode%>');
	}
}
</script>
<!--js-->


</head>

<body>


<form name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
			<div id="title_zi">多媒体彩铃</div>
		</div>
<input type="hidden" name="phone_no" value="<%=phone_no%>">
<input type="hidden" name="work_no" value="<%=work_no%>">
	<tr>
      <td>
        <table  cellspacing="0" >
           <tr > 
		      <td width="10%"  >手机号码</td>
			  <td  nowrap><%=phone_no%></td>
		   </tr>
		   <tr > 
		      <td width="10%"  >客户名称</td>
			  <td  nowrap>
			  <%if(cust_name.trim().equals("unknow")){out.print("<font color=#880000>客户姓名未登记</font>");}else{out.print(cust_name);}%>
			  </td>
		   </tr>
		   <tr > 
		      <td width="10%"  >客户地址</td>
			  <td  nowrap><%=cust_address%></td>
			 
		   </tr>
		   <tr > 
		      <td width="10%"  >证件号码</td>
			  <td  nowrap><%=id_iccid%></td>
		   </tr>
		   <tr > 
		      <td width="10%"  >当前状态</td>
			  <td  nowrap>
				<font color="#880000"><%=run_name%></font>
			  </td>
		   </tr>
		   
		   <tr > 
		      <td width="10%"  >办理类型</td>
			  <td  nowrap>
			    <input type="radio" name="opr_code" id="kt" value="01">开通&nbsp;
				<input type="radio" name="opr_code" id="zt" value="21">主动暂停&nbsp;
				<input type="radio" name="opr_code" id="hf" value="22">主动恢复&nbsp;
				<input type="radio" name="opr_code" id="zx" value="02">注销&nbsp;
			  </td>
		   </tr>
		   <!--
			<tr > 
		      <td width="10%"  > 希望生效时间</td>
			  <td  nowrap>
			    <input type="text" name="effeti_time" id="effeti_time" v_type="date" v_format = "yyyyMMdd" v_name="生效时间" size="20" onblur="if(checkElement(this)){return false;}" maxlength="8"/>
			  </td>
		   </tr>
		   
		   <tr height="26"> 
		      <td width="12%" > 新密码</td>
			  <td  nowrap>
			    <input type="password" name="new_pwd" id="new_pwd" size="21" maxlength="8"/>
			  </td>
		   </tr>
		  
		  <tr > 
		      <td width="10%"  > SP企业代码</td>
			  <td  nowrap>
			    <input type="text" name="sp_id" id="sp_id" size="20" maxlength="18"/>
			  </td>
		   </tr>
		   
		    <tr height="26"> 
		      <td width="10%"  > 彩铃套餐代码</td>
			  <td  nowrap>
			    <input type="text" name="pack_numb" id="pack_numb" size="20" maxlength="24"/>
			  </td>
		   </tr>
		  
			<tr > 
		      <td width="10%"  > SP业务代码</td>
			  <td nowrap>
			    <input type="text" name="biz_code" id="biz_code" size="20" maxlength="10"/>
			  </td>
			</tr>
		  -->
		  <input type="hidden" name="login_accept" value="<%=printAccept%>">
			<tr > 
		      <td width="10%"   align="center" colspan="2"> 
			    <input type="button" class="b_foot" value="确认&打印" name="confirm" onclick = "doCfm();">&nbsp;&nbsp;&nbsp;
			    <input type="reset" class="b_foot" value="清除" name="reset">&nbsp;&nbsp;&nbsp;
				<input type="button" class="b_foot" value="返回" name="close" onclick="history.go(-1);">
              </td>
			</tr>
        </table>
      <%@ include file="/npage/include/footer.jsp" %>   
</form>
<br><br>
</body>
</html>
