<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%  
    String opCode = "d668";
    String opName = "局数据管理";	
   	String workNo = (String)session.getAttribute("workNo");
	  String org_code_note = (String)session.getAttribute("orgCode");
	  String paraAray[] = new String[35];
	  paraAray[0] = request.getParameter("optflag");
    if(paraAray[0].equals("0"))
    {
	    paraAray[1] = workNo;
	    paraAray[2] = request.getParameter("dsmpType");
	    paraAray[3] = request.getParameter("spid");
	    paraAray[4] = request.getParameter("spname");
	    paraAray[5] = request.getParameter("spType");
	    paraAray[6] = request.getParameter("devcode");
	    paraAray[7] = request.getParameter("provcode");
	    paraAray[8] = request.getParameter("balprov");
	    paraAray[9] = request.getParameter("validdate");
	    paraAray[10] = request.getParameter("expiredate");
	    paraAray[11] = request.getParameter("servflag");
	    paraAray[12] = request.getParameter("spattr");
	    paraAray[13] = request.getParameter("spstatus");
			paraAray[14] =request.getParameter("spsvcid");
			paraAray[15] =request.getParameter("spenname");
			paraAray[16] =request.getParameter("spshortname");
			paraAray[17] =request.getParameter("spdesc");
			paraAray[18] =request.getParameter("csrtel");
			paraAray[19] =request.getParameter("csrurl");
			paraAray[20] =request.getParameter("contactperson");
			paraAray[21] =request.getParameter("fixedline");
	  }
	  else
		{
			paraAray[1] = workNo;
	    paraAray[2] = request.getParameter("dsmpType");
	    paraAray[3] = request.getParameter("spid");
	    paraAray[4] = request.getParameter("bizno");
	    paraAray[5] = request.getParameter("bizname");
	    paraAray[6] = request.getParameter("billingtype");
	    paraAray[7] = request.getParameter("infofee");
	    paraAray[8] = request.getParameter("balprop");
	    paraAray[9] = request.getParameter("validdate");
	    paraAray[10] = request.getParameter("expiredate");
	    paraAray[11] = request.getParameter("num");
	    paraAray[12] = request.getParameter("reconfirm");
	    paraAray[13] = request.getParameter("isthirdvalidate");
	    paraAray[14] = request.getParameter("biztype");
			paraAray[15] = request.getParameter("bizdesc");
			paraAray[16] = request.getParameter("servtype");
			paraAray[17] = request.getParameter("servidalias");
			paraAray[18] = request.getParameter("submethod");
			paraAray[19] = request.getParameter("accessmodel");
			paraAray[20] = request.getParameter("provaddr");
			paraAray[21] = request.getParameter("provport");
			paraAray[22] = request.getParameter("usagedesc");
			paraAray[23] = request.getParameter("introurl");
			paraAray[24] = request.getParameter("other_bal_obj1");
			paraAray[25] = request.getParameter("other_bal_obj2");
			paraAray[26] = request.getParameter("innetcount");
			paraAray[27] = request.getParameter("servattr");
			paraAray[28] = request.getParameter("bizstatus");
			paraAray[29] = request.getParameter("serv_property");
		}
%>
	<wtc:service name="sd668update" routerKey="region" routerValue="<%=org_code_note%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
	<wtc:param value="<%=paraAray[16]%>"/>
	<wtc:param value="<%=paraAray[17]%>"/>
	<wtc:param value="<%=paraAray[18]%>"/>
	<wtc:param value="<%=paraAray[19]%>"/>
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
	<wtc:param value="<%=paraAray[23]%>"/>
	<wtc:param value="<%=paraAray[24]%>"/>
	<wtc:param value="<%=paraAray[25]%>"/>
	<wtc:param value="<%=paraAray[26]%>"/>
	<wtc:param value="<%=paraAray[27]%>"/>
	<wtc:param value="<%=paraAray[28]%>"/>
	<wtc:param value="<%=paraAray[29]%>"/>
</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
