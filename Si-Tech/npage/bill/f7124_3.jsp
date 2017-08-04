<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划配置
 update zhaohaitao at 2009.1.7
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>

<%
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	
	/**如果是7127,7128就是亲情号码申请或者变更**/
	if(opCode.equals("7127")){
		opName = "家庭服务计划-亲情号码申请";
	}else if(opCode.equals("7128")){
		opName = "家庭服务计划-亲情号码变更";
	}
    
    String workNoFromSession=(String)session.getAttribute("workNo");

	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_Code = baseInfoSession[0][16];
 
    String[][] temfavStr=(String[][])arrSession.get(3);
    String[] favStr=new String[temfavStr.length];
    boolean pwrf=false;
    for(int i=0;i<favStr.length;i++)
    {
		favStr[i]=temfavStr[i][0].trim();
	    if(favStr[i].compareTo("a272") == 0)
		{
		  pwrf=true;
		}
    }
%>

<HEAD><TITLE>家庭服务计划亲情号码变更</TITLE>
</HEAD>
 
<SCRIPT type=text/javascript>
onload = function(){
  document.all.mphone_no.focus();
}
//----------------验证及提交函数-----------------
function query(subButton)
{
  //controlButt(subButton);//延时控制按钮的可用性
  subButton.disabled = true;
  if(check(frm1239))
  {
    frm1239.action="f7124_query.jsp";
    frm1239.submit();	
  }
}
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  } 
  
</SCRIPT>
<!--**************************************************************************************-->
 
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM method=post name="frm1239"  onKeyUp="chgFocus(frm1239)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	    <TABLE cellSpacing="0">
            <TR> 
		     <TD class="blue">操作类型</TD>
             <TD>
		       <input type="radio" name="opFlag" value="新增" <%if(opCode.equals("7127"))out.println("checked");%>>新增
			   	 <input type="radio" name="opFlag" value="修改" <%if(opCode.equals("7128"))out.println("checked");%>>修改
			   	 <input type="radio" name="opFlag" value="取消" <%if(opCode.equals("g581"))out.println("checked");%>>取消
		     </TD>
            </TR>		
            <TBODY> 
            <TR> 		 
		   	  <TD class="blue"> 
                <div align="left">亲情主卡</div>
              </TD>
			  <TD> 
                <input name="mphone_no" id="mphone_no" value="" v_type="mobphone" v_must=1 v_minlength=11 v_maxlength=11  index="1" >
			  </TD>
            </TR>
			</tbody>
		</TABLE>
        <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer" align=center>
                    <input class="b_foot" name="queryAll" type="button" value="确认" onclick="query(this)" index="3">
			        <input class="b_foot" name="reset1"   type=button onClick="frm1239.reset();" value="清除">
			        <input class="b_foot" name="back"   onclick="removeCurrentTab()" type="button" value="关闭">
			  </TD>
            </TR>
          </TBODY>
        </TABLE>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 	<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>

</html>
