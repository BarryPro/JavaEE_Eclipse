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
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<%
	String regionCode=(String)session.getAttribute("regCode");
	String opCode = "g088";
	String opName = "���Ž���֪ͨ��������";
 	String[][] result = new String[][]{}; 
	String unitid = request.getParameter("unitid");	
    String workno = (String)session.getAttribute("workNo");
 
//�� �� ���� ����
String s_year = request.getParameter("fromMonth");
String s_month = request.getParameter("toMonth");
String s_region_code = request.getParameter("s_in_ModeTypeCode");
String s_dis_code = request.getParameter("s_in_CaseTypeCode");
System.out.println("   AAAAAAAA  s_year is  "+s_year+" and s_month is "+s_month+" and s_region_code is "+s_region_code+" and s_dis_code is "+s_dis_code);

//���ڽ��ȵ������sql
String[] inParas0 = new String[2];
String[] inParas1 = new String[2];
String[] inParas2 = new String[2];
String[] inParas3 = new String[2];

String s_dis="";

//�ϸ��� select to_char(add_months(to_date('201201','YYYYMM'),-1),'YYYYMM') from dual
String[] inParas_ym = new String[2];
inParas_ym[0]="select to_char(add_months(to_date(:ym,'YYYYMM'),-1),'YYYYMM') from dual";
inParas_ym[1]="ym="+s_year+s_month;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="15004675829"  retcode="retCode11" retmsg="retMsg11" outnum="1">
		<wtc:param value="<%=inParas_ym[0]%>"/>
		<wtc:param value="<%=inParas_ym[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_valYm" scope="end" />	

<%
System.out.println("AAAAAAAAAAAAAAAAAAaa ret_valYm is "+ret_valYm[0][0]);
String year_month_old="";
year_month_old=ret_valYm[0][0];
String s_flag="";// 0���� 1����

if(s_dis_code=="" ||s_dis_code.equals(""))
{
	System.out.println("���м���");
 
	s_flag="0";
}
else
{
	System.out.println("qx���� "+s_dis_code);
	 
	s_flag="1";
	s_dis=s_dis_code.substring(2,4);
}

	
%>
 

<wtc:service name="bs_getttMsg2" routerKey="phone" routerValue="15004675829"  retcode="retCode3" retmsg="retMsg3" outnum="7">
	<wtc:param value="<%=s_region_code%>"/>
	<wtc:param value="<%=s_dis%>"/>
	<wtc:param value="<%=s_year+s_month%>"/>
	<wtc:param value="<%=year_month_old%>"/>
</wtc:service>
<wtc:array id="ret_val2" scope="end" />	

 
<%
	if ((ret_val2==null||ret_val2.length==0) )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯʧ��!");
				history.go(-1);
			</script>
		<%
	}
	else
	{
		%>
		<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=opName%></TITLE>
<link rel="stylesheet" href="../e610/reset.css" media="all" />
<link rel="stylesheet" href="../e610/bills1.css" media="all" />
<link rel="stylesheet" href="../e610/print-reset.css" media="print" />
 
<script language="javascript">
	function getFile(flag)
	{
		/* 
		document.frm.action="g559_txt.jsp";
		document.frm.sflag.value=flag;
		 
		document.frm.syear.value="<%=s_year%>";
		document.frm.smonth.value="<%=s_month%>";
		 
		document.frm.sregino_code.value="<%=s_region_code%>";
		document.frm.sdis_code.value="<%=s_dis_code%>";
 		document.frm.submit();*/
		rdShowMessageDialog("��ȥ10.110.2.150������������!������ϸ��ʹ���ֲ�!");
	}

 
</script>
</HEAD>

<BODY class="email" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<!-------------------                  ���˵����ݿ�ʼ                    -------------------------->
<form name="frm">
<div class="container">
 
 <div align="center"><h2><b> </b></h2></div> 
 
	 

	   
   <table width="98%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
    
     
	 
  
	  <tr>
		<td rowspan=2 width=20%>ǰ�ڽ��</td>
			<td>���</td>
			<td>��Ʊ����</td>
			<td>����</td>
			<td>��Ʊ���</td>
			<td>��Ʊֹ��</td>
			<td>�칺����</td>
			<td>���߽��</td>
	  </tr>
	  <tr>
			<td>С��</td>
			<td>--</td>
			<td><%=ret_val2[0][4]%></td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
	  </tr>
	 
	  <tr>
		<td rowspan=2 width=20%>�����칺</td>
			<td>���</td>
			<td>��Ʊ����</td>
			<td>����</td>
			<td>��Ʊ���</td>
			<td>��Ʊֹ��</td>
			<td>�칺����</td>
			<td>���߽��</td>
	  </tr>
	  <tr>
			<td>С��</td>
			<td>--</td>
			<td><%=ret_val2[0][5]%></td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
	  </tr>

	  <tr>
		<td rowspan=2 width=20%>����ʹ��&nbsp;<input type="button" value="ʹ����ϸ" onclick="getFile('<%=s_flag%>')"> </td>
			<td>���</td>
			<td>��Ʊ����</td>
			<td>����</td>
			<td>��Ʊ���</td>
			<td>��Ʊֹ��</td>
			<td>�칺����</td>
			<td>���߽��</td>
	  </tr>
	  <tr>
			<td>С��</td>
			<td>--</td>
			<td>   <%=ret_val2[0][2]%> 
		 
			</td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
			<td>   <%=ret_val2[0][3]%>  
			 
			</td>
	  </tr>
	    
	   <tr>
		<td rowspan=2 width=20%>���ڽ��</td>
			<td>���</td>
			<td>��Ʊ����</td>
			<td>����</td>
			<td>��Ʊ���</td>
			<td>��Ʊֹ��</td>
			<td>�칺����</td>
			<td>���߽��</td>
	  </tr>
	  <tr>
			<td>С��</td>
			<td>--</td>
			<td><%=ret_val2[0][6]%></td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
			<td>--</td>
	  </tr>		 
	 
      
    </table>
 
	
    
  
 
    <input type="hidden" name="sflag">
	<input type="hidden" name="syear">
	<input type="hidden" name="smonth">
	<input type="hidden" name="sregino_code">
	<input type="hidden" name="sdis_code">
 
    
<div align="center">
	 
	<input type="button"  class="b_foot"value="�ر�" title="�ر�" onClick="window.close()" />
	&nbsp;
	<input type="button"  class="b_foot"value="����" title="����" onClick="history.go(-1)" />
</div>
</div>

 

<!-------------------                  ���˵����ݽ���                    -------------------------->
</form>
</BODY>

</HTML>
		<%
	}

%> 
	 
 

