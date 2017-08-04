   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("getGrpUserno.jsp");
	String orgCode = request.getParameter("orgCode");
	String smCode  = request.getParameter("smCode");
    String grpId   = request.getParameter("grpId");
	String regionCode = orgCode.substring(0,2);

    ArrayList retArray = new ArrayList();
	String []inputPara = new String[]{regionCode,smCode};
		
		String result[][] =new String[][]{};
		
    String grpno = "";
    String SeqFlag = "";

    String returnCode = "0";
    String retMessage = "查询成功！";


        String sqlStr = "select Seq_Flag from sGrpSmCode where sm_code = '" + smCode + "'";
        //retArray = impl.sPubSelect("1",sqlStr);
        
%>        
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%        
        result = result_t1;
        SeqFlag = (result_t1[0][0]).trim();
        if (SeqFlag.compareToIgnoreCase("N") == 0) {
            grpno = grpId;
        } else {
%>

    <wtc:service name="sGetGrpUserNo" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=regionCode%>" />
			<wtc:param value="<%=smCode%>" />
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<%        	
            grpno = result_t2[0][0];
            
            System.out.println("-----------grpno----------------"+grpno);
    	    returnCode = code2;
            retMessage = msg2;
        }

%>   
var response = new AJAXPacket();
var retType = '<%= request.getParameter("retType") %>';
var retCode = "<%=returnCode%>";
var retMessage = "<%=retMessage%>";
var grpno = "<%=grpno%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("GrpNo",grpno);
core.ajax.receivePacket(response);

