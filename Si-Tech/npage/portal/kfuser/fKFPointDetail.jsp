<%
   /*
   * ����: ������ϸ��ѯ
�� * �汾: v1.0
�� * ����: 2009��05��09��
�� * ����: libina
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/ProductChange/include.jsp" %>
<%@ include file="/npage/public/prodQryInclude.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  opName = "������ϸ��ѯ";
  String opCode = "����";
  String phone_no = (String)session.getAttribute("activePhone");
	String sqlStr1 = " select id_no from dCustmsg where phone_no='"+ phone_no+ "'"; 
	String start_time = request.getParameter("start_time");
	String end_time = request.getParameter("end_time");
	String sqlStr2="";
  double point = 0.0;
  
  String SQL1 = "select to_char(sysdate,'yyyymm') from dual";/*��������@���±�@libina@20090519*/
   
  if(phone_no!=null && start_time!=null && end_time!=null){
%>

<wtc:pubselect name="sPubSelect" outnum="1">
	 <wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>		     
<wtc:iter id="rows1" indexId="i" >
<%
  sqlStr2="SELECT TO_CHAR(a.op_time,'YYYY-MM-DD HH:mm:ss'), a.use_point, a.op_note, a.login_no, b.group_name FROM wmarkopr a, dchngroupmsg b "
     + " WHERE a.id_no = '"+ rows1[0]+"' AND b.boss_org_code = (SELECT SUBSTR (org_code, 1, 7) FROM dloginmsg WHERE login_no = a.login_no)"
     + "AND a.op_time BETWEEN TO_DATE ('"+start_time.trim()+"', 'YYYYMM') AND TO_DATE ('"+end_time.trim()+"', 'YYYYMM') order by a.op_time desc";
%>
</wtc:iter>
<%
  };
%>
<html>
<head>
<title><%=opName%></title>

<!-- javascript functions-->
<script language="JavaScript">
//�����������
function doclear() {
	document.form1.reset();
	document.form1.action="fKFPointDetail.jsp";
	document.form1.submit();
}
//�ύ��ѯ��У�����ڸ�ʽ
function doSubmitQuery(){
		var start_time = $("#start_time").val();	
		var end_time = $("#end_time").val();
		
		if(!forDate($("#start_time")[0])){
			return false;
		}
		
		if(!forDate($("#end_time")[0])){
			return false;
		}
		
		if(start_time>end_time){
			rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��",0);
			return false;
		}
   
    document.form1.action="fKFPointDetail.jsp";
	  document.form1.submit();
	}
</script>
</head>
<body onMouseDown=" return hideEvent()" onKeyDown=" return hideEvent()">
  	<form name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>
     <div class="title">��ѯ����</div>
       <table cellspacing="0">
          <tr>
            <td width="10%" class="blue">�������</td>
            <td>
              <input name="phone_no" type="text"  id="phone_no" value="<%=phone_no%>" size="18" readonly class="InputGrey">
            </td>
            <td width="10%" class="blue">��ʼ����</td>
            <td>
              <input name="start_time" type="text"  id="start_time" value="" size="18" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;<font class="orange">*</font>
            </td>
            <td width="10%" class="blue">��������</td>
            <td>
              <input name="end_time" type="text"  id="end_time" value="" size="18" maxlength="6" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_format="yyyyMM" onKeyDown="if(event.keyCode==13){doSubmitQuery()}">&nbsp;<font class="orange">*</font>
            </td>
          </tr>
          <tr>
            <td colspan="6"  id=��footer�� align="right">	
              <input type="button" name="query" class="b_foot" value="��ѯ" onclick="doSubmitQuery()" >
							&nbsp;
							<input type="button" name="return1" class="b_foot" value="����" onclick="doclear()" >
						</td>
          </tr>
      </table>   
     </div>
     <div id="Operation_Table">
       <div class="title">�ͻ����ֽ����Ϳۼ���ϸ��ѯ���</div>
		   <table width="100%" border="0" cellpadding="0" cellspacing="0">
		     <tr>
		       <th>����ʱ��</th>
					 <th>������ֵ</th>
					 <th>����ԭ��</th>
					 <th>��������</th>
					 <th>����Ӫҵ��</th>
		     </tr>

<%
if(phone_no!=null && start_time!=null && end_time!=null){
int num = 0 ;
%>
<wtc:pubselect name="sPubSelect" outnum="5">
	 <wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:iter id="rows2" indexId="i" >
      <%if(num%2==0){%>
		     <tr>
		       <td class="Grey"><%="".equals(rows2[0])?"&nbsp":rows2[0]%></td>   
		       <td class="Grey">
		         <%if(!"".equals(rows2[1]))
		             {
		               point = 0.0 - Double.parseDouble(rows2[1]);
		               if(point > 0.0){
		         %>
		            +<%=point%>
		         <%       
		               }else{
		         %>
		            <%=point%>
		         <%    }
		             }else{
		         %>
		            &nbsp;
		         <%  }  %>
		       </td>
		       <td class="Grey"><%="".equals(rows2[2])?"&nbsp;":rows2[2]%></td>
		       <td class="Grey"><%="".equals(rows2[3])?"&nbsp;":rows2[3]%></td>
		       <td class="Grey"><%="".equals(rows2[4])?"&nbsp;":rows2[4]%></td>
		     </tr>
		   <%
		      num++;
		      }else{%>
		     <tr>
		       <td><%="".equals(rows2[0])?"&nbsp":rows2[0]%></td>   
		       <td>
		         <%if(!"".equals(rows2[1]))
		             {
		               point = 0.0 - Double.parseDouble(rows2[1]);
		               if(point > 0.0){
		         %>
		            +<%=point%> 
		         <%       
		               }else{
		         %>
		            <%=point%>
		         <%    }
		             }else{
		         %>
		            &nbsp;
		         <%  }  %>
		       </td>
		       <td><%="".equals(rows2[2])?"&nbsp;":rows2[2]%></td>
		       <td><%="".equals(rows2[3])?"&nbsp;":rows2[3]%></td>
		       <td><%="".equals(rows2[4])?"&nbsp;":rows2[4]%></td>
		     </tr>
		   <%
		      num++;
		      }%>
</wtc:iter>

<%
    System.out.println("�����¼��ʼ@libina@20090519");
	  System.out.println("������ý����"+retCode+"/"+retMsg);
	  int successFlag = 1;
	  if("000000".equals(retCode)){
	     successFlag = 0;
	  }
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  <wtc:sql><%=SQL1%></wtc:sql> 	
  </wtc:pubselect>
	<wtc:array id="result1" scope="end"/> 	
<%
  String SQL2 = "insert into DLOGMANOPR"+result1[0][0]+" values(sysdate,'"+phone_no+"','"+login_no+"','01005',"+successFlag+",'01005','0','������ϸ��ѯ')";
%>  
    <wtc:service name="sPubModify" outnum="3">
			<wtc:param value="<%=SQL2%>"/>
			<wtc:param value="dbcall"/>
		</wtc:service>
<%
  System.out.println("�����¼����@libina@20090519");
  }
%>
		   </table>
<%@ include file="/npage/include/footer.jsp" %>      
    </form>    
</body>
</html>