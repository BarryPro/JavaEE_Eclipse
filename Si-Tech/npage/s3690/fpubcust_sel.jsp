<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>

<%
    String opName = "���ſͻ���ѯ";
    //�õ��������
    ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
 	String dWorkNo = (String)session.getAttribute("workNo");				//��������
	String dNopass = (String)session.getAttribute("password");				//��������
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String pageTitle 	= request.getParameter("pageTitle");
    String fieldNum 	= "";
    String fieldName 	= request.getParameter("fieldName");
		String iccid 			= request.getParameter("iccid");
    String cust_id		= request.getParameter("cust_id");
    String unit_id 		= request.getParameter("unit_id");
    
    String rOpCode 		= request.getParameter("rOpCode");
    System.out.println("gaopengSeeLog==========rOpCode====="+rOpCode);
    
    String sqlFilter 	= "";
		String regionCode	=	request.getParameter("regionCode");
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 25;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
    String v_iStartPos = String.valueOf(iStartPos);
    String v_iEndPos = String.valueOf(iEndPos);

    if (iccid.trim().length() > 0)
        sqlFilter = sqlFilter + " and a.id_iccid = '" + iccid + "'";
    if (unit_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.unit_id = " + unit_id;
    if (cust_id.trim().length() > 0)
        sqlFilter = sqlFilter + " and b.cust_id = " + cust_id;
    if ( regionCode.trim().length() > 0 )
        sqlFilter = sqlFilter + " and substr(a.org_code,1,2) = '" + regionCode +"'"; 
        

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
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
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
        			            obj = "Rinput" + rIndex +"0"+ fieldNo;
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
		    rdShowMessageDialog("��ѡ����Ϣ�");
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
	<div id="title_zi">��ѯ���</div>
</div>
<table cellspacing="0">
<TR align=center>
	<TH>֤������</TH>
	<TH>���ſͻ�ID</TH>
	<TH>���ſͻ�����</TH>
	<TH>���ű��</TH>
	<TH>��������</TH>
	<TH>������֯</TH>
	<!--<TH>������</TH>-->
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
	
      		%>
          <wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
            <wtc:param value="0"/>
            <wtc:param value="01"/>
            <wtc:param value="3690"/>
            <wtc:param value="<%=dWorkNo%>"/>	
            <wtc:param value="<%=dNopass%>"/>		
            <wtc:param value=""/>	
            <wtc:param value=""/>
            <wtc:param value="<%=unit_id%>"/>
            <wtc:param value="<%=cust_id%>"/>
            <wtc:param value="<%=iccid%>"/>
            <wtc:param value=""/>
            <wtc:param value="3690"/>
            <wtc:param value=""/>	
            <wtc:param value=""/>
            <wtc:param value="<%=regionCode%>"/>
            <wtc:param value="<%=v_iStartPos%>"/>
            <wtc:param value="<%=v_iEndPos%>"/>
            <wtc:param value="2"/>
            <wtc:param value=""/>
            <wtc:param value="3"/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
          </wtc:service>
          <wtc:array id="retArr1" scope="end"/>

      		<%
      		    if (retArr1.length>0 && retCode1.equals("000000")){
      		        result = retArr1;
      		    }
			%>
              
           <wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="100" >
            <wtc:param value="0"/>
            <wtc:param value="01"/>
            <wtc:param value="3690"/>
            <wtc:param value="<%=dWorkNo%>"/>	
            <wtc:param value="<%=dNopass%>"/>		
            <wtc:param value=""/>	
            <wtc:param value=""/>
            <wtc:param value="<%=unit_id%>"/>
            <wtc:param value="<%=cust_id%>"/>
            <wtc:param value="<%=iccid%>"/>
            <wtc:param value=""/>
            <wtc:param value="3690"/>
            <wtc:param value=""/>	
            <wtc:param value=""/>
            <wtc:param value="<%=regionCode%>"/>
            <wtc:param value="<%=v_iStartPos%>"/>
            <wtc:param value="<%=v_iEndPos%>"/>
            <wtc:param value="1"/>
            <wtc:param value=""/>
            <wtc:param value="3"/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
            <wtc:param value=""/>
          </wtc:service>
          <wtc:array id="retArr2" scope="end"/>
            <%
                int recordNum = 0;
                if (retArr2.length>0 && retCode2.equals("000000")){
      		        allNumStr = retArr2;
      		        recordNum = Integer.parseInt(allNumStr[0][0].trim());
      		    }
      		//result = (String[][])retArray.get(0);
			//allNumStr = (String[][])retArray1.get(0);
            //int recordNum = Integer.parseInt(allNumStr[0][0].trim());
      		for(int i=0;i<recordNum;i++)
      		{
      			
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR align=center>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
      		    System.out.println("gaopengSeeLog============result["+i+"]["+j+"]===" + result[i][j].trim() );
                    if(j==0)
                    {
                        typeStr = "<TD>";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                	else if (j == (Integer.parseInt(fieldNum) - 1))
                	{
          		        inputStr = inputStr + "<TD>" + "" + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";    
          		            System.out.println("gaopengSeeLog====result["+i+"]["+j+"]=====11111===inputStr===" +inputStr);      		            
                	}
                	/*2014/08/12 15:20:28 gaopeng �ͻ�������Ϣģ����չʾ���󣨵������� 
                		���ſͻ����� ��ģ��������
                	*/
                	
                		else if(j == 2 && "e887".equals(rOpCode)){
                		
	                		String unitCustName = result[i][j].trim();
	                		
	                		
	                		if(unitCustName != null && !"".equals(unitCustName)){
												if(unitCustName.length() == 2 ){
													unitCustName = unitCustName.substring(0,1)+"*";
												}
												if(unitCustName.length() == 3 ){
													unitCustName = unitCustName.substring(0,1)+"**";
												}
												if(unitCustName.length() == 4){
													unitCustName = unitCustName.substring(0,2)+"**";
												}
												if(unitCustName.length() > 4){
													unitCustName = unitCustName.substring(0,2)+"******";
												}
											}
                		
                		inputStr = inputStr + "<TD>" + unitCustName + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            unitCustName + "'readonly></TD>";   
          		            System.out.println("gaopengSeeLog===result["+i+"]["+j+"]====2222=====inputStr===" +inputStr);
                		}
                	
                    else
                    {        	
          		        inputStr = inputStr + "<TD>" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";   
          		            System.out.println("gaopengSeeLog===result["+i+"]["+j+"]====2222=====inputStr===" +inputStr);       		            
                    }          		            
      		    }
      		     System.out.println("gaopengSeeLog============typeStr===" +typeStr );
      		      System.out.println("gaopengSeeLog======3333======inputStr===" +inputStr );
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
        
%>
<%


%>   
  </table>
  <table cellSpacing=0>
    <tr>
        <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    int iQuantity = 0;
    if (retArr2.length>0 && retCode2.equals("000000")){
      iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    }
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	  PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
</td>
</tr>
</table>
<!------------------------------------------------------>
<TABLE cellSpacing=0>
    <TR id="footer"> 
        <TD align=center>
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
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>        
            </TD>
        </TR>
    </TABLE>
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
