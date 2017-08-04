<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>



<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>

<%
String opCode = request.getParameter ( "opCode" );
String opName = request.getParameter ( "opName" );

    //得到输入参数
    ArrayList retArray = new ArrayList();
    ArrayList retArray1 = new ArrayList();
    String return_code,return_message;

    String[][] allNumStr =  new String[][]{};
    SPubCallSvrImpl callView = new SPubCallSvrImpl();

/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlFilter = "";

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
    
	String logacc=request.getParameter("logacc");	
	String chnSrc=request.getParameter("chnSrc");	
	//String opCode=request.getParameter("opCode");	
	String workNo=request.getParameter("workNo");	
	String passwd=request.getParameter("passwd");	
	
	String phoneNo=request.getParameter("phoneNo");	
	String usrPwd=request.getParameter("usrPwd");	
	String unitId=request.getParameter("unitId");	
	String icustid=request.getParameter("icustid");	
	String idIccId=request.getParameter("idIccId");	
	
	String bizCodAdd=request.getParameter("bizCodAdd");
	String oprCode=request.getParameter("oprCode");	
	String svcNo=request.getParameter("svcNo");	
	String grpId=request.getParameter("grpId");	
	String regCode=request.getParameter("regCode");	
	
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
	//String startPos=request.getParameter("startPos");	
	//String endPos=request.getParameter("endPos");	
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;	
    String iBeg = iStartPos+"";
    String iEnd = iEndPos+"";
	String qryType=request.getParameter("qryType");	
	String pntType=request.getParameter("pntType");	
	String accType=request.getParameter("accType");	
	String smCode=request.getParameter("smCode");	
	
	String vpmnNo=request.getParameter("vpmnNo");	
	String cnocNo=request.getParameter("cnocNo");	
	String other=request.getParameter("other");	
	String opNote=request.getParameter("opNote");	    
	int recordNum = 0;
	int iQuantity = 0;	
%>

