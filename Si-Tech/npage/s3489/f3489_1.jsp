<%
   /*
   * ����: ͳ���͸��ѹ�ϵ������ѯ
�� * �汾: v1.0
�� * ����: 2009/02/05
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-09-15    qidp        �°漯�Ų�Ʒ����
   * 2009-11-05    niuhr		���ݲ�ѯ���Ͳ�ͬ��ת����ͬ����
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%	
	//��ȡ�û�session��Ϣ	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String nopass   = WtcUtil.repNull((String)session.getAttribute("password"));                    //��½����	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("f3489_1.jsp");
	String op_name="ͳ���͸��ѹ�ϵ������ѯ";
	
	String opCode = "3489";
	String opName = "ͳ���͸��ѹ�ϵ������ѯ";
%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
function queryBWInfo()
{
   if(!forInt(document.form1.condText)) return false;
   if(document.form1.condText.value=="")
   { 
   	 rdShowMessageDialog("�������ѯ������");
	 document.form1.condText.select();
	 return;
   }
   if(!check(form1)) return false;
   if(document.all.begin_time.value!="")
	{
		if(!forDate(document.all.begin_time))
		{
			return false;
		}
	}
	if(document.all.end_time.value!="")
	{
		if(!forDate(document.all.end_time))
		{
			return false;
		}
	}


	var begin_time=document.all.begin_time.value;
	var end_time=document.all.end_time.value;

    var queryType = document.form1.queryType1.value; //��ѯ����
    var favCond = document.form1.queryType.value;  //��ѯ����
    var favValue = document.all.condText.value;    //������Ϣ
   if(queryType=="0")//ͳ����ϵ��0
   {
   	 
   	document.middle.location="f3489info.jsp?queryType="+queryType+"&favCond="+favCond+"&favValue=" + favValue+"&begin_time="+begin_time+"&end_time="+end_time;
   }
   else //���ѹ�ϵ��1
   {  		
   	 	document.middle.location="f3489info1.jsp?queryType="+queryType+"&favCond="+favCond+"&favValue=" + favValue+"&begin_time="+begin_time+"&end_time="+end_time;
   }	
	
}	

	
	
</script>

</head>

<body>
	<form action="" name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">ͳ���͸��ѹ�ϵ������ѯ</div>
    </div>
	<table cellspacing="0">
			<TR id="con3">
				<td class='blue' nowrap>��ѯ����</TD>
				<TD colspan = "3"��>
			      	<select name=queryType1>
              		<option value="0">ͳ����ϵ</option>
              		<option value="1">���ѹ�ϵ</option>
            		</select> 
			      </TD>
		    </TR>
 			 <TR id="con2">
				  <td class='blue' nowrap>��ѯ����</TD>
			      <TD>
			      	<select name=queryType>
              		<option value="0">�����˻�</option>
              		<option value="1">���ű��</option>
              		<option value="2">��Ա����</option>
            		</select> 
			      </TD>
          <td class='blue' nowrap>������Ϣ</TD>
          <TD>
          	<input type="text" v_must="1" v_type="0_9" name="condText" size="20" maxlength="60" >
          </TD>	
			  </TR>
			  <TR id="con4">
				<td class='blue' nowrap>��ѯ��ʼ����</td>
				<td>
					<input type=text  v_type="0_9"  name="begin_time" maxlength="8" size="20" v_format="yyyyMMdd">
					(YYYYMMDD)
				</td>
				<td class='blue' nowrap>��ѯ��������</td>
				<td>
					<input type=text  v_type="0_9" name="end_time" maxlength="8" size="20" v_format="yyyyMMdd">
					(YYYYMMDD)
				</td>
			  </TR>
			  
		</TABLE>
		
		<TABLE cellspacing="0">	    
			    <TR id="footer"> 
		         	<TD> 
		         	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="queryBWInfo()">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
		         	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="javascript:removeCurrentTab();" >
				 	  </TD>
		       </TR>
	     </TABLE> 
	      
					<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
					style="HEIGHT: 280px; WIDTH: 100%; Z-INDEX: 1">
					</IFRAME>
<%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

