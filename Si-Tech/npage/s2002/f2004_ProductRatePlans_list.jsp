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
	        <th width="25%" nowrap>�ʷѼƻ���ʶ</th>
	        <th width="75%" nowrap>�ʷ�����</th>	    
	        <th width="75%" nowrap>ȱʡ�ʷѱ�ʶ</th>    
	      </tr>
        <tbody>
<wtc:service name="s9100DetQry" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="6"/>
		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="5" scope="end" /> <!-- update by wangzn	from outnum="8" length="4" to	outnum="8" length="5"	-->	
<%  
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>		
  			  <tr 
  			  	a_RatePlanID=<%=result[i][1]%>
  			  	a_Description=<%=result[i][2]%> 			  	  			  	
  			  	>
				    <td><a class="p_RatePlanID" style="cursor: hand;"><%=result[i][1]%></a>
					  &nbsp;</td>
					  <td class="p_Description"><%=result[i][2]%>					  	
					  &nbsp;</td>			
					  <td class="p_Description"><%=result[i][4]%>					  	
					  &nbsp;</td>				<!-- add by wangzn	 		-->			 					 					 
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
$("#wait0").hide();
	 //���º���
	 function ProductInfoUpdate(){	 	  
      var ProductRatePlanTR = $(this).parent().parent();
	 	  ProductRatePlan=[
	 	  	        $(ProductRatePlanTR).attr("a_RatePlanID"),//0
	 	  	        $(ProductRatePlanTR).attr("a_Description"),//1
	 	  	        '<%=sPOSpecNumber%>',
	 	  	        '<%=sProductSpecNumber%>'
	 	  	        ];      
	    var retInfo = window.showModalDialog
	    (
	    'f2004_ProductRatePlan_detail.jsp',	     
	    ProductRatePlan,
	    'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    return true;                                                           
	 }
$(document).ready(function(){ 
	 //ע����º���
	 $('.p_RatePlanID').bind('click', ProductInfoUpdate);	
});
</script>
