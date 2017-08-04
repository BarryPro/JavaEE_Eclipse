<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%!
    int recordNum = 0;
    int iQuantity = 0;
    String[][] result = new String[][]{};
%> 	
<%
    String opName = "信息查询";
    String regionCode = (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");	
    String svcname = request.getParameter("serviceName")==null?"sPubSelect":request.getParameter("serviceName"); //服务名称
    String router_key = request.getParameter("routerKey") ==null?"region":request.getParameter("routerKey");
    String router_value = request.getParameter("routerValue")==null?regionCode:request.getParameter("routerValue");
    	
     String op_name = request.getParameter("pageTitle");
     String fieldNum = "";
     String fieldName = request.getParameter("fieldName");
     String sqlStr = request.getParameter("sqlStr")==null?"":request.getParameter("sqlStr");
     System.out.println("sqlStr == == "+sqlStr);
     String varStr = request.getParameter("varStr")==null?"":request.getParameter("varStr");
     String sqlStr1 = request.getParameter("sqlStr1")==null?"":request.getParameter("sqlStr1");
     String varStr1 = request.getParameter("varStr1")==null?"":request.getParameter("varStr1");
     String selType = request.getParameter("selType");
     String retQuence = request.getParameter("retQuence");
     int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
     int iPageSize = 25;
     int iStartPos = (iPageNumber-1)*iPageSize;
     int iEndPos = iPageNumber*iPageSize;

    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript">
function saveTo()
{
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
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex*10000 + fieldNo*100;
        			            //alert(obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                             //alert(retValue);                                  
        					 window.returnValue= retValue     
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		window.close(); 
}

function saveTo1(num)
{
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

            //alert(document.fPubSimpSel.elements[i].value);
              rIndex = num;
              tempQuence = retQuence;
              for(n=0;n<retNum;n++)
                {   
       	            chPos = tempQuence.indexOf("|");
       	            fieldNo = tempQuence.substring(0,chPos);
       	            //alert(fieldNo);
       	            obj = "Rinput" + rIndex*10000 + fieldNo*100;
       	            //alert(obj);
       	            retValue = retValue + document.all(obj).value + "|";
       	            tempQuence = tempQuence.substring(chPos + 1);
       	         }
                //alert(retValue);                                  
       		 window.returnValue= retValue     
              
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}

		window.close(); 
}

function allChoose()
{   //复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = true;
        }
    }  
}

function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = false;
        }
    }  
}
</script>
</HEAD>
<body>
<form method=post name="fPubSimpSel">   

<%@ include file="/npage/include/header_pop.jsp" %>  
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<tr>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th nowrap>" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</tr>");
     fieldNum = String.valueOf(tempNum);
     String col = String.valueOf(WtcUtil.countSqlCol(sqlStr)); //取查询语句返回列数
%> 

<%
           if (sqlStr1.trim().length() > 0) 
			{ %>		        
		    <wtc:service name="<%=svcname%>"  retCode="errCode" retMsg="errMsg"  outnum="1">
		    <wtc:param value="<%=sqlStr%>" />
	         <wtc:param value="<%=varStr1%>"/>
	         </wtc:service>
		        <wtc:array id="rows">
					<% result = rows; %>
		        </wtc:array>
		     <%
                iQuantity = Integer.parseInt(result[0][0].trim());
             }
%>      
	<%System.out.println("name = "+svcname);
	  System.out.println("sql = "+sqlStr);
	  System.out.println("varstr = "+varStr);
        %>
     <wtc:service name="<%=svcname%>"  retCode="errCode" retMsg="errMsg"  outnum="<%=col%>">
		 <wtc:param value="<%=sqlStr%>" />
	         <wtc:param value="<%=varStr%>"/>
	   </wtc:service>
		 <wtc:iter id="rows" indexId="k">
<% 
		    int i = k.intValue();
      	typeStr = "";
        inputStr = "";
      	out.print("<tr>");
        for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		 {
      		    String tdClass = "";
                if (j%2==0){
                    tdClass = "Grey";
                }
                if(j==0)
                  {
                        typeStr = "<TD>";
                        if(selType.compareTo("radio") == 0  )
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();' onclick='saveTo1("+i+")'" + ">"; 
					              }	
						            else if (selType.compareTo("checkbox") == 0  )
						            {												     
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						            }    
												      		            
                        typeStr = typeStr + (rows[j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i*10000 + j*100 + "' class='InputGrey' value='" + 
          		            (rows[j]).trim() + "'readonly></TD>";          		            
                  }
                  else
                  {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (rows[j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i*10000 + j*100 + "' class='InputGrey' value='" + 
          		            (rows[j]).trim() + "'readonly></TD>";          		            
                  }          		                     		            
      	  }
      		out.print(typeStr + inputStr);
      		out.print("</tr>"); 
%> 
		</wtc:iter>
   </tr>
  </table>

<%	
    if (sqlStr1.trim().length() > 0) {
        Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	    PageView view = new PageView(request,out,pg); 
     	view.setVisible(true,true,0,0);       
    }
%>

<!------------------------------------------------------>
    <table cellSpacing="0">
        <tr> 
            <td>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_text' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='b_text' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 
</td></tr>
</table>
    <table cellSpacing="0">
        <tr> 
            <td id="footer">
<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name="commit" onClick="saveTo()" style="cursor:hand" type="button" value="确认">&nbsp;
<%
				}
%>             
                <input class="b_foot" name="back" onClick="window.close()" style="cursor:hand" type="button" value="返回">&nbsp;        
            </td>
        </tr>
    </table>
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
</div>
</form>
<%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</html>    
