<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = "2029";
		String opName = "商品订单订购关系管理";
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
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";                                           
    String sOrderSourceID       = request.getParameter("sOrderSourceID"      )==null?"":request.getParameter("sOrderSourceID"      );
    String sCustomerNumber      = request.getParameter("sCustomerNumber"     )==null?"":request.getParameter("sCustomerNumber"     );
    String sPOOrderNumber       = request.getParameter("sPOOrderNumber"      )==null?"":request.getParameter("sPOOrderNumber"      );
    String sPOSpecNumber        = request.getParameter("sPOSpecNumber"       )==null?"":request.getParameter("sPOSpecNumber"       );
    String sProductOfferingID   = request.getParameter("sProductOfferingID"  )==null?"":request.getParameter("sProductOfferingID"  );
    String sHostCompany         = request.getParameter("sHostCompany"        )==null?"":request.getParameter("sHostCompany"        );
    String sPORatePolicyEffRule = request.getParameter("sPORatePolicyEffRule")==null?"":request.getParameter("sPORatePolicyEffRule");
    String p_OperType = request.getParameter("p_OperType");
	String in_ChanceId = request.getParameter("in_ChanceId");/*chendx 20110329*/
		/**分页要用的代码**/
    Map map = request.getParameterMap();
    /**************** 分页设置 ********************/
    int recordNum = 0;
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    String vStartPos = ""+iStartPos;
    String vEndPos = ""+iEndPos;
    /**********************************************/
    String sqlStr="";
    /******************/    

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
        opener.getOrderInfoRtn(retValue);
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

<!--************************分页的样式表**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</HEAD>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>     	
<table cellspacing="0">
    <tr align="center">
    	<th nowrap>订单来源</th>
        <th nowrap>EC集团客户编码</th>
        <th nowrap>商品订单号</th>
        <th nowrap>商品规格编号</th>
        <th nowrap>商品订购关系ID</th>        
        <th nowrap>主办省</th>        
        <th nowrap>套餐生效规则</th>
        <th nowrap>订单状态</th>
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
        System.out.println("fieldNum:"+fieldNum);
    %>
    	<!--wuxy alter outnum="20"  -->
        <wtc:service name="s9103DetQry" retcode="retCode" retmsg="retMsg" outnum="24" routerKey="region" routerValue="<%=regionCode%>">
            <wtc:param value="<%=sOrderSourceID%>"/>
            <wtc:param value="<%=sCustomerNumber%>"/>
            <wtc:param value="<%=sPOOrderNumber%>"/>
            <wtc:param value="<%=sPOSpecNumber%>"/>
            <wtc:param value="<%=sProductOfferingID%>"/>
            <wtc:param value="<%=sHostCompany%>"/>
            <wtc:param value="<%=sPORatePolicyEffRule%>"/>
            <wtc:param value="<%=p_OperType%>"/>
            <wtc:param value="<%=regionCode%>"/>
            <wtc:param value="<%=vStartPos%>"/>
            <wtc:param value="<%=vEndPos%>"/>
            <wtc:param value="<%=in_ChanceId%>"/><!--chendx 20110329-->
            <wtc:param value="<%=workNo%>"/><!--chendx 20110329-->
        </wtc:service>
        <wtc:array id="result" scope="end"/>
    <%
            if (result.length>0 && retCode.equals("000000")){
  		        recordNum = Integer.parseInt(result[0][19].trim());
  		        System.out.println("# recordNum = "+recordNum);
  		    }
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < 24; j++) {
                     System.out.println("result["+i+"]["+j+"]="+ result[i][j]);
                    if (j == 0) {
                        
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][10]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    }else if(j==5){
                    	inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][11]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";                  	
                    }else if(j==6){
                    	inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][12]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";    
                    	
                    }else if(j==7){
                    	inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][13]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";    
                    }else if(j==10||j==11||j==12||j==13||j==14||j==15||j==16||j==17||j==18||j==20||j==22||j==23){
                    	inputStr = inputStr + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "' readonly>";    
                    	}
                    else if(j>=8){
                    	inputStr = inputStr + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "' readonly>";                   	
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
</table>
<table cellspacing=0>
    <tr>
        <td>
        <%	
            //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
            //int iQuantity = 500;
            System.out.println("<"+iPageNumber+">,<"+iPageSize+">,<"+recordNum+">");
            Page pg = new Page(iPageNumber,iPageSize,recordNum);
            PageView view = new PageView(request,out,pg); 
            view.setVisible(true,true,0,0);       
        %>
        </TD>
    </TR>
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
</BODY>
</HTML>    
