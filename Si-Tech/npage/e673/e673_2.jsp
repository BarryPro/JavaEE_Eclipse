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
		String return_page = "e673_2.jsp";
		String opCode = "e673";
		String opName = "发票统计信息";
		boolean flag = false;	
		String workno = (String)session.getAttribute("workNo");
		String invoice_code = request.getParameter("invoice_code");
		String invoice_number = request.getParameter("invoice_number");
		String org_code = (String)session.getAttribute("orgCode");
 		String regionCode = org_code.substring(0,2);
			
		
	   if(invoice_code == null)
	  {
		    invoice_code = "";
		    flag = false;
	  }
	  else
	  {
	      flag = true;
	  }	

      String return_code="";
	  String ret_msg="";
	  String [] inParas = new String[2];
	  inParas[0]  = invoice_code;
	  inParas[1]  = invoice_number;

	  String sqlStr1 = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
	  String sqlStr = "select region_code||district_code,district_name from sdiscode where use_flag='Y' and district_code!='99' order by district_code";
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="retMsg" retcode="retCode">
			<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="retMsg" retcode="retCode">
			<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String case_options = "";
   String mode_options ="<option value=>--请选择--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     case_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     mode_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">
var modetypecode = new Array();//模块代码
  var modetypename = new Array();//模块名称
  var casetypecode = new Array();//申告类型代码
  var casetypename = new Array();//申告类型名称
  <%
  for(int m=0;m<return_result.length;m++)
  {
		out.println("casetypecode["+m+"]='"+return_result[m][0]+"';\n");
		out.println("casetypename["+m+"]='"+return_result[m][1]+"';\n");
  }
  for(int m=0;m<return_result1.length;m++)
  {
		out.println("modetypecode["+m+"]='"+return_result1[m][0]+"';\n");
		out.println("modetypename["+m+"]='"+return_result1[m][1]+"';\n");
  }
  %>
  
function getCase(control,controlToPopulate)
{
	for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
  myEle = document.createElement("option") ;
//    myEle.value = control.value;
//      myEle.value = "00";
//        myEle.text = control.options[control.selectedIndex].text;
         myEle.value = "";
        myEle.text = "--请选择--";
        controlToPopulate.add(myEle) ;
	for ( x = 0 ; x < casetypecode.length  ; x++ )
   {
      if ( casetypecode[x].substr(0,2) == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = casetypecode[x] ;
        myEle.text = casetypename[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
	
}
function commit(){
	
  if(document.frm.invoice_code.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.invoice_code.value = "";
     document.frm.invoice_code.focus();
     return false;
  }
  
  if(document.frm.invoice_number.value=="")  {
     rdShowMessageDialog("请输入发票号码!");
     document.frm.invoice_number.value = "";
     document.frm.invoice_number.focus();
     return false;
  }
  
 	 document.frm.submit();
	        
}

 

function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.focus();
     return false;
  }
  

 if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	       
			var phone_no = document.all.phoneNo.value;
		  var busy_type = "1";  
			var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("phone_no",phone_no);
			checkPwd_Packet.data.add("busy_type",busy_type);
			core.ajax.sendPacket(checkPwd_Packet);
			
			checkPwd_Packet=null;
 
}


 function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("没有此用户的相关资料!");
		return;
	}
 
  commit();
}
 function sel1() {
 		 
		window.location.href='e673.jsp';
 }

 function sel2(){
 
	window.location.href='e673_2.jsp';
 }

function sel3(){
 
	window.location.href='e673_3.jsp';
 }
 function sel4(){
    window.location.href='e673_4.jsp';
 }
 function sel5(){
    window.location.href='e673_5.jsp';
 }
 function sel6(){
    window.location.href='e673_6.jsp';
}
 
function sel7(){
    window.location.href='e673_7.jsp';
}
 function doclear() {
 		frm.reset();
 }
 
 function commit2(){
	
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
  
    if(document.frm.fromMonth.value=="")  {
     rdShowMessageDialog("请输入年份!");
     document.frm.fromMonth.value = "";
     document.frm.fromMonth.focus();
     return false;
  }
  
  if(document.frm.toMonth.value=="")  {
     rdShowMessageDialog("请输入月份!");
     document.frm.toMonth.value = "";
     document.frm.toMonth.focus();
     return false;
  }
 
     document.frm.action="e673_2Cfm.jsp";
 	 document.frm.submit();
	        
}
 </script> 
 
<title>黑龙江BOSS-手机支付缴费</title>
</head>
<BODY>
<form action="e673_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票统计信息和录入</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
    	<td>
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >录入发票号码和发票代码 
          <input name="busyType2" type="radio" onClick="sel2()" value="1" checked>发票使用情况查询 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">领用存情况表
          <input name="busyType2" type="radio" onClick="sel4()" value="1">上期领用存情况表
          <input name="busyType2" type="radio" onClick="sel5()" value="1">营业厅领票
          <input name="busyType2" type="radio" onClick="sel6()" value="1">查询与删除
          <input name="busyType2" type="radio" onClick="sel7()" value="1">查询
         </td> 
    </tr>
  </table>

  
  <table cellspacing="0">    
    <tr>
       <td align="right" class="blue" width="15%">地市名称&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="s_in_ModeTypeCode" onchange="getCase(this,s_in_CaseTypeCode)">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="right" class="blue" width="15%">区县名称&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="s_in_CaseTypeCode" >
          	<option value="">--请选择--</option>                   
          </select><font color="#FF0000">*</font>
      </td>     
    </tr>
    <tr>
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
    	<td align="right" class="blue" width="15%">发票代码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_code" value="" size="20" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
      <td align="right" class="blue" width="15%">发票号码&nbsp;&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="invoice_number" value="" size="20" maxlength="10"  onKeyPress="return isKeyNumberdot(0)" >
      </td>  
    </tr>
  </table>
   <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="查询" onclick="commit()" >
         
          &nbsp;
          <input type="button" name="query" class="b_foot" value="导出txt" onclick="commit2()" >
           &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>

  <br>
      

		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>序号</th>
        <th>开票时间</th>
        <th>发票代码</th>
        <th>发票号码</th>    
        <th>项目内容</th>     
        <th>付款单位</th>
        <th>合计金额</th>
        <th>开票人</th>
        <th>备注</th> 
        <th>收款单位名称</th>    
        <th>收款单位纳税人识别号</th>   
        <th>发票名称</th>
        <th>发票种类</th>
        <th>联次/组数</th>
             
      </tr>
<%
   if(flag){
%>

	<wtc:service name="bs_6732Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="16" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	

   return_code = retCode;
   ret_msg = retMsg;
   if(return_code.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
        <td><%=tempArr[i][7]%></td>
        <td><%=tempArr[i][8]%></td>
        <td><%=tempArr[i][9]%></td>
        <td><%=tempArr[i][10]%></td>
        <td><%=tempArr[i][11]%></td>
        <td><%=tempArr[i][12]%></td>
        <td><%=tempArr[i][13]%></td>
        <td><%=tempArr[i][14]%></td>
        <td><%=tempArr[i][15]%></td>
      </tr>
<%}}

else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("信息查询出错!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%	}

}%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

