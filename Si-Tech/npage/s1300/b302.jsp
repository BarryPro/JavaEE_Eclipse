<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-15 ҳ�����,�޸���ʽ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>


<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String belongName = baseInfo[0][16];
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String op_code = "b302"  ;
    
    String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD><TITLE>�ɷѳ���</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>


<script language="JavaScript">
<!--
 function form_load()
{
	form.sure.disabled=true;
	form.phoneNo.focus();
}

function docheck()
{
	if(document.form.phoneNo.value.length<11 &&document.form.contractno.value.length<5)
	{   
		rdShowMessageDialog("��������ȷ�ķ�����룡");
		document.form.phoneNo.focus();
		return false;
	}
   if(form.billdate.value.length<6)
   {   
	    rdShowMessageDialog("�ɷ��·ݲ���Ϊ�գ�<br>������YYYYMM��ʽ���·ݣ�");
	    document.form.billdate.focus();
	    return false;
	}

	if(form.billdate.value.substring(0,4)<"1990" || form.billdate.value.substring(0,4)>"2050")
   {
	    rdShowMessageDialog("�ɷ��·��������<br>������YYYYMM��ʽ���·ݣ�");
	    document.form.billdate.focus();
	    return false;
    }
      
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
   	var  returnValue ;  
    if (form.contractno.value.length<5)    
    {
    
        returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneNo.value,"",prop);
        if(returnValue==null)
        {
        	rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
        	document.form.phoneNo.focus();
        	return false;
        }
        
        if(returnValue == "" )
        {
        	rdShowMessageDialog("��û��ѡ���Ӧ���ʺţ�",0);
        	document.form.phoneNo.focus();
        	return false;
        }
        
        document.form.contractno.value = returnValue;
    }
	
	returnValue=window.showModalDialog('getwater_td.jsp?billmonth='+document.form.billdate.value+'&contractno='+document.form.contractno.value,"",prop);
    	 
    
    if( returnValue == null )
    {
    	rdShowMessageDialog("û���ҵ���Ӧ����ˮ��",0);
    	document.form.phoneNo.focus();
    	return false;
    }
    
    if(returnValue == "" )
    {
    	rdShowMessageDialog("��û��ѡ���Ӧ����ˮ��",0);
    	document.form.phoneNo.focus();
    	return false;
    }
    
    document.form.water_number.value = returnValue;
    document.form.action="s1310_2td.jsp";
	
    document.form.submit();
    return true;
 
 
}
//-->
</script>
</HEAD>
<BODY>
<FORM action="s1310_2td.jsp" method=post name=form>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�ɷ���Ϣ</div>
</div>
    <table cellspacing="0">
        <tr> 
            <td class="blue">ҵ������</td>
            <td colspan=2>�ɷѳ���</td>
            <td class="blue">����</td>
            <td colspan=2><%=belongName%> </td>
        </tr>
        
        
        <tr> 
            <td class="blue">�������</td>
            <td colspan=2>
 
                <input type="text" name="phoneNo" maxlength="11" onKeyDown="if(event.keyCode==13)form.billdate.focus()" onKeyPress="return isKeyNumberdot(0)"  >
            </td>
            <td class=blue>�ɷ��·�</td>
            <td colspan=2> 
                <input type="text" name="billdate" maxlength="6" onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
                <input class="b_text" name=sure22 type=button value=��ѯ onClick="docheck();">
            </td>
        </tr>
        <tr> 
            <td class=blue>�ʻ�����</td>
            <td colspan=2> 
                <input type="text" name="contractno" readonly  >
            </td>
            <td class=blue>�ɷ���ˮ</td>
            <td colspan=2>
                <input type="text" readonly name="water_number">
            </td>
        </tr>
        <tr> 
            <td class=blue>�û�/�ʻ�����</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield7">
            </td>
            <td class=blue>�ɷѽ��</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield8">
            </td>
        </tr>
        <tr> 
            <td class=blue>�û�����</td>
            <td colspan=2> 
                <input type="text" readonly name="textfield6" maxlength="5">
            </td>
            <td class=blue>�ɷ�ʱ��</td>
            <td colspan=2> 
                <input type="text" readonly name="paytime" maxlength="20">
            </td>
        </tr>
        <tr> 
            <td class=blue>�ɷѹ���</td>
            <td colspan=5>
                <input type="text" readonly name="textfield5" maxlength="6">
            </td>
        </tr>
        
        <tr> 
            <td colspan=6 class=blue>�ɷ���Ϣ</td>
        </tr>
        
        <tr> 
            <th>����/�ʻ�����</th>
            <th>�ɷѽ��</th>
            <th>Ԥ���</th>
            <th>����</th>
            <th colspan=2>���ɽ�</th>
        </tr>
        
        
        <tr> 
            <td class=blue>�˷ѽ��</td>
            <td colspan=5>
                <input readonly name=remark2>
            </td>
        </tr>
        
        </table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type="button" value=ȷ�� onclick="docheck()">
                    <input class="b_foot" name=clear type=reset value=���>
                    <input class="b_foot" name=reset type=button value=�ر� onClick="removeCurrentTab()">
                </td>
            </tr>
        </tbody>
    </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
