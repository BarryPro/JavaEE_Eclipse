<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String sProductOrderNumber = request.getParameter("sProductOrderNumber");
  String sMemberNo=request.getParameter("sMemberNo");
  
  String sqlstr= "select Character_id,Character_name,Character_value "
               + "from dproductTaskMebCha where  PRODUCT_ID = '"+sProductOrderNumber+"' and Member_no='"+sMemberNo+"' ";
               
   System.out.println("sqlStr="+sqlstr);
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<!--th width="10%" nowrap>ѡ��</th-->
	        <th width="20%" nowrap>���Դ���</th>
	        <th width="30%" nowrap>������</th>
	        <th width="40%" nowrap>����ֵ</th>			        
	      </tr>
        <tbody>
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=sqlstr%>
</wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>
  			  <tr class="keyperson_contenttr"
  			  	 a_ParameterNumber     = "<%=result[i][0]%>"
  			  	 a_ParameterName       = "<%=result[i][1]%>"
  			  	 a_ParameterValue      = "<%=result[i][2]%>"
  			  	 a_OperType            = "OLD"
  			  >					  
					  <!--td>    
					  <input type="Checkbox" name= "KeyPersonListChkBox">
					  </td-->    
					  <td>
					  <a class="p_ParameterNumber" style="cursor: hand;"><%=result[i][0]%></a>						  	
					  </td>
					  <td class="p_ParameterName"><%=result[i][1]%>
					  </td>
			      <td class="p_ParameterValue"><%=result[i][2]%>
					  </td>
	        </tr>
<%
    }
  }
}
%>
	         <!--tr id="keyPerson_buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="ParameterNumberAdd" value="����">
	        		&nbsp;
	        		<input type="button" class="b_text" id="ParameterNumberDel" value="ɾ��">
	          </th>
	        </tr-->
	      </tbody>
		</form>
	</table>
</div>
