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
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";                                           
    String sPOSpecNumber       = request.getParameter("sPOSpecNumber"      );
    String sPOOrderNumber      = request.getParameter("sPOOrderNumber"     );
    String sPOSpecRatePolicyID = request.getParameter("sPOSpecRatePolicyID");
    String sRatePlanID         = request.getParameter("sRatePlanID"        );
    String sParamcode         = request.getParameter("sParamcode"        );
    System.out.println("sRatePlanID|"+sRatePlanID);    
            
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
        opener.getParameterNumberRtn(retValue);
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
<FORM method=post name="fPubSimpSel">
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">ICB参数值选择</div></div>	

<table cellspacing="0">
    <tr align="center">
        <th nowrap>参数编码</th>
        <th nowrap>参数值</th>      
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
    %>
    

<wtc:service name="s9100DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">		
	<wtc:param value="<%=sRatePlanID%>"/>
  <wtc:param value="2"/>
  	<wtc:param value="<%=sPOSpecRatePolicyID%>"/>
  		<wtc:param value="<%=sPOSpecNumber%>"/>
  			<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="1" length="4" scope="end" />
		    	
    <!----分页的代码结束---->	
    	
    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
                System.out.println("result[i][1]"+result[i][1]);
                System.out.println("result[i][2]"+result[i][2]);
                System.out.println("result[i][3]"+result[i][3]);
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < 3; j++) {
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr +(result[i][1]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][1]).trim() + "'readonly></TD>";
                    }else if ( j == 1){     
                        inputStr = inputStr + "<TD class"+tbclass+"'>" + (result[i][2]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" + (result[i][2]).trim() + "'readonly></TD>";
                    }else if ( j == 2){
                        inputStr = inputStr +"<input type='hidden'  id='Rinput" + i + j + "' value='" + (result[i][3]).trim() + "'readonly>";
                    }                    	
                    
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
    %>
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
<input type="hidden" name="retFieldNum" value=3>
<input type="hidden" name="retQuence" value=<%=retQuence%>>
<!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</div>
</div>
</FORM>
</BODY>
</HTML>    