<HTML><HEAD>
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
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
                                            opener.getvaluecust(retValue);
                       }
                    }
                }               
                if(retValue =="")
                {
                    rdShowMessageDialog("请选择信息项！",0);
                    return false;
                }
                window.returnVal = retValue;
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
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" >
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
	<DIV class = "title" >
		<DIV id = "title_zi"><%=opName%></DIV>
	</DIV>
	
	<table >
	<tr>
	<TR bgcolor='649ECC' height=25>
	<TH align=center>集团编码</TH>
	<TH align=center>集团名称</TH>
	<TH align=center>归属地</TH>
	<TH align=center>归属组织</TH>
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
	//根据传人的Sql查询数据库，得到返回结果
	try
	{
	%>
	<wtc:service name="sGrpCustQry" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regCode%>">
	    <wtc:param value="<%=logacc%>" />
	    <wtc:param value="<%=chnSrc%>" />
	    <wtc:param value="<%=opCode%>" />
	    <wtc:param value="<%=workNo%>" />
	    <wtc:param value="<%=passwd%>" />
	    
	    <wtc:param value="<%=phoneNo%>" />
	    <wtc:param value="<%=usrPwd%>" />
	    <wtc:param value="<%=unitId%>" />
	    <wtc:param value="<%=icustid%>" />
	    <wtc:param value="<%=idIccId%>" />
	    
	    <wtc:param value="<%=bizCodAdd%>" />
	    <wtc:param value="<%=oprCode%>" />
	    <wtc:param value="<%=svcNo%>" />
	    <wtc:param value="<%=grpId%>" />
	    <wtc:param value="<%=regCode%>" />
	    
	    <wtc:param value="<%=iBeg%>" />
	    <wtc:param value="<%=iEnd%>" />
	    <wtc:param value="1" />
	    <wtc:param value="<%=pntType%>" />
	    <wtc:param value="<%=accType%>" />
	    <wtc:param value="<%=smCode%>" />
	    
	    <wtc:param value="<%=vpmnNo%>" />
	    <wtc:param value="<%=cnocNo%>" />
	    <wtc:param value="<%=other%>" />
	    <wtc:param value="<%=opNote%>" />	
	</wtc:service>
	<wtc:array id="resultCnt" scope="end"   />	
	<%
	if (!code.equals("000000"))
	{
	%>
		<script>
			rdShowMessageDialog("<%=code%>:<%=msg%>",0);
			window.close();
		</script>
	<%
	}
	%>	
	
	<wtc:service name="sGrpCustQry" outnum="8" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regCode%>">
	    <wtc:param value="<%=logacc%>" />
	    <wtc:param value="<%=chnSrc%>" />
	    <wtc:param value="<%=opCode%>" />
	    <wtc:param value="<%=workNo%>" />
	    <wtc:param value="<%=passwd%>" />
	    
	    <wtc:param value="<%=phoneNo%>" />
	    <wtc:param value="<%=usrPwd%>" />
	    <wtc:param value="<%=unitId%>" />
	    <wtc:param value="<%=icustid%>" />
	    <wtc:param value="<%=idIccId%>" />
	    
	    <wtc:param value="<%=bizCodAdd%>" />
	    <wtc:param value="<%=oprCode%>" />
	    <wtc:param value="<%=svcNo%>" />
	    <wtc:param value="<%=grpId%>" />
	    <wtc:param value="<%=regCode%>" />
	    
	    <wtc:param value="<%=iBeg%>" />
	    <wtc:param value="<%=iEnd%>" />
	    <wtc:param value="<%=qryType%>" />
	    <wtc:param value="<%=pntType%>" />
	    <wtc:param value="<%=accType%>" />
	    <wtc:param value="<%=smCode%>" />
	    
	    <wtc:param value="<%=vpmnNo%>" />
	    <wtc:param value="<%=cnocNo%>" />
	    <wtc:param value="<%=other%>" />
	    <wtc:param value="<%=opNote%>" />	
	</wtc:service>
	<wtc:array id="result" scope="end"   />
	<%
	if (!code1.equals("000000"))
	{
	%>
		<script>
			rdShowMessageDialog("<%=code1%>:<%=msg1%>",0);
			window.close();
		</script>
	<%
	}
	System.out.println("result~~~~"+result.length);
	System.out.println("resultCnt~~~~"+resultCnt.length);
	recordNum = Integer.parseInt( resultCnt[0][0] );
	iQuantity = Integer.parseInt( resultCnt[0][0] );
	System.out.println("resultCnt[0][0]~~~~"+resultCnt[0][0]);
	for(int i=0;i<recordNum;i++)
	{
		
	    typeStr = "";
	    inputStr = "";
	    out.print("<TR>");
	    for(int j=0;j<Integer.parseInt(fieldNum);j++)
	    {
	    System.out.println("result["+i+"]["+j+"]~~~~"+result[i][j]);
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
	    	//int iQuantity = 500;

	   }

	}catch(Exception e){
	        
	}          
	   %>
	   		</tr>
	   </table>
	   <%

		Page pg = new Page(iPageNumber,iPageSize,iQuantity);
		PageView view = new PageView(request,out,pg); 
		view.setVisible(true,true,0,0);  
%>
	
	<!------------------------------------------------------>
	<TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
	<TBODY>
	<TR bgcolor="#EEEEEE"> 
	    <TD align=center bgcolor="#EEEEEE" id='footer'>
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
	        <input class="button" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
	<%
	}
	%>             
	        <input class="button" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;        
	    </TD>
	</TR>
	</TBODY>
	</TABLE>
	<!------------------------> 
	<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
	<input type="hidden" name="retQuence" value=<%=retQuence%>>
	</div>
</div>
  <!------------------------>  
</FORM>
<script>
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( "300" );
		stepNum = stepNum + 1;
	}
);

function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}
</script>
</BODY>
</HTML>    