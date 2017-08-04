<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-------------------------------------------->
<!---日期:  2008-11-27                    ---->
<!---作者:  guanbj                       ---->
<!---代码:  s1849                         ---->
<!---功能：视频共享                       ---->
<!---修改：办理服务开通和注销业务         ---->
<!-------------------------------------------->
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<!-------------------以下是自动调用查询WTC函数------------------------>
<%
String regionCode = (String)session.getAttribute("regCode");
String phone_no=request.getParameter("phone_no");
String opCode = "1849";
String opName = "视频共享";
String op_name="";
String work_no =(String)session.getAttribute("workNo");
String loginName =(String)session.getAttribute("workName");

%>
<wtc:service name="s1849Qry" outnum="8" routerKey="phone" routerValue="<%=phone_no%>">
<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="8" scope="end" />
<%
String cust_name="";
String run_name="";
String run_code="";
String is_open="";
String return_code="";
String return_msg="";
String cust_address="";
String id_iccid="";
cust_name=result[0][0];
run_name=result[0][1];
run_code=result[0][2];
is_open=result[0][3];
return_code=result[0][4];
return_msg=result[0][5];
cust_address = result[0][6].trim();
id_iccid = result[0][7].trim();
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<!-------------------以上是自动调用查询WTC函数------------------------>
<html>
<head>
<title>视频共享</title>
<script type="text/javascript">
core.loadUnit("debug");
core.loadUnit("rpccore");
onload=function()
{
	var temp= "<%=run_code%>";
	var return_code="<%=return_code%>";
	var return_msg="<%=return_msg%>";
	if(return_code=="000000")
	{
  		if(<%=is_open%>=='01'){
  			document.getElementById("kt").disabled=true;
  			document.getElementById("zx").disabled=false;
  		}else if(<%=is_open%>=='00')
  		{
  		
  			document.getElementById("kt").disabled=false;
  			document.getElementById("zx").disabled=true;
  		
  		}
  		else{
  			document.getElementById("kt").disabled=true;
  			document.getElementById("zx").disabled=true;
  			rdShowMessageDialog("用户已经注销此业务，请下月一号再办理业务！");
			parent.removeTab('<%=opCode%>');
  		}

  		if(temp=='A'||temp=='K'){}
  		else{
  			document.getElementById("kt").disabled=true;
  			rdShowMessageDialog("该用户运行状态不正常，不能办理业务！");
			parent.removeTab('<%=opCode%>');
  		}
  	}else
	{
		rdShowMessageDialog("错误:"+return_code+return_msg);
		history.go(-1);
	}
}

