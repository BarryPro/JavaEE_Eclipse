<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: leimd
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
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
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";  
    String s_ProductID        = request.getParameter("s_ProductID"         )==null?"":request.getParameter("s_ProductID"         );    
    String s_flag             = request.getParameter("s_flag"         )==null?"":request.getParameter("s_flag"         );     
    System.out.println("s_flag="+ s_flag);                              
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
                        
		/**��ҳҪ�õĴ���**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "15";
    /******************/    
   
		/**��Ҫ��sql���**/
      /*wuxy alter 20081216
	String sqlStr = "select  a.PRODUCT_OFFER_ID, a.order_chn,ratepolicy_efft,poorder_status,"+
   " decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'), "+
   " decode(RATEPOLICY_EFFT, '1', '������Ч', '2', '��������Ч'), "+
   " decode(a.poorder_status,'1','������Ʒ����','2','ȡ����Ʒ����','3','��Ʒ��ͣ','4','��Ʒ�ָ�') "+
  " from dpoorderInfo a, sbbosslistcode b "+
 " where a.HOST_PROV = b.detail_code "+
  "  and b.list_code = 'CompanyID' ";*/
    /*String sqlStr= "select c.product_order_id,a.order_chn,a.op_time, c.product_status , "+
  					   " decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'), "+
  						" a.op_time,decode(a.poorder_status,'1','����') "+
  						" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b ,dgrpcustmsg d,dcustdoc e "+
  						" where a.HOST_PROV = b.detail_code "+ 
  						" and b.list_code = 'CompanyID'  and c.product_status='1' "+
  						" and to_number(a.customer_id)=d.unit_id and d.cust_id=e.cust_id and e.region_code='"+regionCode+"' "+
  						" and a.poorder_status='1' and c.poorder_id=a.poorder_id  and c.product_order_id  like '?%' ";*/
    /*String sqlStr=" select c.product_order_id,a.order_chn,a.op_time, c.product_status , "
                 +" decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'),  "
                 +" a.op_time,decode(a.poorder_status,'1','����')  "
                 +" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b   "
                 +" where a.HOST_PROV = b.detail_code "
                 +" and b.list_code = 'CompanyID'  and c.product_status='1' "
                 +" and a.poorder_status='1' and c.poorder_id=a.poorder_id  and c.product_order_id  like '?%' ";*/
    String sqlStr="";
    //wuxy alter 20100204 ���ȫ��MAS���Ų�Ʒ���û���ӳ�Ա���� ��ʱ����
    /*2013/11/28 14:48:13 gaopeng U_R_CMI_JL_liubo_2013_1095542 @˫���ں�ͨ��ҵ������ sql������,a.pospec_number����*/
    if("".equals(s_ProductID))
    {
        if("1".equals(s_flag))
        {
        	sqlStr=" select c.Product_Id,a.order_chn,a.op_time, c.product_status , c.id_no,"
                 +" decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'),  "
                 +" a.op_time cc,decode(a.poorder_status,'1','����'),h.select_only  "
                 +" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b ,dpoorderinfo d,dgrpcustmsg e,dcustdoc f  ,(select * from dgrpusermsg where run_code='A') g,smembertype h "
                 +" where a.HOST_PROV = b.detail_code "
                 +" and b.list_code = 'CompanyID'   "
                 +"  and c.poorder_id=d.poorder_id "
                 +" and trim(d.customer_id)=to_char(e.unit_id) and e.cust_id=f.cust_id "
                 +" and f.region_code='"+regionCode+"' "
                 +" and c.productspec_number = h.productspec_number(+)"
                 +"  and c.poorder_id=a.poorder_id and c.Product_Id is not null  and c.id_no=g.id_no(+) ";
        }
        else
        {
    	  sqlStr=" select c.Product_Id,a.order_chn,a.op_time, c.product_status , c.id_no,"
                 +" decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'),  "
                 +" a.op_time cc,decode(a.poorder_status,'1','����'),j.select_only  "
                 +" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b ,dpoorderinfo d,dgrpcustmsg e,dcustdoc f ,(select * from dgrpusermsg where run_code='A') g ,dbbossproductdeploy h,smembertype j  "
                 +" where a.HOST_PROV = b.detail_code "
                 +" and b.list_code = 'CompanyID'  and c.product_status='1' "
                 +" and d.poorder_status='1' and c.poorder_id=d.poorder_id "
                 +" and trim(d.customer_id)=to_char(e.unit_id) and e.cust_id=f.cust_id "
                 +" and f.region_code='"+regionCode+"' "
                 +" and c.productspec_number = j.productspec_number(+)"
                 +" and a.poorder_status='1' and c.poorder_id=a.poorder_id and c.Product_Id is not null and c.id_no=g.id_no(+)  "
                 +" AND c.product_id = h.product_id(+) "
                 +" AND h.id_no IS NULL ";//wangzn 2010-4-1 20:23:45 ������Ѿ�����ȫ��mm ��ʡ��Ʒ���õĶ�����ϵ����
        }
    }
    else
    {
    	if("1".equals(s_flag))
        {
        	sqlStr=" select c.Product_Id,a.order_chn,a.op_time, c.product_status , c.id_no,"
                 +" decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'),  "
                 +" a.op_time cc,decode(a.poorder_status,'1','����') ,h.select_only "
                 +" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b  ,dpoorderinfo d,dgrpcustmsg e,dcustdoc f , (select * from dgrpusermsg where run_code='A') g,smembertype h "
                 +" where a.HOST_PROV = b.detail_code "
                 +" and b.list_code = 'CompanyID'   "
                 +"  and (c.poorder_id=d.poorder_id or c.product_offer_id =d.product_offer_id)"
                 +" and trim(d.customer_id)=to_char(e.unit_id) and e.cust_id=f.cust_id "
                 +" and f.region_code='"+regionCode+"' "
                 +" and c.productspec_number = h.productspec_number(+)"
                 +"  and (c.poorder_id=a.poorder_id or c.product_offer_id =a.product_offer_id ) and c.Product_Id ='"+s_ProductID+"'  and c.Product_Id is not null and c.id_no=g.id_no(+)   ";
        }
        else
        {
    		sqlStr=" select c.Product_Id,a.order_chn,a.op_time, c.product_status ,c.id_no, "
                 +" decode(trim(a.order_chn),'0','ʡBOSS�ϴ�','1','EC�ϴ�','2','BBOSS����'),  "
                 +" a.op_time cc,decode(a.poorder_status,'1','����') ,j.select_only "
                 +" from dproductorderdet c ,dpoorderinfo a,sbbosslistcode b  ,dpoorderinfo d,dgrpcustmsg e,dcustdoc f ,(select * from dgrpusermsg where run_code='A') g ,dbbossproductdeploy h ,smembertype j"
                 +" where a.HOST_PROV = b.detail_code "
                 +" and b.list_code = 'CompanyID'  and c.product_status='1' "
                 +" and d.poorder_status='1' and (c.poorder_id=d.poorder_id or c.product_offer_id =d.product_offer_id) "
                 +" and trim(d.customer_id)=to_char(e.unit_id) and e.cust_id=f.cust_id "
                 +" and f.region_code='"+regionCode+"' "
                 +" and c.productspec_number = j.productspec_number(+)"
                 +" and a.poorder_status='1' and  (c.poorder_id=a.poorder_id or c.product_offer_id =a.product_offer_id )  and c.Product_Id ='"+s_ProductID+"'  and c.Product_Id is not null and c.id_no=g.id_no(+)    "
                 +" AND c.product_id = h.product_id(+) "
                 +" AND h.id_no IS NULL ";//wangzn 2010-4-1 20:23:45 ������Ѿ�����ȫ��mm ��ʡ��Ʒ���õĶ�����ϵ����
        }
    }
     
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
    	  var retValue = "";
    	  var retValue1="";
    	  var retValue2="";
    	  var retValue8 = "";
        if(typeof (document.all("List").length) =="undefined"){
        	if(typeof (document.all("List")) =="undefined"){
        		rdShowMessageDialog("�޲�Ʒ����!");
        	}else{
        		if(document.all("List").checked){
        			  retValue=document.all("Rinput00").value;
        			  retValue1=document.all("Rinput01").value;
        			  retValue2=document.all("Rinput04").value;
        			  retValue8 = document.all("Rinput08").value;
        			  
        		}
        	}
        }else{
        	for(var i=0;i<document.all("List").length;i++){
        		if(document.all("List")[i].checked){
        			
        			retValue=document.all("Rinput"+i+"0").value;
        			retValue1=document.all("Rinput01").value;
        			retValue2=document.all("Rinput"+i+"4").value;
        			retValue8 = document.all("Rinput"+i+"8").value;
        		}
        	}
        }
        if(retValue!=""&&retValue!=null){
        	
        	window.opener.document.getElementById("productID").value=retValue;
        	window.opener.document.getElementById("orderSource").value=retValue1;
        	window.opener.document.getElementById("grpIdNo").value=retValue2;
        	window.opener.document.all.nextoper.disabled=false;
        	/*2013/11/28 14:48:13 gaopeng U_R_CMI_JL_liubo_2013_1095542 @˫���ں�ͨ��ҵ������ �ж�����ǡ�˫���ں�ͨ��ҵ�񡱣�����Ʒ������0102001�����Ա�Ĳ�������ֻ�С���ѯ����ѡ��*/
        	if("1" == retValue8){
        		window.opener.$("#operType").find("option").each(function(){
        			/*f2035_1.jsp �������� 5�ǲ�ѯ��value*/
        			if($(this).val() != "5"){
        				$(this).remove();
        			}
        		});
        	}else {
        		window.opener.$("#operType").find("option").each(function(){
        				$(this).remove();       		
        		});
        		window.opener.$("#operType").append("<option value='5'>��ѯ</option>"); 
        		window.opener.$("#operType").append("<option value='1'>����</option>"); 
        		window.opener.$("#operType").append("<option value='0'>ɾ��</option>"); 
        		window.opener.$("#operType").append("<option value='3'>��ͣ��Ա</option>"); 
        		window.opener.$("#operType").append("<option value='4'>�ָ���Ա</option>"); 
        		window.opener.$("#operType").append("<option value='6'>�޸ĳ�Ա����</option>");         			
        		}
        	window.close();
        }else{
        	rdShowMessageDialog("��ѡ���Ʒ����!");
        }
         
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
    <tr>
        <th nowrap>��Ʒ�������</th>
        <th nowrap>������Դ </th>
        <th nowrap>��Чʱ��</th>   
        <th nowrap>��Ʒ״̬</th>    
    </tr>
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
        
        System.out.println("###############wxy->countSql->"+countSql);
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
        System.out.println("querySql==="+querySql);
    
    	System.out.println("totalNumber==="+totalNumber);
    	 /*2013/11/28 14:48:13 gaopeng U_R_CMI_JL_liubo_2013_1095542 @˫���ں�ͨ��ҵ������ ���ζ��һ�� ��Ϊoutnum=9*/
    %>
    
	    <wtc:pubselect name="sPubSelect" outnum="9" routerKey="region" routerValue="<%=regionCode%>"><%--outnumҪ��ȡ����������1,��Ϊ����ȡ�������к�--%>
	    	<wtc:sql><%=querySql%></wtc:sql>
	    </wtc:pubselect>
	    <wtc:array id="result" scope="end"/>
		    	
    <!----��ҳ�Ĵ������---->	
    	
    <%
        String tbclass="";
        for (int i = 0; i < result.length; i++) {
        		System.out.println("gaopeng=2014/03/21 16:27:45====="+result[i][8]);
        		tbclass = (i%2==0)?"Grey":"";
            typeStr = "";
            inputStr = "";
            out.print("<TR>");
            for (int j = 0; j < Integer.parseInt(fieldNum)+1; j++) {
                System.out.println("gaopeng === result["+i+"]["+j+"]==="+result[i][j]);
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
                }
                 else if( j == Integer.parseInt(fieldNum)){
                	inputStr = inputStr + "<TD style='display:none'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "' value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                }
                else {
                    inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "' value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                }
            }
            /*2013/11/28 14:48:13 gaopeng U_R_CMI_JL_liubo_2013_1095542 @˫���ں�ͨ��ҵ������ �ж�����ǡ�˫���ں�ͨ��ҵ�񡱣�����Ʒ������0102001�����Ա�Ĳ�������ֻ�С���ѯ����ѡ��*/
            inputStr = inputStr + "<input type='hidden' id='Rinput"+i+"8'" + " value='"+ (result[i][8]).trim() +"'"  + "'readonly />";
            
            out.print(typeStr + inputStr);
            out.print("</TR>");
        }
    %>
    </tr>
    <tr>
    	<td colspan="4" align="right">
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
