 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>Ͷ���˷Ѳ�ѯ</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	//String opCode = "4141";		
  	String opCode = "zgaj";		
	String opName = "һ���˷�";	//header.jsp��Ҫ�Ĳ���
	//activePhone = request.getParameter("activePhone");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
	String contextPath = request.getContextPath();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"", "", "", "", "", ""};
	String account="2";
	String loginNo = (String)session.getAttribute("workNo");

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0, 4)),
			(Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
	for (int i = 0; i <= 5; i++) {
		if (i != 5) {
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
			//cal.add(Calendar.MONTH, -1);
		} else
			mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	}
	// ������
	String sql_reason = "select first_code,first_name from SREFUNDCheckType where valid_flag='2' order by first_code desc ";
%>
<script language=javascript>
function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
function sel1()
{
	window.location.href='zgaj_1.jsp';
}
function sel2()
{
	window.location.href='zgaj_cz.jsp';
}
</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

function docomm(subButton)
{
	//ȷ��flag �жϲ���
	var phone_no  = document.all.phone_no.value;
	var tsdzls = document.all.tsdzls.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ֻ�����!");
		return false;
	}
	else if(tsdzls=="")
	{
		rdShowMessageDialog("������Ͷ�ߵ�����ˮ����!");
		return false;
	}
	//ʱ�䲻�ܳ���6����
	var s_begin= document.all.beginTime.value;
	var s_end= document.all.endTime.value;
	var year1 =  s_begin.substr(0,4);  
	var year2 =  s_end.substr(0,4);   
	var month1 = s_begin.substr(4,2);  
	var month2 = s_end.substr(4,2);    
	var len=(year2-year1)*12+(month2-month1);
	//alert("len is "+len);
	if(len>6)
	{
		rdShowMessageDialog("��ѯ�굥ʱ�䷶Χ���ܳ���6����!");
		return false;
	}
	else
	{
		frm.action="zgaj_2.jsp?phone_no="+phone_no+"&tsdzls="+tsdzls;
		frm.submit();
	}
	
} 
 
 

function init()
{
	document.all.kjlx[document.all.kjlx.selectedIndex].value="";
	document.all.jflx[document.all.jflx.selectedIndex].value="";
	document.all.ywsysj.value="";
	document.all.hjsj.value="";
}
</script>

<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />

</head>
<body>
<form name="frm" method="POST" >

	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">һ���˷�</div>
	</div>
	<table cellspacing="0">
		<tbody>
		<tr> 
        <td class="blue" width="16%">�˷ѷ�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
			  <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>�˷� 
			</q>
			<q vType="setNg35Attr">
			  <input name="busyType1" id="busyType1" type="radio" onClick="sel2()" value="2" >���� 
			</q>
		</tr>
		</tbody>
	</table>
	<table>
			<TD class="blue" width=16%>��ѯ����</td>
			<td><input type="text" name="phone_no" id="phone_no"  maxlength=11 size="18">&nbsp;&nbsp;</td>
			<TD class="blue" width=16%>Ͷ�ߵ�����ˮ</td>
			<td><input type="text" name="tsdzls" id="tsdzlsid" maxlength=30 size="30" onKeyPress="return isKeyNumberdot(0)" >&nbsp;&nbsp;</td>
	</tr>
		<!--xl add end ��ѯ����-->
 
		 
			<tr>
			<TD class="blue" width=16%>��ѯ����</TD>
			<td colspan="3"><input type="text" name="beginTime" size="20" maxlength="6" value=<%=mon[1]%>></td>
			<input type="hidden" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
        
			</tr>
            <TD class="blue" width=16%>�˷�ҵ������</TD>
            <TD colspan="3">
                <select name="searchType" >
                    <%
						for(int i=0;i<ret_val.length;i++)
						{
							if(ret_val[i][1].equals("ȫ��")){
									%>
									<option value="<%=ret_val[i][0]%>" selected >
						
						                  <%=ret_val[i][1]%></option>
									<%
								}
							else
							{
								%>
									<option value="<%=ret_val[i][0]%>"><%=ret_val[i][1]%></option>
								<%
							}
							
						}
					%>
                </select>
            </TD>
        </TR>
		</table>
		<table  cellspacing="0" >
			<tr>
				<td id="footer">     
					<input type=button name="confirm"class="b_foot"  value="ȷ��" onClick="docomm()">    
					<input type=button name=back value="���" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
					<input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">             
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html> 