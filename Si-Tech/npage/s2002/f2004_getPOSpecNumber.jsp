<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = "";
		String opName = "";
    String workNo = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode=org_code.substring(0,2);
%>
<%
    /*
    SQL语句        sql_content
    选择类型       sel_type   
    标题           title      
    字段1名称      field_name1
    */
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName    = request.getParameter("fieldName");
    String sPOSpecNumber= request.getParameter("sPOSpecNumber")==null?"":request.getParameter("sPOSpecNumber");
    String sPOSpecName  = request.getParameter("sPOSpecName")  ==null?"":request.getParameter("sPOSpecName");
    String sStatus      = request.getParameter("sStatus")      ==null?"":request.getParameter("sStatus");
    String sStartDate   = request.getParameter("sStartDate")   ==null?"":request.getParameter("sStartDate");
    String sEndDate     = request.getParameter("sEndDate")     ==null?"":request.getParameter("sEndDate");    
    String selType      = request.getParameter("selType");    
    String retQuence    = request.getParameter("retQuence");    
    String sqlFilter    = "";
    
    System.out.println("###################fieldName->"+fieldName);    
    
		/**分页要用的代码**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "10";
    /******************/    

    if (sPOSpecNumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and Pospec_number = '" + sPOSpecNumber + "'";
    if (sPOSpecName.trim().length() > 0)
        sqlFilter = sqlFilter + " and Pospec_name = '" + sPOSpecName + "'";
    //if (sStatus.trim().length() > 0)
       // sqlFilter = sqlFilter + " and status = '" + sStatus + "'";
    //if (sStartDate.trim().length() > 0)
       // sqlFilter = sqlFilter + " and Begin_date >= to_date('" + sStartDate + "','yyyy-mm-dd') ";
    //if (sEndDate.trim().length() > 0)
       // sqlFilter = sqlFilter + " and End_date <= to_date('" + sEndDate + "','yyyy-mm-dd' )";        
		
		/**主要的sql语句**/

		String sqlStr = "select POSPEC_NUMBER ,POSPEC_NAME ,STATUS ,to_char(BEGIN_DATE,'yyyy-mm-dd') ,to_char(END_DATE,'yyyy-mm-dd') ,POSPEC_DESC,decode(STATUS,'A','正常商用','S','内部测试','T','测试待审','R','试商用') "+
		                "from dPospecInfo where 1 = 1 " + sqlFilter;
		/*String sqlStr="select pospecnumber,pospecname ,status,to_char(to_date(startdate,'yyyymmdd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss'), " +
		              " to_char(to_date(enddate,'yyyymmdd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss'),description, decode(STATUS,'A','正常商用','S','内部测试','T','测试待审','R','试商用') "+
		              " from  oneboss.dobPOfferingSpecMsg where 1=1 "+sqlFilter ; */              
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
    <TITLE>商品规格选择
    </TITLE>
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
                    
                    rIndex = document.fPubSimpSel.elements[i].RIndex;
                    tempQuence = retQuence;
                    for (n = 0; n < retNum; n++)
                    {
                        chPos = tempQuence.indexOf("|");
                        fieldNo = tempQuence.substring(0, chPos);
        			            
                        obj = "Rinput" + rIndex + fieldNo;
        			            
                        retValue = retValue + document.all(obj).value + "|";
                        tempQuence = tempQuence.substring(chPos + 1);
                    }
                                                            
                    window.returnValue = retValue;
                }
            }
        }
        if (retValue == "")
        {
            rdShowMessageDialog("请选择信息项！", 0);
            return false;
        }
        //opener.document.all.cust_name.className = "InputGrey";
        opener.getPOSpecNumberRtn(retValue);
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
    
  /**分页用到的js函数**/  
	function gotoPage(pageId){
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
	}
</SCRIPT>

<!--************************分页的样式表**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</HEAD>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>     	
<table cellspacing="0">
    <tr align="center">
        <th nowrap>商品规格编码</th>
        <th nowrap>商品规格名称</th>
        <th nowrap>商品规格状态</th>
        <th nowrap>商品生效时间</th>
        <th nowrap>商品失效时间</th>
        <th nowrap>商品规格描述</th>         
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
        
        System.out.println("#########################fieldNum->"+fieldNum);
    %>
    
    <!----分页的代码---->
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
		    <wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" routerValue="<%=regionCode%>"><%--outnum要比取出的列数大1,因为它还取出了序列号--%>
		    <wtc:sql><%=querySql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result" scope="end"/>
		    	
    <!----分页的代码结束---->	
    	
    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < Integer.parseInt(fieldNum); j++) {
                	System.out.println("result["+i+"]["+j+"]=="+result[i][j]);
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
                    } else if (j == 2){
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][6]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    	
                    }else if (j == Integer.parseInt(fieldNum)){
                    	  typeStr = typeStr + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly>";
                    	
                    } else {
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
				<%=PageListNav.pageNav(totalNumber, pageSize, currentPage)%><a>总计<B class="orange"><%=totalNumber%></B>条记录</a>
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
                        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选 class='b_foot'>&nbsp");
                        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选 class='b_foot'>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class='b_foot' name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <%
                    }
                %>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
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
