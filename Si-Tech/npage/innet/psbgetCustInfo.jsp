<%
/********************
 version v2.0
开发商: si-tech
*
*update:liutong@20080822
********************/
%>
<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>	
<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/

	  String opCode = "1104";
	  String opName = "普通开户";
        String workNo = (String)session.getAttribute("workNo");
        String password = (String)session.getAttribute("password"); 
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String custnames="";
    String custiccid="";
    if(sqlStr.indexOf("CUST_NAME")!=-1) {
    		String[] custnamesarry=sqlStr.split("CUST_NAME=");
    		System.out.println(custnamesarry.length+"==custnamesarry==========="+custnamesarry[0]);
    		System.out.println(custnamesarry.length+"==custnamesarry==========="+custnamesarry[1]);
    		custnames=custnamesarry[1];
    }
    if(sqlStr.indexOf("ID_ICCID")!=-1) {
    		String[] custiccidsarry=sqlStr.split("ID_ICCID=");
    		System.out.println(custiccidsarry.length+"==custiccidsarry==========="+custiccidsarry[0]);
    		System.out.println(custiccidsarry.length+"==custiccidsarry==========="+custiccidsarry[1]);
    		custiccid=custiccidsarry[1];
    }
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
/*    
    String selType = "";
    String pageTitle = "";
    
    String fieldNum = "2";
    String sqlStr = request.getParameter("sqlStr");
    String fieldName = "标识|名称|性别|年龄|";     
*/   
%>

<HTML><HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
</HEAD>
<BODY>

<SCRIPT type=text/javascript>
function saveTo()
{
/*
		 var d1= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString())+" "+new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds();
*/

      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var fieldNo;        //返回域序列号
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
       //返回单条记录
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          { 
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //判断是否被选中
        				     //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         //alert('retNum'+retNum);
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex + fieldNo;
        			            //alert('2----'+obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                             //alert('1------'+retValue);                                  
        					 window.returnValue= retValue;
<%
	//if (selType.equals("radio"))
	//{
	//	out.println("window.close();");
	//}
%>
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择客户信息！",0);
		    return false;
		}
/*
var d2= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString())+" "+new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds();
alert("start time:"+d1+"\r\n"+"end time:"+d2);
*/
window.close(); 
}

			
      		
</SCRIPT>


<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>   
 <table cellspacing="0" >
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR align='center'>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th>" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);

    %>
					
					<wtc:service name="sCustTypeQryA"  routerValue="<%=regionCode%>"  retcode="return_code" retmsg="return_message" outnum="<%=fieldNum%>" >
						<wtc:param value="0" />
						<wtc:param value="01" />	
						<wtc:param value="1100" />	
						<wtc:param value="<%=workNo%>" />
						<wtc:param value="<%=password%>" />
						<wtc:param value="" />
						<wtc:param value="" />
						<wtc:param value="<%=custnames%>" />
						<wtc:param value="<%=custiccid%>" />
			</wtc:service>
			<wtc:array id="result"  scope="end"/>
<%  	
    System.out.println("result==========sCustTypeQryA服务========================="+result.length);  		
      		int recordNum = result.length;
      		String tbClass="";   

      		for(int i=0;i<recordNum;i++)
      		{
      		
      			if(i%2==0){
							tbClass="Grey";
						}else{
							tbClass="";
						}
				
				
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr ="<TD>&nbsp;<input type='" + selType +  
          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
                            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        typeStr = typeStr + "<input type='hidden' id='Rinput"+i+j+"'  value='"+result[i][j] + "' readonly>" +result[i][j] + "</TD>";          		            
                    }
                    else if(j==7)
                    {
          		        inputStr = inputStr + "<TD><input type='password' " +
          		            " id='Rinput" + i + j + "' class='InputGrey' style='text-align:center' value='" + 
          		            result[i][j] + "' readonly></TD>";                      
                    }
                    else
                    {
          		        inputStr = inputStr + "<TD><input type='hidden' id='Rinput"+i+j+"'  value='"+result[i][j]+"' readonly>" +result[i][j] + "</TD>";          		            
                    }
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	     
%>
        <TR> 
            <TD align=center id=footer colspan=9>
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TABLE>
  
 <%@ include file="/npage/include/footer_pop.jsp" %> 
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
</FORM>
</BODY></HTML>    
