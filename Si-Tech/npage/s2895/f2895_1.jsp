<%
   /*
   * ����: �����ۺ���Ϣ��ѯ - ������
�� * �汾: v1.0
�� * ����: 2007/10/25
�� * ����: sunzg
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.14
 ģ��:���Ŷ�����Ϣ����(�޸�)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
	//��ȡ�û�session��Ϣ	
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");	
	String[][] baseInfo = (String[][])arrSession.get(0);
  	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               //��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //��½����	
	String regionCode = baseInfo[0][16].substring(0,2);
			
	String op_name="���Ŷ�����ϵ��ѯ";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>
	
	
function qryProdInfo()
{
   if(check(form1)){
   var custId = document.all.custId.value;
   var unitId = document.all.unitId.value;
   document.middle.location="f2895ProdInfo.jsp?custId="+custId+"&unitId="+unitId;
   tabBusi.style.display="";
   }
}	

function queryCustDoc()
{
	if(document.all.idIccid.value == "")
 	 	{
 	 		rdShowMessageDialog("������֤�����룡");
 	 		document.all.idIccid.focus();
 	 		return;
 	 	}
 	var idIccid = document.all.idIccid.value;
	window.open("f2895QryCustDoc.jsp?idIccid="+idIccid+"","","height=600,width=400,scrollbars=yes");
}
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	
		  <TABLE cellspacing="0">
 			 <TR>
				  <TD class="blue">֤������</TD>
			      <TD colspan=3>
			      	<input name="idIccid" align="left" type="text" v_maxlength=20 v_type="string"> 
			        <font class="orange">*</font>
			        <input class="b_text" type="button" name="queryCustDocButton" onclick="queryCustDoc()" value="�� ѯ">
			      </TD>
			  </TR>
			  <TR>
			  	<TD class="blue">���ſͻ�ID</TD>
			  	<TD>
			  		<input name="custId" type="text" v_minlength=1 v_maxlength=14 v_type="int" maxlength="14" readonly>
			  	</TD>
			  	<TD class="blue">���ſͻ�����</TD>
          		<TD>
		          	<input name ="custName" type="text" v_maxlength=60 v_type="string" maxlength="60" size=30 readonly>
		        </TD>
			  </TR>	
		 </TABLE>
		
		 <TABLE id="tabBtn" style="display:''" cellspacing="0">	    
			    <TR> 
		         	<TD id="footer" colspan = "4"> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="qryProdInfo()">
		         	    &nbsp;
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
		         	    &nbsp;  
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
		<TABLE id="tabBusi" style="display:none" width="100%" height="300px" cellspacing="0">	
			<TR> 
				<td nowrap>
					<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
					style="HEIGHT:500px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
				</td> 
			</TR>
		</TABLE>	
		
	<input type="hidden" name="unitId" value=""/>
	   <%@ include file="/npage/include/footer.jsp" %>      
</form>
</body>
</html>

