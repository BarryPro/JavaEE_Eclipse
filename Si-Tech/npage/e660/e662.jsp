<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
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
		String opCode = "e662";
		String opName = "�ֹ�ϵͳ��ֵ��ѯ";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

%>

<HTML>
<HEAD>
<script language="JavaScript">
	function do_query()
	{
		
		var document_name	= frm.document_name.value ;
	  var document_no		= frm.document_no.value ;
		document.frm.action="e662_1.jsp?document_name="+document_name+"&document_no="+document_no;
		document.frm.submit();
	}
	
	function do_moHu()
	{
		var begin_ymd = frm.begin_ymd.value;
		var end_ymd	= frm.end_ymd.value;
		var	region_code	= frm.region_code.value;	
		document.frm.action="e662_0.jsp?region_code="+region_code+"&begin_ymd="+begin_ymd+"&end_ymd="+end_ymd;
		document.frm.submit();
	}
</script> 

 
<title>�ֹ�ϵͳ��ֵ���</title>
</head>
<BODY onload=""> 
<form action="" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ȷ��ѯ �����빫����Ϣ</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">��������</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_name" size="50" >  <font color="orange">*</font>
				</td>
				<td class="blue" width="15%">�����ĺţ�</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_no" size="50" >  <font color="orange">*</font>
				</td>
				
     </tr>
    </tbody>
  </table>
             
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="do_query()" >
       </td>
    </tr>
  </table>
  
		<div class="title">
			<div id="title_zi">ģ����ѯ</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">��ʼʱ��(YMD)��</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="begin_ymd" size="20" >  <font color="orange">*</font>
				</td>
				<td class="blue" width="15%">����ʱ��(YMD)��</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="end_ymd" size="20" >  <font color="orange">*</font>
				</td>
				<td class="blue" width="15%">��ѯ���У�</td>
	     	<td> 
	     	<%
	     		String[] inParas1 = new String[1];
	     		String regionCode = (String)session.getAttribute("regCode");
	     		inParas1[0] = "SELECT DISTINCT region_code, region_name FROM sRegionCode ORDER BY region_code";  
	     	%>
	     		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		    	<wtc:param value="<%=inParas1[0]%>"/>
		    	</wtc:service>
		    	<wtc:array id="result" scope="end" />
		  
					<select name="region_code" id="region_code" class="button" onChange="">
						<option value="ZZ" selected>--���޵���--</option>
	      	 	<%
	      	 		for(int i=0;i<result.length;i++)
	      	 		{ 
	      	 			
	      	 	%>
	      	 	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
	      	    <%
	      	
	      	    	}
	      	    %>
	      	 </select>
	       
	       <font color="orange">*</font>
	     </td>
				
     </tr>
    </tbody>
  </table>
             
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="ģ����ѯ" onclick="do_moHu()" >
       </td>
    </tr>
  </table>
  
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>