<%
/********************
 version v2.0
������: si-tech
*
*create by lipf 20120509
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%!
	/**
	 * ��ʽ���ַ������ڣ��ӿڱ��ķ��ظ�ʽyyyyMMddHHmmss lipf 2012-05-09
	 * @param tag         �����ַ���
	 * @param format      ���ʽ���ڸ�ʽ
	 * @return
	 * @throws Exception
	 */
	public String dateFormatForStr(Object tag,String format) throws Exception{
		if(tag==null || "".equals(tag)){
			return "";
		}
		return dateFormatForStr(tag.toString(),"yyyyMMdd HHmmss",format);
	}
	
	/**
	 * ��ʽ���ַ�������      lipf 2012-05-09
	 * @param tag         �����ַ���
	 * @param fromFormat  ����ʽ���ڸ�ʽ
	 * @param toFormat    ���ʽ���ڸ�ʽ
	 * @return
	 * @throws Exception
	 */
	public String dateFormatForStr(String tag,String fromFormat,String toFormat) throws Exception{
		SimpleDateFormat fromSdf=new SimpleDateFormat(fromFormat);
		SimpleDateFormat toSdf=new SimpleDateFormat(toFormat);
		return toSdf.format(fromSdf.parse(tag));
	}
%>
<%
	String opCode = "1600";
  String opName = "�����Ϣ��ѯ֮��֤ʧ����Ϣ��ѯ";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String iLoginAccept = "0";     //��ˮ
  String iChnSource = "01";			//������ʶ
  String iOpCode=request.getParameter("opCode");//��������
  String iLoginNo = (String)session.getAttribute("workNo");//����
	String iLoginPwd = (String)session.getAttribute("password");//��������
	String iPhoneNo  = request.getParameter("iPhoneNo");//�ֻ�����
  String iUserPwd = "";					//�ֻ�����
	String iOpNote="��֤ʧ����Ϣ��ѯ";//��ע
	String iAccount  =request.getParameter("iAccount");//�û��˺�
	String iQeyType=request.getParameter("iQeyType");//��ѯ����
	String iCycle=request.getParameter("iCycle");//��ѯ����
%>
	<wtc:service name="sAccessLogQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iOpNote%>"/>
		<wtc:param value="<%=iAccount%>"/>
		<wtc:param value="<%=iQeyType%>"/>
		<wtc:param value="<%=iCycle%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if (!"000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("������ʾ:<%=retMsg1%>");
			history.go(-1);
		</script>
<%	
	}
%>
<HTML><HEAD><TITLE>��֤ʧ����Ϣ��ѯ</TITLE>
</HEAD>
<body>

<FORM method=post name="f1600_sOnLineQry">
<%@ include file="/npage/include/header.jsp" %>     	
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">��֤ʧ����Ϣ</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center">
          <th>��֤ʱ��</th>
          <th>��IP</th>
          <th>�󶨶˿�</th>
          <th>ʧ��ԭ��</th>
        </tr>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++)
			{
				if(y%2==0)
				{
					tbClass="Grey";
				}else
				{
					tbClass="";
				}
%>
	        <tr align="center">
<%    		
				for(int j=0;j<result[0].length;j++)
				{
					if(j==0){
						result[y][j]=dateFormatForStr(result[y][j],"yyyy-MM-dd HH:mm:ss");
					}
%>				
		  			<td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%			
				}
			}
%>
	        </tr>
         </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=iOpCode%>')" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
