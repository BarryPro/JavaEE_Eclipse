   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "��Ʒ����";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>

<%
    //�õ��������
    String return_code,return_message;
    String[][] result = new String[][]{};
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
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String inStr = request.getParameter("inStr");
 
 System.out.println("==inStr="+inStr);
    
    System.out.print("----------sqlStr-----------------"+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   } 
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
    int DB_RECORD_NUM = 0;
%>

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

<SCRIPT type=text/javascript>

var ACC_TOKEN = ",";
var ALL_TOKEN = "*";

function init()
{
	var token=ACC_TOKEN;
	var retInfo = document.all.inStrPara.value;
    var chPos;
    var valueStr;
    var record_num = document.all.dbRecordNum.value;
    
    	//alert("record_num="+record_num);
		//alert("retInfo="+retInfo);
	        	
	if( retInfo == "*" ){//��ʾȫ��
		allChoose();
		return;
	}
	
	chPos = retInfo.indexOf(token);   //ע��:�������ַ����ķָ��. yl.
    while(chPos > -1)
    {

		valueStr = retInfo.substring(0,chPos);
		//����checked
		chg_checked(valueStr);
        retInfo = retInfo.substring(chPos + 1);
        chPos = retInfo.indexOf(token);
        if( chPos > -1 )
        	tmpPos = chPos ;
    }
    if( !(chPos > -1)){			
		valueStr = retInfo;
		chg_checked(valueStr);
	}	


}

function chg_checked(valueStr)
{
	var obj="";
	var flag=0;
	var listLen=0;
	var record_num = document.all.dbRecordNum.value;
	var j=0;
	
	
	if( record_num <= 0){
		return;
	}
	if( typeof(document.all.List.length)=="undefined"){
		flag=0;
		listLen=1;
		obj = 'Rinput' + i + j;	//��ʾ���Ǵ��������
		document.all.List.checked = true;
		return;		
	}else{
		flag=1;
		listLen=document.all.List.length;
	}
		
	for(var i=0; i<listLen ; i++){
		obj = 'Rinput' + i + j;	//��ʾ���Ǵ��������
		if( document.all(obj).value == valueStr){
			document.all.List[i].checked = true;
			break;
		}
	
	}
	
	
}

function saveTo()
{
      var rIndex;        //ѡ�������
      var retValue = ""; //����ֵ
      var chPos;         //�ַ�λ��
      var obj;
      var isAllChgFlag = 0;
      var isBreakFlag = 0;
      
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
        			            if( document.all(obj).value == ALL_TOKEN){
        			            	retValue = ALL_TOKEN;
        			            	isBreakFlag = 1;
        			            	break;        			            
        			            }        			            
        			            retValue = retValue + document.all(obj).value + ACC_TOKEN;
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
        			         if( isBreakFlag == 1){
        			         	break;
        			         }
        			         	
                             //alert(retValue);                                  
   
                       }else{
                       		isAllChgFlag = 1;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}
		if( isAllChgFlag == 0 ){
			retValue = ALL_TOKEN;
		}
		
		window.returnValue= retValue;					
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
		<div id="title_zi">ѡ���������</div>
	</div>


  <table  cellspacing="0">
    <tr>
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR   height=25>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<Th>&nbsp;&nbsp;" + valueStr + "</Th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     
%> 

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
      		//retArray = callView.view_spubqry32(fieldNum,sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%      		
					if(result_t.length>0&&code.equals("000000"))
      		result = result_t;
      		
      		int recordNum = result.length;
      		DB_RECORD_NUM = recordNum;
//      		System.out.println("=recordNum="+recordNum+",DB_RECORD_NUM="+DB_RECORD_NUM);
      		
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR >");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr ="<TD>&nbsp;<input type='" + selType +  
          		            "' name='List' id='List' style='cursor:hand' RIndex='" + i + "'" + 
          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
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
    <TABLE  cellSpacing="0">
    <TBODY>
        <TR > 
            <TD align=center id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input  class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input  class='b_foot_long'  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
    } 
%>            
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
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
  <input type="hidden" name="dbRecordNum" value=<%=DB_RECORD_NUM%>>
  <input type="hidden" name="inStrPara" value=<%=inStr%>>
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
