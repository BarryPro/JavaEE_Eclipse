<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������Ϣ��ѯ</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	
	String unitId = request.getParameter("unitId");//��ѯ����
	
	String v_isDirectManageCust = "0";
	String v_directManageCustNo = "";
	String v_groupNo = "";
%>

	<wtc:service name="sGrpInfoQry"  outnum="20" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="5082" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
	<%
		if("000000".equals(errcode)){
			if(result1.length > 0){
				v_isDirectManageCust = result1[0][17];
				v_directManageCustNo = result1[0][18];
				v_groupNo = result1[0][19];
			}
		}
	%>
		
	<wtc:service name="s5082ListEXC"  outnum="22" retcode="errcode1" retmsg="errmsg1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="5082" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
	</wtc:service>
	<wtc:array id="result3" start="0" length="22" scope="end"/>
<%
	System.out.println("result3.length: "+result3.length);
	System.out.println("---liujian5082---result1.length: "+result1.length + "--errcode=" + errcode);
%>
</HEAD>
<script>
	$(function(){
		$("#isDirectManageCust").val("<%=v_isDirectManageCust%>");
		$("#directManageCustNo").val("<%=v_directManageCustNo%>");	
		$("#groupNo").val("<%=v_groupNo%>");		
	});
	function printxls(){
		window.open("f5082_2_printxls.jsp?unitId=<%=unitId%>");
	}	
</script>
<% if (!"000000".equals(errcode) || result1[0][0].trim().equals("")) {%>
<script language="javascript">
	rdShowMessageDialog("û���ҵ��κ�����");
	history.go(-1);
</script>
<%}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ</div>
</div>
		<TABLE cellSpacing=0>
			<TR> 
			  <td class='blue' nowrap>���ű��</TD>
			  <TD><input type="text" readonly class="InputGrey" name="phoneNo" size="20" maxlength="11" value="<%=result1[0][0]%>">
			  </TD>
			  <td class='blue' nowrap>��������</TD>
			  <TD><input type="text" readonly class="InputGrey"  name="beginFlag" size="20" maxlength="1" value="<%=result1[0][1]%>"></TD>
			</TR>
			<TR> 
			  <td class='blue' nowrap>VPMN����</TD>
			  <TD><input type="text" readonly  class="InputGrey" name="openTime" size="20" maxlength="20" value="<%=result1[0][2]%>"></TD>
			  <td class='blue' nowrap>�ͻ�ID</TD>
			  <TD><input type="text" readonly class="InputGrey" name="oldExpire" size="20" maxlength="20" value="<%=result1[0][10]%>"></TD>
			</TR>
			<TR> 
			  <td class='blue' nowrap>�ͻ�������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="expireTime" size="20" maxlength="20" value="<%=result1[0][11]%>" ></TD>
			  <td class='blue' nowrap>��������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="remain_fee" size="20" maxlength="20" value="<%=result1[0][3]%>"></TD>
			</TR>  
			<TR> 
			  <td class='blue' nowrap>��ϵ�绰</TD>
			  <TD colspan =1><input type="text" readonly class="InputGrey" name="opNote" size="20" maxlength="60" value="<%=result1[0][4]%>"></TD>
			  <td class='blue' nowrap>֤������</TD>
			  <TD><input type="text" readonly class="InputGrey" name="id_iccid" size="20" maxlength="20" value="<%=result1[0][12]%>"></TD>
			</TR>         
			<TR> 
			  <td class='blue' nowrap>һ��֧���˻�</TD>
			  <TD><input type="text" readonly class="InputGrey" name="current_code" size="20" maxlength="20" value="<%=result1[0][13]%>"></TD>
			  <td class='blue' nowrap>�˻�����</TD>
			  <TD><input type="text" readonly class="InputGrey" name="opNote" size="20" maxlength="60" value="<%=result1[0][14]%>"></TD>
			</TR>   
			<TR> 
			  <td class='blue' nowrap>�ͻ�����ȼ�</TD>
			  <TD><input type="text" readonly class="InputGrey" name="current_code" 
			  		size="20" maxlength="20" value="<%=result1[0][15]%>"></TD>
				<td class='blue' nowrap>�Ƿ�ֱ�ܿͻ�
				</td>
				<td> 
				  <select name="isDirectManageCust" id="isDirectManageCust" disabled >
				  	<option value="0" selected>��</option>
				  	<option value="1">��</option>
				  </select>
				</td>
			</TR>  
			<tr>
				<TD class="blue" nowrap>ֱ�ܿͻ�����
				</TD>
				<TD> 
					<input type="text" name="directManageCustNo" id="directManageCustNo"  v_type="string"  readonly class="InputGrey" />
				</TD>
				<TD class="blue" nowrap>��֯��������
				</TD>
				<TD colspan="3"> 
					<input type="text" name="groupNo" id="groupNo"  v_type="string" readonly class="InputGrey" />
				</TD>
			</tr>           
		  </TABLE>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">���Ų�Ʒ�б�</div>
