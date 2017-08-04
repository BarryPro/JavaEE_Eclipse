<%

/********************

 * @ OpCode    :  3218

 * @ OpName    :  查询集团成员列表

 * @ CopyRight :  si-tech

 * @ Author    :  wangzn

 * @ Date      :  2011/7/22 8:41:49

 * @ Update    :  

 ********************/

%>


<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	int beginNum = 1;

	int endNum = 40000;

	int countNum = 3000;

	



	String loginNo = (String)session.getAttribute("workNo");

	String loginName = (String)session.getAttribute("workName");

	String orgCode = (String)session.getAttribute("orgCode");

	String ip_Addr = (String)session.getAttribute("ipAddr");

	String regionCode = (String)session.getAttribute("regCode");

	String orgId = regionCode = (String)session.getAttribute("orgId");

	

	String[][] input_paras = new String[1][13];

	

	String opCode = request.getParameter("opCode");

  	String opNote = request.getParameter("opNote");

  	String grpId = request.getParameter("GRPID");

  	String QRYTYPE = request.getParameter("QRYTYPE");

  	

%>

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="seq"/>

<%

  	

	input_paras[0][0] = request.getParameter("loginNo"); 	/* 操作工号   */ 

	input_paras[0][1] = request.getParameter("orgCode");	/* 机构编码   */

	input_paras[0][2] = regionCode;							/* 地区代码   */

	input_paras[0][3] = request.getParameter("opCode");		/* 操作代码   */

	input_paras[0][4] = request.getParameter("opNote");		/* 操作备注   */

	input_paras[0][5] = seq;								/* 操作流水   */

	input_paras[0][6] = ip_Addr;

	input_paras[0][7] = orgId ;

	input_paras[0][8] = "2";								/* 操作类型	0、查询 1、翻页 2、导出 */

	input_paras[0][9] =	grpId;								/* 集团号     */

	input_paras[0][10] = request.getParameter("QRYTYPE");	/* 查询类型 0 网内 1、网外*/

	//input_paras[0][11] = beginNum.toString();

	//input_paras[0][12] = endNum.toString();

  	

  	for(int i=0; i<input_paras[0].length; i++){

		

		if( input_paras[0][i] == null ){

			input_paras[0][i] = "";

		}

		System.out.println("["+i+"]="+input_paras[0][i]);

	}

	

	

	int sheetNum = 0;

	input_paras[0][11] = "0";

	input_paras[0][12] = "0";

	

	//查询数据

%>		

	<wtc:service name="s3218Cfm" outnum="10" retmsg="returnMessage" retcode="returnCode" routerKey="region" routerValue="<%=regionCode%>">

		<wtc:param value="<%=input_paras[0][0 ]%>" />

		<wtc:param value="<%=input_paras[0][1 ]%>" />	

		<wtc:param value="<%=input_paras[0][2 ]%>" />

		<wtc:param value="<%=input_paras[0][3 ]%>" />

		<wtc:param value="<%=input_paras[0][4 ]%>" />

		<wtc:param value="<%=input_paras[0][5 ]%>" />

		<wtc:param value="<%=input_paras[0][6 ]%>" />

		<wtc:param value="<%=input_paras[0][7 ]%>" />

		<wtc:param value="<%=input_paras[0][8 ]%>" />

		<wtc:param value="<%=input_paras[0][9 ]%>" />

		<wtc:param value="<%=input_paras[0][10]%>" />

		<wtc:param value="<%=input_paras[0][11]%>" />

		<wtc:param value="<%=input_paras[0][12]%>" />

	</wtc:service>

	<wtc:array id="result_t1" start="0" length="1" scope="end"/>

	<wtc:array id="result_t2" start="1" length="9" scope="end"/>  <%//diling add@2011/10/3 增加4个参数的输出%>

var response = new AJAXPacket();
response.data.add("retcode","<%= returnCode %>");
response.data.add("retmsg","<%= returnMessage %>");
core.ajax.receivePacket(response);