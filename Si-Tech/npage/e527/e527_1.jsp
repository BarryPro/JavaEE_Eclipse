<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String[] inParas2 = new String[2];
		String opCode = "e527";
		String opName = "ϵͳ��ֵʧ�����ݲ�ѯ";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
 
		String sql_region="select region_code,region_name from sregioncode ";
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_region%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

function doProcess(packet){
 
}

 

 

function docheck()
{
	
	/*
	if(document.frm.phoneNo.value=="")
    {
	    rdShowMessageDialog("������������!");
		document.frm.phoneNo.focus();
		return false;
    }
    if((document.frm.beginYm.value==""&&document.frm.endYm.value!="") ||(document.frm.beginYm.value!=""&&document.frm.endYm.value=="") )
    {
	    rdShowMessageDialog("�����뿪ʼ�ͽ�������!");
		document.frm.beginYm.focus();
		return false;
    }
	var tt = document.all.cityId.options[document.all.cityId.selectedIndex].text;
 
	if(tt.value=="")
    {
	    rdShowMessageDialog("������������!");
		document..all.cityId.focus();
		return false;
    }*/
    if(document.frm.phoneNo.value==""&&(document.frm.beginYm.value==""&&document.frm.endYm.value=="") &&document.frm.cityId.options[document.frm.cityId.selectedIndex].value=="0")
	{
		rdShowMessageDialog("�ֻ����롢��ѯ��ʼ���������º͵��б�ѡ��һ!");
		return false;
	}
	else if((document.frm.beginYm.value==""&&document.frm.endYm.value!="")||(document.frm.beginYm.value!=""&&document.frm.endYm.value==""))
	{
		rdShowMessageDialog("��ѯ��ʼ���ºͽ������²���Ϊ��!");
		return false;
	}
	else
	{
		//	alert("document.frm.phoneNo.value is "+document.frm.cityId.options[document.frm.cityId.selectedIndex].value); 
		document.frm.action="e527_2.jsp?phoneNo="+document.frm.phoneNo.value+"&beginYm="+document.frm.beginYm.value+"&endYm="+document.frm.endYm.value+"&cityId="+document.frm.cityId.options[document.frm.cityId.selectedIndex].value;
		document.frm.submit();
	}

} 

 

 function doclear() {
 		frm.reset();
 }

 
-->
	   
 </script> 
 
<title>������BOSS-��ѯ</title>
</head>
<BODY> 
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>

    <table cellspacing="0">
      <tbody> 
	  <!--������tr id������
	  <tr class="blue" style="display:none" id="sptime3">
	  -->
   
	   
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)">
      </td>
	  </tr>
	  
	  <tr>
	  <td class="blue">����</td>
      <td> 
        <select name="cityId" style= "width:135px;">
			<option value="0" selected></option>
				<%for(int i=0; i<ret_val.length; i++)
					{%>
						<option value="<%=ret_val[i][0]%>"><%=ret_val[i][1]%></option>
				  <%}%>
		</select>
      </td>

    </tr>
	<tr>
      <td class="blue" colspan=2>��ʼ����&nbsp;&nbsp;&nbsp;<input type="text" name="beginYm" size="6"  maxlength="6"   > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <font class="blue">��ֹ����</font>&nbsp;&nbsp;&nbsp;<input type="text" name="endYm" size="6" maxlength="6"   >
      </td>
	</tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
          <input type="reset" name="return1" class="b_foot" value="���"   >
          &nbsp;
         <!--
		  <input type="button" name="reprint"  class="b_foot" value="�ش�Ʊ" onclick="doreprint()">
		  -->
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