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
%>
<%
		String opCode = "7422";
		String opName = "������Ϣ��ѯ";
    String workNo = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode=org_code.substring(0,2);		
%>
<%
    /*
    SQL���        sql_content
    ѡ������       sel_type   
    ����           title      
    �ֶ�1����      field_name1
    */
    
    
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";                                           
    String sPONumber = request.getParameter("sPONumber")==null?"":request.getParameter("sPONumber");    
    String sUnitID   = request.getParameter("sUnitID")==null?"":request.getParameter("sUnitID");
    String sIDNo     = request.getParameter("sIDNo")==null?"":request.getParameter("sIDNo");
    String sPOStatus = request.getParameter("sPOStatus")==null?"":request.getParameter("sPOStatus");
    String sIdiccid = request.getParameter("sIdiccid")==null?"":request.getParameter("sIdiccid");
    
		/**��ҳҪ�õĴ���**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "10";
    /******************/
    if (sPONumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.ORDER_SEQ = '" + sPONumber + "'";
    if (sUnitID.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.CUST_ID = '" + sUnitID + "'";
    if (sIDNo.trim().length() > 0)
        sqlFilter = sqlFilter + " and d.unit_id = '" + sIDNo + "'";
    if (sPOStatus.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.ORDER_STATUS = '" + sPOStatus + "'";
    if (sIdiccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and e.id_iccid = '" + sIdiccid + "'";
        
            
		/**��Ҫ��sql���**/
		String sqlStr = " select a.ORDER_SEQ,"+//0
										" a.CUST_ID,"+//1
										" d.unit_id,"+//2
										" a.ORDER_STATUS,"+//3
										" a.MOTIVE_CODE,"+//4
       							" b.MOTIVE_NAME,"+//5									
       							" a.ORDER_TYPE,"+//6
										" a.EFFT_DATE,"+//7
										" a.ORDER_NOTE,a.id_no ,"+//8��9
										" e.id_iccid ,"+//10
       							" decode(a.ORDER_STATUS,'1','����������','2','��������ɹ�','f','��������ʧ��','d','��������'),"+//11
       							" decode(a.ORDER_TYPE,'0','ȡ��','1','��ͨ') "+//12
										" from DMOTIVEORDERINFO a,dgrpcustmsg d,dcustdoc e,SMOTIVEPRODCFG b,sproductcode c "+
										" where a.motive_code = b.motive_code and b.motive_prod = c.product_code" + 
										" and a.cust_id=d.cust_id and d.cust_id=e.cust_id and e.region_code='"+regionCode+"' " +
										" and c.product_status='Y' and login_no = '"+workNo+"' "+sqlFilter;
		System.out.println("###sqlStr->" + sqlStr);

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
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>����100����ѡ��</TITLE>
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
        //alert(retNum);
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
        opener.getPOMsgRtn(retValue);
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
				<th nowrap>�������</th>    	
        <th nowrap>���ſͻ�ID </th>
        <th nowrap>�����û�ID</th>
        <th nowrap>����״̬</th> 
        <th nowrap>��Ʒ������</th>
        <th nowrap>��Ʒ������</th>
        <th nowrap>��������</th>
     <!--   <th nowrap>������ֹ����</th>   -->    
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
        System.out.println("fieldNum:"+fieldNum);
    %>
    
    <!----��ҳ�Ĵ���---->
    <%
        String countSql = PageFilterSQL.getCountSQL(sqlStr);
    %>
		    <wtc:pubselect name="sPubSelect" outnum="1">
		    <wtc:sql><%=countSql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="allNumStr" scope="end"/>
    <%
        if (allNumStr != null && allNumStr.length > 0) {
            totalNumber = allNumStr[0][0];
        }

        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr, currentPage, pageSize, totalNumber);
    %>
		    <wtc:pubselect name="sPubSelect" outnum="13"><%--outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
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
                for (int j = 0; j < 11; j++) {
                 System.out.println("result["+i+"]["+j+"]="+result[i][j]);
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][0]).trim() + "'readonly></TD>";
                    } else if (j == 2){
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][9]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    	
                    }
                    else if (j == 3){
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][10]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    	
                    }else if (j == 6){
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][11]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    	
                    }else if (j == 8||j==7||j==9||j==10){
                        inputStr = inputStr + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly>";
                    	
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
    	<td colspan="12" align="right">
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
