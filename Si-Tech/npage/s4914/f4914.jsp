<%
   /*
   * ����: B-C/P���Ա��ѯ - ������
�� * �汾: v1.0
�� * ����: 2008/04/28
�� * ����: hupp
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-15    qidp        �°漯�Ų�Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%	
	//��ȡ�û�session��Ϣ	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));           //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                     //��½����	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f4914.jsp");
	String op_name="B-C/P���Ա��ѯ";
	
	String opCode = "4914";
	String opName = "B-CP���Ա��ѯ";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function qryProdInfo()
{  
	
	if (document.all.custID.value==""){
		
		rdShowMessageDialog("�������ѯ������");
		return false;

		}
   if(check(form1)){
   var custID = document.all.custID.value;
   var queType = document.all.queType.value;
   var queCondition = document.all.queCondition.value;
   
   if (queCondition=="0")
   {
   document.middle.location="f4914Info.jsp?custID="+custID+"&queType="+queType+"&queCondition="+queCondition;
   }
   else
   {
    document.middle.location="f4914Info2.jsp?custID="+custID+"&queType="+queType+"&queCondition="+queCondition;   	
   }
   }
}	


	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
		<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">B-CP���Ա��ѯ</div>
</div>
		<TABLE cellspacing="0" >
 			 <TR id="con2">
				<td class='blue' nowrap>��ѯ����</td>

	     		<td nowrap colspan='3'>  

		             <select name="queType">

	              		<option value="0">MAS/ADC��</option> 

	              		<option value="1">��MAS/ADC��</option> 	

	              	</select>

		          <font class='orange'>*</font>
			      </td>
		  </TR>
			  <TR>
			  	<td class='blue' nowrap>��ѯ��������</TD>
	     		<td nowrap> 
		             <select name="queCondition">

	              		<option value="0">�ֻ�����</option> 

	              		<option value="1">����֤������</option> 	

	              		<option value="2">���ű��</option> 			

		             </select>

		      <font class='orange'>*</font>

					 	</td>
		<td class='blue' nowrap>��ѯ����</TD>
          <TD>
          	<input name ="custID" type="text" v_maxlength=60 v_type="string" maxlength="60" size=30 >
          </TD>
			  </TR>	
		</TABLE>
		
		<TABLE cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="qryProdInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 

						<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"   
						style="HEIGHT: 300px; VISIBILITY: inherit; WIDTH: 98%; Z-INDEX: 1">
						</IFRAME>
					
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

