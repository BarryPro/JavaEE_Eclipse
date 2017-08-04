<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  String workNo = WtcUtil.repNull(request.getParameter("workNo")); 
  String oldWorkNo = WtcUtil.repNull(request.getParameter("oldWorkNo")); 
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")); 
	
  String sqlGetWorkNo = "";
  System.out.println("====wanghfa====ajax_checkWorkNo.jsp==== indexOfTest = ");
	if ("newweb,newsms,newwap".indexOf(workNo) != -1) {
		 sqlGetWorkNo = "select count(*)"
			 + "  from dloginmsg"
			 + " where login_no = '" + workNo + "'"
			 + "   and group_id in"
			 + "       (select parent_group_id"
			 + "          from dchngroupinfo"
			 + "         where parent_group_id not in ('1000', '10014')"
			 + "           and group_id ="
			 + "               (select group_id from dcustmsg where phone_no = '" + phoneNo + "'))";
	} else {
		sqlGetWorkNo = "select count(*)"
			 + "  from dloginmsg"
			 + " where login_no = '" + workNo + "'"
			 + "   and group_id in"
			 + "       (select parent_group_id"
			 + "          from dchngroupinfo"
			 + "         where parent_group_id not in ('1000', '10014')"
			 + "           and group_id ="
			 + "               (select group_id from dloginmsg where login_no = '" + oldWorkNo + "'))";
	}
  System.out.println("====wanghfa====ajax_checkWorkNo.jsp==== sqlGetWorkNo = " + sqlGetWorkNo);
  String result = "";
%>
	<wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlGetWorkNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	System.out.println("====ajax_checkWorkNo.jsp====wanghfa==== sPubSelect " + retCode1 + ", " + retMsg1);
	if ("000000".equals(retCode1) && result1.length > 0) {
		System.out.println("====ajax_checkWorkNo.jsp====wanghfa==== result1[0][0] = " + result1[0][0]);
		result = result1[0][0];
	}
%>
<%=result%>
