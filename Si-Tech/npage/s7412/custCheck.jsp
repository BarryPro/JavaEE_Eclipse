<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-10-30
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iCustId    = WtcUtil.repNull((String)request.getParameter("custId"));
    
    String errCode = "";
    String errMsg  = "";
    String cnt = "0";
    try{
        String sqlStr = "select count(*) from  dgrpusermsg where sm_code = 'DL' and (run_code = 'A' or ( run_code = 'I' and  op_time>to_date(to_char(last_day(add_months(sysdate,-1)),'yyyymmdd')||' 23:59:59','yyyymmdd hh24:mi:ss') ) ) and cust_id = '"+iCustId+"'";
    %>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg  = retMsg ;
        System.out.println("# return from custCheck.jsp -> errCode = " + errCode);
        System.out.println("# return from custCheck.jsp -> errMsg  = " + errMsg );
        
        if("000000".equals(errCode)){
            cnt = retArr[0][0];
        }
        System.out.println("# return from custCount.jsp -> cnt = " + cnt);
        
    }catch(Exception e){
        errCode = "999999";
        errMsg = "取客户信息失败！";
        e.printStackTrace();
    }
%>
var response = new AJAXPacket();
var vRetCode = "<%=errCode%>";
var vRetMsg  = "<%=errMsg%>";
var vCnt = "<%=cnt%>";
response.data.add("retCode",vRetCode);
response.data.add("retMsg",vRetMsg);
response.data.add("cnt",vCnt);
core.ajax.receivePacket(response);
