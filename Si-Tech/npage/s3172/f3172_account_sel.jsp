
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>
              
<%
  String opCode = "3172";
  String opName = "һ��֧���ʻ��ɷ�";
%>              

<%
	request.setCharacterEncoding("ISO-8859-1"); 
%>
   
   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    //�õ��������
  String return_code,return_message;
  String[][] result = new String[][]{};
  String[][] allNumStr =  new String[][]{};
   
	
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
	String regionCode = (String)session.getAttribute("regCode");
  String pageTitle 	= request.getParameter("pageTitle");
  String fieldNum 	= "";
  String fieldName 	= request.getParameter("fieldName");    
  
  //String supecId = new String(request.getParameter("supecId").getBytes("ISO-8859-1"),"GB2312");//���������ѯ�����Ĳ���

  String sqlFilter 	= "";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String s_start= String.valueOf(iStartPos);
	String s_end = String.valueOf(iEndPos);
    //if (supecId.trim().length() > 0)
        //    sqlFilter = sqlFilter + "a.con_cust_id=(select b.cust_id from dMhECInfo b where b.supec_id ='" + supecId + "' and b.vest_prov='451' )";
		
		String idCard=request.getParameter("idCard");
   	//String sqlStr = "select to_char(count(*)) from dconmsg  where account_type in ('A','1')  and con_cust_id in(select cust_id from dCustDoc where ID_ICCID='"+idCard+"') ";
		//String sqlStr1 = "select * from (select to_char(CONTRACT_NO),BANK_CUST,rownum id from dconmsg  where account_type in ('A','1')  and con_cust_id in(select cust_id from dCustDoc where ID_ICCID='"+idCard+"')) where id <="+iEndPos+" and id>"+iStartPos;
	//System.out.println(sqlStr1);
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");

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
    System.out.println("11111111111111111111111111111111");
%>

<HTML><HEAD>
<TITLE>֧���ʻ���Ϣ</TITLE>
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
		<div id="title_zi">ѡ���˺�</div>
	</div>
   <TABLE>
   <BODY>
    <TR>      

  <table cellspacing="0">
    
<TR><TD class="blue">&nbsp;&nbsp;�ʺ�</TD><TD class="blue">&nbsp;&nbsp;�ʻ�����</TD></TR> 
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
      		//retArray = callView.TlsPubSelBoss(fieldNum,sqlStr1);
			    //retArray1 = callView.TlsPubSelBoss("1",sqlStr);
			
%>

<!--xl add for ��crm���ṩ�ķ����滻ԭsPubSelect��ѯ-->
		<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="code1" retmsg="msg1" outnum="1">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3172"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3172"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
		</wtc:service>
     <wtc:array id="allNumStr_t" scope="end"/>

	 
<!--xl add for ��crm���ṩ�ķ����滻ԭsPubSelect��ѯ-->
		<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="code2" retmsg="msg2" outnum="<%=fieldNum%>">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3172"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3172"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=s_start%>"/>
			<wtc:param value="<%=s_end%>"/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
		</wtc:service>
     <wtc:array id="result_t" scope="end"/>

 

<%			
      		result = result_t;      		
      		
					allNumStr = allNumStr_t;
            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR bgcolor='#EEEEEE' style='font-size:12px;'>");
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
    <TABLE width="100%" border=0 align=center cellpadding="4" cellSpacing=1>
    <TBODY>
        <TR > 
            <TD align=center idr="foote">
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
                <input  name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ�� class="b_foot">&nbsp;
<%
				}
%>             
                <input  name=back onClick="window.close()" style="cursor:hand" type=button value=���� class="b_foot">&nbsp;        
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
