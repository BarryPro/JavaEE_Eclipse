<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-15
********************/
%>
<%
  String opCode = "3596";
  String opName = "个人SI业务受理";
%>

<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>


<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">

<%

    //得到输入参数
    String[][] result = new String[][]{};
    String[] paramsIn = null;
	  String[][] allNumStr =  new String[][]{};
    Logger logger = Logger.getLogger("fpubprod_sel.jsp");
%> 	
<%
    String fieldNum = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldName = request.getParameter("fieldName");
	  //String op_code = request.getParameter("op_code");
    //String sm_code = request.getParameter("sm_code");
    String regionCode = request.getParameter("regionCode");
    String ecsiId = request.getParameter("ecsiId");
	  
	  System.out.println("ecsiId="+ecsiId);
	   
	  //分页设置
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	  String sqlStr = null;
	  String sqlStr1 = null;
	  	  
			sqlStr =  "select nvl(count(*),0)"
								+" from dbaseecsibusi a,dparteroperation b,dBaseEcSIBusiadd c"
								+" where a.oper_id=b.oper_id "                                 
								+" and a.ecsiid=c.ecsiid  "                                    
								+" and a.bizcode=c.bizcode "                                   
								+" and b.status='02' "                                         
							  +" and b.check_status='08' "                                 
								+" and a.biztype='1' "                                       
								+" and a.ecsiid='"+ecsiId+"' ";                                    
								
 	  
			sqlStr1 = "select a.ecsiid,a.bizcode,a.bizname,c.servcode,a.baseservcodeprop"
								+" from dbaseecsibusi a,dparteroperation b,dBaseEcSIBusiadd c"
								+" where a.oper_id=b.oper_id "                                 
								+" and a.ecsiid=c.ecsiid  "                                    
								+" and a.bizcode=c.bizcode "                                   
								+" and b.status='02' "                                         
							  +" and b.check_status='08' "                                 
								+" and a.biztype='1' "                                       
								+" and a.ecsiid='"+ecsiId +"' ";               
										  
       System.out.println("sqlStr####="+sqlStr);
       System.out.println("sqlStr1$$$$="+sqlStr1);	
         
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

<HTML><HEAD>
<TITLE>黑龙江BOSS-个人订购ＳＩ业务查询</TITLE>

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
      var retFieldNum = document.fpubmebProdCodesel.retFieldNum.value;
      var retQuence = document.fpubmebProdCodesel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
          //返回单条记录
          for(i=0;i<document.fpubmebProdCodesel.elements.length;i++)
          { 
    		      if (document.fpubmebProdCodesel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fpubmebProdCodesel.elements[i].checked==true)
    				   {     //判断是否被选中
        				     //alert(document.fpubmebProdCodesel.elements[i].value);
        			         rIndex = document.fpubmebProdCodesel.elements[i].RIndex;
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
                  // alert("retValue="+retValue);                                  
        					 window.returnValue= retValue;
                }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		opener.getvalueSi(retValue);
		window.close(); 
}
	
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>

<BODY>
<FORM method=post name="fpubmebProdCodesel"> 
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">黑龙江BOSS-个人订购ＳＩ业务查询</div>
	</div>

  <table  cellspacing="0">
    <tr>
<TR>
	<TD class="blue">&nbsp;&nbsp;ＳＩ编码</TD>
	<TD class="blue">&nbsp;&nbsp;业务代码</TD>
	<TD class="blue">&nbsp;&nbsp;业务名称</TD>
	<TD class="blue">&nbsp;&nbsp;业务接入号</TD>
	<TD class="blue">&nbsp;&nbsp;接入号属性</TD>
</TR> 
<%  //绘制界面表头  
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
    //根据传入的Sql查询数据库，得到返回结果
	try
 	{      	
 	
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_l" scope="end"/>


		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_l" scope="end"/>

<% 	
      	//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			  //retArray1 = callView.sPubSelect("1",sqlStr);
        result = result_l ;
			  allNumStr = allNumStr_l;

            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            for(int i=0;i<recordNum;i++)
      		  {
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR >");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						            }	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else if(j==4)
                    {        		        
          		         if(result[i][j].trim().equals("01"))
          		         {
          		         	inputStr = inputStr + "<TD>&nbsp;" + "短信" + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";        
          		         } 
          		        else if( result[i][j].trim().equals("02")) 
          		        {
          		        	inputStr = inputStr + "<TD>&nbsp;" + "彩信" + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>"; 
          		        }         
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
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	  PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>

<!------------------------------------------------------>
    <TABLE  cellSpacing="0">
    <TBODY>
        <TR > 
            <TD align=center >
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
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
  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>    
	
