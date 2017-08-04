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
		String org_code = (String)session.getAttribute("orgCode");
		String opCode = "e900";
		String opName = "铁通发票信息";
		boolean flag = false;	
		String return_page = "e900_3.jsp";

		String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String workno = (String)session.getAttribute("workNo");
		
			
		
		if(from == null)
		{
		    from = "";
		    flag = false;
		}
		  else
		  {
		      flag = true;
		  }	

      String return_code="";
	  String ret_msg="";
	  String [] inParas = new String[5];
	  inParas[0]  = from;
	  inParas[1]  = to;
	  inParas[2]  = s_in_ModeTypeCode;
	  inParas[3]  = s_in_CaseTypeCode;
	  inParas[4]  = workno;	 

	  String sqlStr1 = "SELECT group_id,group_name from schnregionlist ORDER BY group_id";
%>

<wtc:pubselect name="TlsPubSelCrm" outnum="2" retmsg="retMsg" retcode="retCode">
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
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">

function commit(){
	
  if(document.frm.temp.value=="1")  {
  	
	  if(document.frm.year.value=="")  {
	     rdShowMessageDialog("请输入年份!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	  }
	  
	  if(document.frm.jd.value=="")  {
	     rdShowMessageDialog("请输入季度!");
	     document.frm.jd.value = "";
	     document.frm.jd.focus();
	     return false;
	  }
	  document.frm.from.value=document.frm.year.value
	  document.frm.to.value=document.frm.jd.value
  }
  
  if(document.frm.temp.value=="2")  {
  	
	  if(document.frm.fromMonth.value=="")  {
	     rdShowMessageDialog("请输入起始月份!");
	     document.frm.fromMonth.value = "";
	     document.frm.fromMonth.focus();
	     return false;
	  }
	  
	  if(document.frm.toMonth.value=="")  {
	     rdShowMessageDialog("请输入结束月份!");
	     document.frm.toMonth.value = "";
	     document.frm.toMonth.focus();
	     return false;
	  }
	  
	  document.frm.from.value=document.frm.fromMonth.value
	  document.frm.to.value=document.frm.toMonth.value
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
  
  document.frm.action="e900_3Txt.jsp";
  document.frm.submit();
	        
}

function commit2(){
	
  if(document.frm.shrName.value =="")  {
	     rdShowMessageDialog("请输入审核人姓名!");
	     document.frm.shrName.value = "";
	     document.frm.shrName.focus();
	     return false;
  }
  if(document.frm.jsrName.value =="")  {
	     rdShowMessageDialog("请输入经手人姓名!");
	     document.frm.jsrName.value = "";
	     document.frm.jsrName.focus();
	     return false;
  }
  if(document.frm.zbrName.value =="")  {
	     rdShowMessageDialog("请输入制表人姓名!");
	     document.frm.zbrName.value = "";
	     document.frm.zbrName.focus();
	     return false;
  }
     document.frm.action="e900_3Cfm.jsp";
 	 document.frm.submit();
	        
}
	


 function sel1() {
 		 
		window.location.href='e900.jsp';
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
 function sel5(){
    window.location.href='e900_5.jsp';
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
	var myPacket = new AJAXPacket("e900_select.jsp","正在获得区县信息，请稍候......");
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
	document.all("s_in_CaseTypeCode").options[0].text="--请选择--";
	document.all("s_in_CaseTypeCode").options[0].value="00";
	for(j=0;j<triListdata.length;j++)
	{
		document.all("s_in_CaseTypeCode").options[j+1].text=triListdata[j][1];
		document.all("s_in_CaseTypeCode").options[j+1].value=triListdata[j][0];
	}//营业厅结果集
	document.all("s_in_CaseTypeCode").options[0].selected=true;
		  
}

function selt1(){
	document.getElementById("selectJd").style.display = (document.getElementById("selectJd").style.display=="")?"none":"";
    document.getElementById("selectMonth").style.display = (document.getElementById("selectMonth").style.display=="")?"none":"";  
    document.frm.temp.value = "1";
}
function selt2(){
	document.getElementById("selectJd").style.display = (document.getElementById("selectJd").style.display=="")?"none":"";
    document.getElementById("selectMonth").style.display = (document.getElementById("selectMonth").style.display=="")?"none":"";
    document.frm.temp.value = "2";
}
 </script> 
 
<title>黑龙江BOSS-手机支付缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">铁通发票信息</div>
		</div>
<input name="temp" type="hidden" value="1">
<input name="from" type="hidden">
<input name="to" type="hidden">
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
    	<td>
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >地市、区县领票 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
          <input name="busyType2" type="radio" onClick="sel2()" value="1" >发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1" checked>领用存情况表
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
          <input name="busyType2" type="radio" onClick="sel7()" value="1">查询
         </td> 
    </tr>
  </table>
  <table cellspacing="0">
     <tr>
    	<td class="blue" width="15%">查询时间范围选择</td>
    	<td>
          <input name="busyType3" type="radio" onClick="selt1()" value="1" checked>季度查询 
          <input name="busyType3" type="radio" onClick="selt2()" value="2">月份查询
         </td> 
    </tr>
  </table> 
  <table cellspacing="0">
  	
  	<tr id="selectJd" style="display;">
    	<td align="right" class="blue" width="15%">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="year" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">季&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度&nbsp;&nbsp;</td>
      <td>         
        <select name="jd" >
          	<option value="">--请选择--</option>   
          	<option value="1">第一季度</option> 
          	<option value="2">第二季度</option> 
          	<option value="3">第三季度</option> 
          	<option value="4">第四季度</option>                 
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
     <tr id="selectMonth" style="display:none;">
    	<td align="right" class="blue" width="15%">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="fromMonth" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;&nbsp;</td>
      <td>         
        <select name="toMonth" >
          	<option value="">--请选择--</option>   
          	<option value="01">一月</option> 
          	<option value="02">二月</option> 
          	<option value="03">三月</option> 
          	<option value="04">四月</option>      
          	<option value="05">五月</option> 
          	<option value="06">六月</option> 
          	<option value="07">七月</option> 
          	<option value="08">八月</option>      
          	<option value="09">九月</option> 
          	<option value="10">十月</option> 
          	<option value="11">十一月</option> 
          	<option value="12">十二月</option>            
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
    <tr>
    	<td align="right" class="blue" width="15%">地市名称&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="s_in_ModeTypeCode" onchange="select_change()">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="right" class="blue" width="15%">区县名称&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="s_in_CaseTypeCode" >
          	<option value="">--请选择--</option>                   
          </select><font color="#FF0000">*</font>
      </td>   
      </td>      
    </tr>
  </table>
   <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          <input type="button" name="query" class="b_foot" value="导出txt" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
      

	<br>
    <br>
    
   <div class="title">
			<div id="title_zi">设置审核人，经手人，制表人，请在月末进行设置，月初生成文件会用到此信息，请各区县单独设置</div>
		</div>
  <table cellspacing="0">
  	
     <tr>
    	<td align="right" class="blue" width="15%">审核人&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="shrName" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
	<td align="right" class="blue" width="15%">经手人&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="jsrName" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">制表人&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="zbrName" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
    </tr>
  </table>
   <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          &nbsp;
          <input type="button" name="query" class="b_foot" value="设置" onclick="commit2()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
    </table>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

