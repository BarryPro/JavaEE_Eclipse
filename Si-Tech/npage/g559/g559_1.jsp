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
		String opCode = "g559";
		String opName = "�°���ͨ��Ʊ���ô汨��";
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
   String mode_options ="<option value=>--��ѡ��--</option>";
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
var modetypecode = new Array();//ģ�����
  var modetypename = new Array();//ģ������
  var casetypecode = new Array();//������ʹ���
  var casetypename = new Array();//�����������
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
        myEle.text = "--��ѡ��--";
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
	     rdShowMessageDialog("��������ʼ�·�!");
	     document.frm.fromMonth.value = "";
	     document.frm.fromMonth.focus();
	     return false;
	  }
	  
	  if(document.frm.toMonth.value=="")  {
	     rdShowMessageDialog("����������·�!");
	     document.frm.toMonth.value = "";
	     document.frm.toMonth.focus();
	     return false;
	  }
	  
	  document.frm.from.value=document.frm.fromMonth.value
	  document.frm.to.value=document.frm.toMonth.value
  }
	
  if(document.frm.s_in_ModeTypeCode.value =="")  {
	     rdShowMessageDialog("��ѡ���������!");
	     document.frm.s_in_ModeTypeCode.value = "";
	     document.frm.s_in_ModeTypeCode.focus();
	     return false;
  }
  if(document.frm.s_in_CaseTypeCode.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.s_in_CaseTypeCode.value = "";
     document.frm.s_in_CaseTypeCode.focus();
     return false;
  }
     document.frm.action="e673_3Txt.jsp";
 	 document.frm.submit();
	        
}

function commit2(){
	
  if(document.frm.shrName.value =="")  {
	     rdShowMessageDialog("���������������!");
	     document.frm.shrName.value = "";
	     document.frm.shrName.focus();
	     return false;
  }
  if(document.frm.jsrName.value =="")  {
	     rdShowMessageDialog("�����뾭��������!");
	     document.frm.jsrName.value = "";
	     document.frm.jsrName.focus();
	     return false;
  }
  if(document.frm.zbrName.value =="")  {
	     rdShowMessageDialog("�������Ʊ�������!");
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
	     rdShowMessageDialog("��ѡ���������!");
	     document.frm.s_in_ModeTypeCode.value = "";
	     document.frm.s_in_ModeTypeCode.focus();
	     return false;
  }

  //document.frm.s_in_CaseTypeCode.value
  if(document.frm.s_in_CaseTypeCode.value==0)
  {
	 // alert("��ѯ������");
  }
  else
  {
	  //alert("��ѯ���ص�"+document.frm.s_in_CaseTypeCode.value+" and ���� "+document.frm.s_in_ModeTypeCode.value);	
  }
		if(document.frm.toMonth.value =="0")  {
	     rdShowMessageDialog("��ѡ���·�!");
	     document.frm.toMonth.value = "0";
	     document.frm.toMonth.focus();
	     return false;
  }	
		if(document.frm.fromMonth.value=="")  {
	     rdShowMessageDialog("�������ѯ���!");
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
 
<title>������BOSS-��Ʊͳ����Ϣ</title>
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
 
          <input name="busyType2" type="radio" onClick="sel3()" value="1" checked>���ô������
         
    </tr>
  </table>
  
  
  <table cellspacing="0">
  
     <tr id="selectMonth" style="display:block;">
    	<td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td> 
        <input class="button"type="text" name="fromMonth" value="" size="20" maxlength="4"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
      </td>  
      <td align="right" class="blue" width="15%">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;</td>
      <td>         
        <select name="toMonth" >
          	<option value="0">--��ѡ��--</option>   
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
    	<td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp;</td>
       <td> <select name="s_in_ModeTypeCode" onchange="getCase(this,s_in_CaseTypeCode)">
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="right" class="blue" width="15%">��������&nbsp;&nbsp;&nbsp; </td>
       <td> <select name="s_in_CaseTypeCode" >
          	<option value="">--��ѡ��--</option>                   
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
          <input type="button" name="query" class="b_foot" value="����txt" onclick="commit()" >
	  -->
          &nbsp;
		  <input type="button" name="cx" class="b_foot" value="��ѯ" onclick="doQuery()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
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

