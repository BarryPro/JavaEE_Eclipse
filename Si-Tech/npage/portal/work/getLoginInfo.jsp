<%
   /*
   * ����: ��ѯӪҵԱ������Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��14��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 
		 Date date=new Date();
		 SimpleDateFormat myFmt=new SimpleDateFormat("yyyy-MM-dd");        
     String myDate=myFmt.format(date);
   
     String Login_name     ="";            // ӪҵԱ����        
     String group_name     ="";            // ӪҵԱ����        
     String pass_time      ="";            // ӪҵԱ���뵽��ʱ��
     String op_time        ="";            // ӪҵԱ�ϴε�¼����
     String contract_phone ="";            // ӪҵԱ�ֻ�����    
     String sex_name       ="";            // ӪҵԱ�Ա�        
     String birthday       ="";            // ӪҵԱ��������    
     String age            ="";            // ӪҵԱ����        
     String festival       ="";            // ӪҵԱ��������    
     String email          ="";            // ӪҵԱ�ʼ�        
%>                

<wtc:service name="sIndexloginMsg" outnum="10" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(retCode.equals("000000")){
       if(result.length>0){
              Login_name      ="".equals(result[0][0])?"����":result[0][0];
              group_name      ="".equals(result[0][1])?"����":result[0][1];
              pass_time       ="".equals(result[0][2])?"����":result[0][2];
              op_time         ="".equals(result[0][3])?"����":result[0][3];
              contract_phone  ="".equals(result[0][4])?"����":result[0][4];
              sex_name        ="".equals(result[0][5])?"����":result[0][5];
              birthday        ="".equals(result[0][6])?"����":result[0][6];     
              age             ="".equals(result[0][7])?"����":result[0][7];     
              festival        ="".equals(result[0][8])?"����":result[0][8];          
              email           ="".equals(result[0][9])?"����":result[0][9];      
       }  
}
%>
<!--
<div id="blueBG">
    <div id="Info_table">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:12px;">
            <tr>
                <th>���ţ� </th>
                <td ><%=workNo.trim()%></td>
                <th>���뵽��ʱ�䣺 </th>
                <td><%=pass_time.trim()%><%if(myDate.equals(pass_time))out.print("<img src='../../../nresources/default/images/shine.gif' > <span class='orange'>��������</span>");%></td>
                <th>�������ѣ�</th>
                <td id="festival"></td>
            </tr>
        </table>
    </div>
</div>
-->
<div class="user_info">
	<span>���ţ�<%=workNo.trim()%></span>
	<span>���뵽��ʱ�䣺<%=pass_time.trim()%><%if(myDate.equals(pass_time))out.print("<img src='../../../nresources/default/images/shine.gif' > <span class='orange'>��������</span>");%></span>
	<span>�������ѣ�<span id="festival"></span></span>
</div>

<script>
	   $("#wait0").hide();	
	   $("#festival").html(showDetail());
</script>