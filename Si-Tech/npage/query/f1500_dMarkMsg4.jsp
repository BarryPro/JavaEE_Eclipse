<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%        

	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û����ֲ�ѯ";
	
	String regionCode =  (String)session.getAttribute("regCode");
	String id_no  = request.getParameter("idNo");
	String phoneNo  = request.getParameter("phoneNo");
	//phoneNo="13836190009";//"13936181264"; 13503637388 13936200254
	String cust_name  = request.getParameter("custName");
	String work_no=(String)session.getAttribute("workNo");
	String work_name=request.getParameter("workName");
	String btime=request.getParameter("btime");
	String etime=request.getParameter("etime");
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
%>

        	
     <wtc:service name="sMarkAddQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="9">
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=work_no%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=btime%>"/>
        <wtc:param value="<%=etime%>"/>
       </wtc:service>
	<wtc:array id="result" scope="end"  start="0"  length="2"/>
	<wtc:array id="resultyhsc" scope="end" start="2"  length="7"/>
	
	



<HTML><HEAD><TITLE>���ɻ��ֲ�ѯ</TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">���ַ��Ų�ѯ(6�����ڷ��ż�¼)</div>
			</div>
	    <table cellspacing="0">
	      <tr align="center"> 
	        <th>���Ż�����������</th>
	        <th>����ʱ��</th>
	        <th>���Ż���ֵ</th>
			<th>��Ч��ʼ��</th>
	        <th>������</th>
	        <th>��ע</th>  
	      </tr>
		<%
		if(retCode2.equals("000000")) {
			String ffsj  = ""; 
			String sxksr = "";
			String dqr   = "";
		if(resultyhsc.length>0) {
			String tbClass="";
			for(int y=0;y<resultyhsc.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
				sxksr=resultyhsc[y][3];
				if(sxksr!=null &&(!sxksr.equals("")))
				{
					sxksr=sxksr.substring(0,4)+"-"+sxksr.substring(4,6)+"-"+sxksr.substring(6,8);
				}
				dqr=resultyhsc[y][4];
				if(dqr!=null &&(!dqr.equals("")))
				{
					dqr=dqr.substring(0,4)+"-"+dqr.substring(4,6)+"-"+dqr.substring(6,8);
				}
				ffsj=resultyhsc[y][0];
				if(ffsj!=null &&(!ffsj.equals("")))
				{
					ffsj=ffsj.substring(0,4)+"-"+ffsj.substring(4,6)+"-"+ffsj.substring(6,8);
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=resultyhsc[y][6]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=ffsj%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=resultyhsc[y][2]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=sxksr%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=dqr%>&nbsp;</td> 
					<td class="<%=tbClass%>"><%=resultyhsc[y][5]%>&nbsp;</td>
				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'><%=retMsg2%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

