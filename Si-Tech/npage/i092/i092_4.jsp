<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<%
		String opCode = "i092";
		String opName = "ǿ��Ԥ��";
		String dateStr = new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date());
 
	 	String[] inParas1 = new String[2];
		String[] inParas2 = new String[2];
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		int	i=0;
		String sButtonName = "";
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }


 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
   function sel4()
   {
		   window.location.href='i092_4.jsp';
   }
   
function do_qry(op_accept)
{
	document.frm.action="i092_4_1.jsp?op_accept="+op_accept  ;

	document.frm.submit();	



	
	//document.frm.action="i092_3_1.jsp" ;

	//document.frm.submit();
	
}

function do_out(op_accept)
{
	document.frm.action="i092_4_2.jsp?op_accept="+op_accept  ;

	document.frm.submit();	
	
}
  
-->
 </script> 
 
<%     	

      	inParas1[0] = "SELECT op_time,rec_num,op_accept,deal_flag FROM ( " ;
      	//inParas1[0] += "SELECT to_char(op_time,'yyyymmdd HH24:MI:SS') op_time, to_char(rec_num) rec_num, to_char(op_accept) op_accept, to_char(deal_flag) deal_flag FROM dForceLogOutMsg WHERE login_no = :login_no and to_char(total_date) < to_char(sysdate,'yyyymm')||01 order by op_time desc " ; 
      	inParas1[0] += "SELECT to_char(op_time,'yyyymmdd HH24:MI:SS') op_time, to_char(rec_num) rec_num, to_char(op_accept) op_accept, to_char(deal_flag) deal_flag FROM dForceLogOutMsg WHERE login_no = :login_no order by op_time desc " ; 
      	inParas1[0] += ") WHERE rownum <=15 " ;

        inParas1[1]="login_no="+workno;

%>
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="4">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    <wtc:param value="<%=inParas1[1]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />	    
<%
		if(result.length == 0)
		{
%>
			<SCRIPT type=text/javascript>
				rdShowMessageDialog("�ù���Ŀǰû�пɲ�ѯ��¼��",0);
				history.go(-1);
			</SCRIPT>
<%
		}
		else
		{

		
		}
%>
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="i092_3_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" >���ֻ������ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">�����в�ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3" >�ļ�����
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4" checked >�ļ���������ѯ
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">��ѡ��Ҫ��ѯ�ļ�¼</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" >
			����ʱ��
		</td>
		<td class="blue">
			��¼��
		</td>
		<td class="blue">������ˮ</td>
		<td class="blue">--</td>
	</tr>
	
<%
	for(i=0;i<result.length;i++)
	{
	
%>
	<tr>
		<td><%=result[i][0]%></td>
		<td><%=result[i][1]%></td>
		<td><%=result[i][2]%></td>
		<td>
			<input type="button" name="query"  value="��ѯ" onclick=do_qry("<%=result[i][2]%>") >
			<input type="button" name="query"  value="����" onclick=do_out("<%=result[i][2]%>") >
		</td>
	</tr>
<%
	}
%>
	 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	        
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %> 
</form>
 </BODY>
</HTML>