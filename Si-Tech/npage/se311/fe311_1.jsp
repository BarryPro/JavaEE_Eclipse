<%
/********************
 * version v2.0
 * ������: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String phoneNo 	= request.getParameter("phoneNo");
		String sqlstr1 ="SELECT a.id_no,b.region_code from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no=:phoneNo";
		
		String srv_params = "phoneNo=" + phoneNo;
		String idNO="";
		String regioncodess="";
%>
		<wtc:service name="TlsPubSelCrm" outnum="2" retcode="retCode11" retmsg="retMsg11">
				<wtc:param value="<%=sqlstr1%>"/>
				<wtc:param value="<%=srv_params%>"/>
		</wtc:service>
    <wtc:array id="ret11"  scope="end"/> 
<%
		if("000000".equals(retCode11)&&ret11.length>0){
			idNO=ret11[0][0];
			regioncodess=ret11[0][1];
			if(!regioncodess.equals(regionCode)) {
				%>
			<script language="javascript">
	      rdShowMessageDialog("���������в�ѯ��������������룡", 0);
	   	</script>
<%
			return;
			}
	  }
	String sqlstr2 ="SELECT b.offer_id,b.offer_name,TO_CHAR(a.state_date,'YYYY-MM-dd hh24:mi:ss') FROM product_offer_instance a, product_offer b WHERE a.serv_id="+idNO+" AND SYSDATE BETWEEN a.eff_date AND a.exp_date AND a.offer_id = b.offer_id  AND b.offer_attr_type = 'YnYc' ";			
%>
      	
    <wtc:pubselect name="sPubSelect"  outnum="3" retcode="retCode" retmsg="retMsg">
    <wtc:sql>
    	<%=sqlstr2%>
    </wtc:sql>  
     </wtc:pubselect>        
      <wtc:array id="ret"  scope="end"/> 
<%
		 if("000000".equals(retCode)){
			
		 }else{
%>
			<script language="javascript">
	      rdShowMessageDialog("������Ϣ��<%=retMsg%><br>������룺<%=retCode%>", 0);
	   	</script>
<%
		
		}
%>
<body>
		<br>
			<div class="title">
				<div id="title_zi">��ѯ��ϢΪ��</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>�ֻ�����</th>
					<th>�ʷѴ���</th>
					<th>�ʷ�����</th>
					<th>����ʱ��</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
%>
					<tr >
						<td><%=phoneNo%></td>
						<td><%=ret[0][0]%></td>
						<td><%=ret[0][1]%></td>
						<td><%=ret[0][2]%></td>
					</tr>
<%			
				}
%>
			</table>

</body>

</html>
      	
