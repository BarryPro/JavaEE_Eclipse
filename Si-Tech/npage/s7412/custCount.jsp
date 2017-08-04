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
    String regionCode       = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iCustId          = WtcUtil.repNull((String)request.getParameter("custId"));
    String iTaskSmCode      = WtcUtil.repNull((String)request.getParameter("taskSmCode"));
    String iTaskBtnId       = WtcUtil.repNull((String)request.getParameter("taskBtnId"));
    String iTaskBizCode     = WtcUtil.repNull((String)request.getParameter("taskBizCode")); /* AD、ML时有值 */
    String iLoginAccept     = WtcUtil.repNull((String)request.getParameter("loginAccept"));
    String iChildAccept     = WtcUtil.repNull((String)request.getParameter("childAccept"));
    String iBbossFlag       = WtcUtil.repNull((String)request.getParameter("bBossFlag"));
    
    String errCode = "";
    String errMsg  = "";
    String oCustCnt= "";
    
    try{
        String sqlStr = "";
        if("AD".equals(iTaskSmCode) || "ML".equals(iTaskSmCode)){
            sqlStr = "select count(*) from dgrpusermsg a,dgrpusermsgadd b "
                + " where a.cust_id = '"+iCustId+"' and a.sm_code = '"+iTaskSmCode+"' and a.id_no = b.id_no "
                + " and b.FIELD_CODE = 'YWDM0' and b.FIELD_VALUE = '"+iTaskBizCode+"' and a.run_code = 'A' and a.region_code = '"+regionCode+"'";
        }else{
            sqlStr = "select count(*) from dgrpusermsg where cust_id = '"+iCustId+"' and sm_code ='"+iTaskSmCode+"' and run_code = 'A' and region_code = '"+regionCode+"'";
        }
    %>
        <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg  = retMsg ;
        System.out.println("# return from custCount.jsp -> errCode = " + errCode);
        System.out.println("# return from custCount.jsp -> errMsg  = " + errMsg );
        
        if("000000".equals(errCode)){
            if(retArr.length>0){
                oCustCnt = retArr[0][0];
            }else{
                oCustCnt = "0";
            }
        }
        System.out.println("# return from custCount.jsp -> oCustCnt = " + oCustCnt);
        
    }catch(Exception e){
        errCode = "999999";
        errMsg = "取客户信息失败！";
        e.printStackTrace();
    }
%>
var response = new AJAXPacket();
var vRetCode = "<%=errCode%>";
var vRetMsg  = "<%=errMsg%>";
var vCustCnt = "<%=oCustCnt%>";
var vTaskSmCode = "<%=iTaskSmCode%>";
var vTaskBtnId = "<%=iTaskBtnId%>";
var vTaskBizCode = "<%=iTaskBizCode%>";
var vLoginAccept = "<%=iLoginAccept%>";
var vChildAccept = "<%=iChildAccept%>";
var vBbossFlag = "<%=iBbossFlag%>";

response.data.add("retCode",vRetCode);
response.data.add("retMsg",vRetMsg);
response.data.add("custCnt",vCustCnt);
response.data.add("taskSmCode",vTaskSmCode);
response.data.add("taskBtnId",vTaskBtnId);
response.data.add("taskBizCode",vTaskBizCode);
response.data.add("loginAccept",vLoginAccept);
response.data.add("childAccept",vChildAccept);
response.data.add("bBossFlag",vBbossFlag);

core.ajax.receivePacket(response);
