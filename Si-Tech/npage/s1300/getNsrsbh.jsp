<%
/********************
*version v2.0
*������: si-tech
*zhangleij 20170628 ���󣺹���������ֵ˰��Ʊ�����йع�����֪ͨ
*��ȡ��������˰��ʶ��š���Ϣ��Ĭ��չʾ��ѯ�����ģ������ֶ��޸�
*
*update:
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opCode = "1302";
	String opName="�˺Žɷ�";
  String paramNo = WtcUtil.repNull(request.getParameter("param_no"));      //����Ϊ1ʱֵΪ�ֻ��ţ�����Ϊ2ʱֵΪ�˻���
  String paramType = WtcUtil.repNull(request.getParameter("param_type"));  //���ͣ�1-phone_no��2-contract_no
	System.out.println("ffffffffffffffffffffffffffnsrsbh paramNo is "+paramNo);
	System.out.println("ffffffffffffffffffffffffffnsrsbh paramType is "+paramType);
	
	String unit_id="";
	String unit_name="";
	String nsrsbh="";
	String result[][]=new String[][]{};
	String[] inParam = new String[2];
	if ("1".equals(paramType)) {
	  inParam[0]="SELECT b.unit_id,b.unit_name,a.NSRSBH FROM (SELECT NVL(TAXPAYER_ID, ' ') NSRSBH,x.cust_id FROM CT_TAXPAYER_INFO x, dcustmsg y WHERE y.phone_no=:phoneno1 AND x.TAXPAYER_FLAG = 'Y'AND x.CUST_ID = y.cust_id UNION SELECT NVL(w.FIELD_VALUE, ' ') NSRSBH,w.cust_id FROM DBVIPADM.DGRPCUSTMSGADD w, dcustmsg z WHERE z.phone_no=:phoneno2 AND w.CUST_ID = z.cust_id AND w.FIELD_CODE = 'NSSBH') a,dgrpcustmsg b WHERE a.cust_id=b.cust_id AND ROWNUM =1";
	  inParam[1]="phoneno1="+paramNo+",phoneno2="+paramNo;
	} else if ("2".equals(paramType)) {
	  inParam[0]="SELECT B.UNIT_ID, B.UNIT_NAME, A.NSRSBH FROM (SELECT NVL(TAXPAYER_ID, ' ') NSRSBH, X.CUST_ID FROM CT_TAXPAYER_INFO X, DCONMSG Y WHERE Y.CONTRACT_NO = :contractno1 AND X.TAXPAYER_FLAG = 'Y' AND X.CUST_ID = Y.CON_CUST_ID UNION SELECT NVL(W.FIELD_VALUE, ' ') NSRSBH, W.CUST_ID FROM DBVIPADM.DGRPCUSTMSGADD W, DCONMSG Z WHERE Z.CONTRACT_NO = :contractno2 AND W.CUST_ID = Z.CON_CUST_ID AND W.FIELD_CODE = 'NSSBH') A, DGRPCUSTMSG B WHERE A.CUST_ID = B.CUST_ID AND ROWNUM = 1";
	  inParam[1]="contractno1="+paramNo+",contractno2="+paramNo;
	} else {
	  //��������ֵ���߲����������
	}
%>
<wtc:service name="TlsPubSelCrm"  outnum="3" >
	<wtc:param value="<%=inParam[0]%>"/>
	<wtc:param value="<%=inParam[1]%>"/>
</wtc:service>
<wtc:array id="retList" scope="end" />

<%		
	if(retList!=null && retList.length>0)
	{
		unit_id=retList[0][0];
		unit_name=retList[0][1];
		nsrsbh=retList[0][2];
	}
%>
<HEAD>
<HTML>
	<HEAD>
		<TITLE>ȷ����˰��ʶ��Ż�ͳһ������ô���</TITLE>
    <script LANGUAGE="JavaScript">
    	//window.returnValue="";
    	function getAccount()
    	{
    		window.returnValue=document.getElementById("nsrsbh").value;
    		//alert("window.returnValue is "+window.returnValue);
    		window.close();
    	}
    </script>
  </HEAD>

<BODY>
<form  name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">ȷ����˰��ʶ��Ż�ͳһ������ô���</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
				<tr>
					<td width="40%">���ź��룺</td>
				  <td><input id="jtNo" name="jtNo" type="text" size="32" value="<%=unit_id%>" disabled></td>	
			  </tr>
			  <tr>
			  	<td width="40%">�������ƣ�</td>
			  	<td><input id="jtName" name="jtName" type="text" size="32" value="<%=unit_name%>" disabled></td>
			  </tr>
			  <tr>
			  	<td width="40%">��˰��ʶ���/ͳһ������ô��룺</td>
			  	<td><input id="nsrsbh" name="nsrsbh" type="text" size="32" value="<%=nsrsbh%>" maxlength="30"></td>
			  </tr>
			  <tr>
			  	<td colspan="2"><font class="orange"><b>˵������ȷ����˰��ʶ���/ͳһ������ô�����Ϣ������Ϣ����ӡ�ڵ��ӷ�Ʊ�ϣ��������ñ������o001��g049���������á�</b></font></td>
			  </tr>
        </TBODY>
	    </TABLE>
 
   <table cellspacing="0">
   <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" id="cfm_id" name="Button" value="����" onKeyDown="if(event.keyCode==13) getAccount();"  onClick="getAccount()">
      </td>
    </tr>
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>