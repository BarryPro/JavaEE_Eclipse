<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>

<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GB2312");%>



<%!                  //封掉   20080903  wtc替换 ejb liutong
    //得到输入参数
   // ArrayList retArray = new ArrayList();
   // String return_code,return_message;
   // String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
%> 	
<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String regionCode = request.getParameter("regionCode");
    String opName="普通开户";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
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
        				    // alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex + fieldNo;
        			           // alert(obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			           // alert(retValue);    
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                             //alert(retValue);                                  
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
		    rdShowMessageDialog("请选择sim卡费！",0);
		    return false;
		}

window.close(); 
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">

<%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=pageTitle%></div>
		</div>
      
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR> ");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TD>&nbsp;&nbsp;" + valueStr + "</TD>";
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

 		   //out.print(fieldNum);
      		//retArray = callView.view_spubqry32(fieldNum,sqlStr);
      		System.out.println(sqlStr);
      		//int recordNum = Integer.parseInt((String)retArray.get(0));
      		//result = (String[][])retArray.get(1);
      		//result = (String[][])retArray.get(0);
      		
      		
      		
 %>
			 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="retMsg" outnum="<%=fieldNum%>">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
 <%
 
 if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("调用服务sPubSelect in 	pubGetsimfee.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	       
 	       
 	       int recordNum = result.length;
      		System.out.print(sqlStr);
      		for(int i=0;i<recordNum;i++)
      		{
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
                        typeStr = typeStr + "<input type='text' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }
                    else if(j==7)
                    {
          		        inputStr = inputStr + "<TD><input type='password' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";                      
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD><input type='text' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
 	        	
 	        	
 	        	
 	        	
 	     	}else{
 			System.out.println("调用服务sPubSelect in 	pubGetsimfee.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

 
      	
     
%>
<%


%>   
   
   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
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
