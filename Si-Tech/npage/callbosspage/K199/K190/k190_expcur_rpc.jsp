<%
  /*
   * ����: �ͷ�һ������¼����Ϣ��
�� * �汾: 1.0.0
�� * ����: 2009/09/07
�� * ����: yinzx
�� * ��Ȩ: sitech
   * 
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.*,com.sitech.boss.util.excel.*"%>


<%!
//����Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "ҵ����ѯ�����Ϣ����";//Excel�ļ���
        try {
        OutputStream os = response.getOutputStream();//ȡ�������
        response.reset();//��������
        response.setContentType("application/ms-excel");//�����������
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//�趨����ļ�ͷ
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5],queryList[i][6],queryList[i][7],queryList[i][8],queryList[i][10]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " ����Excel�ļ�[�ɹ�] ");
        }catch  (Exception e1) {
           System.out.println( " ����Excel�ļ�[ʧ��] ");
           e1.printStackTrace();
        } 
    }
    
    
    public void getExecl(String[][] queryList,String[] strHead,HttpServletResponse response){
       this.toExcel(queryList, strHead, response); 
    }
     
%>

<%
  String strSql="";
  String addvalxin = "";
 
 
  String querySql = (String)request.getParameter("querySql");
  
  	String[] strHead = { "�����", "�������", "�ض����̱�־", "���̵���������", "������",
			"���д���","�û�����", "����·��", "�û����","��������"  };
 
 
    
     
%>

<wtc:service name="s151Select" outnum="13">
	<wtc:param value="<%=querySql%>" />
</wtc:service>
<wtc:array id="queryList" start="0" length="11" scope="end" />

 


<%
   this.toExcel(queryList, strHead, response); 
  
%>
<script language="javascript"  >
	window.close();
</script>