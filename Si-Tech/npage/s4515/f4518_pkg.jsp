   
<%
/********************
 version v2.0
 ������ si-tech
 create wanghlc@2009-8-31
********************/
%>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>            
<%
  String opCode = "4518";
  String opName = request.getParameter("opName");
  String work_no = request.getParameter("work_no");
 	String start_time = request.getParameter("start_time");
  String end_time = request.getParameter("end_time");
  String pkg_code = request.getParameter("pkg_code");
	StringBuffer countSql = new StringBuffer();
	countSql.append("select region_name,trim(pkg_code)||'-->'||trim(pkg_name),update_login,to_char(stop_time,'YYYY-MM-DD'),trim(power_right),to_char(old_stop_time,'YYYY-MM-DD'),trim(old_power_right),decode(update_type,'A','����','U','�޸�'),to_char(update_time,'YYYY-MM-DD HH24:MM:SS') from svpmnpkgcodehis a,sregioncode b where a.region_code = b.region_code and update_type is not null ");
	if(!("".equals(work_no))){
		countSql.append("and update_login='"+work_no+"' ");
	}
	if(!("".equals(start_time))){
		countSql.append("and update_date>=to_number('"+start_time+"') ");
	}
	if(!("".equals(end_time))){
		countSql.append("and update_date<=to_number('"+end_time+"') ");
	}
	if(!("".equals(pkg_code))){
		countSql.append("and pkg_code = '"+pkg_code+"'");
	}
	countSql.append("order by update_accept desc");
	String countSqlc = countSql.toString();
	
		/**��ҳҪ�õĴ���**/
	Map map = request.getParameterMap();
	String totalNumber = "";
	String currentPage = request.getParameter("currentPage") == null ? "1"
			: request.getParameter("currentPage");
	String pageSize = "10";
	/******************/


	String powerCode2=(String)session.getAttribute("powerCode");
	ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
		String[][] powerRight = (String[][])powerRightArr.get(0);
		HashMap m = new HashMap();
		for(int i = 0 ; i<powerRight.length; i ++){
			m.put(powerRight[i][0],powerRight[i][1]);
		}
		
	
%>              




	
	
<html>
<head>
	<!--************************��ҳ����ʽ��**************************-->
		<link rel="stylesheet" type="text/css"
			href="/nresources/default/css/fenye.css" media="all" />
<base target="_self">
<title>�ʷ����ò�����ϸ��Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
function gotoPage(pageId){
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
}
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">�ʷ����ò�����ϸ��Ϣ</div>
	</div>
	
	  <%
			String countSqlAll = PageFilterSQL.getCountSQL(countSqlc);
		%>
		<wtc:pubselect name="sPubSelect" outnum="10">
			<wtc:sql><%=countSqlAll%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="allNumStr" scope="end" />
		<%
			if (allNumStr != null && allNumStr.length > 0) {
				totalNumber = allNumStr[0][0];
			}

    	String querySql = PageFilterSQL.getOraQuerySQL(countSqlc, currentPage,	pageSize, totalNumber);
    	
		%>


				<table cellspacing="0" >
					<tr  height="22">
							<TD align="center" class="blue">����</TD>			
							<TD align="center" class="blue">�ʷ�����</TD>									
	  					<TD align="center" class="blue">����</TD>
	  					<TD align="center" class="blue">��������</TD>
	  					<TD align="center" class="blue">Ȩ��</TD>
	  					<TD align="center" class="blue">����ǰ��������</TD>
	  					<TD align="center" class="blue">����ǰȨ��</TD>
	  					<TD align="center" class="blue">����</TD>
	  					<TD align="center" class="blue">����ʱ��</TD>    
				  </tr>	
		  <wtc:pubselect name="sPubSelect" outnum="14">
				<%--outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
				<wtc:sql><%=querySql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="rows" scope="end" />
				
					<%
					for (int i = 0; i < rows.length; i++) {
					String str = rows[i][4];
					String str1 = rows[i][6];
				%>
				<tr align="center">
					<td nowrap><%=rows[i][0]%>&nbsp;</td>
					<td nowrap align="left"><%=rows[i][1]%>&nbsp;</td>
					<td nowrap><%=rows[i][2]%>&nbsp;</td>
					<td nowrap><%=rows[i][3]%>&nbsp;</td>
					<td nowrap><%=m.get(str)%>&nbsp;</td>
					<td nowrap><%=rows[i][5]%>&nbsp;</td>
					<td nowrap><%=(m.get(str1)==null?"":m.get(str1))%>&nbsp;</td>
					<td nowrap><%=rows[i][7]%>&nbsp;</td>
					<td nowrap><%=rows[i][8]%>&nbsp;</td>
					
				</tr>
				<%
					}
				%>
				
				  
	  	<tr>
					<td colspan="14" align="right">
						<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>�ܼ�<B
							class="orange"><%=totalNumber%></B>����¼</a>
					</td>
				</tr>
							
				  
				  
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="iframeClose()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
</TABLE>	


	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
	  <form name="form2" method="post">
		<%=PageListNav.writeRequestString(map, currentPage)%>
	</form>
 </div>
</body>
</html>

