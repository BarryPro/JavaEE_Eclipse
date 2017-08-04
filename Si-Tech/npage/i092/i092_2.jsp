<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "i092";
		String opName = "强制预拆";
 
		String[] inParas2 = new String[1];
		inParas2[0]="select region_code,region_name from sregioncode order by region_code asc";

		 String sqlStr1 = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
		String sqlStr = "select region_code||district_code,district_name from sdiscode where use_flag='Y' and district_code!='99' order by district_code";
 
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
<wtc:array id="ret_val" scope="end" />

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String case_options = "";
   String mode_options ="<option value=0>--请选择--</option>";
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
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }

   function docheck3()
   {
	   var region_code =  document.all.s_in_ModeTypeCode[document.all.s_in_ModeTypeCode.selectedIndex].value;
	   
	   var dis_code =  document.all.s_in_CaseTypeCode[document.all.s_in_CaseTypeCode.selectedIndex].value;
	  // alert("dis_code is "+dis_code+"dis_code.substr(2,2) is " +dis_code.substr(2,2)+" and dis_code.length is "+dis_code.length);
	   if(region_code=="0")
	   {
		   rdShowMessageDialog("请选择查询地市");
		   return false;
	   }
	   else
	   {
		    if(dis_code.length==2)
		    {
				document.frm.action = "i092_2_qry.jsp?s_region_code="+region_code+"&s_dis_code="+dis_code;
				document.frm.submit();
				//查询按钮置为不可用状态
				document.all.query.disabled=true;
			}
			else
		    {
				document.frm.action = "i092_2_qry.jsp?s_region_code="+region_code+"&s_dis_code="+dis_code.substr(2,2);
				//alert(document.frm.action);
				document.frm.submit();
				//查询按钮置为不可用状态
				document.all.query.disabled=true;
			}	
			
	   }	
	   	
	   
   }
 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
    function getCase(control,controlToPopulate)
	{
		for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
	    
		/*myEle = document.createElement("option") ;
		myEle.value = "00";
			myEle.text = control.options[control.selectedIndex].text;
			controlToPopulate.add(myEle) ;
			*/
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
	
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >按手机号码查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2" checked>按地市查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    

	<tr>
    	<td align="left" class="blue" width="15%">地&nbsp;&nbsp;市&nbsp;&nbsp;名&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;
        <select name="s_in_ModeTypeCode" onchange="getCase(this,s_in_CaseTypeCode)">
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
	  <input type="button" name="query" class="b_foot" value="查询" onclick="docheck3()" >
       
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