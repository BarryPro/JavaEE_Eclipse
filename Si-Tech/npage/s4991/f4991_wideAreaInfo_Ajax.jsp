<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt" %>
<%
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
    String cfmLogin = request.getParameter("cfmLogin");
    String idIccid = "";
    String phone_no = "";
    String custName = "";
    String id_no = "";
    String sm_name = "";
    String sm_code = "";
    String vModeName = "";
    String vModeCode = "";
    String run_name = "";
    String run_code = "";
    String vOweFee = "";
    String vAttrName = "";
    String vCustAttr = "";
    String attname = "";
    String attcode = "";
    String vDetailAddr = "";
    System.out.println("+++++++++cfmLogin=[" + cfmLogin + "]");
%>
<wtc:service name="sGBroadBandMsg" routerKey="region" routerValue="<%=regionCode%>" outnum="20" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=cfmLogin%>"/>
    <wtc:param value="4991"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	System.out.println("+++++++++retCode=[" + retCode + "]");
    System.out.println("+++++++++retMsg=[" + retMsg + "]");
    if ("000000".equals(retCode) || "0".equals(retCode)) {
    System.out.println("++++++++++++result.length=["+result.length+"]");
        if (result.length > 0) {
            idIccid = result[0][19].trim();
            phone_no = result[0][14].trim();
            id_no = result[0][0].trim();
            sm_name = result[0][2].trim();
            sm_code = result[0][1].trim();
            custName = result[0][3].trim();
            vModeName = result[0][7].trim();
            vModeCode = result[0][6].trim();
            run_name = result[0][5].trim();
            run_code = result[0][4].trim();
            vOweFee = result[0][11].trim();
            vAttrName = result[0][9].trim();
            vCustAttr = result[0][8].trim();
            attname = result[0][18].trim();
            attcode = result[0][17].trim();
            vDetailAddr = result[0][10].trim();
        } else {
            retCode = "000007";
            retMsg = "未查询到相关信息！";
        }
    }
    
    System.out.println("+++++++++idIccid=[" + idIccid + "]");
    System.out.println("+++++++++phone_no=[" + phone_no + "]");
    System.out.println("+++++++++custName=[" + custName + "]");
    System.out.println("+++++++++id_no=[" + id_no + "]");
    System.out.println("+++++++++sm_name=[" + sm_name + "]");
    System.out.println("+++++++++sm_code=[" + sm_code + "]");
    System.out.println("+++++++++vModeName=[" + vModeName + "]");
    System.out.println("+++++++++vModeCode=[" + vModeCode + "]");
    System.out.println("+++++++++run_name=[" + run_name + "]");
    System.out.println("+++++++++run_code=[" + run_code + "]");
    System.out.println("+++++++++vOweFee=[" + vOweFee + "]");
    System.out.println("+++++++++vAttrName=[" + vAttrName + "]");
    System.out.println("+++++++++vCustAttr=[" + vCustAttr + "]");
    System.out.println("+++++++++attname=[" + attname + "]");
    System.out.println("+++++++++attcode=[" + attcode + "]");
    System.out.println("+++++++++vDetailAddr=[" + vDetailAddr + "]");
%>
var response = new AJAXPacket();
var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var idIccid = "<%=idIccid%>";
var phone_no = "<%=phone_no%>";
var custName = "<%=custName%>";
var id_no = "<%=id_no%>";
var sm_name = "<%=sm_name%>";
var sm_code = "<%=sm_code%>";
var vModeName = "<%=vModeName%>";
var vModeCode = "<%=vModeCode%>";
var run_name = "<%=run_name%>";
var run_code = "<%=run_code%>";
var vOweFee = "<%=vOweFee%>";
var vAttrName = "<%=vAttrName%>";
var vCustAttr = "<%=vCustAttr%>";
var attname = "<%=attname%>";
var attcode = "<%=attcode%>";
var vDetailAddr = "<%=vDetailAddr%>";
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);
response.data.add("idIccid",idIccid);
response.data.add("phone_no",phone_no);
response.data.add("custName",custName);
response.data.add("id_no",id_no);
response.data.add("sm_name",sm_name);
response.data.add("sm_code",sm_code);
response.data.add("vModeName",vModeName);
response.data.add("vModeCode",vModeCode);
response.data.add("run_name",run_name);
response.data.add("run_code",run_code);
response.data.add("vOweFee",vOweFee);
response.data.add("vAttrName",vAttrName);
response.data.add("vCustAttr",vCustAttr);
response.data.add("attname",attname);
response.data.add("attcode",attcode);
response.data.add("vDetailAddr",vDetailAddr);
core.ajax.receivePacket(response);