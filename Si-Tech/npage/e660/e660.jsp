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
		String opCode = "e660";
		String opName = "�ֹ�ϵͳ��ֵ����";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr"); 
		String regionCode = (String)session.getAttribute("regCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());



      	inParas2[0] = "select to_char(count(*)) from cKeyWordMap where op_code = 'e660' and key_word = 'IS_OK_LOGINNO' and key_value = :login_no";  
      	inParas2[1] = "login_no="+workno ;
%>


      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
		    <wtc:param value="<%=inParas2[0]%>"/>
		    <wtc:param value="<%=inParas2[1]%>"/>
		    </wtc:service>
		    <wtc:array id="IS_LOGIN" scope="end" />
		    	
<%
				if( IS_LOGIN[0][0].equals("0") )
				{
%>
				<script language="JavaScript">
					rdShowMessageDialog("����û�е���Ȩ�ޣ���");	
					removeCurrentTab();
				</script>
<%
				}
%>



<HTML>
<HEAD>
<script language="JavaScript">

function do_ftp()
{
	var document_name	= frm.document_name.value ;
	var document_no		= frm.document_no.value ;
	var import_date		= frm.import_date.value ;
	var	active_name		= frm.active_name.value ;
	var	all_user			= frm.all_user.value ;
	var	all_fee				= frm.all_fee.value ;
	var	ip_Addr				= frm.ip_Addr.value;
	var	shortMsg1			= frm.shortmsg1.value;
	var	shortMsg2			= frm.shortmsg2.value;
	
	
	if(document_name=='')
	{
		rdShowMessageDialog("�����빫����");
		document.frm.document_name.focus();
		return false;
	}
	if(document_no=='')
	{
		rdShowMessageDialog("�����빫���ĺ�");	
		document.frm.document_no.focus();
		return false;
	}
	if(active_name=='')
	{
		rdShowMessageDialog("������Ӫ�����룡");	
		document.frm.active_name.focus();
		return false;
	}
	if(all_user=='')
	{
		rdShowMessageDialog("�������ֵ���û���");	
		document.frm.all_user.focus();
		return false;
	}
	if(all_fee=='')
	{
		rdShowMessageDialog("�������ֵ���ý��");	
		document.frm.all_fee.focus();
		return false;
	}
	if(import_date=='0')
	{
		rdShowMessageDialog("��ѡ���ֵ����");
		document.frm.import_date.focus();
		return false;
	}
	if(frm.file_name.value.length<1)
	{
		rdShowMessageDialog("�����ļ�����������ѡ�������ļ���");
		document.frm.file_name.focus();
		return false;
	}
	if(shortMsg1.length > 80)
	{
		rdShowMessageDialog("����ģ�� PART1�������뾫����󳤶�40���֣�80���ַ���");
		document.frm.shortmsg1.focus();
		return false;
	}
	if(shortMsg2.length > 80)
	{
		rdShowMessageDialog("����ģ�� PART2�������뾫����󳤶�40���֣�80���ַ���");
		document.frm.shortmsg1.focus();
		return false;
	}
	
	document.frm.action="e660_1.jsp?document_name="+document_name+"&document_no="+document_no+"&import_date="+import_date+"&active_name="+active_name+"&all_fee="+all_fee+"&all_user="+all_user+"&ip_Addr="+ip_Addr+"&shortmsg1="+shortMsg1+"&shortmsg2="+shortMsg2 ;

	document.frm.submit();
	
}

</script> 

 
<title>�ֹ�ϵͳ��ֵ����</title>
</head>
<BODY onload=""> 
<form action="e660_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�뵼���ֵ����</div>
		</div>
		
	<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
	
  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">��������</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_name" size="50" >  <font color="orange">*</font>
 					<font color="red">�20����</font>
				</td>
				
     </tr>

     <tr>
        <td class="blue" width="15%">�����ĺţ�</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="document_no" size="50" >  <font color="orange">*</font>
 					<font color="red">�20����</font>
				</td>
				
     </tr>
     
     <tr>
        <td class="blue" width="15%">Ӫ�����룺</td>
        <td colspan="2"> 
 					<input class="button"type="text" name="active_name" size="50" >  <font color="orange">*</font>
 					<font color="red">�����뾭��ϵͳ�ĺ�̨����</font>
				</td>
				
     </tr>
     
    <tr>
    	<td class="blue" width="15%">��ֵ�ܽ�</td>
    	<td>
    		<input class="button"type="text" name="all_fee" size="50" >  <font color="orange">*</font>
    	</td>
    </tr>
    <tr>
    	<td class="blue" width="15%">��ֵ���û�����</td>
    	<td>
    		<input class="button"type="text" name="all_user" size="50" >  <font color="orange">*</font>
    	</td>
    </tr>
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 

      <td class="blue" width="15%">��ֵ���ڣ�</td>
      <td> 
      	<%
      	String[] inParas1 = new String[2];
      	
      	inParas1[0] = "select back_rule,to_char(back_date) from sBackPayRule where back_rule like 'zzzzzzzz%'";  
      	%>
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />
		  
				<select name="import_date" id="import_date" class="button" onChange="">
					<option value="0" selected>--δѡ��--</option>
        	<%
        		for(int i=0;i<result.length;i++)
        		{ 
        			
        	%>
        	<option value="<%=result[i][0]%>"><%=result[i][1]%>��</option>
           <%
     
           	}
           %>
        </select>
        
        <font color="orange">*</font>
      </td>
    </tr>
  </table>
  
  <table cellspacing="0">
    <tr> 

      <td class="blue" width="15%">����ģ�� PART1��</td>
      <td> 

        <input class="button"type="text" name="shortmsg1" size="70" >
        <font color="red">�40����</font>
      </td>
    </tr>
    <tr>
      <td class="blue" width="15%">����ģ�� PART2��</td>
      <td> 
        <input class="button"type="text" name="shortmsg2" size="70" >
        <font color="red">�40����</font>
      </td>
  	</tr>
    <tr>
    	<td class="blue" width="15%">˵����</td>
    	<td>
    			1����������<br>
    			&nbsp;&nbsp;"����ģ�� PART1������ģ�� PART2"������д��<br>
    			2�����Ͷ����в���Ҫ��ֵ�����Ϊ����<br>
    			&nbsp;&nbsp;����������ֱ����д�� "����ģ�� PART1"�С�<font color="red">����ģ�� PART2��Ҫ�����ݡ�</font><br>
    			&nbsp;&nbsp;&nbsp;&nbsp;���磺"�𾴵Ŀͻ����ã����������䷵���ѻϵͳ�ѽ����ѳ��������˻�����ע����ա�"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ģ�� PART1="�𾴵Ŀͻ����ã����������䷵���ѻϵͳ�ѽ����ѳ��������˻�����ע����ա�"<br>
    			3�������а�����ֵ���<br>
    			&nbsp;&nbsp;������д"����ģ�� PART1,����ģ�� PART2"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;���磺"�𾴵Ŀͻ����ã����������䷵���ѻϵͳ�ѽ� <font color="red">XX</font> Ԫ���������˻�����ע����ա�"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;��Ҫ�������ã�<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ģ�� PART1="�𾴵Ŀͻ����ã����������䷵���ѻϵͳ�ѽ�"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ģ�� PART2="Ԫ���������˻�����ע����ա�"<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������Զ������η��ѽ���滻 "XX"��
    	</td>
  	</tr>
  </table>

    
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">���ݵ��룺</td>
    	<td>
    		<input type="file" name="file_name" size="30" class="button">
    	</td>
    </tr>
    
    <tr>
    	<td class="blue" width="15%">�����ļ���ʽ˵��:</td>
    	<td>
    		��ʽҪ�󣺷������|�˺�|���ã��ܷ��ã�|��ʼʱ�䣨YYYYMMDD��|����ʱ��(YYYYMMDD)|���Ѵ������ܼƷ��Ѵ�����|��ע<br>
    		<br>
    			&nbsp;&nbsp;������룬����Ϊ�ƶ������ֻ��ţ��15λ��<br>
    			&nbsp;&nbsp;�˺ţ��19λ��<br>
    			&nbsp;&nbsp;�ܷ��ã�Ϊ����������λС����<font color="red">������Ƕ�γ�ֵ���˴����ܽ���ܺͣ�������ÿ�ε�ƽ��ֵ��</font><br>
    			&nbsp;&nbsp;��ע���30�����֡�<br>
    		<br>
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���磺13845099725|12073469466|120|20100901|20110930|12|����1<br>
    		<br>&nbsp;&nbsp;&nbsp;&nbsp;ע��ָ���Ϊ��|�� <br>
    	</td>
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="�ϴ�" onclick="do_ftp()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
  
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
