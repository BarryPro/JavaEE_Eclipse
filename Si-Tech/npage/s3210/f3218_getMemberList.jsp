<%

    /********************

     * @ OpCode    :  3218

     * @ OpName    :  ��ѯ���ų�Ա�б�

     * @ CopyRight :  si-tech

     * @ Author    :  wangzn

     * @ Date      :  2011/7/14 14:19:03

     * @ Update    :  

     ********************/

%>

<%@ page contentType="text/html; charset=GBK" %>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String loginNo = (String)session.getAttribute("workNo");

	String loginName = (String)session.getAttribute("workName");

	String orgCode = (String)session.getAttribute("orgCode");

	String ip_Addr = (String)session.getAttribute("ipAddr");

	String orgId = (String)session.getAttribute("orgId");

	

	String regionCode = (String)session.getAttribute("regCode");

	

 

	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";

	String errorCode="444444";

	String[][] errCodeMsg = null;

	String[][] input_paras = new String[1][14];

	

	String[][] callData = new String[][]{};

	String[][] callData1 = new String[][]{};

	int no=0;

	

	String TOKEN = "~";



	List al = null;

	boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ

  	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����



  	String opCode = request.getParameter("opCode");

  	String opNote = request.getParameter("opNote");

  	String grpId = request.getParameter("GRPID");

  	String tmpDEPT = request.getParameter("tmpDEPT");

  	String OVERDUE = request.getParameter("OVERDUE");

  	String tmpSTARTDATE = request.getParameter("tmpSTARTDATE");

  	String tmpENDDATE = request.getParameter("tmpENDDATE");

  	String QRYTYPE = request.getParameter("QRYTYPE");

  	String ACCEPTNO = request.getParameter("ACCEPTNO");

  	String BEGINPOSI = request.getParameter("BEGINPOSI");

%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="seq"/>

<%

  	

	input_paras[0][0] = request.getParameter("loginNo"); 	/* ��������   */ 

	input_paras[0][1] = request.getParameter("orgCode");	/* ��������   */

	input_paras[0][2] = regionCode;							/* ��������   */

	input_paras[0][3] = request.getParameter("opCode");		/* ��������   */

	input_paras[0][4] = request.getParameter("opNote");		/* ������ע   */

	input_paras[0][5] = seq;	

	input_paras[0][6] = ip_Addr;

	input_paras[0][7] = orgId ;

	input_paras[0][8] = request.getParameter("opType");		/* ��������	0����ѯ 1����ҳ 2������ */

	input_paras[0][9] =	request.getParameter("GRPID");		/* ���ź�     */

	input_paras[0][10] = request.getParameter("QRYTYPE");	/* ��ѯ���� 0 ���� 1������*/

	input_paras[0][11] = request.getParameter("beginNum");

	input_paras[0][12] = request.getParameter("endNum");
	input_paras[0][13] = request.getParameter("true_code");

	

 	

		

	for(int i=0; i<input_paras[0].length; i++){

		

		if( input_paras[0][i] == null ){

			input_paras[0][i] = "";

		}

		System.out.println("["+i+"]="+input_paras[0][i]);

	}




     String svcName = "s3218Cfm";
     
%>		
	<wtc:service name="<%=svcName%>" outnum="30" retmsg="returnMessage" retcode="returnCode" routerKey="region" routerValue="<%=regionCode%>">

		<wtc:param value="<%=input_paras[0][0 ]%>" />

		<wtc:param value="<%=input_paras[0][1 ]%>" />	

		<wtc:param value="<%=input_paras[0][2 ]%>" />

		<wtc:param value="<%=input_paras[0][3 ]%>" />

		<wtc:param value="<%=input_paras[0][4 ]%>" />

		<wtc:param value="<%=input_paras[0][5 ]%>" />

		<wtc:param value="<%=input_paras[0][6 ]%>" />

		<wtc:param value="<%=input_paras[0][7 ]%>" />

		<wtc:param value="<%=input_paras[0][8 ]%>" />

		<wtc:param value="<%=input_paras[0][9 ]%>" />

		<wtc:param value="<%=input_paras[0][10]%>" />

		<wtc:param value="<%=input_paras[0][11]%>" />

		<wtc:param value="<%=input_paras[0][12]%>" />
		<wtc:param value="<%=input_paras[0][13]%>" />

	</wtc:service>

	<wtc:array id="result_t1" start="0" length="1" scope="end"/>

	<wtc:array id="result_t2" start="1" length="13" scope="end"  /> <%//diling update@2011/10/3 ������4�����δ��������;%>

	var resultArray = new Array();

<%

	

	System.out.println("@:******************************************");

	System.out.println("@:***"+result_t2.length);
	for(int i=0;i<result_t2.length;i++){

	System.out.println("@:******************************************");

	%>

		resultArray[<%=i%>] = new Array();

	<%

			for(int j=0;j<result_t2[i].length;j++){

				if(result_t2[i][j]!=null){

				System.out.println("-----------3218--------------result_t2["+i+"]["+j+"]="+result_t2[i][j]);

%>

					resultArray[<%=i%>][<%=j%>]="<%=result_t2[i][j]%>";

<%				}

			}

	}

%>



var response = new AJAXPacket();

response.data.add("returnCode","<%=returnCode%>");

response.data.add("returnMessage","<%=returnMessage%>");

response.data.add("resultArray",resultArray);
<%
if(result_t1.length>0){
%>
response.data.add("resultCnt","<%=result_t1[0][0]%>");
<%
}
%>
core.ajax.receivePacket(response);
