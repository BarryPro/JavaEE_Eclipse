<%
  /*
   * ����: e_mail�Ǽ�
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc 
�� * ��Ȩ: sitech
   * 
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
		 */ 
        public String returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();

		   //�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//��name����'_'�ֳ�3������.
			if (names.length >= 3) {
		//������ܷ�˵�����ֲ��Ϸ�.̫�����ֲ���.
		    value = request.getParameter(name);
		//�������ֵõ�value
		if (value.trim().equals("")) {
			//���value��""����.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//���� ��һ���ַ���.��like ���� =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//��ط������ݿ���ֶδ���.������'_'�Ժ�Ķ������ݿ��ֶ���.
		objs[1] = name;
		//�ڶ����ַ���.��ѯ����.
		objs[2] = value;
		//������.��ѯ��ֵ.
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//����ط��ǽ��ַ���ת��������.Ȼ���������.����19Ҫ��2֮��.
		} catch (Exception e) {

		}
		//������������key����,ojbs����ŵ�value����.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//�õ�һ�����������.
		Arrays.sort(objNos);
		//�����ֽ�������.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//�����like �� = �ֱ���.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append( objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
		}

        return buffer.toString();
}

%>


<%
		/*midify by guozw 20091114 ������ѯ�����滻*/
	 String myParams="";
	 String org_code = (String)session.getAttribute("orgCode");
	 String regionCode = org_code.substring(0,2);

    String opCode="K208";
    String opName="�ʼ��ѯ-e_mail�Ǽ�";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
		
  	String sqlStr = "select to_char(t1.cust_id),t1.contact_mailaddress from dcustdoc t1,dcustmsg t2 where ";
  	String sqlJoinStr = " and t1.cust_id=t2.cust_id";
    String phone_no   =  request.getParameter("0_=_t2.phone_no"); 
    String contact_mailaddress = request.getParameter("contact_mailaddress");

    String[][] dataRows = new String[][]{};
    String cust_id= request.getParameter("cust_id");
    String action = request.getParameter("myaction");
    System.out.println("============action=="+action);
%>			
<%	if ("doLoad".equals(action)) {
      sqlStr+=returnSql(request)+sqlJoinStr;
      System.out.println("==========sqlStr=="+sqlStr);
        %>		           
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList" scope="end"/>
				<%
				dataRows = queryList;
				if(dataRows.length!=0){
				   cust_id = dataRows[0][0];
				   System.out.println("===========dataRows[0][0]="+dataRows[0][0]);
				}
    }
   if ("modify".equals(action)) {
     sqlStr = "update dcustdoc set contact_mailaddress= :contact_mailaddress where cust_id= :cust_id";
     myParams = "contact_mailaddress="+contact_mailaddress+",cust_id="+cust_id ;
     %>
      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="0">
				<wtc:param value="<%=sqlStr%>"/>
			</wtc:service>
		<%
		if(retCode.equals("000000")){
		%>
		   <script language="javascript">rdShowMessageDialog("�޸ĳɹ���",2);</script>
		<%
		}else{
			%>
		   <script language="javascript">rdShowMessageDialog("�޸�ʧ�ܣ�",1);</script>
		  <%
		}
   }
%>


<html>
<head>
<title>e_mail�Ǽ�</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
		 checkElement(this); 
	}	
//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function submitInputCheck(flag){
       if(flag=='doLoad'&&  document.sitechform.phone_no.value == ""){
    	   showTip(document.sitechform.phone_no,"�û����벻��Ϊ��"); 
    	   sitechform.phone_no.focus(); 	
       }else if(flag=='modify'&& document.sitechform.contact_mailaddress.value == ""){
    	   showTip(document.sitechform.contact_mailaddress,"email��ַ����Ϊ��"); 
    	   sitechform.contact_mailaddress.focus(); 	
       }else{
         hiddenTip(document.sitechform.phone_no);
         hiddenTip(document.sitechform.contact_mailaddress);
         submitMe(flag);
    	}
}
function submitMe(flag){
   window.sitechform.myaction.value=flag;
   window.sitechform.action="K208_qcEmailRegQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi"> ��ѯ���� </div></div>
		<table cellspacing="0" style="width:100%;">
     <tr >
      <td > �û�����
      <!--zhengjiang 20091010 ����onkeyup="value=value.replace(/[^\d]/g,'');"��onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
				<input id="phone_no" name="0_=_t2.phone_no" type="text"  onkeyup="value=value.replace(/[^\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" value=<%=(phone_no==null)?"":phone_no%> >
				<font color="orange">*</font>
			</td>
      <td id="footer" style="width:360px">
       <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInputCheck('doLoad');return false;">
      </td>
    </tr>
		</table> 
<br>
		<div class="title"><div id="title_zi">email��ѯ���</div></div>
		<table cellspacing="0" >
     <tr >
      <td > 
      	<%=(dataRows.length!=0&&dataRows[0][1]!=null)?dataRows[0][1]:"&nbsp;"%>
      </td>
    </tr>
		</table> 
<br>
		<div class="title"><div id="title_zi">�޸�email</div></div>
		<table cellspacing="0" >
     <tr >
      <td > Email��ַ��
				<input id="contact_mailaddress" name="contact_mailaddress" type="text"  value="" >
			</td>
      <td id="footer" style="width:360px">
      	<p id="footer">
       <input name="modify" type="button"  id="modify" class="b_foot" value="�޸�" onClick="submitInputCheck('modify');return false;">
      </p>
      </td>
    </tr>
		</table>    
	</div>  	
	<input name="myaction" type="hidden" value="">
  <input name="cust_id" type="hidden" value="<%=cust_id%>">
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>

