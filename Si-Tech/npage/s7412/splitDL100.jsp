<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String errCode = "";
    String errMsg = "";
    
    String workNo           = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode       = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iLoginAccept     = WtcUtil.repNull((String)request.getParameter("loginAccept"));
    String iOpCode          = WtcUtil.repNull((String)request.getParameter("opCode"));
    String iTotalCount      = WtcUtil.repNull((String)request.getParameter("totalCount"));
    String iSmCodeList      = WtcUtil.repNull((String)request.getParameter("smCodeList"));
    String iSmNameList      = WtcUtil.repNull((String)request.getParameter("smNameList"));
    String iPackageFlagList = WtcUtil.repNull((String)request.getParameter("packageFlagList"));
    String iBbossFlagList   = WtcUtil.repNull((String)request.getParameter("bbossFlagList"));
    String iLocalFlagList   = WtcUtil.repNull((String)request.getParameter("localFlagList"));
    String iProCodeList     = WtcUtil.repNull((String)request.getParameter("proCodeList"));
    String iProNameList     = WtcUtil.repNull((String)request.getParameter("proNameList"));
    String iCustId          = WtcUtil.repNull((String)request.getParameter("custId"));
    
    System.out.println("# workNo            = " + workNo);  
    System.out.println("# iLoginAccept      = " + iLoginAccept);  
    System.out.println("# iOpCode           = " + iOpCode);  
    System.out.println("# iTotalCount       = " + iTotalCount);  
    System.out.println("# iSmCodeList       = " + iSmCodeList);
    System.out.println("# iSmNameList       = " + iSmNameList);
    System.out.println("# iPackageFlagList  = " + iPackageFlagList);  
    System.out.println("# iBbossFlagList    = " + iBbossFlagList);
    System.out.println("# iLocalFlagList    = " + iLocalFlagList);    
    System.out.println("# iProCodeList      = " + iProCodeList);
    System.out.println("# iProNameList      = " + iProNameList);
    System.out.println("# iCustId           = " + iCustId);
    
    String oLoginAcceptList = "";
    String oChildAcceptList = "";
    
    StringTokenizer stSmCode = new StringTokenizer(iSmCodeList,"~");
    String[] iSmCodeArr = new String[stSmCode.countTokens()];
    int i = 0;   
    while(stSmCode.hasMoreTokens()){
        iSmCodeArr[i++] = stSmCode.nextToken();
    }
    
    StringTokenizer stPackageFlag = new StringTokenizer(iPackageFlagList,"~");
    String[] iPackageFlagArr = new String[stPackageFlag.countTokens()];
    i = 0;   
    while(stPackageFlag.hasMoreTokens()){
        iPackageFlagArr[i++] = stPackageFlag.nextToken();
    }
    
    StringTokenizer stBbossFlag = new StringTokenizer(iBbossFlagList,"~");
    String[] iBbossFlagArr = new String[stBbossFlag.countTokens()];
    i = 0;   
    while(stBbossFlag.hasMoreTokens()){
        iBbossFlagArr[i++] = stBbossFlag.nextToken();
    }
    
    StringTokenizer stLocalFlag = new StringTokenizer(iLocalFlagList,"~");
    String[] iLocalFlagArr = new String[stLocalFlag.countTokens()];
    i = 0;   
    while(stLocalFlag.hasMoreTokens()){
        iLocalFlagArr[i++] = stLocalFlag.nextToken();
    }
    
    try{
    %>
        <wtc:service name="sSplitDL100" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=iOpCode%>"/> 
            <wtc:param value="<%=iLoginAccept%>"/> 
            <wtc:param value="<%=iTotalCount%>"/> 
            <wtc:param value="<%=iCustId%>"/>
            <wtc:params value="<%=iSmCodeArr%>"/> 
            <wtc:params value="<%=iPackageFlagArr%>"/>
            <wtc:params value="<%=iBbossFlagArr%>"/>
            <wtc:params value="<%=iLocalFlagArr%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg = retMsg;
        System.out.println("# return from splitDL100.jsp by Service sSplitDL100 -> returnCode = "+errCode);
        System.out.println("# return from splitDL100.jsp by Service sSplitDL100 -> returnMessage = "+errMsg);
        if("000000".equals(errCode)){
            for(i=0;i<retArr.length;i++){
                oLoginAcceptList = oLoginAcceptList + retArr[i][0] + "~";
                oChildAcceptList = oChildAcceptList + retArr[i][1] + "~";
            }
            System.out.println("# return from splitDL100.jsp -> oLoginAcceptList = "+oLoginAcceptList);
            System.out.println("# return from splitDL100.jsp -> oChildAcceptList = "+oChildAcceptList);
        }
    }catch(Exception e){
        errCode = "999999";
        errMsg = "调用服务sSplitDL100拆分动力100订单失败！";
        e.printStackTrace();
    }
%>

var response = new AJAXPacket();
var errCode = "<%=errCode%>";
var errMsg = "<%=errMsg%>";

var vProCodeList = "<%=iProCodeList%>";
var vProNameList = "<%=iProNameList%>";
var vSmCodeList = "<%=iSmCodeList%>";
var vSmNameList = "<%=iSmNameList%>";
var vTotalCount = "<%=iTotalCount%>";
var vLoginAcceptList = "<%=oLoginAcceptList%>";
var vChildAcceptList = "<%=oChildAcceptList%>";
var vBbossFlagList = "<%=iBbossFlagList%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("smCodeList",vSmCodeList);
response.data.add("smNameList",vSmNameList);
response.data.add("proCodeList",vProCodeList);
response.data.add("proNameList",vProNameList);
response.data.add("totalCount",vTotalCount);
response.data.add("loginAcceptList",vLoginAcceptList);
response.data.add("childAcceptList",vChildAcceptList);
response.data.add("bbossFlagList",vBbossFlagList);

core.ajax.receivePacket(response);