<%
    /*************************************
    * 功  能: 网上终端销售出库 e899
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String iMeiNo = WtcUtil.repStr(request.getParameter("iMeiNo"), "");
	String machineColor = WtcUtil.repStr(request.getParameter("machineColor"), "");
	String res_code = WtcUtil.repStr(request.getParameter("res_code"), "");//机型
	String groupId = (String)session.getAttribute("groupId");
	String regCode = (String)session.getAttribute("regCode");
	String retchkImeiMsg = "";
	
	String  inParams [] = new String[2];
  //inParams[0] = "SELECT count(1) FROM DBCHNTERM.DCHNRESMOBINFO a, DBCHNTERM.SCHNPUBLICDICTCODE b where a.buy_mode = b.dict_code and a.imei_no = :imeino and b.dict_name =:machinecolor and a.group_id=:groupid and a.status_code='10'";
  //inParams[1] = "imeino="+iMeiNo+",machinecolor="+machineColor+",groupid="+groupId;
  inParams[0] = "SELECT COUNT(1) "
               +" FROM DBCHNTERM.DCHNRESMOBINFO a, dbchnterm.web_imei_order b "
               +" WHERE a.status_code = '10' "
               +" AND  NOT EXISTS (SELECT 1 FROM dbchnterm.dchnworkflowdetimeicheck t, dbchnterm.dchnworkflowbase t1 "
               +" WHERE t.wf_id = t1.wf_id "
               +" AND t.imei_no = A.IMEI_NO "
               +" AND t1.wf_type IN ('60', '70')) "
               +" AND b.res_code = a.res_code "
               +" AND b.state = '0' "
               +" AND b.group_id = a.group_id "
               +" AND a.imei_no =:imeino "
               +" AND a.res_code =:rescode "
               +" AND a.group_id =:groupid ";
  inParams[1] = "imeino="+iMeiNo+",rescode="+res_code+",groupid="+groupId;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  System.out.println("---e899----retCode="+retCode);
  if("000000".equals(retCode)){
    if(ret.length>0){
      retchkImeiMsg = ret[0][0];
    }else{
      retchkImeiMsg = "";
    }
  }else{
    retchkImeiMsg = "";
  }
  
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("retchkImeiMsg","<%=retchkImeiMsg%>");
core.ajax.receivePacket(response);
 
	    