<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2009��8��25��
�� * ����: wangzn
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
  String opName ="";
  String opCode = "";
  System.out.println("sProductSpecNumber:"+sProductSpecNumber);	 
%>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/include/header.jsp" %>
	<table cellspacing="0">
			   <tr>
			    <th nowrap>����ȱʡ�ʷ�</th> 
	        <th nowrap>�ʷѼƻ���ʶ</th>
	        <th nowrap>�ʷ�����</th>	  
	        <th nowrap>ȱʡ�ʷѱ�ʶ</th>   
	        
	      </tr>
       
<wtc:service name="s9100DetQry" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="6"/>
		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="5" scope="end" /> 
<%  
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>		
  			  <tr>
  			  	<td><input type=radio name="default_flag"  value=<%=result[i][1]%>  <%if(result[i][4].equals("Y")){%>checked<%}%>></td>
				    <td><%=result[i][1]%>
					  &nbsp;</td>
					  <td class="p_Description"><%=result[i][2]%>					  	
					  &nbsp;</td>			
					  <td class="p_Description"><%=result[i][4]%>					  	
					  &nbsp;</td>					 					 
	        </tr>
<%
       }
     }
  }
%>
	     
		
	</table>
	<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot'  onClick="parent.doSubmit();" style="cursor:hand" type=button value=�ύ>
            		<input class='b_foot'  onClick="parent.document.URL='s2039SetDefaultEC.jsp';" style="cursor:hand" type=button value=����>
            </TD>
        </TR>
    </TBODY>
</TABLE>	

