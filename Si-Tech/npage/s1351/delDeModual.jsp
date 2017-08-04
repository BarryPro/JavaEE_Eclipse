<%
   /*
   * 功能: 个性帐单模板
　 * 版本: v1.0
　 * 日期: 2010/09/21
　 * 作者: zhangss
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               //工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	
	String op_name = "";


	String show_mode = request.getParameter("show_mode");     //模版编号
  


	
		SPubCallSvrImpl impl = new SPubCallSvrImpl();
	    
	  String paraArr[] = new String[1];
		
		paraArr[0]= show_mode;     
		
		impl.callFXService("sDelDeModeNew",paraArr,"2");
		impl.printRetValue();
		int errCode=impl.getErrCode();   
		String errMsg=impl.getErrMsg();	
		
		if(errCode==0)
		{%>
			<script language=javascript>
				 rdShowMessageDialog("删除成功！");
			   history.go(-1);
			</script>
		<%
		}
	else
		{
		%>
			<script language=javascript>
				 rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
				  history.go(-1);
			</script>
		<%
		}
	
%>
