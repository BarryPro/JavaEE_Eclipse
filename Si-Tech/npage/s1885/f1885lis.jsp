   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-3-17
********************/
%>
              
<%
  String opCode = "1885";
  String opName = "���֤ɨ������˱���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
 

<%
  String regionCode = (String)session.getAttribute("regCode");
	String begindate=request.getParameter("opdate1");
	System.out.println("--------------begindate-------------"+begindate);
	String enddate=request.getParameter("opdate2");
	System.out.println("--------------enddate-------------"+enddate);
	String op_code=request.getParameter("op_code");
	System.out.println("--------------op_code-------------"+op_code);
	String workno=request.getParameter("workno");
	System.out.println("--------------workno-------------"+workno);
	
	String infoData[][] = new String[][]{};
	int recordNum = 0;
	int  iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	if(op_code.equals("1100")||op_code.equals("1104")){
	String sql_iccid = "SELECT b.cust_id, a.id_type, b.id_iccid, a.id_name, b.work_no,to_char(b.opr_date,'yyyy-mm-dd') oprdate, b.op_code, op_code ,b.id_iccid"
										+" FROM DCUSTICCIDIMG a  ,  DCUSTIDTOICCID b "
										+" where a.id_iccid=b.id_iccid and b.work_no='"+workno+"' and b.op_code='"+op_code+"' and  b.opr_date  between to_date('"+begindate+"','yyyy-mm-dd') and to_date('"+enddate+"','yyyy-mm-dd')";
	String sql_counticcid = "select count(*) from DCUSTIDTOICCID where work_no='"+workno+"' and opr_date  between to_date('"+begindate+"','yyyy-mm-dd') and to_date('"+enddate+"','yyyy-mm-dd')";
	System.out.println("--------------sql_iccid-------------"+sql_iccid);
	%>
		<wtc:pubselect name="sPubSelect" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql_iccid%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="infoData1" scope="end"/>	
	 	
	 	
	 	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql_counticcid%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="allNumStr" scope="end"/>	
	 	
	 	
	<%
	
	 recordNum = Integer.parseInt(allNumStr[0][0].trim());
	
	 System.out.println("--------------recordNum--------------------"+recordNum);
	 System.out.println("--------------infoData1.length-------------"+infoData1.length);
	infoData = infoData1;
	}
else{
%>
<wtc:service name="s1885Qry" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="errMsg1"  outnum="8" >
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=begindate%>"/>
			<wtc:param value="<%=enddate%>"/>
</wtc:service>
<wtc:array id="infoData2" scope="end" />
<%
infoData = infoData2;
 }
 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���֤ɨ������˱���</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language="JavaScript">
function viewpic(dbname,la,nameu,opc,idIccidjs){
	
		//alert("�·ݲ��±�|"+dbname);
		//alert("Ψһֵ|"+la);
		//alert("�ͻ�����|"+nameu);
		//alert("opcode|"+opc);
		var dbyyyy=dbname.substring(0,4);
		var dbmm=dbname.substring(5,dbname.lastIndexOf("-"));
		var dbnamej=dbyyyy+dbmm;
 		var path = "f1885viewpic.jsp?database="+dbnamej+"&login_accept="+la+"&nameu="+nameu+"&opc="+opc+"&idIccidjs="+idIccidjs;
    retInfo = window.open(path,"newwindow","height=550, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	}
</script>

</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">���֤ɨ������˱���</div>
	</div>
 
  <table  cellspacing="0">
    <tr> 
      <th>�ͻ�ID		</th>
      <th>���֤����</th>
      <th>���֤����</th>
      <th>���֤����</th>
      <th>����			</th>
      <th>����ʱ��	</th>
      <th>ҳ�����	</th>
      <th>���֤��Ƭ</th>
    </tr>
    <%
    String class_name ="";
    for(int i=0;i<infoData.length;i++)
    {
			out.print("<tr>");   
			if(i%2==0)
			 class_name="Grey";
			else
				class_name="";
				
			out.print("<td class="+class_name+">"+infoData[i][0]+"</td>");    
			out.print("<td class="+class_name+">"+infoData[i][1]+"</td>");
			out.print("<td class="+class_name+">"+infoData[i][2]+"</td>");
			out.print("<td class="+class_name+">"+infoData[i][3]+"</td>");
			out.print("<td class="+class_name+">"+infoData[i][4]+"</td>");
			out.print("<td class="+class_name+">"+infoData[i][5]+"</td>");
			out.print("<td class="+class_name+">"+infoData[i][6]+"</td>");
			out.print("<td class="+class_name+"><input type=button onClick=viewpic('"+infoData[i][5].trim()+"','"+infoData[i][7]+"','"+infoData[i][3]+"','"+infoData[i][6]+"','"+infoData[i][2]+"') class=b_text value=�鿴ͼƬ></td>");
			out.print("</tr>");    
    }
    
    %>
    <table cellspacing="0">
     <tr>
    <%
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //Page pg = new Page(iPageNumber,iPageSize,iQuantity);
    Page pg = new Page(iPageNumber,25,recordNum);
    PageView view = new PageView(request,out,pg);
  
%>
		<div style="position:relative;font-size:12px" align="center">
<%
     view.setVisible(true,true,0,0);    
%>
		</div>
	</tr>
</table>
<table cellspacing="0">
	<tr>
      <td colspan="8" id="footer"> <div align="center" > 
          <input name="back" onClick="removeCurrentTab()" type="button"  value="�ر�" class="b_foot">
          &nbsp;
          <input name="back21" onClick="history.go(-1)" type="button"  value="����" class="b_foot">
          &nbsp; </div></td>
    </tr>
  </table>
  <br>
 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
