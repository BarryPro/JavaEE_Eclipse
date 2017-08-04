<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html;charset=GB2312" %>
<!--取客户产品信息-->
<wtc:utype name="sCustOffer" id="retConsOffer" scope="end" routerKey="region" routerValue="01">
        <wtc:uparam value="13007045867" type="LONG"/>
        <wtc:uparam value="15804614326" type="STRING"/>
</wtc:utype>


<%

        String retCode = "";
        retCode = retConsOffer.getValue(0);
        out.println(retCode);
%>

  <wtc:service name="s1200Init"  retcode="retCode1" retmsg="retMsg1" outnum="27" >
        <wtc:param value="15804614326"/>
    <wtc:param value="aaaaxp"/>
        <wtc:param value="01"/>
        <wtc:param value="1200"/>
  </wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%

        out.println(retCode1);
%>
