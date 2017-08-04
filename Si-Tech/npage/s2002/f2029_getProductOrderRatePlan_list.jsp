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
   // String p_OperType = (String)session.getAttribute("p_OperType_f2029_1.jsp");      //add by wangzn
   // String p_BusinessMode = (String)session.getAttribute("p_BusinessMode_f2029_1.jsp"); // add by wangzn
    String p_OperType = request.getParameter("p_OperType"); //add by wangzn
    String p_BusinessMode  = request.getParameter("p_BusinessMode");    //add by wangzn
    String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
    String in_BatchNo = WtcUtil.repNull((String)request.getParameter("in_BatchNo"));
    String busi_req_type = WtcUtil.repNull((String)request.getParameter("busi_req_type"));
  //  out.print(p_BusinessMode+"----"+p_OperType); //add by wangzn for test
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
    String sProductSpecNumber= request.getParameter("sProductSpecNumber");  
    System.out.println("sProductSpecNumber="+sProductSpecNumber);
    String sPoSpecNumber=request.getParameter("sPoSpecNumber");  
    String selType      = request.getParameter("selType");    
    String retQuence    = request.getParameter("retQuence");    
    String sqlFilter    = "";    
    

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
    <TITLE>产品级资费选择
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
        opener.getProductOrderRatePlanRtn(retValue);
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
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">商品规格选择</div></div>	    	
<table cellspacing="0">
    <tr>
        <th nowrap>资费计划标识</th>
        <th nowrap>资费描述</th>        
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
<wtc:service name="s9100DetQry" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="6"/>
	<wtc:param value="<%=sPoSpecNumber%>"/>
	<wtc:param value="<%=busi_req_type%>"/>
	<wtc:param value="<%=in_ChanceId%>"/>
	<wtc:param value="<%=in_BatchNo%>"/>			
</wtc:service>
<wtc:array id="result" start="2" length="5" scope="end" />
    	
    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                for (int j = 0; j < 3; j++) {
                   System.out.println("result["+i+"]["+j+"]="+result[i][j]);
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" ;
                            //liujian 2012-7-6 10:59:18 radio的情况，都让选择，去掉disabled
                            //if(selType != null && selType.equals("radio")) {
                            
                           	//}
                  			//add by wangzn
                            //else 
                            if(!p_BusinessMode.equals("")&&((p_BusinessMode.equals("5")&&result[i][4].trim().equals("N"))||((!p_BusinessMode.equals("5")&&result[i][4].trim().equals("Y"))))){
                            	 typeStr = typeStr+"disabled";
                            }
                            typeStr = typeStr + ">";
                        }
                        typeStr = typeStr +(result[i][1]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][1]).trim() + "'readonly></TD>";
                    }else  if ( j ==1){
                        inputStr = inputStr +"<input type='hidden'  id='Rinput" + i + j + "' value='" + (result[i][2]).trim() + "'readonly>";
                    }else{     
                        inputStr = inputStr + "<TD class"+tbclass+"'>" + (result[i][2]).trim() + "<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][3]).trim() + "'readonly></TD>";
                    }                    	
                    
                }
                System.out.println(typeStr + inputStr);
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
