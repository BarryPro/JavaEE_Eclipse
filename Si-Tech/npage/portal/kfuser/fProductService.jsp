<%
   /*
   * ����: �˵���ʷ��ѯ_�����ʾҳ��
�� * �汾: v1.0
�� * ����: 2009��6��25��
�� * ����: libin,libina
�� * ��Ȩ: sitech
   * �޸���ʷ
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    	//�������
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

  String org_code = (String) (session.getAttribute("orgCode")==null?"":session.getAttribute("orgCode"));
  String regionCode = org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	
	String opCode = "";
  String opName = "ȫ����Ʒ��Ϣ";
%>


<html>
	<head>
	<title></title>
	</head>
<body>

<wtc:service name="sKFProdInfo_new" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">��Ʒ��Ϣ</div>
<table cellspacing="0" >
	    <tr> 
		    <th width="10%">����</th>
				<th width="10%">��Ʒ����</th>
				<th width="10%">��Ʒ����</th> 
				<th width="40%">��Ʒ��Чʱ��</th> 
				<th width="10%">��������</th> 
				<th width="20%">����ʱ��</th> 
	    </tr>
	    <tr>
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
			String classes="";
			if(i%2==0){
			  classes="grey";
			}
%>             
	       <td class="<%=classes%>" title="<%=result[i][0]%>" ><%=(("").equals(result[i][0])||result[i][0]==null)?"&nbsp;":result[i][0]%></td>
	       <td class="<%=classes%>" title="<%=result[i][1]%>" ><%=(("").equals(result[i][1])||result[i][1]==null)?"&nbsp;":result[i][1]%></td>
	       <td class="<%=classes%>" title="<%=result[i][2]%>" ><%=(("").equals(result[i][2])||result[i][2]==null)?"&nbsp;":result[i][2]%></td>
	       <td class="<%=classes%>" title="<%=result[i][3]%>" ><%=(("").equals(result[i][3])||result[i][3]==null)?"&nbsp;":result[i][3]%></td>
	       <td class="<%=classes%>" title="<%=result[i][4]%>" ><%=(("").equals(result[i][4])||result[i][4]==null)?"&nbsp;":result[i][4]%></td>
	       <td class="<%=classes%>" title="<%=result[i][5]%>" ><%=(("").equals(result[i][5])||result[i][5]==null)?"&nbsp;":result[i][5]%></td>
	     </tr>
<%
	  }
	 }
}
		%>
</table>
</div>

<wtc:service name="sServiceMsg" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
  <wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
<div id="Operation_Table"> 
<div class="title">�ѿ�ͨ�ط�����</div>
	<table cellspacing="0" id="myTable">
  	<tr> 
    	<th width="15%">��������</th>
			<th width="25%">��ͨʱ��</th>
			<th width="25%">����ʱ��</th>
			<th width="10%">�����</th>
			
	  </tr>
	 <%       
	   if("000000".equals(retCode)){
		  	for (int i=0;i<result0.length;i++){
			 %>
			 <tr align="center"> 
			 <% 
			    if(i%2==0){
			%>
						<td class="Grey"><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result1[i][0]%></td>
						<td class="Grey"><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result2[i][0]%></td>
						<td class="Grey"><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result3[i][0]%></td>
						<td class="Grey"><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result4[i][0]%></td>
      <%
				}else{
			%>
						<td><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result1[i][0]%></td>
						<td><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result2[i][0]%></td>            
            <td><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result3[i][0]%></td>
            <td><%=(("").equals(result1[i][0]) || result1[i][0]==null)?"&nbsp;":result4[i][0]%></td>
			<%
				}
		  %>
      </tr>
    <%}}%>
  </table>
</div>

<wtc:service name="sHW_SpQryByUsr" outnum="12" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="10" scope="end" />
<div id="Operation_Table"> 
<div class="title">�Ѷ���SPҵ��</div>
	<table cellspacing="0">
  	<tr>
    	<th width="8%"  NOWRAP>��ҵ����</th>
			<th width="8%"  NOWRAP>��ҵ����</th>
			<th width="8%"  NOWRAP>ҵ�����</th>
			<th width="8%"  NOWRAP>ҵ������</th>
			<th width="8%"  NOWRAP>�����</th>
			<th width="15%" NOWRAP>����ʱ��</th>		 
			<th width="8%"  NOWRAP>����/ȡ����ʽ</th>
			<th width="8%"  NOWRAP>�շѷ�ʽ</th>
			      
	  </tr> 	 
    <%
		if(retCode.equals("000000")){
			if(result!=null && result.length>0){
				for(int i=0;i<result.length;i++){
	      	String classes="";
					if(i%2==0){
						classes="grey";
					}
					double	price = 0.0;
					if(result[i][6]!=null && !"".equals(result[i][6])){
						price = Double.parseDouble(result[i][6])/1000;
					}	
			%>	             
		    <tr>	  
		    	<td nowrap class="<%=classes%>" title="<%=result[i][0]%>"><%=result[i][0].equals("")?"&nbsp;":result[i][0]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][1]%>"><%=result[i][1].equals("")?"&nbsp;":result[i][1]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][2]%>"><%=result[i][2].equals("")?"&nbsp;":result[i][2]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][3]%>"><%=result[i][3].equals("")?"&nbsp;":result[i][3]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][6]%>"><%=price%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][9]%>"><%=result[i][9].equals("")?"&nbsp;":result[i][9]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][8]%>"><%=result[i][8].equals("")?"&nbsp;":result[i][8]%></td>
		    	<td nowrap class="<%=classes%>" title="<%=result[i][5]%>"><%=result[i][5].equals("")?"&nbsp;":result[i][5]%></td>			
		    </tr>
		<%
			   }
			 }else{
		%>
			 	 <td nowrap align='center' colspan="8">���û�δ����SPҵ��</td>
		<%
			 }
		 }
		%>	
		<tr>
		</tr>
  </table>
</div>
<%@ include file="/npage/include/footer.jsp"%>  
</body>
</html>