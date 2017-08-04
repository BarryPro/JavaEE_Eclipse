<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% 
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
	String cust_id = request.getParameter("cust_id");
	String sm_code = request.getParameter("sm_code");
	int    retCode = 0;
	String retMsg = "";

	String grpFlag = "";
	int	   iCount = 0;

	String sqlStr = "";
	//String[][] resultList = new String[][]{};
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	sqlStr="select grp_flag from sGrpSmCode where sm_code='"+sm_code+"'";
	//resultList=(String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="resultList" scope="end" />
<%
    if(resultList.length>0 && retCode1.equals("000000")){
	    grpFlag=resultList[0][0];
	}
	if (grpFlag.equals("Y"))
	{
		sqlStr="select count(*) from dGrpContract where cust_id="+cust_id;
		//resultList=(String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="resultList" scope="end" />
<%
        if(resultList.length>0 && retCode2.equals("000000")){
		    iCount=Integer.parseInt(resultList[0][0]);
		}
	}

%>

var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType","<%=request.getParameter("retType")%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("grpFlag","<%=grpFlag%>");
response.data.add("iCount","<%=iCount%>");
core.ajax.receivePacket(response);

