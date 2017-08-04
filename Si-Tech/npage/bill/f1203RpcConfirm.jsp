<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>

var arrContractNo = new Array();
var arrPayType = new Array();

<%
    String verifyType = request.getParameter("verifyType");
    SPubCallSvrImpl impl = new SPubCallSvrImpl();
  	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String[][] info = (String[][])arr.get(2);//读取登陆IP，角色名称，所在部门（组合）
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//读取工号密码 
	String pass = password1[0][0];
	
	String phoneNo = request.getParameter("phoneNo");          //手机号码
    String opCode = request.getParameter("opCode");          //操作代码
    ArrayList retList = new ArrayList();
	String[] paraAray1 = new String[5];
	paraAray1[0] = phoneNo;		/* 手机号码   */ 
    paraAray1[1] = work_no; 	/* 操作工号   */
    paraAray1[2] = org_code;	/* 归属代码   */
	paraAray1[3] = opCode;      /* 操作代码   */
    paraAray1[4] = info[0][2];  /* iIpAddrip地址   */


    for(int i=0; i<paraAray1.length; i++)
    {		
	  if( paraAray1[i] == null )
	  {
	    paraAray1[i] = "";
	  }
    }

    retList = impl.callFXService("s1201_Valid", paraAray1, "5","phone",phoneNo);
	
	String[][] bindContractNoArr= new String[][]{};
    String[][] payTypeArr= new String[][]{};
	String bind_cust_name="";
	int errCode = impl.getErrCode();
    String errMsg = impl.getErrMsg();
    System.out.println("errCode=================" + errCode);
	if(errCode==0)
	{
	  bind_cust_name = (((String[][])retList.get(2)))[0][0];//绑订客户姓名
	  bindContractNoArr = ((String[][])retList.get(3));//绑订合同号
	  payTypeArr = ((String[][])retList.get(4));//付费方式
      for(int i=0;i<bindContractNoArr.length;i++)
      {
	    out.println("arrContractNo["+i+"]='"+bindContractNoArr[i][0]+"';\n");
	    out.println("arrPayType["+i+"]='"+bindContractNoArr[i][0]+"--"+payTypeArr[i][0]+"';\n");
      }
	}
%>
  var response = new AJAXPacket();
  response.guid = '<%= request.getParameter("guid") %>';
  response.data.add("verifyType","<%= verifyType %>");
  response.data.add("errorCode","<%= errCode %>");
  response.data.add("errorMsg","<%= errMsg %>");
  response.data.add("bind_cust_name","<%= bind_cust_name %>");
  response.data.add("arrContractNo",arrContractNo);
  response.data.add("arrPayType",arrPayType);
  core.ajax.receivePacket(response);