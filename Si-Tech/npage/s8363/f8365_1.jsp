<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: �쳣���׼��ͳ��   8365
   * �汾: 1.0
   * ����: 2009/12/28
   * ����: gaolw
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page import="java.util.*"%>



<%
	String opCode="8365";
	String opName="�쳣���׼��ͳ��";
	
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");

	String regionCode=(String)session.getAttribute("regCode");
  

	String sqlStr="select region_code,region_name,group_id from sregioncode where region_code<=13 order by region_code";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	int dateInt = Integer.parseInt(dateStr); 
	String dateStr1 = (dateInt-1)+"";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="regionData" scope="end" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�쳣���׼��ͳ��</TITLE>
</HEAD>
<body>

<SCRIPT language="JavaScript">

function doSubmit()
{
  var querryDate = document.form1.querryDate.value;
  var today = document.form1.querryDate1.value;
  
  if(querryDate.length == 0)
  {
  	rdShowMessageDialog("����������ͳ�����ڣ�");
  	document.form1.querryDate.focus();
    return false;
  }
  
  if(querryDate.length != 8)
  {
  	rdShowMessageDialog("ͳ�����ڸ�ʽ���ԣ����������룡");
  	document.form1.querryDate.value = "";
  	document.form1.querryDate.focus();
    return false;
  }

  
  if(querryDate > today)
  {
    rdShowMessageDialog("ͳ�����ڱȵ�ǰ���ڴ����������룡");
    document.form1.querryDate.value = "";
    document.form1.all("querryDate").focus();
    return false;
  }
  with(document.forms[0])
  {
      hTableName.value="rcr001";
	  	hParams1.value= "prc_8365_rpt01_upg('"+document.form1.workNo.value+"','"+document.form1.group_id.value+"','"+document.form1.querryDate.value+"' ";
	  	var path = "<%=request.getContextPath()%>/npage/rpt/print_rpt.jsp";
	  	alert(path);
	  	action = path;
      submit();
  }
}

</SCRIPT>
<FORM method=post name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ��ͳ����</div>
	</div>
<table cellSpacing="0">
    <tr >
		<td class="blue" >����</td>
		<td colspan="3">
<select id=group_id name=group_id >
        <option class='button' value='10014'>00-- >ȫʡ</option>
<%for (int i = 0; i < regionData.length; i++) {%>
	      		  <option value="<%=regionData[i][2]%>"><%=regionData[i][0]%>-- ><%=regionData[i][1]%>
	      		  </option>
	    	      <%}%>
                    </select>
		</td>
	</tr>
	<tr>
		<td class="blue">ͳ������</td>
		<td>
			<input type="text" name="querryDate" id="querryDate" size="15" v_must=1  v_type="0_9" maxlength="8" value=<%=dateStr1%> style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">&nbsp;<font class="orange">*(��ʽYYYYMMDD)</font>
		</td>
	</tr>

	<tr>
		<td colspan="4" align="center" id="footer">
		&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
		&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
		<!--&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>-->
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
	

	<input type="hidden" name="workNo" value="<%=work_no%>">
	<input type="hidden" name="org_code" value="<%=org_code%>">
	<input type="hidden" name="hDbLogin" value ="dbchange">
	<input type="hidden" name="hParams1" value="">
	<input type="hidden" name="hTableName" value="">
	<input type="hidden" name="querryDate1" value="<%=dateStr%>">

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script language="javascript">
/*----------------------------����RPC������������------------------------------------------*/


 onload=function(){
	form1.reset();
	}


</script>
