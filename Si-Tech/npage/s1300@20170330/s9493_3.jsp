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
		String opCode = "9493";
		String opName = "��Ʊ��Ϣ��ѯ";

%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.InvoiceNumber.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.InvoiceNumber.value = "";
     document.frm.InvoiceNumber.focus();
     return false;
  }
  
  if(document.frm.InvoiceNumber.value.length < 8)  {
     rdShowMessageDialog("��Ʊ���볤�Ȳ���!");
     document.frm.InvoiceNumber.value = "";
     document.frm.InvoiceNumber.focus();
     return false;
  }
	
  if(document.frm.InvoiceCode.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.InvoiceCode.value = "";
     document.frm.InvoiceCode.focus();
     return false;
  }
  
  if(document.frm.InvoiceCode.value.length < 12)  {
     rdShowMessageDialog("��Ʊ���볤�Ȳ���!");
     document.frm.InvoiceCode.value = "";
     document.frm.InvoiceCode.focus();
     return false;
  }
  /*
  if(document.frm.print_time.value=="")  {
     rdShowMessageDialog("�������ӡ��!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  } 
  
  
  if(document.frm.print_time.value.length !=4 )  {
     rdShowMessageDialog("��ӡ�곤�Ȳ���!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  }*/   
  
  //��ȡ��ӡ��
  var yearSel= document.getElementById("year_id");

	document.frm.submit();
	            
}

 function sel1() {
 		 
		window.location.href='s9493.jsp';
 }

 function sel2(){
 
	window.location.href='s9493_3.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
 function sel6(){
    window.location.href='s9493_6.jsp';
 }

 function doclear() {
 		frm.reset();
 }


 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form action="s9493_query1.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊ��Ϣ��ѯ��¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >����ˮ��ѯ 
          <input name="busyType21" type="radio" onClick="sel2()" value="2" checked> ����Ʊ�����ѯ 
          <input name="busyType22" type="radio" onClick="sel3()" value="3"> ¼�뷢Ʊ����ͷ�Ʊ���� 
          <input name="busyType23" type="radio" onClick="sel6()" value="4"> ӪҵԱ��Ʊɾ��
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="InvoiceNumber" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="InvoiceCode" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��ӡ��:&nbsp;&nbsp;&nbsp;
       <%
	   String year_sql = "select to_char(sysdate,'YYYY') from dual";
	   %>
	   <wtc:pubselect name="TlsPubSelBoss"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:sql><%=year_sql%></wtc:sql>
		</wtc:pubselect>
		
		<wtc:array id="result0"  scope="end" />
	   <select id=year_id name=year_name   maxlength="4">
				 
				<%
					if(result0.length > 0){
						%>
						<option value = "<%=result0[0][0]%>" selected><%=result0[0][0]%></option>
						<% 
						for(int k =1;k<6;k++)
						{%>
							<option value="<%=Integer.parseInt(result0[0][0])-k%>"><%=Integer.parseInt(result0[0][0])-k%></option>
						<%}
						
					}
					else{
						 %>
						 <script language="javascript">
							rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ�����������ϢΪ��!");
							history.go(-1); 
					</script>
						 <%
						
					}	
						%>
			</select>
		
      </td>
      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="��ѯ" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

