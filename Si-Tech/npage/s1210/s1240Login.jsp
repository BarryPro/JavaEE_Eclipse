<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *������ҳ��������֤����
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String opCode = "1240";
	String opName = "��ת����";
	String OPflag =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//OPflag == "2"ʱΪ�ͷ����Ž���
%>

<%
  request.setCharacterEncoding("GBK");
  HashMap hm=new HashMap();
  hm.put("1","û�пͻ�ID��");
 	hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("3","�������");
  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
  hm.put("5","δ��ȡ���û������Ļ�����Ϣ!");
  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ת����</title>
<%  
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
%>

<script language=javascript>
 onload=function()
 {
 		self.status="";
		<%
			if(ReqPageName.equals("s1240Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {        
		%>   	 
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
		<%
			  }else if(retMsg.equals("100")){
		%>
					rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ�ѣ����ܰ���ҵ��');	    
		<%
			  }else if(retMsg.equals("101")){
		%>
		      rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		<%
			  }
			}
		%>
		 //�������Ϊ��,��رմ�ҳ��
    if (<%=activePhone%>==null||<%=activePhone%>=="") {
        parent.removeTab('<%=opCode%>');
        return false;
        }
    /*else{	
  		doCfm();
  	}*/
  	
  		if("2"=="<%=OPflag%>"){
  			doCfm();
	   	}
  }

		//�ύ����
		function doCfm()
		{
		    //getAfterPrompt();//add by qidp
		    frm.action="s1240Main.jsp";
		    frm.submit();	
		}
</script>
</head>
<body>
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)" >
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1240Login">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">��ת����</div>
			</div>
	    <table cellspacing="0">
          <tr> 
            <td width="16%" class="blue">�������</td>
      			<td>  
                <input type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" class="InputGrey" readonly>
      			</td>
			    </tr>
			    <tr> 
			      <td colspan="5" id="footer"> 
			          <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()">
					  		<input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
			      </td>
			    </tr>
  		</table>
  		<%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>