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
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  String sProductSpecNumber = request.getParameter("sProductSpecNumber");
  System.out.println("sProductSpecNumber:"+sProductSpecNumber);	 
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">			  
	      <tr>
	        <th width="25%" nowrap>��Ʒ����ʶ</th>
	        <th width="75%" nowrap>������ϵ</th>	        
	      </tr>
        <tbody>
<wtc:service name="s9100DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="a"/>
		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="3" scope="end" />
<%  
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>
  			  <tr>
				    <td><%=result[i][1]%>
					  &nbsp;</td>
					  <td><%=result[i][2]%>					  	
					  &nbsp;</td>					 					 					 					 
	        </tr>
<%
       }
     }
  }
%>
	      </tbody>
		</form>
	</table>
</div>
<script>
//���ع�����
$("#wait2").hide();
</script>
