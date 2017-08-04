<%
    /*************************************
    * 功  能: 判断页面内容是否置灰 3690
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-11-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String v_sm_code = WtcUtil.repNull((String)request.getParameter("v_sm_code"));
	
	String inParams[] = new String[2];
	inParams[0] ="select name_id,name_type from sgrpmsgdisabled where sm_code =:smcode and OP_TYPE = '1' and disabled_flag = 'N'";
  inParams[1] = "smcode="+v_sm_code;
%>

var nameIdArr = new Array();
var nameTypeArr = new Array();

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
<wtc:param value="<%=inParams[0]%>"/>
<wtc:param value="<%=inParams[1]%>"/> 
</wtc:service>  
<wtc:array id="ret"  scope="end"/>
  
<%
  if("000000".equals(retCode)){
    if(ret.length>0){
      for(int i=0;i<ret.length;i++){
      %>
        nameIdArr["<%=i%>"]="<%=ret[i][0]%>";
        nameTypeArr["<%=i%>"]="<%=ret[i][1]%>";
      <%  
      }
    }
  }
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("nameIdArr",nameIdArr);
response.data.add("nameTypeArr",nameTypeArr);
core.ajax.receivePacket(response);
