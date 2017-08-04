<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
   	 //得到输入参数
  	String return_code,return_message;
  	String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
	String opCode = "3171";
	String opName = "支付关系管理";
	String regionCode= (String)session.getAttribute("regCode");
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
 %> 	

<%
	String pageTitle 	= request.getParameter("pageTitle");
	String fieldNum 	= "";
	String fieldName 	= request.getParameter("fieldName");   

	String sqlFilter 	= "";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	String s_start= String.valueOf(iStartPos);
	String s_end = String.valueOf(iEndPos);
   
	String idCard=request.getParameter("idCard");
	//String sqlStr = "select count(*) from dconmsg  where account_type='A'  and con_cust_id in(select cust_id from dCustDoc where ID_ICCID='"+idCard+"') ";
	 
	
	String selType = request.getParameter("selType");
	String retQuence = request.getParameter("retQuence");

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

<HTML>
	<HEAD>
		<TITLE>支付帐户信息</TITLE>
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
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}
		opener.getvalueAccount(retValue);
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
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel"> 
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">支付帐户信息</div>
	</div>
  	<table  cellspacing="0">
		<TR>
			<th>&nbsp;&nbsp;帐号</th>
			<th>&nbsp;&nbsp;帐户名称</th>
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
	     fieldNum = String.valueOf(tempNum+1);
	%> 

<%
    //根据传人的Sql查询数据库，得到返回结果
	try
 	{      	
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
		//retArray1 = callView.sPubSelect("1",sqlStr);
		%>
		 
<!--xl add for 用crm侧提供的服务替换原sPubSelect查询-->
		<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum%>">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3171"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3171"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=s_start%>"/>
			<wtc:param value="<%=s_end%>"/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="retArray" scope="end"/>


		
       
<!--xl add for 替换查询count-->
		<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3171"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3171"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="retArray1" scope="end"/>


		<%		
      		//result = (String[][])retArray.get(0);      		
      		 result=retArray;
		//allNumStr = (String[][])retArray1.get(0);
		allNumStr=retArray1;
            	int recordNum = Integer.parseInt(allNumStr[0][0].trim());            
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
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
</table>
<%
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
    PageView view = new PageView(request,out,pg);
%>

<div style="position:relative;font-size:12px;" align="center">
<%
   	view.setVisible(true,true,0,0);       
%>
</div>
<!------------------------------------------------------>
	<TABLE  cellSpacing=0>
		<TBODY>
			<TR> 
			    <TD id="footer">
			<%
			if(selType.compareTo("checkbox") == 0)
			{           
				out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
				out.print("<input class='b_foot_long' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
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
</BODY>
</HTML>    
