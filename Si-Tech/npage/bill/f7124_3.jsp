<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ�����
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
	
	/**�����7127,7128�����������������߱��**/
	if(opCode.equals("7127")){
		opName = "��ͥ����ƻ�-�����������";
	}else if(opCode.equals("7128")){
		opName = "��ͥ����ƻ�-���������";
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

<HEAD><TITLE>��ͥ����ƻ����������</TITLE>
</HEAD>
 
<SCRIPT type=text/javascript>
onload = function(){
  document.all.mphone_no.focus();
}
//----------------��֤���ύ����-----------------
function query(subButton)
{
  //controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
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
		     <TD class="blue">��������</TD>
             <TD>
		       <input type="radio" name="opFlag" value="����" <%if(opCode.equals("7127"))out.println("checked");%>>����
			   	 <input type="radio" name="opFlag" value="�޸�" <%if(opCode.equals("7128"))out.println("checked");%>>�޸�
			   	 <input type="radio" name="opFlag" value="ȡ��" <%if(opCode.equals("g581"))out.println("checked");%>>ȡ��
		     </TD>
            </TR>		
            <TBODY> 
            <TR> 		 
		   	  <TD class="blue"> 
                <div align="left">��������</div>
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
                    <input class="b_foot" name="queryAll" type="button" value="ȷ��" onclick="query(this)" index="3">
			        <input class="b_foot" name="reset1"   type=button onClick="frm1239.reset();" value="���">
			        <input class="b_foot" name="back"   onclick="removeCurrentTab()" type="button" value="�ر�">
			  </TD>
            </TR>
          </TBODY>
        </TABLE>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 	<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>

</html>
