<%
/*关于跨省专线业务两级订单流改造的需求*/
%>
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
    //String workNo = (String)session.getAttribute("workNo");
    //String org_code = (String)session.getAttribute("orgCode");
    String workNo = request.getParameter("workNo");
    String org_code = request.getParameter("orgCode");
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
    String sp_OperType  = request.getParameter("sp_OperType");   
   String sp_ProductSpecNumber= request.getParameter("sp_ProductSpecNumber")==null?"":request.getParameter("sp_ProductSpecNumber");  //wuxy add
    String retQuence    = request.getParameter("retQuence");    
    String sqlFilter    = "";   
    
    System.out.println("-------------sp_OperType="+sp_OperType);
    System.out.println("-------------sp_ProductSpecNumber="+sp_ProductSpecNumber);
    System.out.println("-------------sPOSpecNumber="+sPOSpecNumber);
     
    //wuxy add
   if(!"1".equals(sp_OperType))
   {
    	sp_ProductSpecNumber="";
   }
    		       

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
    <TITLE>产品规格选择
    </TITLE>
</HEAD>
<BODY onload="">
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
        var pro_id=retValue.split("|");
        //opener.document.all.cust_name.className = "InputGrey";
        opener.getProductNumberRtn(retValue);
        opener.getOneTimeFeeStatus(pro_id[0]);
        opener.getSAStatus(pro_id[0]);
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
</HEAD>
<FORM method=post name="fPubSimpSel"> 
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">产品规格选择</div></div>	    	
<table cellspacing="0">
    <tr align="center">
        <th nowrap>产品规格编号</th>
        <th nowrap>产品规格名称</th>
        <th nowrap>产品规格状态</th>
        <th nowrap>产品描述</th>        
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
    %>
<wtc:service name="s9100DetQry" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sPOSpecNumber%>"/>
	<wtc:param value="5"/>
	<wtc:param value="<%=sp_ProductSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="6" scope="end" />    	
    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < 5; j++) {
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr +(result[i][j]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    }else  if ( j == 2){
                        inputStr = inputStr +"<input type='hidden'  id='Rinput" + i + j + "' value='" + (result[i][5]).trim() + "'readonly>";
                    }else{     
                        inputStr = inputStr + "<TD class"+tbclass+"'>" + (result[i][j]).trim() + "</TD>";
                    }                    	
                    
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
    </tr>
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
</div>
</div>
</FORM>
</BODY>
</HTML>    
