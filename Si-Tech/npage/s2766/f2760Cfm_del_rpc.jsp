<%
   /*
   * 功能: 个性帐单模板 rpc
　 * 版本: v1.0
　 * 日期: 2006/08/28
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>

<%
	String currRowIndex = request.getParameter("currRowIndex");   //行索引  
	
	String workNo = request.getParameter("workNo");   		//工号  			                                  
	String nopass = request.getParameter("nopass");       //密码  			                                  
	String org_code = request.getParameter("org_code");   //机构代码                                
	String op_code = request.getParameter("op_code");     //操作代码                                
	String op_type = request.getParameter("op_type");  	  //操作类型(新增 '0' ,修改 '1',删除 '2')                                                                        
	String show_id = request.getParameter("show_id");     //显示ID			                                  
	String show_order = request.getParameter("show_order");   //显示序列号                              
	String show_name = request.getParameter("show_name"); //显示名称                                  
	String line = request.getParameter("line");           //显示行数                                
	String list = request.getParameter("list");           //显示列数                                
	String font_num = request.getParameter("font_num");   //字体大小                                
	String lenth = request.getParameter("lenth");         //显示长度                                
	String var_flag = request.getParameter("var_flag");   //变量标识                                
	String show_mode = request.getParameter("show_mode"); //所属模版号                              
	String col_name = request.getParameter("col_name");   //字段名称                                
	String noval_flag = request.getParameter("noval_flag"); 	//无值动态标志
	String line_off = request.getParameter("line_off");   //行偏移量                                
	String list_off = request.getParameter("list_off");   //列偏移量                                
	String dym_flag = request.getParameter("dym_flag");   		//动态区标识   
	String dym_id = request.getParameter("dym_id");   					//动态ID                         

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
