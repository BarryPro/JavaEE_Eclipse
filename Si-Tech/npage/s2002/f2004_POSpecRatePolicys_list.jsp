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
  System.out.println("sPOSpecNumber:"+sPOSpecNumber);	 
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="25%" nowrap>�ʷѲ��Ա���</th>
	        <th width="75%" nowrap>�ʷѲ�������</th>		        
	      </tr>
        <tbody>
<wtc:service name="s9100DetQry" outnum="8" routerKey="region" routerValue="<%=regionCode%>">	
	<wtc:param value="<%=sPOSpecNumber%>"/>
  <wtc:param value="0"/>
</wtc:service>
<wtc:array id="result" start="2" length="6" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){		
%>
  			  <tr
  			  	 a_POSpecRatePolicyID = "<%=result[i][0]%>"
  			  	 a_Name               = "<%=result[i][1]%>"
  			  	 a_Description        = "<%=result[i][2]%>"
  			  	 a_StartDate          = "<%=result[i][3]%>"
  			  	 a_EndDate            = "<%=result[i][4]%>"  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	
  			  >					
					  <td>
					  <a class="p_IPOSpecRatePolicyID" style="cursor: hand;"><%=result[i][0]%></a>						  	
					  &nbsp;</td>
					  <td class=p_Name><%=result[i][1]%>
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
	 //���º���
	function POSpecRatePolicyUpdate(){
    var POSpecRatePolicyUpdateTR = $(this).parent().parent();
	 	var  POSpecRatePolicyUpdate=[
	 	  	        $(POSpecRatePolicyUpdateTR).attr("a_POSpecRatePolicyID"),//0
	 	  	        $(POSpecRatePolicyUpdateTR).attr("a_Name"),              //1
	 	  	        $(POSpecRatePolicyUpdateTR).attr("a_Description"),       //2
	 	  	        $(POSpecRatePolicyUpdateTR).attr("a_StartDate"),         //3
	 	  	        $(POSpecRatePolicyUpdateTR).attr("a_EndDate"),           //4
	 	  	        '<%=sPOSpecNumber%>'                                       //5
	 	  	        ];
	 	
	  var retInfo = window.showModalDialog
	  (
	  'f2004_POSpecRatePolicy_detail.jsp',
	  POSpecRatePolicyUpdate,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
	  return true;
	}
$(document).ready(function(){
	 //ע����º���
	 $('.p_IPOSpecRatePolicyID').bind('click', POSpecRatePolicyUpdate);
});
</script>
