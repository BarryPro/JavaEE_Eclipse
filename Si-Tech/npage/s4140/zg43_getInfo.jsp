<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: Ͷ���˷Ѳ�ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2009-08-10
�� * ����: zhangshuaia
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "4141";
 		String opName = "Ͷ���˷�--��ѯ";
		
		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
					
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		String tftj = request.getParameter("tftj");
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
	 
		//String getInfoSql = "";	
 
		String[] inParas2 = new String[2];
			
 
%>


<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	
	
</head>
<body>	
	<div id="Operation_Table">
	<%
		if(tftj=="1" ||tftj.equals("1"))
		{
			//gprs Ͷ���ֻ����롢�˷���ˮ���˷���ֹʱ��(gprsΪʱ��Σ�����ҵ��Ϊʱ���)������ʱ�䡢������ˮ���˷����͡��˷����ࡢ�˷�ҵ���˷ѹ��š��˷ѽ��
			inParas2[0]="select phone_no,   refund_accept,   refund_begin_dt,  refund_end_dt, to_char(a.op_time, 'yyyymmdd hh24:mi:ss'),   to_char(login_accept),  b.third_name,  a.tf_login_no,  to_char(a.system_price), '����',   'GPRS�˷�'  from drefundmsg a, srefundthird b where a.phone_no = :phone_no   and substr(a.op_time,1,8) between to_date(:date1,'yyyymmdd hh24:mi:ss') and to_date(:date2, 'yyyymmdd hh24:mi:ss') and a.third_code = b.third_code and b.valid_flag = '4'   and a.flag = '4'  and a.first_code = '1' order by a.op_time desc";
			inParas2[1]="phone_no="+phone_no+",date1="+begin_time+",date2="+end_time;
			%>
			<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="11">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="sVerifyTypeArr" scope="end" />
			<table id="t1">
				<tr align="center"> 
					<th>Ͷ���ֻ�����</th>
					<th>�˷���ˮ</th>
					<th>�˷ѿ�ʼʱ��</th> 
					<th>�˷ѽ���ʱ��</th>
					<th>����ʱ��</th>
					<th>������ˮ</th>
					<th>�˷�����</th>
					<th>�˷�����</th>
					<th>�˷�ҵ��</th>
					<th>�˷ѹ���</th>
					<th>�˷ѽ��</th>
				</tr>
			 
			<%
					if(sVerifyTypeArr.length==0){
						out.println("<tr height='25' align='center'><td colspan='11'>");
						out.println("<font class='orange'>û���κμ�¼��</font>");
						out.println("</td></tr>");
					}else if(sVerifyTypeArr.length>0){
						for(int i=0;i<sVerifyTypeArr.length;i++){
								 
			%>
								<tr>
									<td><%=sVerifyTypeArr[i][0]%></td>
									<td><%=sVerifyTypeArr[i][1]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][3]%></td>
									<td><%=sVerifyTypeArr[i][4]%></td>
									<td><%=sVerifyTypeArr[i][5]%></td>
									<td><%=sVerifyTypeArr[i][9]%></td>
									<td><%=sVerifyTypeArr[i][10]%></td>
									<td><%=sVerifyTypeArr[i][6]%></td>
									<td><%=sVerifyTypeArr[i][7]%></td>
									<td><%=sVerifyTypeArr[i][8]%></td>
								</tr>
			<%				
						}
					}
			%>
		  </table>
			<%
		}
		else
		{
			//����ҵ��
			//Ͷ���ֻ����롢�˷���ˮ���˷���ֹʱ��(gprsΪʱ��Σ�����ҵ��Ϊʱ���)������ʱ�䡢������ˮ���˷����͡��˷����ࡢ�˷�ҵ���˷ѹ��š��˷ѽ��
			inParas2[0]="select phone_no,refund_accept,to_char(a.op_time,'YYYYMMDD hh24:mi:ss'),to_char(login_accept),decode(REFUND_TYPE,1,'����',2,'˫��'),decode(REFUND_kind,1,'����/����ҵ��',2,'GPRS�˷�'),b.third_name,a.tf_login_no,to_char(a.system_price) from drefundmsg a,srefundthird b where a.phone_no=:s_no and substr(a.op_time,1,8) between to_date(:date1,'yyyymmdd hh24:mi:ss') and to_date(:date2, 'yyyymmdd hh24:mi:ss') and a.third_code=b.third_code and b.valid_flag='4' and a.flag='4' and a.first_code='0' order by a.op_time desc";
			inParas2[1]="s_no="+phone_no+",date1="+begin_time+",date2="+end_time;
			%>
			<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="9">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="sVerifyTypeArr" scope="end" />
			<table id="t1">
				<tr align="center"> 
					<th>Ͷ���ֻ�����</th>
					<th>�˷���ˮ</th>
					<th>�˷�ʱ��</th> 
					<th>����ʱ��</th>
					<th>������ˮ</th>
					<th>�˷�����</th>
					<th>�˷�����</th>
					<th>�˷�ҵ��</th>
					<th>�˷ѹ���</th>
					<th>�˷ѽ��</th>
				</tr>
			 
			<%
					if(sVerifyTypeArr.length==0){
						out.println("<tr height='25' align='center'><td colspan='10'>");
						out.println("<font class='orange'>û���κμ�¼��</font>");
						out.println("</td></tr>");
					}else if(sVerifyTypeArr.length>0){
						for(int i=0;i<sVerifyTypeArr.length;i++){
								 
			%>
								<tr>
									<td><%=sVerifyTypeArr[i][0]%></td>
									<td><%=sVerifyTypeArr[i][1]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][3]%></td>
									<td><%=sVerifyTypeArr[i][4]%></td>
									<td><%=sVerifyTypeArr[i][5]%></td>
									<td><%=sVerifyTypeArr[i][6]%></td>
									<td><%=sVerifyTypeArr[i][7]%></td>
									<td><%=sVerifyTypeArr[i][8]%></td>
								</tr>
			<%				
						}
					}
			%>
		  </table>
			<%
		}
	%>
     
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       		<input class="b_text" name="sure" type="button" value="����EXCEL" style="cursor:hand;" onClick="exportExcel('Operation_Table');" >
				<input class="blue" name="loginAccept" type="hidden" >					
				<input class="blue" name="opNote" type="hidden" value="����Ա��<%=workNo%> ����˵���ע���������Ϣ����" >									
				<input class="blue" name="op_code" type="hidden" value="<%=op_code%>">									
			</td>
	  </tr>
 </table>  
 	</div>