function doCfm()
{
	getAfterPrompt();
	var count = 0;
	for(var i = 0 ; i < document.frm.Td_code.length ; i ++)
	{
		if(document.all.Td_code[i].checked){
			count += 1;
		} 
	}
	if(count == 0){
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
	var phone_no="<%=phone_no%>";
	var work_no="<%=work_no%>";
	var Td_code = "1";
	for(var i = 0 ; i< document.frm.Td_code.length; i++){
		 if(document.frm.Td_code[i].checked==true){
			Td_code=document.frm.Td_code[i].value;
		 }
	 }
	// alert("ccccccccccccc");
	var myPacket = new AJAXPacket("s1849deal.jsp","操作正在处理，请稍候......");
	myPacket.data.add("work_no", work_no);
	myPacket.data.add("phone_no", phone_no);
	myPacket.data.add("Td_code",Td_code);
	myPacket.data.add("login_accept",document.frm.login_accept.value);
  	//alert("ppppppppppppppp");
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
  	
	 var retInfo = "";
	 var count = 0;
	 var oprcode="";
	 var opr_name="";
	for(var i = 0 ; i < document.frm.Td_code.length ; i ++)
	{
		if(document.all.Td_code[i].checked){
			count += 1;
			oprcode = document.all.Td_code[i].value;
		} 
	}
	if(oprcode=="01")
	{
		opr_name="开通";
	}else if(oprcode=="02")
	{	opr_name="注销";
	}
	cust_info+="手机号码：   "+"<%=phone_no%>"+"|";
	cust_info+="客户姓名：   "+"<%=cust_name%>"+"|";
	cust_info+="客户地址：   "+"<%=cust_address%>"+"|";
	cust_info+="证件号码：   "+"<%=id_iccid%>"+"|";
	
	opr_info+="业务类型：视频共享"+opr_name+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
}
function doProcess(packet)
{
	var code=packet.data.findValueByName("code");
	var msg=packet.data.findValueByName("msg");
	//alert(code);
	//alert(msg);
	if(code!="000009")
	{
		rdShowMessageDialog(code+","+msg);
		window.location.reload("s1849.jsp?phone_no=<%=phone_no%>&op_code=1849");
	}
	else 
	{
		rdShowMessageDialog("000000,"+msg);
		parent.removeTab('<%=opCode%>');
	}
	
	
}
</script>
</head>

<body >
<form name="frm">
	<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
	<div id="title_zi">视频共享</div>
	</div>
	<tr>
      <td>
		<table  cellspacing="2">
			<tr> 
				<td width="10%"nowrap> 手机号码</td>
			  	<td  nowrap>&nbsp;<%=phone_no%></td>
			</tr>
		   	<tr > 
		    	<td width="10%"  nowrap> 客户名称</td>
			  	<td  nowrap>&nbsp;
			  	<%if(cust_name.equals("unknow")){out.print("姓名未登记");}else{out.print(cust_name);}%>
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
		      	<td width="10%"  nowrap> 当前状态</td>
			  	<td  nowrap>
			  	&nbsp;手机号码状态为<font color="#880000"><%=run_name%></font>,
			  	<%
			  	if(is_open.equals("00")){out.print("您还没有办理过该业务");}
        		if(is_open.equals("01")){out.print("您已经办理该业务，业务状态为正常");}
			  	%>
			  	</td>
		   </tr>
		   <tr> 
		   		<td width="10%"  nowrap> 办理类型</td>
			  	<td  nowrap>
			    	<input type="radio" name="Td_code" id="kt" value="01" >开通服务&nbsp;
					<input type="radio" name="Td_code" id="zx" value="02" >注销服务&nbsp;
			  	</td>
		   </tr>
		   <!--
		  	<tr> 
		      	<td width="10%"  nowrap> 生效时间</td>
			  	<td  nowrap>
			    	<input type="text" name="effetiTime" id="effetiTime" v_type="date" v_format = "yyyyMMdd" v_name="生效时间" size="20" onblur="if(checkElement(this)){return false;}" maxlength="8"/>
			  	</td>
		   	</tr>
		   	<tr> 
		      	<td width="12%"  nowrap> 新密码</td>
			  	<td  nowrap>
			    	<input type="password" name="newPwd" size="21" id="newPwd"/>
			  	</td>
		   	</tr>
		  	<tr > 
		      	<td width="10%"  nowrap> SP企业代码</td>
			  	<td nowrap>
			    	<input type="text" name="spId" id="spId"/>
			  	</td>
		   </tr>
		   
		    <tr > 
		      <td width="10%"  nowrap> 套餐编码</td>
			  <td  nowrap>
			    <input type="text" name="packNumb" id="packNumb"/>
			  </td>
		   </tr>
		  
		  <tr > 
		      <td width="10%"  nowrap> SP业务代码</td>
			  <td  nowrap>
			    <input type="text" name="bizCode" id="bizCode"/>
			  </td>
		   </tr>
-->
			<input type="hidden" name="login_accept" value="<%=printAccept%>">
		   <tr height="26"> 
		      <td width="10%"  nowrap align="center" colspan="2"> 
			    <input type="button" class="b_foot" value="确认&打印" name="confirm" onclick = "doCfm();">
			    <input type="button" class="b_foot" value="返回" name="close" onclick="history.go(-1)">
              </td>
		   </tr>
		</table>
     <%@ include file="/npage/include/footer.jsp" %>   
</form>

<br><br>
</body>
</html>
