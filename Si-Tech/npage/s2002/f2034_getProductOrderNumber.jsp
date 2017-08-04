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
    String fieldNum  = "12";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";                                           
    String sOrderType         = request.getParameter("sOrderType"         )==null?"":request.getParameter("sOrderType"         );
    String sProductOrderNumber= request.getParameter("sProductOrderNumber")==null?"":request.getParameter("sProductOrderNumber");
    String sProductSpecNumber = request.getParameter("sProductSpecNumber" )==null?"":request.getParameter("sProductSpecNumber" );
    String sAccessNumber      = request.getParameter("sAccessNumber"      )==null?"":request.getParameter("sAccessNumber"      );
    String sPriAccessNumber   = request.getParameter("sPriAccessNumber"   )==null?"":request.getParameter("sPriAccessNumber"   );
    String sLinkman           = request.getParameter("sLinkman"           )==null?"":request.getParameter("sLinkman"           );
    String sContactPhone      = request.getParameter("sContactPhone"      )==null?"":request.getParameter("sContactPhone"      );
    String sDescription       = request.getParameter("sDescription"       )==null?"":request.getParameter("sDescription"       );
    String sServiceLevelID    = request.getParameter("sServiceLevelID"    )==null?"":request.getParameter("sServiceLevelID"    );
    String sTerminalConfirm   = request.getParameter("sTerminalConfirm"   )==null?"":request.getParameter("sTerminalConfirm"   );
    String sOperationSubTypeID= request.getParameter("sOperationSubTypeID")==null?"":request.getParameter("sOperationSubTypeID");
    String sTASK_FLAG= request.getParameter("sTASK_FLAG")==null?"":request.getParameter("sTASK_FLAG");                                                                                                                                                
    String p_CustomerNumber   = request.getParameter("p_CustomerNumber"   )==null?"":request.getParameter("p_CustomerNumber");
                        
		/**分页要用的代码**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "11";
    /******************/    
   
    //if (sOrderType.trim().length() > 0)
    //    sqlFilter = sqlFilter + " and Product_order_id = '" + sOrderType + "'";
    if (sProductOrderNumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and Product_order_id = '" + sProductOrderNumber + "'";
    if (sProductSpecNumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and ProductSpec_Number = '" + sProductSpecNumber + "'";
    if (sAccessNumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and Access_Number = '" + sAccessNumber + "'";
    if (sPriAccessNumber.trim().length() > 0)
        sqlFilter = sqlFilter + " and priAccess_Number = '" + sPriAccessNumber + "'";
    if (sLinkman.trim().length() > 0)
        sqlFilter = sqlFilter + " and Link_man = '" + sLinkman + "'";
    if (sContactPhone.trim().length() > 0)
        sqlFilter = sqlFilter + " and Link_phone = '" + sContactPhone + "'"; 
    if (sDescription.trim().length() > 0)                                                    
        sqlFilter = sqlFilter + " and Product_desc = '" + sDescription + "'";
    if (sServiceLevelID.trim().length() > 0)                                                    
        sqlFilter = sqlFilter + " and Service_level = '" + sServiceLevelID + "'";
    if (sTerminalConfirm.trim().length() > 0)                                                    
        sqlFilter = sqlFilter + " and Second_confirm = '" + sTerminalConfirm + "'";
    if (sOperationSubTypeID.trim().length() > 0)                                                    
        sqlFilter = sqlFilter + " and Oper_type = '" + sOperationSubTypeID + "'"; 
    if (sTASK_FLAG.trim().length() > 0)                                 
        sqlFilter = sqlFilter + " and TASK_FLAG = '" + sTASK_FLAG + "'";  
    if (p_CustomerNumber.trim().length() > 0)                                                    
        sqlFilter = sqlFilter + " and CustomerNumber = '" + p_CustomerNumber + "'"; 
		/**主要的sql语句**/

		/*String sqlStr = "select PRODUCT_ORDER_ID,PRODUCTSPEC_NUMBER, ACCESS_NUMBER, PRIACCESS_NUMBER, LINK_MAN, TASK_FLAG,"
                  + "LINK_PHONE, PRODUCT_DESC, SERVICE_LEVEL, SECOND_CONFIRM, OPER_TYPE,"
                  + "decode(trim(PRODUCT_ORDER_ID),'1','正常下达','2','撤销工单'),decode(trim(SECOND_CONFIRM),'0','不需要','1','需要'), "
                  + "decode(trim(OPER_TYPE),'1','业务开通','2','业务取消','6','变更成员'),decode(trim(task_flag),'1','未竣工','0','已竣工',trim(task_flag)) "
                  + "from dproductTaskInfo where 1=1 " + sqlFilter;
        String sqlStr="select PRODUCT_ORDER_ID,PRODUCTSPEC_NUMBER, ACCESS_NUMBER, PRIACCESS_NUMBER, LINK_MAN, decode(trim(task_flag),'1','未竣工','0','已竣工'),  "
                     +" LINK_PHONE,trim(PRODUCT_DESC),SERVICE_LEVEL,decode(trim(SECOND_CONFIRM),'0','不需要','1','需要'),  "
                     +" decode(trim(OPER_TYPE),'1','业务开通','2','业务取消','6','变更成员')   "
                     +" from dproductTaskInfo where 1=1 "+sqlFilter;*/
        String sqlStr="select PRODUCT_ORDER_ID,PRODUCTSPEC_NUMBER, ACCESS_NUMBER, PRIACCESS_NUMBER, LINK_MAN, task_flag,  "
                     +" LINK_PHONE,trim(PRODUCT_DESC),SERVICE_LEVEL,SECOND_CONFIRM,  "
                     +" OPER_TYPE, "
                     +" nvl(CustomerNumber, ' ')  "
                     +" from dproductTaskInfo where 1=1 "+sqlFilter;
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
       // rdShowMessageDialog(retValue);
        opener.getProductOrderNumberRtn(retValue);
        
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
        <th nowrap>产品订单号</th>
        <th nowrap>产品规格编号</th>
        <th nowrap>产品关键号码</th>
        <th nowrap>产品附件号码</th>
        <th nowrap>产品订单状态</th>
        <th nowrap>产品描述</th>
    </TR>
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
		    <wtc:pubselect name="sPubSelect" outnum="12" routerKey="region" routerValue="<%=regionCode%>"><%--outnum要比取出的列数大1,因为它还取出了序列号--%>
		    <wtc:sql><%=querySql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result" scope="end"/>
		    	
    <!----分页的代码结束---->	
    	
    <%
            String tbclass="";
            for(int k=0;k<result.length;k++)
             {
                 for(int kk=0;kk<Integer.parseInt(fieldNum)+1;kk++)
                 {
                      //System.out.println("result["+k+"]["+kk+"]="+result[k][kk]);
                 }
             }
            
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                for (int j = 0; j < Integer.parseInt(fieldNum); j++) {
                    System.out.println("result["+i+"]["+j+"]=="+result[i][j]);
                    if (j==0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr +(result[i][j]).trim()+"<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "'readonly></TD>";
                    } else if (j==4||j==6||j==8||j==9||j==10||j==11){
                        inputStr = inputStr + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "' readonly>";
                    	
                    }else{
                    	
                        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" +
                                (result[i][j]).trim() + "' readonly></TD>";
                        
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
                
                System.out.println("####################typeStr + inputStr--->"+typeStr + inputStr);
            }
    %>
    </tr>
    <tr>
    	<td colspan="11" align="right">
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
