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
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = "5082";
	String opName = "������Ϣ��ѯ";
    
	String idNo = request.getParameter("idNo");//��ѯ����
	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	String vStartPos = ""+iStartPos;
	String vEndPos = ""+iEndPos;
	
	System.out.println("idNo:"+idNo);

    
    String[][] result1 = new String[][]{};
    int recordNum = 0;
    try{
    %>

    	<wtc:service name="bs_s242ConCfm"  outnum="6" retcode="errcode" retmsg="errmsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=idNo%>" />

    	</wtc:service>
    	<wtc:array id="retArr1" scope="end"/>
    
    <%
        if("000000".equals(errcode)){
            if(retArr1.length>0){
                result1 = retArr1;
                for(int i = 0;i<result1.length;i++) {
            		for(int j = 0;j<result1[0].length;j++)
            		    System.out.println("result1["+i+"]["+j+"]"+result1[i][j]);
        	    }
        	    recordNum = Integer.parseInt(result1[0][5].trim());

        	}
        }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("������룺<%=errcode%>,������Ϣ��<%=errmsg%>",0);
                    history.go(-1);
                </script>
            <%
        }
    }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("���÷���bs_s242ConCfmʧ�ܣ�",0);
            </script>
        <%
        e.printStackTrace();
    }
%>
</HEAD>
<% if (!(result1.length>0) || result1[0][0].trim().equals("")){%>
<script language="javascript">
	rdShowMessageDialog("û���ҵ��κ�����",0);
	history.go(-1);
</script>
<%}else{%>
<body>
<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ</div>
</div>
    <table cellspacing="0">
      <tr>
      	<!--<td>��Ա���</td> -->
        <th>�˻�����</th>
		<th>�˻�����</th>
        <th>�û�Ԥ��</th>
        <th>�ɻ���Ԥ��</th>
        <th>δ���ʻ���</th>

      </tr>
  <%
		for(int y=0;y<result1.length;y++){
	  %>
	  
	  <tr>
	  <%    
		for(int j=0;j<result1[0].length-1;j++){
	  %>
	    <td><%=result1[y][j]%></td>
	  <%
		}
	  %>
	   </tr>
	  <%
	    }
	  %>
    </table>

 <table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,recordNum);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>

    <table cellspacing=0>
      <tr id="footer"> 
		<td>
			  <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
			  <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
			  <input class="b_foot_long" name=print onClick="printxls()" type=button value=����ΪXLS���>
		</td>
	  </tr>
	</table>
<script>
	function printxls(){
		window.open("f5082_6_printxls.jsp?idNo=<%=idNo%>");
	}	
</script>
<%@ include file="/npage/include/footer.jsp" %>
</FORM></BODY></HTML>
<%}%>