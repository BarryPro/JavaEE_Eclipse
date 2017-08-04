<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.24
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%> 
<% request.setCharacterEncoding("gbk");%>

<%!
    //得到输入参数
    int recordNum = 0;
    int iQuantity = 0;
    String return_code,return_message;

%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
	String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String sqlStr1 = request.getParameter("sqlStr1")==null?"":request.getParameter("sqlStr1");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

	System.out.println("sqlStr====="+sqlStr);
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
<HEAD><TITLE><%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
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
	      var fPubSimpSels = document.getElementsByName("List");
          //for(i=0;i<document.fPubSimpSel.elements.length;i++)
		  for(i=0;i<fPubSimpSels.length;i++)
          { 
    		      //if (document.fPubSimpSel.elements[i].name=="List")
    		      //{    //判断是否是单选或复选框
    				   if (fPubSimpSels[i].checked==true)
    				   {     //判断是否被选中
        				     //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = fPubSimpSels[i].RIndex;
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
        					 window.returnValue= retValue     
                       }
    		   // }
    		}		
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
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>	
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%> 

<%
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{      	
        //retArray = callView.sPubSelect(fieldNum,sqlStr);
%>
		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
		
        recordNum = result.length;
        if (result.length == 0)
            recordNum = 0;

  		for(int i=0;i<recordNum;i++)
  		{
  			String tdClass = (i%2==0)?"":"Grey";
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
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            (result[i][j]).trim() + "'readonly></TD>";          		            
                }
                else
                {        		        
      		        inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            (result[i][j]).trim() + "'readonly></TD>";          		            
                }          		            
  		    }
  		    out.print(typeStr + inputStr);
  		    out.print("</TR>");
  		}
 	}catch(Exception e){
   		System.out.println("查询错误!!");
 	}          
%>
<%


%>   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;        
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
