<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2000.01.13
 ģ�飺���ź�ͬЭ��¼��
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%request.setCharacterEncoding("gbk");%>

<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.io.*" %>

<%
    //�õ��������
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
	int outNum = 0;
	String regCode = (String)session.getAttribute("regCode");
	String dWorkNo = (String)session.getAttribute("workNo");				//��������
	String dNopass = (String)session.getAttribute("password");				//��������
	String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
	String iccid = request.getParameter("iccid");
    String cust_id = request.getParameter("cust_id");
    String unit_id = request.getParameter("unit_id");
    String sqlFilter = "";
    String sqlFilter1 = "";

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String v_iStartPos = String.valueOf(iStartPos);
	String v_iEndPos = String.valueOf(iEndPos);
	String[] inParams1 = new String[2];
	inParams1[1] = "";

    if (iccid.trim().length() > 0){
        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
        //sqlFilter1 = sqlFilter1 + " and a.id_iccid =:iccid";
        //inParams1[1] = inParams1[1] + "iccid=" + iccid;
    }
    if (unit_id.trim().length() > 0){
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
     	//sqlFilter1 = sqlFilter1 + " and b.unit_id =:unit_id";
     	//inParams1[1] = inParams1[1] + ",unit_id=" + unit_id;
    }
    if (cust_id.trim().length() > 0){
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;
     	//sqlFilter1 = sqlFilter1 + " and b.cust_id =:cust_id";
     	//inParams1[1] = inParams1[1] + ",cust_id=" + cust_id;
    }

  //String sqlStr = "select nvl(count(*),0) num from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter;
	//String sqlStr1 = "select * from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter + ") where id <="+iEndPos+" and id>="+iStartPos;
	
	//inParams1[0]  = "select *  from (select a.id_iccid, a.cust_id, a.cust_name, b.unit_id, b.unit_name, rownum id from dCustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id " + sqlFilter1 + ") where id <=:iEndPos and id>=:iStartPos";
	//inParams1[1] = inParams1[1] + ",iEndPos=" + iEndPos + ",iStartPos=" + iStartPos;
	
	//System.out.println("inParams1[0]======="+sqlStr1);
	//System.out.println("inParams1[1]======="+inParams1[1]);
	
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

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���ſͻ���ѯ</TITLE>
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

  <table cellspacing="0">
	<TR >
		<TH>&nbsp;&nbsp;֤������</TH>
		<TH>&nbsp;&nbsp;���ſͻ�ID</TH>
		<TH>&nbsp;&nbsp;���ſͻ�����</TH>
		<TH>&nbsp;&nbsp;���ű��</TH>
		<TH>&nbsp;&nbsp;��������</TH>
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
      		//retArray = callView.view_spubqry32(fieldNum,sqlStr1);
%>
			<!--
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6">			
			<wtc:param value="<%=inParams1[0]%>"/>	
			<wtc:param value="<%=inParams1[1]%>"/>	
			</wtc:service>	
			<wtc:array id="result1"  scope="end"/>
			-->	  
	 <wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="1902"/>
    <wtc:param value="<%=dWorkNo%>"/>	
    <wtc:param value="<%=dNopass%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value="<%=unit_id%>"/>
    <wtc:param value="<%=cust_id%>"/>
    <wtc:param value="<%=iccid%>"/>
    <wtc:param value=""/>
    <wtc:param value="1902"/>
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=v_iStartPos%>"/>
    <wtc:param value="<%=v_iEndPos%>"/>
    <wtc:param value="2"/>
    <wtc:param value=""/>
    <wtc:param value="2"/>
    <wtc:param value=""/>
  </wtc:service>
  <wtc:array id="result1" scope="end"/>
			  
	<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="1902"/>
    <wtc:param value="<%=dWorkNo%>"/>	
    <wtc:param value="<%=dNopass%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value="<%=unit_id%>"/>
    <wtc:param value="<%=cust_id%>"/>
    <wtc:param value="<%=iccid%>"/>
    <wtc:param value=""/>
    <wtc:param value="1902"/>
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=v_iStartPos%>"/>
    <wtc:param value="<%=v_iEndPos%>"/>
    <wtc:param value="1"/>
    <wtc:param value=""/>
    <wtc:param value="2"/>
    <wtc:param value=""/>
  </wtc:service>
  <wtc:array id="result2" scope="end"/>  
			
<%
			//retArray1 = callView.view_spubqry32("1",sqlStr);
      		//int recordNum = Integer.valueOf((String)retArray.get(0)); 
      		result = result1;
			allNumStr = result2;
      		int recordNum = result.length;
      		for(int i=0;i<recordNum;i++)
      		{
      			String tdClass = (i%2==0)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD class="+tdClass+">&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
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
  </table>
  <div style="position:relative;font-size:12px;">
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
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
