<%
   /*
   * ����: �����ʵ�ģ�� rpc
�� * �汾: v1.0
�� * ����: 2006/08/28
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>

<%
	String currRowIndex = request.getParameter("currRowIndex");   //������  
	
	String workNo = request.getParameter("workNo");   		//����  			                                  
	String nopass = request.getParameter("nopass");       //����  			                                  
	String org_code = request.getParameter("org_code");   //��������                                
	String op_code = request.getParameter("op_code");     //��������                                
	String op_type = request.getParameter("op_type");  	  //��������(���� '0' ,�޸� '1',ɾ�� '2')                                                                        
	String show_id = request.getParameter("show_id");     //��ʾID			                                  
	String show_order = request.getParameter("show_order");   //��ʾ���к�                              
	String show_name = request.getParameter("show_name"); //��ʾ����                                  
	String line = request.getParameter("line");           //��ʾ����                                
	String list = request.getParameter("list");           //��ʾ����                                
	String font_num = request.getParameter("font_num");   //�����С                                
	String lenth = request.getParameter("lenth");         //��ʾ����                                
	String var_flag = request.getParameter("var_flag");   //������ʶ                                
	String show_mode = request.getParameter("show_mode"); //����ģ���                              
	String col_name = request.getParameter("col_name");   //�ֶ�����                                
	String noval_flag = request.getParameter("noval_flag"); 	//��ֵ��̬��־
	String line_off = request.getParameter("line_off");   //��ƫ����                                
	String list_off = request.getParameter("list_off");   //��ƫ����                                
	String dym_flag = request.getParameter("dym_flag");   		//��̬����ʶ   
	String dym_id = request.getParameter("dym_id");   					//��̬ID                         

	SPubCallSvrImpl impl = new SPubCallSvrImpl();
  ArrayList acceptList = new ArrayList();

  String paraArr[] = new String[20];
	
	paraArr[0]= workNo;
	paraArr[1]= nopass;
	paraArr[2]= org_code;
	paraArr[3]= op_code;
	paraArr[4]= op_type;
	paraArr[5]= show_id;
	paraArr[6]= show_order;
	paraArr[7]= show_name;
	paraArr[8]= line;
	paraArr[9]= list;
	paraArr[10]= font_num;
	paraArr[11]= lenth;
	paraArr[12]= var_flag;
	paraArr[13]= show_mode;
	paraArr[14]= col_name;
	paraArr[15]= noval_flag;
	paraArr[16]= line_off;
	paraArr[17]= list_off;
	paraArr[18]= dym_flag;
	paraArr[19]=dym_id;
						
	acceptList = impl.callFXService("s2731Cfm",paraArr,"2");
	impl.printRetValue();
	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg();	
	
%>
   
	var response = new RPCPacket();
	response.guid = '<%= request.getParameter("guid") %>';
	response.data.add("retFlag","del");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("currRowIndex","<%=currRowIndex%>");
	core.rpc.receivePacket(response);
