<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>

<%
    //�õ��������
    //ArrayList retArray = new ArrayList();
    //ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opName = "���Ų�Ʒ��ѯ";
%>

<%
/*
SQL���        sql_content
ѡ������       sel_type
����           title
�ֶ�1����      field_name1
*/
	System.out.println("f3103_getgrpuser.jsp ......");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
	String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String user_no = request.getParameter("user_no");
	String sm_code =request.getParameter("sm_code");
    String sqlFilter = "";

    int iPageNumber 
    = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	
    if (iccid != null)
    {
	    if (iccid.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
	    }
		}    
    if (cust_id != null)
    {
	    if (cust_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and a.cust_id=" + cust_id + " and b.cust_id=" + cust_id 
	        + " and c.cust_id=" + cust_id;
	    }
    }
    if (unit_id != null)
    {
	    if (unit_id.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and b.unit_id=" + unit_id;
	    }
    }
    if (user_no != null)
    {
	    if (user_no.trim().length() > 0) {
	        sqlFilter = sqlFilter + "  and c.user_no='" + user_no + "'";
	    }
    }
    if (sm_code != null)
    {
			if (sm_code.trim().length() > 0) {
	        sqlFilter = sqlFilter + " and c.sm_code ='" + sm_code+"'";
	    }
	}

if(iccid == null){
    iccid = "";
}
if(cust_id == null){
    cust_id = "";
}
if(unit_id == null){
    unit_id = "";
}
if(user_no == null){
    user_no = "";
}

    String sqlStr = "SELECT nvl(count(*),0) num FROM dcustdoc a, dcustdocorgadd b, dgrpusermsg c," 
    	+"sproductcode d,ssmproduct f,ssmcode g "
    	+"WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id and b.cust_id = c.cust_id "
    	+"and d.product_level = 1 AND d.product_status = 'Y' "
    	+"and f.product_code=d.product_code and g.sm_code=f.sm_code "
    	+"and g.region_code=c.region_code and c.REGION_CODE='"+regionCode+"' " + sqlFilter;
    
    
    String sqlStr1 = "select * from (SELECT a.id_iccid, a.cust_id, TRIM (b.unit_name), c.id_no,decode(c.run_code,'A','����','I','Ԥ��','a','����',c.run_code),TRIM (c.user_name), c.product_code, d.product_name, b.unit_id, c.account_id, g.sm_name,c.user_no,h.apn_no,rownum id FROM dCustDoc a, dbvipadm.dGrpCustMsg b, dGrpUserMsg c, sProductCode d,sSmProduct f,sSmCode g,dGrpApnMsg h WHERE c.product_code = d.product_code AND a.cust_id = b.cust_id and b.cust_id = c.cust_id AND d.product_level = 1 AND d.product_status = 'Y' and f.product_code=d.product_code and g.sm_code=f.sm_code and g.region_code=c.region_code AND c.id_no=h.id_no(+) and c.REGION_CODE='"+regionCode+"'  " + sqlFilter + " ) where id <"+iEndPos+" and id>="+iStartPos;
	
	
	
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!sqlStr1="+sqlStr1);
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    //System.out.print("sqlStr="+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

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
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")
      {     return false;   }
       //���ص�����¼
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          {
                  if (document.fPubSimpSel.elements[i].name=="List")
                  {    //�ж��Ƿ��ǵ�ѡ��ѡ��
                       if (document.fPubSimpSel.elements[i].checked==true)
                       {     //�ж��Ƿ�ѡ��
                             //alert(document.fPubSimpSel.elements[i].value);
                             rIndex = document.fPubSimpSel.elements[i].RIndex;
                             tempQuence = retQuence;
                             for(n=0;n<retNum;n++)
                             {
                                chPos = tempQuence.indexOf("|");
                                fieldNo = tempQuence.substring(0,chPos);
                                //alert(fieldNo);
                                obj = "Rinput" + rIndex +"-"+ fieldNo;
                                //alert(obj);
                                //alert(document.all(obj).value);
                                //alert(retValue);
                                retValue = retValue + document.all(obj).value + "|";
                                //alert(retValue);
                                tempQuence = tempQuence.substring(chPos + 1);
                             }
                             //alert(retValue);
                             window.returnValue= retValue;
                             //alert(retValue);
                             
                       }
                }
            }
        
        if(retValue =="")
        {
            rdShowMessageDialog("��ѡ����Ϣ�",0);
            return false;
        }
        retValue=retValue+"0.00|0.00|"
        //alert(retValue);
        opener.getvaluecust(retValue);
        window.close();
}

