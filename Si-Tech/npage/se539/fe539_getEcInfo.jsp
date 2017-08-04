<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 获取EC信息
　 * 版本: v1.0
　 * 日期: 2009年03月03日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

	String opCode = "";
	String opName = "";
    String workNo = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String  powerRight= (String)session.getAttribute("powerRight");
    String workPwd = (String)session.getAttribute("password");
    String regionCode=org_code.substring(0,2);	
    
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum  = "";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";  
    String s_ecsiid= request.getParameter("s_ecsiid")==null?"":request.getParameter("s_ecsiid" );    
    System.out.println("s_ecsiid="+ s_ecsiid);   
    
    String s_ecsiname =request.getParameter("s_ecsiname")==null?"":request.getParameter("s_ecsiname" );
    System.out.println("s_ecsiname="+ s_ecsiname);                            
    
    if (selType.compareTo("S") == 0) {
        selType = "radio";
    }
    if (selType.compareTo("M") == 0) {
        selType = "checkbox";
    }
    if (selType.compareTo("N") == 0) {
        selType = "";
    }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String[][] result = new String[][]{};
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>EC选择
    </TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<SCRIPT type=text/javascript>
    function saveTo()
    {
    	  var retValue = "";
    	  var retValue1="";
    	  
    	 
    	 if(document.fPubSimpSel.elements[0].name == "commit")
          {     return false;   }
         if(typeof (document.all("List").length) =="undefined"){
        	if(typeof (document.all("List")) =="undefined"){
        		rdShowMessageDialog("无集团客户信息!");
        	}else{
        		if(document.all("List").checked){
        			  retValue=document.all("Rinput00").value;
        			  retValue1=document.all("Rinput01").value;
        			  retValue2=document.all("Rinput02").value;
        			  
        		}
        	}
         }else{
        	for(var i=0;i<document.all("List").length;i++){
        		if(document.all("List")[i].checked){
        			
        			retValue=document.all("Rinput"+i+"0").value;
        			retValue1=document.all("Rinput"+i+"1").value;
        			retValue2=document.all("Rinput"+i+"2").value;
        			
        		}
        	}
        }
        if(retValue!=""&&retValue!=null){
        	
        	window.opener.document.getElementById("ecsiid").value=retValue;
        	window.opener.document.getElementById("ecsiname").value=retValue1;
        	window.opener.document.getElementById("phone_no").value=retValue2;
        	window.opener.document.getElementById("ecsiid").readOnly=true;
        	window.opener.document.all.nextoper.disabled=false;
        	window.close();
        }else{
        	rdShowMessageDialog("请选择一个集团客户!");
        }
         
    }

    function allChoose()
    {   //复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
            {    //判断是否是单选或复选框
                document.fPubSimpSel.elements[i].checked = true;
            }
        }
    }

    function cancelChoose()
    {   //取消复选框全部选中
        for (i = 0; i < document.fPubSimpSel.elements.length; i++)
        {
            if (document.fPubSimpSel.elements[i].type == "checkbox")
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
<table cellspacing="0">
    <tr align="center">
        <th nowrap>集团编码</th>
        <th nowrap>集团客户名称</th>
        <th nowrap>联系电话</th>   
        
    </tr>
    <% //绘制界面表头
        chPos = fieldName.indexOf("|");
        out.print("");
        String titleStr = "";
        int tempNum = 0;
        while (chPos != -1) {
            valueStr = fieldName.substring(0, chPos);
            titleStr = "";
            out.print(titleStr);
            fieldName = fieldName.substring(chPos + 1);
            tempNum = tempNum + 1;
            chPos = fieldName.indexOf("|");
        }
        out.print("");
        fieldNum = String.valueOf(tempNum);
        System.out.println("fieldNum:"+fieldNum); 
    %>
	    <wtc:service name="sCustQryMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="e539"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=s_ecsiid%>"/>
              <wtc:param value="<%=s_ecsiname%>"/>
                
       </wtc:service>
       <wtc:array id="retArr1" scope="end"/>
		  <%
  		    if (retCode.equals("000000")){
  		        result = retArr1;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }  	

    	    
        String tbclass="";
        for (int i = 0; i < result.length; i++) {
        		tbclass = (i%2==0)?"Grey":"";
            typeStr = "";
            inputStr = "";
            out.print("<TR align='center'>");
            for (int j = 0; j < Integer.parseInt(fieldNum); j++) {
                //System.out.println(result[i][j]);
                if (j == 0) {
                    typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                    if (selType.compareTo("") != 0) {
                        typeStr = typeStr + "<input type='" + selType +
                                "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                    }
                    typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "' value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                }
                 else {
                    inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "' value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                } 
            }
            out.print(typeStr + inputStr);
            out.print("</TR>");
        }
    %>
   
</table>

<!------------------------------------------------------>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <%
                    if (selType.compareTo("checkbox") == 0) {
                        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选 class='b_foot'>&nbsp");
                        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选 class='b_foot'>&nbsp");
                    }
                %>

                <%
                    if (selType.compareTo("") != 0) {
                %>
                <input class='b_foot' name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                <%
                    }
                %>
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
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