</body>
</html>  
<script language="javascript">
	function exportExcel(DivID){
 //������Excel�����Excel�������ȶ���
 var jXls, myWorkbook, myWorksheet;
 
 try {
  //�����ʼ��ʧ��ʱ������ʾ
  jXls = new ActiveXObject('Excel.Application');
 }catch (e) {
	return false;
 }
 
 //����ʾ���� 
 jXls.DisplayAlerts = false;
 
 //����AX����excel
 myWorkbook = jXls.Workbooks.Add();
 //myWorkbook.Worksheets(3).Delete();//ɾ����3����ǩҳ(�ɲ���)
 //myWorkbook.Worksheets(2).Delete();//ɾ����2����ǩҳ(�ɲ���)
 
 //��ȡDOM����
 var curTb = document.getElementById(DivID);
 //alert("1");
 //��ȡ��ǰ��Ĺ�����(����һ��)
 myWorksheet = myWorkbook.ActiveSheet; 
 //alert("2");
 //���ù���������
 myWorksheet.name="NPͳ��";
 
 //��ȡBODY�ı���Χ
 var sel = document.body.createTextRange();
 //alert("3 curTb is "+curTb);
 //���ı���Χ�ƶ���DIV��
 sel.moveToElementText(curTb);
 //alert("4");
 //ѡ��Range
 sel.select();
 
 //��ռ�����
 window.clipboardData.setData('text','');
 
 //���ı���Χ�����ݿ�����������
 sel.execCommand("Copy");
 
 //������ճ����������
 myWorksheet.Paste();
 
 //�򿪹�����
 jXls.Visible = true;
 
 //��ռ�����
 window.clipboardData.setData('text','');
 jXls = null;//�ͷŶ���
 myWorkbook = null;//�ͷŶ���
 myWorksheet = null;//�ͷŶ���
}
</script>