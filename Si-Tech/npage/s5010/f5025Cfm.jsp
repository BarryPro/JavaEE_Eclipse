<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.24
 ģ��: �����ʷѴ�������
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%		
	String opCode = "5025";
	String opName = "�����ʷѴ�������";    
	    
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
  
%>
<%

	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String error_code="444444";
	String[][] errCodeMsg = null;
	List al = null;
	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
  	
  	StringBuffer procSql = new StringBuffer();
	String opType="",mode_code="",next_mode_code="",new_next_mode_code="",use_flag="",op_code="",op_note="";

    opType = request.getParameter("opType");//��������
	mode_code = request.getParameter("mode_code");//��ǰ�ʷ�
	next_mode_code = request.getParameter("next_mode_code");//�����ʷ�
	new_next_mode_code = request.getParameter("new_next_mode_code");//�µ����ʷ�
	use_flag = request.getParameter("useFlag");//��Ч��־
    op_note = request.getParameter("op_note");//��ע
	op_code = "5025";//��������
   
		
	 //�ڴ˴��γɴ洢���̵Ĵ�,�������Ե���һ�������Ϳ����ˡ�

	 procSql.append(" Prc_5025_cfm('" + opType+ "'");
	 procSql.append(",'" + regionCode+ "'");
	 procSql.append(",'" + mode_code+ "'");
	 procSql.append(",'" + next_mode_code+ "'");
	 procSql.append(",'" + new_next_mode_code+ "'");
	 procSql.append(",'" + use_flag+ "'");
	 procSql.append(",'" + op_code + "'");
	 procSql.append(",'" + ip_Addr + "'");
	 procSql.append(",'" + op_note + "'");
	 procSql.append(",'" + loginNo + "'");
 
     System.out.println("f5025Cfm.jsp:procSql="+procSql.toString());
 
     //al = s5010.get_spubproccfm( procSql.toString() );
%>
	<wtc:service name="sPubProcCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=procSql.toString()%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>	
<%     
     if(result1.length==0){
 		// System.out.println("======jsp5025:array is null!!===");
		 valid = 1;
	 }else{
		  //errCodeMsg = (String[][])al.get(0);
	   	  error_code = retCode1;
		  
		  if(!error_code.equals("000000")){
			  valid = 2;
			  error_msg = retMsg1;
		  }else{
		  	  valid = 0;
		  }
	  }
%>

<%if( valid == 1){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!",0);
	history.go(-1);
//-->
</script>

<%}else if( valid == 2){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>ҵ��������:"+"<%=error_code %></br>"+"������Ϣ:"+"<%=error_msg %>",0);
	history.go(-1);
//-->
</script>

<%}else{%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("�����ɹ�!!",2);
	history.go(-1);
//-->
</script>
<%}%>








