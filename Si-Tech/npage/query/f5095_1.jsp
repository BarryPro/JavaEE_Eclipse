<%
   /*
   * ����: BBOSSǩԼ��ϵ��������ѯ - ������
�� * �汾: v1.0
�� * ����: 2008/09/17
�� * ����: sunzg
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-10    qidp        �����°��Ʒ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>

<%	
	//��ȡ�û�session��Ϣ	
  String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f5095_1.jsp");
	String op_name="BBOSSǩԼ��ϵ��������ѯ";
	String opCode = "3488";
	String opName = "BBOSSǩԼ��ϵ��������ѯ";
%>	
	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function queryBWInfo()
{
   if(document.form1.condText.value=="")
   { 
   	 rdShowMessageDialog("������������Ϣ��");
	 document.form1.condText.select();
   }
   else
   {
   	 var favCond = document.form1.queryType.value; 
   	 var favValue = document.all.condText.value;
   	 document.middle.location="f5095info.jsp?favCond="+favCond+"&favValue=" + favValue;
   }
}	

	
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">BBOSSǩԼ��ϵ��������ѯ</div>
</div>			
		
		<TABLE id="mainOne" cellspacing="0" >
 			 <TR id="con2">
				  <td class='blue' nowrap>��ѯ����</TD>
			      <TD>
			      	<select align="left" name=queryType id='queryType'>
                  		<option value="0">���ű��</option>
                  		<option value="1">֤������</option>
                  		<option value="2">�ֻ�����</option>
                  		<option value="3">��ҵ����</option>
                  		<option value="4">ҵ�����</option>
                  		<option value="5">���ŷ������</option>
            		</select> 
			      </TD>
          <td class='blue' nowrap>������Ϣ</TD>
          <TD>
          	<input type="text" id="condText" name="condText" size="20" maxlength="60" >
          </TD>	
			  </TR>
		</TABLE>
		
		<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
					style="HEIGHT: 330px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2">
					</IFRAME>
</form>
</body>
</html>

