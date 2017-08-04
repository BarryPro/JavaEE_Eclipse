<%
    /********************
     * @ OpCode    :  4399
     * @ OpName    :  跨省V网查询
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-1-28 18:27:29
     * @ Update    :  
     ********************/
%>
<%
    String opCode = "4399";
    String opName = "跨省VPMN查询";
    
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>跨省VPMN查询</title>
 <script type=text/javascript>
 	  function resetJsp(){
        window.location='f4399.jsp';
    }	
    function doSubmit(){
    	  if(!check(form1)){
    	  	return;
    	  }
    	  document.all.midDiv.style.height='300px';
    	  var acr_group_no = document.form1.acr_group_no.value;
    	  document.middle.location="f4399_result.jsp?acr_group_no=" + acr_group_no;
    	  
    }
 	
 </script>
</head>
<body>
  <form name="form1" action="" method="post">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
	     <div id="title_zi">跨省VPMN查询</div>
    </div>
    <table cellspacing=0>
      <tr>
      	<td class='blue' nowrap width='18%'>跨省集团编号</td>
      	<td><input type='text' name='acr_group_no' id='acr_group_no' v_must='1' v_name='acr_group_no' v_type='0_9'/>
      	</td>
      </tr>
    </table>
    <div style="height:0px;overflow: auto;" id='midDiv'>
 	     <IFRAME frameBorder=0 id=middle name=middle scrolling="no" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
	     </IFRAME>
    </div>
    <TABLE cellSpacing=0>
      <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="sure" id="sure" type=button value="确认" onclick="doSubmit();"/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="清除" onClick="resetJsp()" />
            <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
      </TR>
    </TABLE>
   
    
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