</div>
    <table cellspacing="0">
      <tr>
        <th>���Ų�ƷID</th>
		<th>��Ʒ����</th>
        <th>��Ʒ�ʺ�</th>
        <th>��Ʒ״̬</th>
        <th>��Ʒ����</th>
        <th>����ʱ��</th>
        <th>��Ʒ����</th>
        <th>APN����</th>
        <th>��ǰʣ����</th>
		<th>Ƿ�ѽ��</th>
		<th>�ʵ���ѯ</th>
        <th>�����Ϣ</th>
        <th>ҵ���ϵȼ�</th>
        <th>���Ѽ�¼��ѯ</th>
        <th>��Ŀ��ͬ���</th>
        <th>��ƷЭ����</th>
      </tr>
	  <%
		for(int y=0;y<result3.length;y++){
		    String tdClass = "";
            if (y%2==0){
                tdClass = "Grey";
            }
	  %>
	  
	  <tr>
	    <td class="<%=tdClass%>"><a href="f2895ModifyProdSrv.jsp?idNo=<%=result3[y][1]%>&sm_code=<%=result3[y][18]%>"><%=result3[y][1]==null||result3[y][1].equals("")?"&nbsp;":result3[y][1]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>&sm_code=<%=result3[y][18]%>"><%=result3[y][9]==null||result3[y][9].equals("")?"&nbsp;":result3[y][9]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][8].equals("")?"&nbsp;":result3[y][8]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][5].equals("")?"&nbsp;":result3[y][5]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][2].equals("")?"&nbsp;":result3[y][2]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][7].equals("")?"&nbsp;":result3[y][7]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][10].equals("")?"&nbsp;":result3[y][10]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][11].equals("")?"&nbsp;":result3[y][11]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_6.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][12].equals("")?"&nbsp;":result3[y][12]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][13].equals("")?"&nbsp;":result3[y][13]%></a></td>
	  	<td class="<%=tdClass%>"><a target="blank" href="f5082_5.jsp?selected_contract_no=<%=result3[y][8]%>">�ʵ���ѯ</a></td>
	  	<td class="<%=tdClass%>"><a href="f5082_4.jsp?id_no=<%=result3[y][1]%>&unit_id=<%=result1[0][0]%>&unit_name=<%=result1[0][1]%>">�����Ϣ</a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][17].equals("")?"&nbsp;":result3[y][17]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_feeRecord.jsp?ProPhoneNo=<%=result3[y][2]%>&countNo=<%=result3[y][8]%>&selecInfoFlag=1&onlineFlag=0">���Ѽ�¼��ѯ</a></td>	   
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][21].equals("")?"&nbsp;":result3[y][21]%></a></td>
	    <td class="<%=tdClass%>"><a href="f5082_3.jsp?idNo=<%=result3[y][1]%>"><%=result3[y][20].equals("")?"&nbsp;":result3[y][20]%></a></td>	   
	   </tr>
	  <%
	    }
	  %>
    </table>

 

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="window.location.href='f5082_1.jsp'" type=button value=����>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
			  <input class="b_foot_long" name=print onClick="printxls()" type=button value=����ΪXLS���>
		</td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<%}%>