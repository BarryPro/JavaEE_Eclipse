   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN���ſ���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312"%>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<%
    //�õ��������
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
    
    String regionCode = (String)session.getAttribute("regCode");
    
    
%>      

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
        String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String sqlFilter = "";

        int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
        int iPageSize = 25;
        int iStartPos = (iPageNumber-1)*iPageSize;
        int iEndPos = iPageNumber*iPageSize;

    if (iccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
    if (unit_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;                                          
    if (cust_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;

    String sqlStr = "select nvl(count(*),0) num from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter;
		/** add by daixy 20081127,group_id����dCustDoc�е�org_id
		 ** String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, a.org_code,b.contact_person ,b.unit_addr ,b.contact_phone, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
		**/   
   	String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, a.org_code,b.contact_person ,b.unit_addr ,b.contact_phone, a.org_id, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;
   /**add by daixy 20081127,group_id����dcustDoc��org_id end **/
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@"+sqlStr1);
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

<HTML><HEAD>
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

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
                                            obj = "Rinput" + rIndex + fieldNo;
                                            //alert(obj);
                                            retValue = retValue + document.all(obj).value + "|";
                                            tempQuence = tempQuence.substring(chPos + 1);
                                         }
                             //alert(retValue);                                  
                                                 window.returnValue= retValue;
                       }
                    }
                }               
                if(retValue =="")
                {
                    rdShowMessageDialog("��ѡ����Ϣ�",0);
                    return false;
                }
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


	<div class="title">
		<div id="title_zi">���ſͻ���ѯ</div>
	</div>
	 
  <table cellspacing="0">
    <tr>
<TR bgcolor='649ECC' height=25>
	<TD align=center class="blue">֤������</TD>
	<TD align=center class="blue">�ͻ�ID</TD>
	<TD align=center class="blue">�ͻ�����</TD>
	<TD align=center class="blue">����ID</TD>
	<TD align=center class="blue">��������</TD>
	<TD align=center class="blue">������</TD>
	<TD align=center class="blue">��ϵ������</TD>
	<TD align=center class="blue">������ϵ��ַ</TD>
	<TD align=center class="blue">������ϵ�绰</TD>
	<TD align=center class="blue">������֯</TD>
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
     fieldNum = String.valueOf(tempNum+1);
%> 

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
        try
        {  
        
%>


		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_t" scope="end"/>


		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t" scope="end"/>

<%             
                //retArray = callView.sPubSelect(fieldNum,sqlStr1);
                //retArray1 = callView.sPubSelect("1",sqlStr);
                result = result_t;
                
                allNumStr = allNumStr_t;
                int recordNum = Integer.parseInt(allNumStr[0][0].trim());
                for(int i=0;i<recordNum;i++)
                {
                    typeStr = "";
                    inputStr = "";
                    out.print("<TR bgcolor='#EEEEEE'>");
                    for(int j=0;j<Integer.parseInt(fieldNum)-1;j++)
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
                                    " id='Rinput" + i + j + "' class='button' value='" + 
                                    (result[i][j]).trim() + "'readonly></TD>";                                      
                    }
                    else
                    {                           
                                inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                                    " id='Rinput" + i + j + "' class='button' value='" + 
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
<%      
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
        PageView view = new PageView(request,out,pg); 
         
%>
<div style="position:relative;font-size:12px" align="center">

<%
    view.setVisible(true,true,0,0);      
%>

</div>

<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
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
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;        
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
</BODY></HTML>    