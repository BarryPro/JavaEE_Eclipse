<%
/*
 * ����: ʡ��Я�� ��ѯ��Ʒ��Ϣ
 * �汾: 1.0
 * ����: 2012/4/25 14:19:13
 * ����: yanpx
 * ��Ȩ: si-tech
 * update:
*/
%>
<div id="bizDiv">
	<div class="title">
		<div id="title_zi">��Ʒ��Ϣ </div>
	</div>
</div>	
<wtc:service name="s2266InitNew" routerKey="region" routerValue="<%=regCode%>" outnum="19" >
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="2266"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
</wtc:service>
<wtc:array id="s2266InitNewArr" scope="end"/>
	
	
<wtc:service name="s6842Sel" routerKey="region" routerValue="<%=regCode%>" outnum="19" >
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="6842"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
</wtc:service>
<wtc:array id="s6842SelArr" scope="end"/>	
<%
	System.out.println("yanpx======"+phoneNo);
	System.out.println("yanpx======"+s2266InitNewArr.length);
	int giftCount = s2266InitNewArr.length+s6842SelArr.length;
%>
    <table>
          <tr align="center">
          		<th>Ӫ�������� </th>
              <th>���� </th>
              <th>��ȡ��־ </th>
              <th>�н����� </th>
              <th>ʵ����Ʒ </th>
              <th>��Ʒ��� </th>
              <th>Ӫ���ȼ����� </th>
          </tr>
          <%
          	for(int i=0;i<s2266InitNewArr.length;i++){
          			String tbclass = i%2==0 ? "Grey" : "";
          %>
          	<tr>
          		  <td class="<%=tbclass%>"><%=s2266InitNewArr[i][2]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][3]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][5]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][6]%></td>   
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][4]%> </td>  
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][1]%></td>   
								<td class="<%=tbclass%>"></td>    		
						</tr>
          <%
          	}
          	for(int j=0;j<s6842SelArr.length;j++){
          		String tbclass = j%2==0 ? "Grey" : "";
          %>
          	<tr>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][7]%></td>
							<td class="<%=tbclass%>"><%=s6842SelArr[j][11]%></td>
              <td class="<%=tbclass%>"><font color="red"><%=("O".equals(s6842SelArr[j][4])?"����δ��ȡ":"δ��ȡ")%></font></td>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][5]%></td>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][12]%></td>   
              <td class="<%=tbclass%>"></td>  
              <td class="<%=tbclass%>"><%=s6842SelArr[j][8]%></td>  
						</tr>                         		
          <%
          	}
          %>          
		</table> 
<script language="javascript">
	var giftCount = "<%=giftCount%>"; /*��ѯ����Ҫ�콱��Ӫ������Ϊ��Y��������Ϊ��N��������ʱ���ֶ�Ϊ��*/
</script>	         	      