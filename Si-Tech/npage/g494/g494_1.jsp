<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "g494";
		String opName = "新版铁通发票信息";
		String login_no = (String)session.getAttribute("workNo");
	    String sqlStr1 = "SELECT group_id,group_name from schnregionlist ORDER BY group_id";
%>
<wtc:pubselect name="TlsPubSelCrm" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String mode_options ="<option value=>--请选择--</option>";
      for(int i=0;i<return_result1.length;i++)
   {
     mode_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.s_Invoice_number.value=="")  {
     rdShowMessageDialog("请输入起始发票号码!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.s_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("起始发票号码长度不够!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
	
	if(document.frm.e_Invoice_number.value=="")  {
     rdShowMessageDialog("请输入终止发票号码!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.e_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("终止发票号码长度不够!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value.length < 12)  {
     rdShowMessageDialog("发票代码长度不够!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  if(document.frm.s_in_ModeTypeCode.value =="")  {
     rdShowMessageDialog("请选择地市名称!");
     document.frm.s_in_ModeTypeCode.value = "";
     document.frm.s_in_ModeTypeCode.focus();
     return false;
  }
  if(document.frm.s_in_CaseTypeCode.value =="")  {
     rdShowMessageDialog("请选择区县名称!");
     document.frm.s_in_CaseTypeCode.value = "";
     document.frm.s_in_CaseTypeCode.focus();
     return false;
  }
  
	document.frm.submit();
	            
}

 function sel1() {
 		 
		window.location.href='g494_1.jsp';
 }

 function sel2(){
 
	window.location.href='e900_2.jsp';
 }
 
 function sel3(){
    window.location.href='e900_3.jsp';
 }
function sel4(){
    window.location.href='e900_4.jsp';
 }
 //营业厅级别
function sel5(){
    window.location.href='g494_5.jsp';
 }
function sel6(){
    window.location.href='e900_6.jsp';
}
 
function sel7(){
    window.location.href='e900_7.jsp';
}
 function doclear() {
 		frm.reset();
 }

function select_change()
{
	var region_code = document.all.s_in_ModeTypeCode[document.all.s_in_ModeTypeCode.selectedIndex].value;
	var myPacket = new AJAXPacket("../e900/e900_select.jsp","正在获得区县信息，请稍候......");
	var sqlStr = "29";
				  
	var param1 = "region_code="+region_code;
	myPacket.data.add("sqlStr",sqlStr);			  
	myPacket.data.add("param1",param1);
	myPacket.data.add("flag",1);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function doProcess(packet)
{	 
    var triListdata = packet.data.findValueByName("tri_list");   
    var flag = packet.data.findValueByName("flag");  
	document.all("s_in_CaseTypeCode").length=0;
	document.all("s_in_CaseTypeCode").options.length=triListdata.length+1;//triListdata[i].length;
	document.all("s_in_CaseTypeCode").options[0].text=document.all("s_in_ModeTypeCode").options[document.all("s_in_ModeTypeCode").selectedIndex].text;
	document.all("s_in_CaseTypeCode").options[0].value="00";
	for(j=0;j<triListdata.length;j++)
	{
		document.all("s_in_CaseTypeCode").options[j+1].text=triListdata[j][1];
		document.all("s_in_CaseTypeCode").options[j+1].value=triListdata[j][0];
	}//营业厅结果集
	document.all("s_in_CaseTypeCode").options[0].selected=true;
		  
}
 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form action="g494_Cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">铁通发票信息</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" checked>地市、区县领票 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
		  <!--
          <input name="busyType2" type="radio" onClick="sel2()" value="1">发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">领用存情况表 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表          
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
		  <input name="busyType2" type="radio" onClick="sel7()" value="1">查询
		  -->
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">起始发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="s_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">终止发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="e_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">发票代码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="12" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>      
    </tr>
    
    <tr>
    	<td align="left" class="blue" width="15%">地&nbsp;&nbsp;市&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="s_in_ModeTypeCode" onchange="select_change()">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">区&nbsp;&nbsp;县&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="s_in_CaseTypeCode" >
          	<option value="">--请选择--</option>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="确认" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

