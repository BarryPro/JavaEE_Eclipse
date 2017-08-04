<%
    /*************************************
    * 功  能: 营销限制配置 g366
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-12-24
    **************************************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName = WtcUtil.repNull((String)request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	String inParams [] = new String[2];
  inParams[0] = "select a.offer_id,a.offer_name,a.exp_type,a.offer_comments,b.eff_date,b.exp_date "
                +" from  product_offer a,product_offer_instance b,dcustmsg c "
                +" where a.offer_id = b.offer_id "
                +" and a.offer_attr_type ='YnRM' "
                +" and b.exp_date>sysdate "
                +" and b.state='A' "
                +" and b.offer_id<>39952 "
                +" and b.serv_id =  c.id_no "
                +" and c.phone_no=:phoneno";
  inParams[1] = "phoneno="+phoneNo;
  
  String v_offer_id = "";
  String v_offer_name = "";
  String v_exp_type = "";
  int retLength = 0;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(retCode1)){
    retLength = ret.length;
    if(ret.length>0){
      v_offer_id = ret[0][0];
      v_offer_name = ret[0][1];
      v_exp_type = ret[0][2];
    }
  }
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode1%>");
	response.data.add("retmsg","<%=retMsg1%>");
  response.data.add("v_offer_id","<%=v_offer_id%>");
  response.data.add("v_offer_name","<%=v_offer_name%>");
  response.data.add("v_exp_type","<%=v_exp_type%>");
  response.data.add("retLength","<%=retLength%>");
	core.ajax.receivePacket(response);