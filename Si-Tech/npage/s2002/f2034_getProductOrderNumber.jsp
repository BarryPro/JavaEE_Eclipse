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
		String opCode = "";
		String opName = "";
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
                        
		/**��ҳҪ�õĴ���**/
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
		/**��Ҫ��sql���**/

		/*String sqlStr = "select PRODUCT_ORDER_ID,PRODUCTSPEC_NUMBER, ACCESS_NUMBER, PRIACCESS_NUMBER, LINK_MAN, TASK_FLAG,"
                  + "LINK_PHONE, PRODUCT_DESC, SERVICE_LEVEL, SECOND_CONFIRM, OPER_TYPE,"
                  + "decode(trim(PRODUCT_ORDER_ID),'1','�����´�','2','��������'),decode(trim(SECOND_CONFIRM),'0','����Ҫ','1','��Ҫ'), "
                  + "decode(trim(OPER_TYPE),'1','ҵ��ͨ','2','ҵ��ȡ��','6','�����Ա'),decode(trim(task_flag),'1','δ����','0','�ѿ���',trim(task_flag)) "
                  + "from dproductTaskInfo where 1=1 " + sqlFilter;
        String sqlStr="select PRODUCT_ORDER_ID,PRODUCTSPEC_NUMBER, ACCESS_NUMBER, PRIACCESS_NUMBER, LINK_MAN, decode(trim(task_flag),'1','δ����','0','�ѿ���'),  "
                     +" LINK_PHONE,trim(PRODUCT_DESC),SERVICE_LEVEL,decode(trim(SECOND_CONFIRM),'0','����Ҫ','1','��Ҫ'),  "
                     +" decode(trim(OPER_TYPE),'1','ҵ��ͨ','2','ҵ��ȡ��','6','�����Ա')   "
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
    <TITLE>��Ʒ���ѡ��
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
            rdShowMessageDialog("��ѡ����Ϣ�", 0);
            return false;
        }
        //opener.document.all.cust_name.className = "InputGrey";
       // rdShowMessageDialog(retValue);
        opener.getProductOrderNumberRtn(retValue);
        
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
        <th nowrap>��Ʒ������</th>
        <th nowrap>��Ʒ�����</th>
        <th nowrap>��Ʒ�ؼ�����</th>
        <th nowrap>��Ʒ��������</th>
        <th nowrap>��Ʒ����״̬</th>
        <th nowrap>��Ʒ����</th>
    </TR>
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
		    <wtc:pubselect name="sPubSelect" outnum="12" routerKey="region" routerValue="<%=regionCode%>"><%--outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
		    <wtc:sql><%=querySql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result" scope="end"/>
		    	
    <!----��ҳ�Ĵ������---->	
    	
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
