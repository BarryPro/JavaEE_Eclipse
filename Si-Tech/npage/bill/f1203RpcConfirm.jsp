<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%
/********************
 version v2.0
������: si-tech
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
	String[][] info = (String[][])arr.get(2);//��ȡ��½IP����ɫ���ƣ����ڲ��ţ���ϣ�
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//��ȡ�������� 
	String pass = password1[0][0];
	
	String phoneNo = request.getParameter("phoneNo");          //�ֻ�����
    String opCode = request.getParameter("opCode");          //��������
    ArrayList retList = new ArrayList();
	String[] paraAray1 = new String[5];
	paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
    paraAray1[1] = work_no; 	/* ��������   */
    paraAray1[2] = org_code;	/* ��������   */
	paraAray1[3] = opCode;      /* ��������   */
    paraAray1[4] = info[0][2];  /* iIpAddrip��ַ   */


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
	  bind_cust_name = (((String[][])retList.get(2)))[0][0];//�󶩿ͻ�����
	  bindContractNoArr = ((String[][])retList.get(3));//�󶩺�ͬ��
	  payTypeArr = ((String[][])retList.get(4));//���ѷ�ʽ
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