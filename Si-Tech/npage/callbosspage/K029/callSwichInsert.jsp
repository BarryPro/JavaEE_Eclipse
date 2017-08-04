<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,com.sitech.crmpd.kf.dto.DCALLTRANSFER.DCallTransfer"%> 
<%
		  /*midify by guozw 20091114 公共查询服务替换*/
		 String myParams="";
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode = org_code.substring(0,2);
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String contactId = WtcUtil.repNull(request.getParameter("contactId"));
    String called = WtcUtil.repNull(request.getParameter("called"));
    String caller = WtcUtil.repNull(request.getParameter("caller"));
    String transagent = WtcUtil.repNull(request.getParameter("transagent"));
    String loginNo = (String)session.getAttribute("workNo");  //取login_no
    String loginName = (String)session.getAttribute("workName"); //取login_name
    String transType = WtcUtil.repNull(request.getParameter("transType")); //transType
    String op_code = WtcUtil.repNull(request.getParameter("op_code")); //op_code
    String is_success = WtcUtil.repNull(request.getParameter("is_success")); //is_success
    String oper_type = WtcUtil.repNull(request.getParameter("oper_type")); //is_success
    String transfer_kf_login_no = (String)session.getAttribute("kfWorkNo");  //取客服login_no   
    String skillName = WtcUtil.repNull(request.getParameter("skillName"));    
    String accept_kf_login_no="";
    String temp = "select kf_login_no from dloginmsgrelation where boss_login_no= :transagent";
    myParams = "transagent="+transagent ;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
          <wtc:param value="<%=temp%>"/>
         <wtc:param value="<%=myParams%>"/> 
        </wtc:service>
        <wtc:array id="tempList"  scope="end"/>
        <%              
if(tempList.length>0){
  accept_kf_login_no=tempList[0][0];
}    
    try{
    DCallTransfer dCallTransfer = new DCallTransfer();
    dCallTransfer.setCONTACT_ID(contactId);
    dCallTransfer.setCONTACT_ACCEPT(contactId);
    dCallTransfer.setCALLER_PHONE(caller);
    dCallTransfer.setTRANSFER_LOGIN_NO(loginNo);
    dCallTransfer.setACCEPT_LOGIN_NO(transagent);
    dCallTransfer.setOPER_TYPE(oper_type);
    dCallTransfer.setTRANSFER_TYPE(transType);
    dCallTransfer.setSKILL_QUENCE(skillName);
    dCallTransfer.setSUCCESS_FLAG(is_success);
    dCallTransfer.setOP_CODE(op_code);
    dCallTransfer.setRANSFER_KF_LOGIN_NO(transfer_kf_login_no);
    dCallTransfer.setACCEPT_KF_LOGIN_NO(accept_kf_login_no);  
    KFEjbClient.insert("insertDCallTransfer", dCallTransfer);
	}catch(Exception e){
	         retCode = "000001";
             retMsg = "保存关系失败";
}
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
