<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String offerId =WtcUtil.repNull(request.getParameter("offerId"));//��������
  String [][] productInfo = null;
  System.out.println("***********************************************************=="+offerId);
%>

<wtc:utype name="sGetOfferById" id="retVal" scope="end">
	 <wtc:uparam value="<%=offerId%>" type="INT"/>  
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1);
	 System.out.println(retCode+"         "+retMsg);
	 if(retCode.equals("0"))
	{
  	int retValNum = retVal.getUtype("2").getSize();
  	productInfo = new String[1][9];
  	if(retValNum>0){
				  int n =0;
				 	for(int j=0;j<29;j++){
					/**����Ʒ��ʶ������Ʒ���ƣ�����Ʒ����������Ʒ���룬��Чʱ�䣬ʧЧʱ�䣬ƫ������ƫ�Ƶ�λ����Ч��ʽ*/
				 	if(j==0||j==4||j==5||j==7||j==10||j==11||j==17||j==18||j==28){
					    productInfo[0][n]=retVal.getUtype(2).getValue(j);
					    System.out.println("######################################################retResult[0]["+n+"]=="+productInfo[0][n]);
					    n++;
					  }
					}	
  	}
	}
%>

<script type="text/javascript">

</script>

		<table id="ta" cellspacing=0>
					<tr>
						<th>ѡ��</th>
						<th>����Ʒ����</th>
						<th>����Ʒ����</th>
						<th>��Чʱ��</th>
						<th>����Ʒ����</th>
						<th>���ۼƻ�</th>	
					</tr>			  
					<%
					for(int i =0;i<productInfo.length;i++){
					%>  		
					<tr>
						<td><input type="radio" name="proRad" checked disabled value="<%=productInfo[i][0]+","+productInfo[i][3]+","+productInfo[i][1]+","+productInfo[i][8]+","+productInfo[i][6]+","+productInfo[i][7]+","+productInfo[i][4]+","+productInfo[i][5]+","+productInfo[i][3]%>" ></td>
						<td><%=productInfo[i][0]%></td>
						<td><%=productInfo[i][1]%></td>
						<td><%=productInfo[i][8]%></td>
						<td><span class="text_long"><%=productInfo[i][2]%></spqn></td>
						<td><input type="button" class="b_text" value="�鿴" onclick="window.showModalDialog('showPrice.jsp?OFFER_ID=<%=productInfo[i][0]%>','dialogHeight=300px','dialogWidth=650px','help=no','status=no')" /></td>
					</tr>
<%
					}
%>				
			</table>