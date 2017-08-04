<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312"%>


<%
    //得到输入参数
    ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    //String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
  
	String pay_si= request.getParameter("pay_si"); 
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);		
    String sqlStr = "select nvl(count(*),0) num from  dpartermsg where PARTER_ID='"+pay_si+"'";
	String sqlStr1 = "select PARTER_ID,PARTER_NAME  from dpartermsg where PARTER_ID = '"+pay_si+"'";
    //retArray = callView.sPubSelect("2",sqlStr1);	
    //result = (String[][])retArray.get(0);	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
	if(result.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("查询SI错误");
			window.close();
		</script>
<%
}else{
%>
<HEAD>
<TITLE>黑龙江BOSS-集团客户查询</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<BODY>
<FORM method=post name="fPubSimpSel">   
<div id="POPUP_TOP">
  <div class="logo"></div>
</div>
<div id="Main">
	<DIV id="Operation_Table">

		<div class="title">
			<div id="title_zi">si查询</div>
		</div>
  <TABLE   cellSpacing="0">
    <TBODY>
             <TR >
                 <TH class="blue">si代码</TH>
	             <TH class="blue">si名称</TH>
              </tr>  
               <TR>
                 <TD><%=result[0][0]%></TD>
	             <TD><%=result[0][1]%></TD>
              </tr>         
              
        <TR id="footer"> 
            <TD colspan="2">

                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=确认>&nbsp;        
            </TD>
            
        </TR>
    </TBODY>
    </TABLE>
	
    <TR> 
    <BODY>
   <TABLE>

  <!------------------------> 
 
  <!------------------------>  
</FORM>
</BODY></HTML>    
<%}%>