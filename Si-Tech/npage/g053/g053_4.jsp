<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "g053";
		String opName = "������Ʊ��Ϣ";
		boolean flag = false;	
		String org_code = (String)session.getAttribute("orgCode");
 	    String regionCode = org_code.substring(0,2);
		String return_page = "g053_4.jsp";
		String region_code = request.getParameter("region_code");
		String bank_code = request.getParameter("bank_code");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String workno = (String)session.getAttribute("workNo");

	    String ret_msg="";
	    String sqlStr = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="retMsg" retcode="retCode">
			<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 
	 	
<%
   String case_options = "";
   String[][] return_result1=new String[1][2];
   return_result1[0][0]="00";
   return_result1[0][1]="������ʡ";
   case_options +="<option value=>--��ѡ��--</option>";
   case_options +="<option value="+return_result1[0][0]+">"+return_result1[0][1]+"</option>";
   for(int i=0;i<return_result.length;i++)
   {
     case_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   String sqlStr1 = "select BANK_CODE,BANK_NAME from QD_BANKCODE order by BANK_CODE";	   
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result9" scope="end"/>	
<%
   String bank_options = "<option value=>--��ѡ��--</option>";
   for(int i=0;i<return_result9.length;i++)
   {
     bank_options += "<option value="+return_result9[i][0]+">"+return_result9[i][1]+"</option>";
   }
%> 	
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">
function commit2(){
	
  if(document.frm.temp.value=="1")  {
  	
	  if(document.frm.year.value=="")  {
	     rdShowMessageDialog("���������!");
	     document.frm.year.value = "";
	     document.frm.year.focus();
	     return false;
	  }
	  
	  if(document.frm.jd.value=="")  {
	     rdShowMessageDialog("�����뼾��!");
	     document.frm.jd.value = "";
	     document.frm.jd.focus();
	     return false;
	  }
	  document.frm.from.value=document.frm.year.value
	  document.frm.to.value=document.frm.jd.value
  }
  
  if(document.frm.temp.value=="2")  {
  	
	  if(document.frm.fromMonth.value=="")  {
	     rdShowMessageDialog("���������!");
	     document.frm.fromMonth.value = "";
	     document.frm.fromMonth.focus();
	     return false;
	  }
	  
	  if(document.frm.toMonth.value=="")  {
	     rdShowMessageDialog("�������·�!");
	     document.frm.toMonth.value = "";
	     document.frm.toMonth.focus();
	     return false;
	  }
	  
	  document.frm.from.value=document.frm.fromMonth.value
	  document.frm.to.value=document.frm.toMonth.value
  }
  
  if(document.frm.bank_code.value =="")  {
	     rdShowMessageDialog("��ѡ����������!");
	     document.frm.bank_code.value = "";
	     document.frm.bank_code.focus();
	     return false;
  }
	
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
  
     document.frm.action="g053_4Cfm.jsp";
 	 document.frm.submit();
	        
}
function sel1() { 		 
		window.location.href='g053.jsp';
}
function sel2(){ 
	window.location.href='g053_2.jsp';
}
function sel3(){
 
	window.location.href='g053_3.jsp';
}
function sel4(){
    window.location.href='g053_4.jsp';
}
function sel5(){
    window.location.href='g053_5.jsp';
}
function sel6(){
    window.location.href='g053_6.jsp';
}
function sel7(){
    window.location.href='g053_7.jsp';
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
 </script> 
 
<title>������BOSS-�ֻ�֧���ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊͳ����Ϣ��¼��</div>
		</div>
<input name="temp" type="hidden" value="1">
<input name="from" type="hidden">
<input name="to" type="hidden">
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
    	<td>
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >������Ʊ
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
          <input name="busyType2" type="radio" onClick="sel2()" value="1" >��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1" >���ô������
          <input name="busyType2" type="radio" onClick="sel4()" value="1" checked>�������ô������          
          <input name="busyType2" type="radio" onClick="sel6()" value="1">��ѯ��ɾ��
          <input name="busyType2" type="radio" onClick="sel7()" value="1">��ѯ
         </td> 
    </tr>
  </table>

  
   <table cellspacing="0">
     <tr>
    	<td class="blue" width="15%">��ѯʱ�䷶Χѡ��</td>
    	<td>
          <input name="busyType3" type="radio" onClick="selt1()" value="1" checked>���Ȳ�ѯ 
          <input name="busyType3" type="radio" onClick="selt2()" value="2">�·ݲ�ѯ
         </td> 
    </tr>
  </table> 
  <table cellspacing="0">
    <tr id="selectJd" style="display;">
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="year" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td>         
        <select name="jd" >
          	<option value="">--��ѡ��--</option>   
          	<option value="1">��һ����</option> 
          	<option value="2">�ڶ�����</option> 
          	<option value="3">��������</option> 
          	<option value="4">���ļ���</option>                 
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
    <tr id="selectMonth" style="display:none;">
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="fromMonth" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td>         
        <select name="toMonth" >
          	<option value="">--��ѡ��--</option>   
          	<option value="01">һ��</option> 
          	<option value="02">����</option> 
          	<option value="03">����</option> 
          	<option value="04">����</option>      
          	<option value="05">����</option> 
          	<option value="06">����</option> 
          	<option value="07">����</option> 
          	<option value="08">����</option>      
          	<option value="09">����</option> 
          	<option value="10">ʮ��</option> 
          	<option value="11">ʮһ��</option> 
          	<option value="12">ʮ����</option>            
          </select><font color="#FF0000">*</font>
      </td>  
    </tr>
  	<tr>
  		<td align="right" class="blue" width="15%">��������:&nbsp;&nbsp;&nbsp;</td>
        <td><select name="bank_code" >
          	<%=bank_options%>                   
          </select><font color="#FF0000">*</font>
      </td>    
      
      <td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="region_code" >
          	<%=case_options%>                 
          </select><font color="#FF0000">*</font>
      </td>           
    </tr>   
  </table>
   <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          <input type="button" name="query" class="b_foot" value="����txt" onclick="commit2()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>

  <br>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

