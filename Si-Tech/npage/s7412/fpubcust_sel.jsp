
<%
	/********************
	 version v3.0
	������: si-tech
	*
	*update:zhanghonga@2008-10-30 ҳ�����,�޸���ʽ
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--�·�ҳ�õ�����-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	System.out.println("regionCode="+regionCode);
%>
<%
		String opCode = "";
		String opName = "������BOSS-���ſͻ���ѯ";
%>
<%
    /*
    SQL���        sql_content
    ѡ������       sel_type   
    ����           title      
    �ֶ�1����      field_name1
    */
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String sqlFilter = "";
    
    
		/**��ҳҪ�õĴ���**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "10";
    /******************/    
    
    if (iccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.id_iccid ='" + iccid.trim() + "'";
    if (unit_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
    if (cust_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;
  
		/**��Ҫ��sql���**/
		String sqlStr = "select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name,a.org_code,a.org_id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id and a.owner_type='04' and a.region_code='"+regionCode+"'  " + sqlFilter;
		System.out.println("###sqlStr->" + sqlStr);
		
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");

    if (selType.compareTo("S") == 0) {
        selType = "radio";
    }
    if (selType.compareTo("M") == 0) {
        selType = "checkbox";
    }
    if (selType.compareTo("N") == 0) {
        selType = "";
    }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String op_name = "BOSS-���ſͻ���ѯ";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE><%=op_name%>
    </TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<SCRIPT type=text/javascript>
    function saveTo()
    {
        var rIndex;        //ѡ�������
        var retValue = ""; //����ֵ
        var chPos;         //�ַ�λ��
        var obj;
        var fieldNo;        //���������к�
        var retFieldNum = document.fPubSimpSel.retFieldNum.value;
        var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
        var retNum = retQuence.substring(0, retQuence.indexOf("|"));
        retQuence = retQuence.substring(retQuence.indexOf("|") + 1);
        var tempQuence;
        if (retFieldNum == "")
        {
            return false;
        }
       //���ص�����¼
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].name == "List")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                if (document.fPubSimpSel.elements[i].checked == true)
                {     //�ж��Ƿ�ѡ��
                    //alert(document.fPubSimpSel.elements[i].value);
                    rIndex = document.fPubSimpSel.elements[i].RIndex;
                    tempQuence = retQuence;
                    for (n = 0; n < retNum; n++)
                    {
                        chPos = tempQuence.indexOf("|");
                        fieldNo = tempQuence.substring(0, chPos);
        			            //alert(fieldNo);
                        obj = "Rinput" + rIndex + fieldNo;
        			            //alert(obj);
                        retValue = retValue + document.all(obj).value + "|";
                        tempQuence = tempQuence.substring(chPos + 1);
                    }
                             //alert(retValue);                                  
                    window.returnValue = retValue;
                }
            }
        }
        if (retValue == "")
        {
            rdShowMessageDialog("��ѡ����Ϣ�", 0);
            return false;
        }
        //opener.document.all.cust_name.className = "InputGrey";
        opener.getvaluecust(retValue);
        window.close();
    }

    function allChoose()
    {   //��ѡ��ȫ��ѡ��
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.fPubSimpSel.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //ȡ����ѡ��ȫ��ѡ��
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                document.fPubSimpSel.elements[i].checked = false;
            }
        }
    }
    
  /**��ҳ�õ���js����**/  
	function gotoPage(pageId){
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
	}
</SCRIPT>

<!--************************��ҳ����ʽ��**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</HEAD>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>     	
<table cellspacing="0">
    <tr align="center">
        <th nowrap>֤������</th>
        <th nowrap>���ſͻ�ID</th>
        <th nowrap>���ſͻ�����</th>
        <th nowrap>���ű���</th>
        <th nowrap>�����û�����</th>
    
    </TR>
    <% //���ƽ����ͷ  
        chPos = fieldName.indexOf("|");
        out.print("");
        String titleStr = "";
        int tempNum = 0;
        while (chPos != -1) {
            valueStr = fieldName.substring(0, chPos);
            titleStr = "";
            out.print(titleStr);
            fieldName = fieldName.substring(chPos + 1);
            tempNum = tempNum + 1;
            chPos = fieldName.indexOf("|");
        }
        out.print("");
        fieldNum = String.valueOf(tempNum);
    %>
    
    <!----��ҳ�Ĵ���---->
    <%
        String countSql = PageFilterSQL.getCountSQL(sqlStr);
    %>
		    <wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=countSql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="allNumStr" scope="end"/>
    <%
        if (allNumStr != null && allNumStr.length > 0) {
            totalNumber = allNumStr[0][0];
        }

        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr, currentPage, pageSize, totalNumber);
    %>
		    <wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>"><%--outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
		    <wtc:sql><%=querySql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result" scope="end"/>
		    	
    <!----��ҳ�Ĵ������---->	
    	
    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < Integer.parseInt(fieldNum); j++) {
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    }else if(j==5||j==6) {
                        inputStr = inputStr +  "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    } 
                    else {
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
    </tr>
    <tr>
    	<td colspan="10" align="right">
				<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>�ܼ�<B class="orange"><%=totalNumber%></B>����¼</a>
    	</td>
    </tr>
</table>

<!------------------------------------------------------>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <%
                    if (selType.compareTo("checkbox") == 0) {
                        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ class='b_foot'>&nbsp");
                        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ class='b_foot'>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class='b_foot' name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
                <%
                    }
                %>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
            </TD>
        </TR>
    </TBODY>
</TABLE>
<!------------------------>
<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
<input type="hidden" name="retQuence" value=<%=retQuence%>>
<!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
<form name="form2" method="post">
    <%=PageListNav.writeRequestString(map, currentPage)%>
</form>
</BODY>
</HTML>    
