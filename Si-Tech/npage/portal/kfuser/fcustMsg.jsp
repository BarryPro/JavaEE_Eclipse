<%
   /*
   * ����: ��ѯ�û���Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��17��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2009-05-12     �޸���  libina     �޸�Ŀ��  ���ӻ�����ϸ��ѯ������
   * �޸����� 2009-05-13     �޸���  libina     �޸�Ŀ��  �޸��ʻ�����ʽ
   * �޸����� 2009-05-13     �޸���  libina     �޸�Ŀ��  ���˵���ʷ��ѯ��1350��Ϊ1351
   * �޸����� 2009-06-04     �޸���  libina     �޸�Ŀ��  �����а�ȫ��������Ϣ
   * �޸����� 2009-06-06     �޸���  libina     �޸�Ŀ��  �Ż�ҳ��
   * �޸����� 2009-06-24     �޸���  libina     �޸�Ŀ��  �޸��˵���ʷ��ѯ������
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
     
     String phone_no = (String)session.getAttribute("activePhone");
     if(phone_no==null||phone_no.equals("")){
       phone_no =request.getParameter("activePhone");
     }
     System.out.println("activePhone"+phone_no);
	String cust_name            = "";
	String id_name              = "";
	String id_iccid             = "";
	String contact_address      = "";
	String vphone_no            = "";
	String open_time            = "";
	String card_name            = "";
	String product_name         = "";
	String town_name            = "";
	String run_name             = "";
	String prepay_fee           = "0";
	String current_point        = "0";
	String vred_flag            = "";
	String vblack_flag          = "";
	String sm_name              = "";
	String grade_code	          = "";
	String region_code	        = "";
	String customer_credibility = "";
%>

<wtc:service name="sKFCustInfo_new" outnum="17" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result0" start="0" length="16" scope="end" />

<%
System.out.println("fcustMsg.jsp__retCode:"+retCode);
if("000000".equals(retCode)){
       if(result0.length>0){
			cust_name            = result0[0][0]==null?"":result0[0][0];
			id_name              = result0[0][1]==null?"":result0[0][1];
			id_iccid             = result0[0][2]==null?"":result0[0][2];
			contact_address      = result0[0][3]==null?"":result0[0][3];
			vphone_no            = result0[0][4]==null?"":result0[0][4];
			open_time            = result0[0][5]==null?"":result0[0][5];
			card_name            = result0[0][6]==null?"":result0[0][6];
			product_name         = result0[0][7]==null?"":result0[0][7];
			town_name            = result0[0][8]==null?"":result0[0][8];
			run_name             = result0[0][9]==null?"":result0[0][9];
			prepay_fee           = result0[0][10]==null?"0.0":result0[0][10];
			current_point        = result0[0][11]==null?"0":result0[0][11];
			vred_flag            = result0[0][12]==null?"":result0[0][12];
			vblack_flag          = result0[0][13]==null?"":result0[0][13];
			sm_name		           = result0[0][14]==null?"":result0[0][14];	
			customer_credibility = result0[0][15]==null?"":result0[0][15];	
      }   
} 
%>
<wtc:array id="result1" start="16" length="1" scope="end" />
<%
String kim_phone = new String();
  if(retCode.equals("000000")){
         if(result1.length>0){          
  	       	for(int i=0;i<result1.length;i++){
  	       	   if(result1[i][0]!=null){
  	       	    	kim_phone = kim_phone+result1[i][0]+"|";
  	       	   }else{
  	       	   		kim_phone="��";
  	       	   }
  	       	}	       	      
         }  
  }
%>
<link href="../../../nresources/default/css/portalet.css"rel="stylesheet"type="text/css">
<link href="../../../nresources/default/css/font_color.css"rel="stylesheet" type="text/css">	
<div id="blueBG">
 <div id="Info_table">
 	<table border="0" cellpadding="0" cellspacing="6" width="100%" class="ctl">
  	<tr>
  	    <th width="10%" nowrap >������</th>
  	  	<td width="30%" nowrap><%=cust_name%></td>
  	  	<th width="10%" nowrap>������룺</th>
  	  	<td width="40%"  colspan="3"><%=vphone_no%></td>
  	  	<!--fSimDetailInfo.jsp-->
  	</tr>
  	<tr>
  	    <th nowrap >֤�����ͣ�</th>
  	  	<td nowrap><%=id_name%></td>
  	  	<th nowrap>����ʱ�䣺</th>
  	  	<td colspan="3" nowrap><%=open_time%></td>  	   	
  	</tr>
  	<tr>
  	    <th nowrap >֤�����룺</th>
  	  	<td nowrap><%=id_iccid%></td>
  	  	<th nowrap>Ʒ�ƣ�</th>
  	  	<td colspan="3" nowrap><%=null == sm_name?"" : sm_name.trim()%></td>	   	
  	</tr>
  	<tr><th nowrap >��ַ��</th>
  	  	<td nowrap><%=contact_address%></td>
  	  	<th nowrap>�ײͣ�</th>
  	  	<td colspan="3" nowrap><%=product_name%></td>  	   	
  	</tr>
  	<tr>
  	  	<th nowrap>����Ӫҵ����</th>
  	  	<td nowrap><%="".equals(town_name)?"δ֪":town_name%></td>
  	   	<th nowrap>����</th>
  	  	<td colspan="3" nowrap><%=card_name%></td>
  	</tr>
  	<tr> 	  	  	     	  	
  	  	<th nowrap>�ʻ���</th>
  	  	<td >
  	  		<span class="green"><%=Double.parseDouble(prepay_fee)*-1%></span>&nbsp;&nbsp;&nbsp;<%if((Double.parseDouble(prepay_fee)*-1)<5) out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>�����ѽɷѣ�</span>");  %> 
				</td>
				<th nowrap>�û������ȣ�</th>
  	  	<td colspan="3" title="<%=customer_credibility%>" nowrap><%=customer_credibility%></td>	
  	</tr>
  	<tr>
  	  	<th nowrap>״̬��</th>
  	  	<td  nowrap><span class="green"><%=run_name%></span>&nbsp;&nbsp;&nbsp; <%if(!run_name.equals("����")) out.print("<img src='../../../nresources/default/images/shine.gif'><span class='orange'>�����ѿ�ͨ��</span>");  %></td>
  	   	<th nowrap>���֣�</th>
  	  	<td colspan="3" nowrap><span class="green"><%=current_point%></span>
  	    <%if(Float.parseFloat(current_point)>300)out.print("<img src='../../../nresources/default/images/shine.gif' ><span class='orange'>���������ѣ�</span>"); %></td>
  	</tr>
  	<tr>
  	  	<th nowrap >��������</th>
  	  	<td nowrap><%=vblack_flag%></td>
  	   	<th nowrap>��������</th>
  	  	<td colspan="3" nowrap><%=vred_flag%></td>
  	</tr>
  	<tr>
  	    <th nowrap>������룺</th>
  	  	<td title="<%=kim_phone%>" nowrap>
  	  		<% 
  	  		// xingzhan 20090220 16:10 ��������Ϊ��������ģʽ
  	  				if(kim_phone==null||"".equals(kim_phone)){
  	  		%>
  	  		      ��
  	  		<%						
  	  				}else{
  	  		%>
  	  		      <a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperKim_PhoneInfo.jsp?kim_phone=<%=kim_phone%>&vphone_no=<%=vphone_no%>');"><span class='orange'>[�������]</span></a>
  	  		<%
  	  				}
  	  		%>
  	  	</td>
  	  	<th colspan="4"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fSimDetailInfo.jsp');"><span class='orange'>[SIM������]</span></a></th>	   	
  	</tr>
  	<tr>
			  <th colspan="2"><a href=javascript:parent.parent.parent.L("2","1515","��ѷ�������ѯ","MessageQuery/s1515/f1515_1.jsp","000")><span class='orange'>[��ѷ�������ѯ]</span></a></th>
  	   	<th colspan="4"><a href=javascript:parent.parent.parent.L("2","1270","���ʷѱ��","../../../page/ProductChange/f1270_login.jsp","000")  ><span class='orange'>[���ʷѱ��]</span></a></th>
  	</tr>
  	<tr> 	  	
  	   	<th colspan="2"><a href=javascript:parent.parent.parent.L("2","1351","�ʵ���ʷ��ѯ","../npage/portal/kfuser/f1351_kf.jsp?phoneNo=<%=phone_no%>","000")  ><span class='orange'>[�ʵ���ʷ��ѯ]</span></a></th>
  	    <th colspan="4"><a href=javascript:parent.parent.parent.L("2","7135","��ҵ����","../../../page/ProductChange/f7135_login.jsp","000")  ><span class='orange'>[��ҵ����]</span></a></th>
  	</tr>
  	<tr>
  	    <th colspan="2"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fKFPointDetail.jsp');"><span class='orange'>[������ϸ��ѯ]</span></a></th>
  	  	<th colspan="4"><a href=javascript:parent.parent.parent.L("2","1213","�ۺϱ��","PersonChange/s1213/f1213.jsp","000")  ><span class='orange'>[�ۺϱ��]</span></a></th>
  	</tr>
	  <tr>
  	    <th colspan="2"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fPayHistoryInfo.jsp');"><span class='orange'>[�ɷѲ�ѯ]</span></a></th>
  	    <th colspan="1"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fOperHistoryInfo.jsp');"><span class='orange'>[��ʷ��Ϣ]</span></a></th>
  	    <th colspan="3"><a href="javaScript:showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fProductService.jsp');"><span class='orange'>[ȫ����Ʒ��Ϣ]</span></a></th>
  	</tr>
</table>
</div>
</div>
<script>
function showPageInfo(tagUrl)
{
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
}
</script>