<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode = "";
	String opName = "吉林BOSS-集团用户查询";
		
    productCfg prodcfg = new productCfg();
    /*
    SQL语句        sql_content
    选择类型       sel_type
    标题           title
    字段1名称      field_name1
    */
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String user_no = request.getParameter("user_no");
    String regionCode = request.getParameter("regionCode");
    String sm_limit = request.getParameter("sm_limit");
    String run_code = request.getParameter("run_code");
    String sqlFilter = "";

    if ((sm_limit != null) && (sm_limit.compareTo("limit") == 0)) {
        sqlFilter = sqlFilter + " and f.sm_code != '" + prodcfg.VPMN_SM_CODE + "' ";
        sqlFilter = sqlFilter + " and f.sm_code != '" + prodcfg.BOSSFAV_SM_CODE + "' ";
        sqlFilter = sqlFilter + " and f.sm_code != '" + prodcfg.ZHUANX_IP_SM_CODE + "' ";
        sqlFilter = sqlFilter + " and f.sm_code != '" + prodcfg.ZHUANX_NET_SM_CODE + "' ";
        sqlFilter = sqlFilter + " and f.sm_code != '" + prodcfg.ZHUANX_DIANLU_SM_CODE + "' ";
    }

    if (iccid.trim().length() > 0) {
        sqlFilter = sqlFilter + " and a.id_iccid = " + iccid + "";
    }
    if (cust_id.trim().length() > 0) {
        sqlFilter = sqlFilter + " and a.cust_id = " + cust_id + " and b.cust_id = " + cust_id + " and c.cust_id = " + cust_id;
    }
    if (unit_id.trim().length() > 0) {
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
    }
    if ((user_no.trim().length() > 0) && (user_no.compareTo("0") != 0)) {
        sqlFilter = sqlFilter + " and c.user_no = '" + user_no + "'";
    }

    String sqlStr = "SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no, Trim(c.user_no), TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, f.sm_name FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c, sproductcode d, sSmCode f WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id AND b.cust_id = c.cust_id AND d.product_level = 1 and c.run_code = '" + run_code + "' AND d.product_status = 'Y' AND c.bill_date > Last_Day(sysdate) + 1 and c.sm_code = f.sm_code and a.region_code=f.region_code and  f.region_code = '" + regionCode + "' and c.sm_code = '97'" + sqlFilter;
    System.out.println("##################>>>>>>>"+sqlStr);
    

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
%>

<HTML>
<HEAD>
    <TITLE>吉林BOSS-集团用户查询</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
    function saveTo()
    {
        var rIndex;        //选择框索引
        var retValue = ""; //返回值
        var chPos;         //字符位置
        var obj;
        var fieldNo;        //返回域序列号
        var retFieldNum = document.fPubSimpSel.retFieldNum.value;
        var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
        var retNum = retQuence.substring(0, retQuence.indexOf("|"));
        retQuence = retQuence.substring(retQuence.indexOf("|") + 1);
        var tempQuence;
        if (retFieldNum == "")
        {
            return false;
        }
       //返回单条记录
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].name == "List")
            {    //判断是否是单选或复选框
                if (document.fPubSimpSel.elements[i].checked == true)
                {     //判断是否被选中
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
            rdShowMessageDialog("请选择信息项！", 0);
            return false;
        }
        opener.getvaluecust(retValue);
        window.close();
    }

    function allChoose()
    {   //复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //判断是否是单选或复选框
                document.fPubSimpSel.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //取消复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //判断是否是单选或复选框
                document.fPubSimpSel.elements[i].checked = false;
            }
        }
    }
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %> 
<table cellspacing="0">
    <tr>
    <TR>
        <th nowrap>身份证号</th>
        <th nowrap>集团客户ID</th>
        <th nowrap>集团客户名称</th>
        <th nowrap>集团用户ID</th>
        <th nowrap>集团用户编号</th>
        <th nowrap>集团用户名称</th>
        <th nowrap>业务包代码</th>
        <th nowrap>业务包名称</th>
        <th nowrap>集团ID</th>
        <th nowrap>付费帐户</th>
        <th nowrap>产品品牌</th>
    </TR>
    <% //绘制界面表头
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
        System.out.println("sssssssssssssssssssssssssssssss");
        System.out.println(fieldNum);
    %>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="12">
				<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result" scope="end" />		
    <%
    				String tbclass = "";
            for (int i = 0; i < result.length; i++) {
            		tbclass = i%2==0?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < result[i].length-1; j++) {
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' class='button' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    } else {
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' class='button' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
    </tr>
    <TBODY>
        <TR>
            <TD id="footer" colspan="11">
                <%
                    if (selType.compareTo("checkbox") == 0) {
                        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
                        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <%
                    }
                %>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %> 
<!------------------------>
<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
<input type="hidden" name="retQuence" value=<%=retQuence%>>
<!------------------------>
</FORM>
</BODY>
</HTML>
