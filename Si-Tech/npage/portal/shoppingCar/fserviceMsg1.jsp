<%
   /*
   * ����: ��ѯ�û���ͨ������Ϣ
�� * �汾: v1.0
�� * ����: 2010��8��23��
�� * ����: wanglm
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ include file="/npage/common/portalInclude.jsp" %>

<%
  String regionCode = (String)session.getAttribute("orgCode");
  String phone_no = (String)request.getParameter("activePhone");
  String sql = " select offer_name,TO_CHAR(b.eff_date,'yyyyMMdd hh24:mi:ss'),TO_CHAR(b.exp_date,'yyyyMMdd hh24:mi:ss')  from product_offer a, product_offer_instance b ,dcustmsg c where a.offer_id = b.offer_id  and b.serv_id = c.id_no and a.offer_type = '40' and  b.exp_date>sysdate and phone_no = '"+phone_no+"' ";
  
  %>

 <wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
 <wtc:sql><%=sql%></wtc:sql>
 </wtc:pubselect>
 <wtc:array id="result" scope="end"/>
<div  id="form">
    <table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list" id="serviceMsg">
  	<tr> 
    	<th>�ط�����</th>
		<th>��ͨʱ��</th>
		<th>����ʱ��</th>
	  </tr>
    <%
		if(retCode.equals("000000")){
			if(result.length>0){
				for(int i=0;i<result.length;i++){
				String re1 = result[i][1];
	      	        String classes="";
					if(i%2==1){classes="grey";}
					{
			%>	             
		<tr>
			<td class="<%=classes%>"><%=result[i][0]%> </td>
			<td class="<%=classes%>"><%=result[i][1]%> </td>
			<td class="<%=classes%>"><%=result[i][2]%>  </td>
		</tr>
		 <%
		       }
			  }
			 }
		}
		%>	
  </table>
</div>
 <script>
 $("#wait3").hide();		   
 </script>
 
