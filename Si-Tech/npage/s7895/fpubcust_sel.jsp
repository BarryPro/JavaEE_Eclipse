<%
/********************
 * version v2.0
 * 开发商: si-tech
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
    String opName = "集团客户查询";
    //得到输入参数
    ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String pageTitle 	= WtcUtil.repNull(request.getParameter("pageTitle"));
    String fieldNum 	= "";
    String fieldName 	= WtcUtil.repNull(request.getParameter("fieldName"));
	String iccid        = WtcUtil.repNull(request.getParameter("iccid"));
    String cust_id		= WtcUtil.repNull(request.getParameter("cust_id"));
    String unit_id 		= WtcUtil.repNull(request.getParameter("unit_id"));
	String regionCode	= WtcUtil.repNull(request.getParameter("regionCode"));
	String service_no = WtcUtil.repNull(request.getParameter("service_no"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));

    String selType = WtcUtil.repNull(request.getParameter("selType"));
    String retQuence = WtcUtil.repNull(request.getParameter("retQuence"));
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
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

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
        			            obj = "Rinput" + rIndex + "0" + fieldNo;
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
		    rdShowMessageDialog("请选择信息项！");
		    return false;
		}
		opener.getvaluecust(retValue);
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
<TR align=center>
	<TH nowrap>证件号码</TH>
	<TH nowrap style='display:none'>集团客户ID</TH>
	<TH nowrap>集团客户名称</TH>
	<TH nowrap style='display:none'>集团产品ID</TH>
	<TH nowrap>集团号</TH>
	<TH nowrap>产品代码</TH>
	<th nowrap>产品名称</th>
	<th nowrap>集团编号</th>
	<th nowrap>产品付费帐户</th>
	<th nowrap style='display:none'>品牌代码</th>
	<th nowrap>品牌名称</th>
	<th nowrap>包月标识</th>
	<th nowrap style='display:none'>操作类型</th>
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
            <wtc:service name="sGetGroupInit" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="20" >
            	<wtc:param value="<%=iccid%>"/>
            	<wtc:param value="<%=cust_id%>"/>
                <wtc:param value="<%=unit_id%>"/>
                <wtc:param value="<%=service_no%>"/>
                <wtc:param value="<%=regionCode%>"/>
                <wtc:param value="7895"/>
                <wtc:param value="m04"/>
                <wtc:param value="<%=workNo%>"/>
                <wtc:param value="<%=workPwd%>"/>
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
<%
  		    if (retCode1.equals("000000")){
  		        result = retArr1;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }

            int recordNum = result.length;
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR align=center>");
      		    for(int j=0;j<20;j++) /*diling update*/
      		    {
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
                    }else if(j == 1 || j == 3 || j == 9 || j == 12 || j == 13 || j == 14 || j == 15||j==16||j==17||j==18||j==19){ /*diling add@2012/5/14*/
          		        inputStr = inputStr + "<TD style='display:none'>" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";
          		            System.out.println("------------7895------result["+i+"]["+j+"]="+result[i][j]);
          		    }else{   
          		        inputStr = inputStr + "<TD>" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + "0" + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";
                    }          		            
      		    }
      		    System.out.println("------------7895------inputStr="+inputStr);
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
        
%>
<%


%>   
  </table>

<!------------------------------------------------------>
<TABLE cellSpacing=0>
    <TR id="footer"> 
        <TD align=center>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>        
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