function allChoose()
{   //��ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = true;
        }
    }
}

function cancelChoose()
{   //ȡ����ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = false;
        }
    }
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>

  <table cellspacing="0">
    <tr>
<TR>
	<TH nowrap>֤������</TH>
	<TH nowrap>���ſͻ�ID</TH>
	<TH nowrap>���ſͻ�����</TH>
	<TH nowrap>���Ų�ƷID</TH>
	<TH nowrap>��Ʒ״̬</TH>
	<TH nowrap>�û�����</TH>
	<TH nowrap>��Ʒ����</TH>
	<TH nowrap>��Ʒ����</TH>
	<TH nowrap>���ű��</TH>
	<TH nowrap>��Ʒ�����ʻ�</TH>
	<TH nowrap>Ʒ������</TH>
	<TH nowrap>��Ʒ����</TH>
	<TH nowrap>APN���</TH>
</TR>
<%  //���ƽ����ͷ
     chPos = fieldName.indexOf("|");
     out.print("");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {
        valueStr = fieldName.substring(0,chPos);
        titleStr = "";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("");
     fieldNum = String.valueOf(tempNum);
%>

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
   
    try
    {
            //retArray = callView.sPubSelect(fieldNum,sqlStr1);
            
            %>
            			    
    <wtc:service name="s3103EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="15" >
        <wtc:param value="3103"/>
        <wtc:param value="<%=workno%>"/>
        <wtc:param value="<%=iccid%>"/> 
        <wtc:param value="<%=cust_id%>"/> 
        <wtc:param value="<%=unit_id%>"/> 
        <wtc:param value="<%=user_no%>"/> 
    </wtc:service>
    <wtc:array id="retArray" scope="end"/>
            <%
  		    System.out.println("# retcode = "+retCode1);
  		    System.out.println("# retmsge = "+retMsg1);
  		    System.out.println("# recordNum = "+retArray.length);
            //retArray1 = callView.sPubSelect("1",sqlStr);
            result=retArray;
            int recordNum = result.length;
            System.out.println("# recordNum = "+recordNum);
            //result = (String[][])retArray.get(0);

            //allNumStr = (String[][])retArray1.get(0);
           // int recordNum = Integer.parseInt(allNumStr[0][0].trim());
//System.out.println("luxcluxc="+fieldNum+"="+result[0][0]); 
            for(int i=0;i<recordNum;i++)
            {
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                for(int j=0;j<Integer.parseInt(fieldNum);j++)
                {
                    if(j==0)
                    {
                        
      					
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
                            typeStr = typeStr + "<input type='" + selType +
                                "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }

      					typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i +"-"+ j + "' class='button' value='" +
                        (result[i][j]).trim() + "'readonly></TD>";
      					
                    }
                    else
                    {
      					inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i +"-"+ j + "' class='button' value='" +
                        (result[i][j]).trim() + "'readonly></TD>";
      					
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
            }
        }catch(Exception e){

        }
%>
<%


%>
   </tr>
  </table>

<!------------------------------------------------------>
    <TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer">
            <TD>
<%
    if(selType.compareTo("checkbox") == 0)
    {
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");
    }
%>

<%
                if(selType.compareTo("") != 0)
                {
%>
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
                }
%>
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=�ر�>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>

    <TR>
    <BODY>
   <TABLE>

  <!------------------------>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>
