<%
/********************
 version v2.0
 ������: si-tech
 *
 *update:zhanghonga@2008-09-06 ҳ�����,�޸���ʽ
 *
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		
    String opCode = "7038";
    String opName = "�������";
    
		String workno = (String)session.getAttribute("workNo");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1= new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<HTML><HEAD>
<script language="JavaScript">
<!--
	onload=function(){
		
	}

 function printtypechange() {
	if (document.mainForm.print_type.value == 1) {
	   IList1.style.display = "";
	   IList2.style.display = "none";
	} 
	else if (document.mainForm.print_type.value == 2) {
	   IList1.style.display = "none";
	   IList2.style.display = "";
	}
}

 function docheck() {
 	
 	 if(!forDate(document.mainForm.begin_date)){
 	 		return false;
 	 }
 	 
 	 if(!forDate(document.mainForm.end_date)){
 	 		return false;	
 	 }

   if (document.mainForm.begin_date.value.length !=8) {
      rdShowMessageDialog("��ʼʱ������������������룡")
      document.mainForm.year_month_end.focus();
      return false;
   }

   if (document.mainForm.end_date.value.length !=8) {
      rdShowMessageDialog("����ʱ������������������룡")
      document.mainForm.year_month_end.focus();
      return false;
   }
  //if (document.mainForm.begin_date.value.substr(0,6) != document.mainForm.end_date.value.substr(0,6)) {
     // rdShowMessageDialog("���ܿ���Ȼ�£����������룡")
     // document.mainForm.year_month_end.focus();
     // return false;
   //}
  
   if (document.mainForm.work_no.value.length != 6) {
      rdShowMessageDialog("��������������������룡")
      document.mainForm.begin_ym.focus();
      return false;
   }
   
   return true;
 }
		function docheck1() {
			if(!docheck()){
				return false;	
			};
			var phone_no = $.trim($("#phone_no").val());
			var login_accept = $.trim($("#login_accept").val());
			if(phone_no.length == 0 && login_accept.length == 0){
				rdShowMessageDialog("�ֻ������ҵ����ˮ��������һ�");
				return false;
			}
			
			document.mainForm.sel_type.value="1";
			document.mainForm.opCode.value="7038";
			document.mainForm.action="f7038show.jsp";
		  document.mainForm.submit();
		}
		
	function doClear(){
		document.all.begin_date.value="";
		document.all.end_date.value="";	
	}
		

-->
 </script>

<title>�����ӡ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<FORM action="" method="post" name="mainForm">
	<input type="hidden" name="sel_type"  value="">
	<input type="hidden" name="opCode"  value="">
	<input type="hidden" name="activePhone" value="<%=activePhone%>">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">�����ӡ</div>
			</div>
       <table cellspacing="0">
				<tr>
					<td class="blue">�������</td>
					<td>
						<input type="text" value=""  name="phone_no" id="phone_no" size="20" maxlength="11" >
					</td>
          <td class="blue">ҵ����ˮ</td>
					<td>
						<input type="text" value=""  name="login_accept" id="login_accept" size="20"  >
					</td>
        </tr>
        <tr>
          <td class="blue">����</td>
          <td colspan="3">
            <input type="text" value="<%=workno%>" class="InputGrey" name="work_no" size="20" maxlength="11" readonly>
          </td>
        </tr>
				 <tr>
            <td class="blue">��ʼ����</td>
            <td>
              <input type="text" value="<%=dateStr%>" v_format="yyyyMMdd" name="begin_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)docheck1()">
							<font class="orange"> * YYYYMMDD</font>
            </td>
            <td class="blue">��������</td>
            <td>
				     	<input type="text" value="<%=dateStr%>" v_format="yyyyMMdd" name="end_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13)docheck1()">
					 		<font class="orange"> * YYYYMMDD</font>
            </td>
 				</tr>
        </table>
        <TABLE cellSpacing="0">
          <TR >
            <TD id="footer">
              <div align="center">
                <input class="b_foot" type="button" name="query1"  value="��ѯ" onclick="docheck1()"  >
                &nbsp;
                <input class="b_foot" type="button" name="return1" value="���" onclick="doClear()" >
                &nbsp;
                <input class="b_foot" type="button" name="return2" value="�ر�" onClick="parent.removeTab('<%=opCode%>')"  >
              </div>
            </TD>
          </TR>
        </TABLE>
     <%@ include file="/npage/include/footer_simple.jsp" %>
		</FORM>
</BODY>
</HTML>
