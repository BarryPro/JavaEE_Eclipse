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
		String opCode = "g559";
		String opName = "新版铁通发票领用存报表";
		boolean flag = false;	
		String return_page = "g559_1.jsp";

		String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
		String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		if(s_in_CaseTypeCode == null) s_in_CaseTypeCode = "";
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
	  if(s_in_CaseTypeCode.length()==4)
	  {
	     inParas[3]  = s_in_CaseTypeCode.substring(2);
	  }
	  inParas[4]  = workno;
	  
System.out.println("s_in_ModeTypeCode:"+s_in_ModeTypeCode);

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
     document.frm.action="e673_3Txt.jsp";
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
     document.frm.action="e673_3Cfm.jsp";
 	 document.frm.submit();
	        
}
 function sel1() {
 		 
		window.location.href='e673.jsp';
 }

 function sel2(){
 
	window.location.href='e673_2.jsp';
 }

function sel3(){
 
	window.location.href='g559_1.jsp';
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

	function doQuery()
	{
		if(document.frm.s_in_ModeTypeCode.value =="")  {
	     rdShowMessageDialog("请选择地市名称!");
	     document.frm.s_in_ModeTypeCode.value = "";
	     document.frm.s_in_ModeTypeCode.focus();
	     return false;
  }

  //document.frm.s_in_CaseTypeCode.value
  if(document.frm.s_in_CaseTypeCode.value==0)
  {
	 // alert("查询市区的");
  }
  else
  {
	  //alert("查询区县的"+document.frm.s_in_CaseTypeCode.value+" and 地市 "+document.frm.s_in_ModeTypeCode.value);	
  }
		if(document.frm.toMonth.value =="0")  {
	     rdShowMessageDialog("请选择月份!");
	     document.frm.toMonth.value = "0";
	     document.frm.toMonth.focus();
	     return false;
  }	
		if(document.frm.fromMonth.value=="")  {
	     rdShowMessageDialog("请输入查询年份!");
	     document.frm.fromMonth.value = "";
	     document.frm.fromMonth.focus();
	     return false;
	  }
	  //alert(document.frm.fromMonth.value);
	  //document.frm.toMonth.value==""

		
		document.frm.action="g559_2.jsp";
		document.frm.submit(); 
	}
 </script> 
 
<title>黑龙江BOSS-发票统计信息</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票统计信息和录入</div>
		</div>
<input name="temp" type="hidden" value="1">
<input name="from" type="hidden">
<input name="to" type="hidden">
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
    	<td>
 
          <input name="busyType2" type="radio" onClick="sel3()" value="1" checked>领用存情况表
         
    </tr>
  </table>
  
  
  <table cellspacing="0">
  
     <tr id="selectMonth" style="display:block;">
    	<td align="right" class="blue" width="15%">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="fromMonth" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;&nbsp;</td>
      <td>         
        <select name="toMonth" >
          	<option value="0">--请选择--</option>   
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
       <td> <select name="s_in_ModeTypeCode" onchange="getCase(this,s_in_CaseTypeCode)">
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
	  <!--
          &nbsp;
          <input type="button" name="query" class="b_foot" value="导出txt" onclick="commit()" >
	  -->
          &nbsp;
		  <input type="button" name="cx" class="b_foot" value="查询" onclick="doQuery()" >
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

