<%
   /*
   * ����: ��ѯ�û���Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��17��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/common/portalInclude.jsp" %>

<%!
boolean havingPriv(HttpSession session,String opcode)
{
	java.util.ArrayList list = (java.util.ArrayList)session.getAttribute("allArr");
	String[][] func = (String[][])list.get(1);
	for(int i=0;i<func.length;i++)
	{
		if(func[i][1]!=null&&func[i][1].equals(opcode))
		{
			return true;
		}
	}
	return false;
}
%>

<%
     String workNo = (String)session.getAttribute("workNo");
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);

     //String phone_no = (String)session.getAttribute("activePhone");
     String phone_no = (String)request.getParameter("activePhone");
     
     String product_name  ="";                //�ײ�    
     String group_name    ="";               //����    
     String current_point ="";                //����    
     String sm_name       ="";                //Ʒ��   
     /* 20090403 zhangshuai begin */
     String attr_code     ="";                //�ͻ�����
     /* 20090403 zhangshuai end */
     String open_time     ="";               //����ʱ��
     String run_name      ="";                //״̬    
     String cust_id       ="";                //�û���  
     String grade         ="";               //����    
     String pre_fee       ="";                //�ʺ����
  
%>

<wtc:service name="sIndexCustMsg" outnum="10" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
       if(result.length>0){
              product_name  =result[0][0];
              group_name    =result[0][1];
              current_point =result[0][2];
              sm_name       =result[0][3];
              open_time     =result[0][4];
              run_name      =result[0][5];
              cust_id       =result[0][6];         
              grade         =result[0][7];
              pre_fee       =result[0][8];  
              /* 20090403 zhangshuai begin */
              attr_code     =result[0][9];
              /* 20090403 zhangshuai begin */
                       
           }
     }
%>	
<%
    
     String cust_name="";    // �ͻ�����        
     String id_type="";      // �ͻ�֤����������
     String id_iccid="";     // �ͻ�֤����      
     String birthday="";     // �ͻ���������    
     String sex="";          // �ͻ��Ա�        
     String age="";          // �ͻ�����        
     
%>

<wtc:service name="sIndexCustDoc" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=cust_id%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
       if(result.length>0){
              cust_name=result[0][0];
              id_type=result[0][1];
              id_iccid=result[0][2];
              birthday=result[0][3];
              sex=result[0][4];
              age=result[0][5];
           }
     }
     
 System.out.println( id_type);
 System.out.println("*******************************************************");

%>
<div id="blueBG">
 <div id="Info_table">
 	<table border="0" cellpadding="0" cellspacing="0" width="100%">
  	<tr>
  	    <th width=80 nowrap >�ֻ�����:</th>
  	  	<td><%=phone_no.trim()%></td>
  	  	<th  nowrap >VIP�ͻ����ԣ�</th>
  	  	<td><%=grade.trim()%></td>
  	   	<td rowspan="14" width="300px" >         	
  	    </td>
  	</tr>
  	<tr>
  			<th>������</th>
  	    <td><%=cust_name.trim()%></td>
  			<th>Ʒ�ƣ�</th>
  	    <td><%=sm_name.trim()%></td>
  	</tr>
  	<tr>
	  		<th nowrap>����ʱ�䣺</th>
	  	  <td nowrap ><%=open_time.trim()%></td>
	  	  <!--20090403 zhangshuai begin -->
	  	  <th nowrap>�û����ԣ�</th>
	  	  <td nowrap ><%=attr_code.trim()%></td>
	  	  <!--20090403 zhangshuai end -->
  	</tr>
  	<tr>
	  		<th>�ײͣ�</th>
	  	  <td nowrap >
	  	  	<%=product_name.trim()%>&nbsp;
 	  		  	  	<%if(havingPriv(session,"1270")){%>
	  	  				<a href=javascript:parent.parent.openPage("2","1270","���ʷѱ��","bill/f1270_1.jsp","001")  ><span class='orange'>���ʷѱ��</span></a>
					<%}%>
	  	  </td>
  	</tr>
  	<tr>
	  		<th>������</th>
	  	  <td colspan=3><%=group_name.trim()%></td>
  	</tr>
  	<tr>
	  		<th>״̬��</th>
	  	  <td colspan=3  >
	  	  	<span class="green"><%=run_name.trim()%></span>
	  	    <%if(!run_name.trim().equals("����")) out.print("<img src='../../../nresources/default/images/shine.gif'><span class='orange'>�����ѿ�ͨ��</span>");  %>
			  </td>
		</tr>
  	<tr>
  		<th nowrap>��ع��ܣ�</th>
  	  <td colspan=3  >
        <%if(havingPriv(session,"1302")){%>
				<a href=javascript:parent.parent.openPage("1","1302","�ɷ�(����)","s1300/s1300.jsp?opCode=1302&opName=����ɷ�","000")  ><span class='orange'>����ɷ�</span></a>&nbsp;&nbsp;
				<%}%>
				<%if(havingPriv(session,"1300")){%>
					<a href=javascript:parent.parent.openPage("1","1300","�ɷ�(�˺�)","s1300/s1300_2.jsp?busy_type=2&opCode=1300&opName=�ʺŽɷ�","000")  ><span class='orange'>�˺Žɷ�</span></a>
				<%}%>
				<%if(havingPriv(session,"1500")){%>
				<a href=javascript:parent.parent.openPage("1","1500","�ۺ���Ϣ��ѯ","query/f1500_1.jsp?opCode=1500&opName=�ۺ���Ϣ��ѯ","000")  ><span class='orange'>�ۺ���Ϣ��ѯ</span></a>
				<!--a href="#" onclick="javascript:window.open('../../../page/query/f1500_1.jsp');"><span class='orange'>�ۺ���Ϣ��ѯ</span></a-->
		        <%}%>
		  </td>
		</tr>
  	<tr>
</table>
</div>
</div>
<script>
 $("#wait1").hide();		   
</script>