<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.lang.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String res_group_id = (String)session.getAttribute("groupId");

	String begin_no = request.getParameter("begin_no");   
	String end_no = request.getParameter("end_no");       
	long cha = 0;
	String chasqls="select Trim("+end_no.trim()+")-Trim("+begin_no.trim()+") from dual";	
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=chasqls%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="alsss" scope="end"/> 
<%
cha =Long.parseLong(alsss[0][0]);	

	String card_num = request.getParameter("card_num");   
	String card_type = request.getParameter("card_type"); 
	String rpc_page = request.getParameter("rpc_page");   //query_card

	boolean query_result = false;
	String card_type_name = "";
	String card_value = "";
	String errorMsg = "";

	StringBuffer sqlbuf = new StringBuffer();
	sqlbuf.append(" select DISTINCT in_table from dchnfilerec where ")
			  .append(" LENGTH(BEGIN_NO) = LENGTH('")
			  .append(begin_no)
			  .append("') ")
			  .append(" AND ((TO_NUMBER(BEGIN_NO) <= TO_NUMBER('")
			  .append(begin_no)
			  .append("') and ")
			  .append(" TO_NUMBER(END_NO) >= TO_NUMBER('")
			  .append(end_no)
			  .append("')) or ")
			  .append(" (TO_NUMBER(BEGIN_NO) <= TO_NUMBER('")
			  .append(end_no)
			  .append("') and ")
			  .append(" TO_NUMBER(END_NO) >= TO_NUMBER('")
			  .append(begin_no)
			  .append("')))");
			  
	System.out.println("sql1 = "+sqlbuf.toString());
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlbuf%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="al" scope="end"/>

<%
	String tab_name = (al != null && al.length == 1) ? al[0][0] : "";
	if("".equals(tab_name)){errorMsg="查询充值卡错误!";}
	if(!"".equals(tab_name)){
		String sqls = new StringBuffer("select count(*) from ").append(tab_name)
				.append( " where card_no>='" )
				.append( begin_no ).append( "' " ).append( " and card_no<='" )
				.append( end_no ).append( "' " ).append( " and length('" ).append( begin_no )
				.append( "') " ).append( "= length('" ).append( end_no ).append( "') " )
				.append( " and card_status='1' and group_id = '" ).append( res_group_id ).append( "'" )
				.append( " and isactive='1' ").toString();

		System.out.println("sql2 = "+sqls.toString());
		
	%>
		<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=sqls%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="list" scope="end"/>
	<%
	if (list != null && list.length != 0) {
		if ((cha+1) != Integer.parseInt(list[0][0])) {
			query_result = false;
			errorMsg="充值卡数目、状态或类型不正确!";
		} else {
			if (list[0][0].equals(card_num)) {
				query_result = true;
				String sqlt = new StringBuffer("select res_name, b.PAR_VALUE from ")
					.append("dChnCardRes a,sChnResCode b where card_no = '")
					.append(begin_no)
					.append("' and a.res_code = b.res_code").toString();
				System.out.println("sql3="+sqlt);
				%>
				  <wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql><%=sqlt%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="list1" scope="end"/>
				<%
				if(list1 != null && list1.length != 0){
					card_type_name = list1[0][0];
					card_value = list1[0][1];
				}else{
					System.out.println("查询卡资源类型失败!");
				}
			} else {
				errorMsg="充值卡数目或类型不正确";
			}
		}
	} else {
		errorMsg="查询充值卡错误!";		
	}
}
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","<%=rpc_page%>");
response.data.add("result","<%=query_result%>");
response.data.add("card_type","<%=card_type_name%>");
response.data.add("card_value","<%=card_value%>");
response.data.add("error_msg","<%=errorMsg%>");
response.data.add("begin_no","<%=begin_no%>");

core.ajax.receivePacket(response);
