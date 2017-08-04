<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String org_code = (String) session.getAttribute("orgCode");
    String regionCode = org_code.substring(0, 2);
    String idIccid = request.getParameter("idIccid") == null ? "" : request.getParameter("idIccid");
    //String sqlStr = "select to_char(b.ID_NO),to_char(b.CUST_ID),to_char(c.ID_ICCID),c.CUST_NAME,b.PHONE_NO,a.CFM_LOGIN ,d.id_name from sidtype d,dcustdoc c,dcustmsg b, dbroadbandmsg a where b.CUST_ID=c.CUST_ID and a.ID_NO=b.ID_NO and c.ID_ICCID=:idIccId and d.id_type=c.id_type ";
   // String sqlVal ="idIccId=" + idIccid + "";
   // System.out.println("sqlStr:[" + sqlStr + "]");
   // System.out.println("sqlVal:[" + sqlVal + "]");
    String loginNo = (String)session.getAttribute("workNo"); 		
    String noPass = (String)session.getAttribute("password");
    String opCode = "4991";
    String opName = "宽带密码变更";
%>
<HTML>
<HEAD><TITLE><%=opName%>
</TITLE>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <BODY>
    <SCRIPT type=text/javascript>
        function turnToDepend()
        {
            var num = 0;
            for (var i = 0; i < pubService.elements.length; i++)
            {
                if (pubService.elements[i].name == "doType")
                {
                    if ((pubService.elements[i].checked == true))
                    {
                        //判断是否被选中
                        rIndex = pubService.elements[i].RIndex;
                        objCfmLogin = "cfmLogin" + rIndex;
                        objIdName= "idName" + rIndex;
                        window.opener.f4991.cfmLogin.value = document.all(objCfmLogin).value;
                        window.opener.f4991.idName.value = document.all(objIdName).value;
                        window.opener.f4991.select_custbutton.disabled=true;
                        window.opener.f4991.idIccid.readonly=true;
                        num++;
                    }
                }
            }
            /** 校验是否选择信息 **/
            if (num == 0) {
                rdShowMessageDialog("请您选择一项信息", 1);
                return false;
            }
            //window.opener.getWideAreaInfo_Ajax();
            window.close();
        }
        function re_back() {
            window.close();
        }
        function doChangeType() {

        }
    </SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="pubService">
    <%@ include file="/npage/include/header_pop.jsp" %>
    <div class="title">
        <div id="title_zi"><%=opName%>
        </div>
    </div>

    <table cellSpacing="0">
        <tr>
            <th nowrap>
                选择
            </th>
            <th nowrap>
                客户编码
            </th>
            <th nowrap>
                客户ID
            </th>
            <th nowrap>
                证件号码
            </th>
            <th nowrap>
                证件类型
            </th>
            <th nowrap>
                客户姓名
            </th>
            <th nowrap>
                入网帐号
            </th>
            <th nowrap>
                宽带帐号
            </th>
        </tr>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=regionCode%>" id="sLoginAccept"/>
        <wtc:service name="sCustTypeQryJ" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="7" >
		      <wtc:param value="<%=sLoginAccept%>"/>
		      <wtc:param value="01"/>
		      <wtc:param value="<%=opCode%>"/>
		      <wtc:param value="<%=loginNo%>"/>
		      <wtc:param value="<%=noPass%>"/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value="<%=idIccid%>"/>
		      <wtc:param value="1"/>
  			</wtc:service>
        <wtc:array id="people_result" scope="end"/>
        <%
            for (int i = 0; i < people_result.length; i++) {
                String st = i + "";
        %>
        <tr>
            <td nowrap>
                <input type="radio" id="doType" name="doType" value="<%=i%>" RIndex="<%=i%>">
            </td>
            <td nowrap>
                <%=people_result[i][0]%>&nbsp;
                <input type="hidden" name="idNo<%=i%>" value="<%=people_result[i][0]%>">
            </td>
            <td nowrap>
                <%=people_result[i][1]%>&nbsp;
                <input type="hidden" name="custId<%=i%>" value="<%=people_result[i][1]%>">
            </td>
            <td nowrap>
                <%=people_result[i][2]%>&nbsp;
                <input type="hidden" name="idIccId<%=i%>" value="<%=people_result[i][2]%>">
            </td>
            <td nowrap>
                <%=people_result[i][6]%>&nbsp;
                <input type="hidden" name="idName<%=i%>" value="<%=people_result[i][6]%>">
            </td>
            <td nowrap>
                <%=people_result[i][3]%>&nbsp;
                <input type="hidden" name="custName<%=i%>" value="<%=people_result[i][3]%>">
            </td>
            <td nowrap>
                <%=people_result[i][4]%>&nbsp;
                <input type="hidden" name="conPhone<%=i%>" value="<%=people_result[i][4]%>">
            </td>
            <td nowrap>
                <%=people_result[i][5]%>&nbsp;
                <input type="hidden" name="cfmLogin<%=i%>" value="<%=people_result[i][5]%>">
            </td>
                <%}%>
        <TR>
            <TD id="footer" colspan="11">
                <input class="b_foot" name=commit onClick="turnToDepend()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="re_back()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TABLE>

    <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
