<%
/*���ڿ�ʡר��ҵ���������������������*/
%>
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
    //String workNo = (String)session.getAttribute("workNo");
    //String org_code = (String)session.getAttribute("orgCode");
    String workNo = request.getParameter("workNo");
    String org_code = request.getParameter("orgCode");
    System.out.println(workNo+"=========="+org_code);
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
    String sPOSpecNumber       = request.getParameter("sPOSpecNumber"      );
    System.out.println("sPOSpecNumber="+sPOSpecNumber);
    String sProductSpecNumber = request.getParameter("sProductSpecNumber");
    String sRatePlanID = request.getParameter("sRatePlanID");
    //wuxy alter 20090622 ���begin_time��end_timeʱ�������
    String countSql="SELECT A.offer_id, A.offer_name, A.Offer_Comments,A.if_cust_price";	
    countSql+=" FROM product_offer A, SPRODUCTSPECPRODRELA B";
  	countSql+=" where A.Offer_Id = B.offer_id and b.begin_time<=sysdate and b.end_time >sysdate and b.Pospec_Number="+sPOSpecNumber;
  	countSql+=" and b.productspec_number="+sProductSpecNumber+" and b.Product_RatePlanID="+sRatePlanID;
  	System.out.println("countSql="+countSql);

            
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
    <TITLE>��Ʒѡ��
    </TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<SCRIPT type=text/javascript>
	//liujian 2012-8-24 16:18:19 ���ã�������ѡ��ť������۷���ֵ�ÿ�
	$(function() {
		$("input[name^='bargain']").click(function(){
			$('#bargainInput').val("");
		});
	});
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
		var flag = "1";
		var position = "";
       
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
        opener.getProductCodeRtn(retValue);
        //liujian 2012-8-27 10:14:36 ������
        opener.getBargainRtn($('#bargainInput').val());
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
	//liujian 2012-8-24 10:03:36 ����Ƿ���� begin
	//���ù������棬���в�Ʒ��Ϣѡ��
	function getInfo_Prod_detail(prodCode,value) {
		document.all(prodCode).checked=true;
	    var pageTitle = "��Ʒ���";
	    var fieldName = "��Ʒ����|��Ʒ����|�������|��������|�۸����|�۸�����|�շѷ�ʽ|�շѷ�ʽ����|��ȡ��ʽ|��ȡ��ʽ����|�۸�ֵ|";
		var sqlStr = "";
	    var selType = "M";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "1|0|";
	    var retToField = "prodPriceStr|";
	
	    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,value));
	}
	function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,prodCode){
	    var path = "f2029_fpubprod_detail_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;
		path = path + "&prodCode=" + prodCode;
	    retInfo = window.open(path,"","height=450, width=900,top=50,left=20,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
	}
	function getvalue(retValue) {
		//ֻ�������һ�μ����Ʒ
		document.all.bargainInput.value=retValue;
	}
	//liujian 2012-8-24 10:03:36 ����Ƿ���� end
</SCRIPT>
<FORM method=post name="fPubSimpSel">
<div id="Main">
<DIV id="Operation_Table"> 
	<div class="title"><div id="title_zi">���Ų�Ʒѡ��</div></div>	

<table cellspacing="0">
    <tr align="center">
        <th nowrap>��Ʒ����</th>
        <th nowrap>��Ʒ����</th>      
        <th nowrap>��Ʒ����</th>  
        <th nowrap>�Ƿ�֧�����</th>     
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
    %>
    

<wtc:pubselect name="sPubSelect" outnum="4" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=countSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

    <%
            String tbclass="";
            for (int i = 0; i < result.length; i++) {
            		tbclass = (i%2==0)?"Grey":"";
                typeStr = "";
                inputStr = "";
                out.print("<TR align='center'>");
                //liujian 2012-8-24 13:35:04 ������ 3�ĳ�4
                for (int j = 0; j < 4; j++) {
                    if (j == 0) {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if (selType.compareTo("") != 0) {
                            typeStr = typeStr + "<input type='" + selType +
                                    "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
                                    "id='bargain_" + i + "'" +
                                    "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr +(result[i][0]).trim()+"<input type='hidden'  id='Rinput" + i + j + "' value='" +
                                (result[i][0]).trim() + "'readonly></TD>";
                    }else if ( j == 1){     
                        inputStr = inputStr + "<TD class"+tbclass+"'>" + (result[i][1]).trim() + "<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" + (result[i][1]).trim() + "'readonly></TD>";
                    }else if ( j == 2){
                        inputStr = inputStr + "<TD class"+tbclass+"'>"+(result[i][2]).trim() +"<input type='hidden' " +
                                " id='Rinput" + i + j + "' value='" + (result[i][2]).trim() + "'readonly>&nbsp;</TD>";
                    }                   	
                    //liujian 2012-8-24 13:35:04 ������
                	else if(j == 3) {
                		/************Ȩ�� begin******************/
						String[][] favInfo = (String[][])session.getAttribute("favInfo");
						int infoLen = favInfo.length;
						boolean pwrf = false;
						String tempStr = "";
						for(int ll=0;ll<infoLen;ll++) {
							tempStr = (favInfo[ll][0]).trim();
							if(tempStr.compareTo("a290") == 0) {
								pwrf = true;
							}
						}
  						/***********Ȩ�� end************/
  						String bargainFlag = (result[i][3]).trim();
  						if(pwrf){
                       		if(bargainFlag.equals("T")){
		          		        inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + "Y"+ 
		          		        	"<input type='hidden' " + " id='Rinput" + i + "0" + j + "' class='button' value='" + 
		          		           	 bargainFlag + "'readonly>";
          		            }else{
	          		            inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + "N" + "<input type='hidden' " +
	          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + "N" + "'readonly>";
          		        	 }
          		        }else{
          		            inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + "N" + "<input type='hidden' " +
          		            	" id='Rinput" + i + "0" + j + "' class='button' value='" + "N" + "'readonly>";
          		        } 
	  		         	if(bargainFlag.equals("T")){
	  		         		if(pwrf){
	  		         			inputStr += "<a href=# onclick=\"getInfo_Prod_detail('bargain_"+i+"','"+result[i][0]+"')\">" + "&nbsp;-->&nbsp;������&nbsp;" + "</A>";
	  		         			inputStr += "</TD>";
	  		        		}
	  		        	}
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
<input type="hidden" name="retFieldNum" value=3>
<input type="hidden" name="retQuence" value=<%=retQuence%>>
<!------------------------>
<!-------liujian 2012-8-24 16:29:04 ��� begin----->
<input type="hidden" name="bargainInput" id="bargainInput" value="">
<!-------liujian 2012-8-24 16:29:04 ��� end----->
<%@ include file="/npage/include/footer_pop.jsp" %> 
</div>
</div>
</FORM>
</BODY>
</HTML>    
