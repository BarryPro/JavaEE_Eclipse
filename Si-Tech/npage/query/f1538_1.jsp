<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�����û����Ѳ�ѯ</TITLE>
    <%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
    String opCode = "1538";   
    String opName = "�����û����Ѳ�ѯ";
    
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }        
                                              
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function doCheck2()
{
if( document.frm1527.phoneNo.value.length<11) 
	{	
		rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		document.frm1527.phoneNo.select();
		return false;
	} 
else {
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
	var str=window.showModalDialog('../s1300/getCountdead.jsp?phoneNo='+document.frm1527.phoneNo.value,"",prop);
	  
	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0){
	   		rdShowMessageDialog("�˺���û���ҵ���Ӧ���ʺţ�");
	   		document.frm1527.phoneNo.focus();
	   		return false;
	   	} else {
	   		document.frm1527.contractNo.value = str;
		//	document.frm1527.Button2.focus();
		}
	
	}
	return true;
}
}

function doCheck()
{	
	var decmonth = document.frm1527.endTime.value.substring(2,6)
				  	- document.frm1527.beginTime.value.substring(2,6);
	if( document.frm1527.phoneNo.value.length<11) 
	{	rdShowMessageDialog("��������ȷ�Ĳ�ѯ������");
		document.frm1527.phoneNo.select();
		return false;
	} else	if ( document.frm1527.contractNo.value.length < 6 ) {
		doCheck2();
		document.frm1527.contractNo.select();
		return false;
	} else 
	{
		if ( document.frm1527.beginTime.value >= '200201'
				&& (  ( 0 <= decmonth && decmonth<= 5 ) || ( 89 <= decmonth && decmonth<= 93 ) )
			)
		{
			document.frm1527.action="f1528_2.jsp";
			frm1527.submit();
		}	else	
		{
			rdShowMessageDialog("ֻ�ܲ�ѯ��ʼʱ��ͽ���ʱ��Ϊ�������ڣ���ʱ�����2002��1�µ����ݣ�");
			return false;
		}
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�����û����Ѳ�ѯ</div>
</div>
<input type="hidden" name="opCode"  value="1538">
<input type="hidden" name="userType"  value="2">


	<TABLE cellSpacing=0>
        <TR > 
          <TD class=blue>�������</TD>
          <TD ><input type="text" name="phoneNo" size="20" maxlength="11" onKeyDown="if(event.keyCode==13){ doCheck2();doCheck();return false;}">
             <input type="button" class="b_text" name="Button1" value="��ѯ�ʺ�" onclick="doCheck2()">
          </TD>
          <TD class=blue>�ʻ���</TD>
          <TD ><input type="text" name="contractNo" size="20" maxlength="20"></TD>  
        </TR>
        <TR > 
          <TD class=blue>��ʼʱ��</TD>
          <TD ><input v_type=int type="text" name="beginTime" size="20" maxlength="6" value=<%=mon[3]%>></TD>
          <TD class=blue>����ʱ��</TD>
          <TD ><input v_type=int type="text" name="endTime" size="20" maxlength="6" value=<%=dateStr.substring(0,6)%>></TD>
        </TR>

  <tr id="footer" > 
    <td colspan=4>
      <input class="b_foot" name=Button2  type="button" onClick="if(check(frm1527)) doCheck()" value="  �� ѯ  ">
      <input class="b_foot" name=reset  type=reset onClick="" value="  �� ��  ">
      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  �� ��  ">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->

