<%
/********************
 * version v2.0
 * 开发商: si-tech
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
	      rdShowMessageDialog("不允许跨地市查询，请重新输入号码！", 0);
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
	      rdShowMessageDialog("错误信息：<%=retMsg%><br>错误代码：<%=retCode%>", 0);
	   	</script>
<%
		
		}
%>
<body>
		<br>
			<div class="title">
				<div id="title_zi">查询信息为：</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>手机号码</th>
					<th>资费代码</th>
					<th>资费名称</th>
					<th>办理时间</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("没有任何记录！");
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
      	
