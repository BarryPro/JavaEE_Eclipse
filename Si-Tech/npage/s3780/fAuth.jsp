<%
  /**
   *    ����: �ͻ������֤
   *  ��ڲ�����
   *  @inparam op_code		����������������롣
   *  @inparam reqPageName	��ѡ�����������ҳ�棬��ʱ���á�
   *  @inparam custId		��ѡ�������ͻ���ʶ�ĳ�ʼֵ��
   *  @inparam retCode		��ѡ��������ʾ���롣��ڽ���Ĵ�ӡ��Ϣ����Ҫ���ں�������ķ��ء�
   *                    	�ں��������У��û�����ͨ�����ô˲������Ϳ����ڴ˽����onload��
   *                    	��ӡ�û���������Ϣ��
   *  @inparam retMsg		��ѡ��������ʾ��Ϣ����ڽ���Ĵ�ӡ��Ϣ����Ҫ���ں�������ķ��ء�
   *                    	�ں��������У��û�����ͨ�����ô˲������Ϳ����ڴ˽����onload��
   *                    	��ӡ�û���������Ϣ��
   *  @outparam LoginAccept	������ˮ���Ӵ�ID���룩��
   *  @outparam CustIdType	�ͻ���ʶ����
   */ 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

 
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<html>
<head>
<%   
	String opCode = "1363";
	String opName = "Ԥ����ϸ��ѯ";	
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
  String work_no=baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String org_Code = baseInfoSession[0][16];
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA loginName is "+loginName+" and org_Code is "+org_Code);
	String workNo=work_no;
	String workName=loginName;
	
	String[][] userPass = (String[][])arrSession.get(4);
	String password=userPass[0][0];

	ArrayList initArr = new ArrayList();
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String op_code = request.getParameter("op_code");
	String sInitCustId = request.getParameter("custId");
	if (sInitCustId == null)
	{
		sInitCustId = "";
	}
	String sReqPageName = request.getParameter("reqPageName");
	String sRetCode = request.getParameter("retCode");
	String sRetMsg = request.getParameter("retMsg");
	String[] paramsIn = new String[2];
	paramsIn[0]=op_code;
	paramsIn[1]="2";//Ĭ�ϵ��ӵĽӴ���ʽ��
	initArr = impl.callFXService("s3781Qry",paramsIn,"10");
	String AuthFuncName = ((String[][])initArr.get(0))[0][0];
	String JspName = ((String[][])initArr.get(1))[0][0];
	System.out.println("sssssssAuthFuncNamesssxxxx2"+AuthFuncName);
	System.out.println("new version test for AAAAAAAAAAAAAAAAAAAAAAAAAAAsssssssJspNamesssxxxx2"+JspName);
	String CustIdType = ((String[][])initArr.get(2))[0][0];
	//System.out.println("ssssssCustIdTypessssxxxx3"+CustIdType);
	String IsLogAuthen = ((String[][])initArr.get(3))[0][0];
	String IsLogContact = ((String[][])initArr.get(4))[0][0];

	String[][] AuthenCode = (String[][])initArr.get(5);
	String[][] AuthenName = (String[][])initArr.get(6);
	String[][] AuthenGroup = (String[][])initArr.get(7);
	String[][] IsMustUsed = (String[][])initArr.get(8);
	String[][] AuthenType = (String[][])initArr.get(9);
	//String AuthenGroup_temp=AuthenGroup[0][0];
	String LoginAccept = request.getParameter("LoginAccept");
	if (LoginAccept == null)
	{
		LoginAccept = "0";
	}
	//AuthenCode  = new String[][]{};
	System.out.println("txxxxxxxxxxxxxxxxxxx========AuthenCode.length================"+AuthenCode.length);
	for(int i=0;i<AuthenCode.length;i++)
	{
		System.out.println("======================AuthenCode================"+AuthenCode[i][0]);
		System.out.println("======================AuthenName================"+AuthenName[i][0]);
		System.out.println("======================AuthenGroup================"+AuthenGroup[i][0]);
		System.out.println("======================IsMustUsed================"+IsMustUsed[i][0]);
		System.out.println("======================AuthenType================"+AuthenType[i][0]);
	}

	//����Ƿ���������֤��
	String[][] temfavStr=(String[][])arrSession.get(3);
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	{
		favStr[i]=temfavStr[i][0].trim();
	}
	boolean isAvoidPwdVerify=false;
	if(Pub_lxd.haveStr(favStr,"a272"))
	{
		isAvoidPwdVerify=true;
	}
	
	String op_name =AuthFuncName;
%>
<title><%=AuthFuncName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
 
<script type="text/javascript" src="../../../js/common/common_check.js"></script>
<script type="text/javascript" src="../../../js/common/common_util.js"></script>
<script type="text/javascript" src="../../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script language=javascript>
<%
	out.println("var vAthenArr = new Array();");
	out.println("vAthenArr[0] = new Array();");
	out.println("vAthenArr[1] = new Array();");
	for(int i=0;i<AuthenCode.length;i++)
	{
		out.println("vAthenArr[0][" + i + "]='" + AuthenCode[i][0] +"';");
		out.println("vAthenArr[1][" + i + "]='AuthId" + i +"';");
	}		

%>

core.loadUnit("rpccore");
onload=function()
{
	changetype('<%=CustIdType%>');
	core.rpc.onreceive = doProcess;
<%
	if (sRetMsg != null)
	{
		if (sRetCode != null)
		{
			out.println("rdShowMessageDialog(\"��ʾ����:"+sRetCode+"\n��ʾ��Ϣ:"+sRetMsg + "\");");
		}
		else
		{
			out.println("rdShowMessageDialog(\""+sRetMsg + "\");");	 
		}
	}
%>
}


//----------------��֤���ύ����-----------------
function doCfm()
{
	var tempStr="";
	for (var i = 0; i < frm.length; i ++)
	{
		var obj = frm.elements[i];
		if ((typeof(obj.name) != 'undefined') &&(typeof(obj.checked) != 'undefined'))
		{
			if (obj.name.substring(0, 5) == 'Radio')
			{
				var k = 0;
				
				if (obj.checked)
				{
					for (var j=0; j < vAthenArr[0].length; j ++)
					{
						if (obj.value1 == vAthenArr[0][j])
						{
							if ((document.all(vAthenArr[1][j]).value == "") && (document.all(vAthenArr[1][j]).disabled==false))
							{
								alert(obj.v_name + "����Ϊ��!");
								document.all(vAthenArr[1][j]).focus();
								return false;
							}
							else if (document.all(vAthenArr[1][j]).value != "")
							{
								tempStr = tempStr +vAthenArr[0][j] + "," + document.all(vAthenArr[1][j]).value + "|";
								//alert(tempStr);
							}
						
						}
					}
				}
				

			}
		}
	}
  if(check(frm))
  {  
	  var myPacket = new RPCPacket("fAuthentication_cfm.jsp?tempStr="+tempStr);
	  myPacket.data.add("work_no","<%=work_no%>");
		myPacket.data.add("password","<%=password%>");
		myPacket.data.add("op_code","<%=op_code%>");
		myPacket.data.add("CustIdType","<%=CustIdType%>");
		myPacket.data.add("CustId",document.frm.CustId.value);
		myPacket.data.add("LoginAccept",document.frm.LoginAccept.value);
		myPacket.data.add("JspName","<%=JspName%>");
		myPacket.data.add("IsLogAuthen","<%=IsLogAuthen%>");
		myPacket.data.add("IsLogContact","<%=IsLogContact%>");
		core.rpc.sendPacket(myPacket);
		delete(myPacket);
  }
}
function doProcess(myPacket)
{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");		
 		self.status="";
		var retLoginAccept = myPacket.data.findValueByName("returnAccept");
		//�����ɹ�
		
		if (errCode==0)
		{
			document.frm.LoginAccept.value = retLoginAccept;
			document.frm.action="/npage/<%=JspName%>";
			document.frm.submit();
		}
		else
		{
			rdShowMessageDialog(errCode+"--["+retMessage+"]");	
		}		
}


//-----------------------------------------------
function changetype(CustIdType)
{
	if(CustIdType==0)document.all.persontype.innerText="�ͻ�ID��";
	if(CustIdType==1)document.all.persontype.innerText="�ֻ����룺";
	if(CustIdType==2)document.all.persontype.innerText="�ʻ�ID��";
}
//----------------------------------------------
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div id="Operation_Table">
      <table width="98%" border="0" cellspacing="1" align="center"  >
      		<input type="hidden" name="org_Code" id="org_Code" value="<%=org_Code%>">
		      <input type="hidden" name="work_no" id="work_no" value="<%=work_no%>">
		      <input type="hidden" name="op_code"  value="<%=op_code%>">
		      <input type="hidden" name="password"   value="<%=password%>">
					<input type="hidden" name="JspName"   value="<%=JspName%>">
					<input type="hidden" name="IsLogAuthen"   value="<%=IsLogAuthen%>">
					<input type="hidden" name="IsLogContact"   value="<%=IsLogContact%>">
					<input type="hidden" name="CustIdType"   value="<%=CustIdType%>">
					<input type="hidden" name="LoginAccept"   value="<%=LoginAccept%>">
      
		<div class="title">
			<div id="title_zi">Ԥ����ϸ��ѯ</div>
		</div>
      	<TR  > 			  
			<TD class="blue" width=15% height = 20 id="persontype"></TD>
			<TD class="blue" width=20% height = 20 colspan=4 >
			<input class="button" type=text  v_type="int"  v_must=1 v_minlength=0 v_maxlength=30 v_name="�ͻ���ʶ"  name=CustId id=CustId maxlength=30 value='<%=sInitCustId%>'>
			<font color="#FF0000">*</font>
			</TD>  
			<TD class="blue" width=15% height = 20></TD>
			<TD class="blue" width=15% height = 20></TD>
		</TR>
<%
		for(int i=0;i<AuthenCode.length;i++)
		{
			String sAuthId="AuthId"+i;
%>
		 <TR   > 
			<TD class="blue" width=10% height = 20>
<%
				if(IsMustUsed[i][0].equals("Y"))
				{
					out.println("<input type=\"radio\" name=\"Radio" + AuthenGroup[i][0] + "\" value1=\"" +
							AuthenCode[i][0] + "\" v_name=\"" + AuthenName[i][0] + "\" onClick=\"document.frm." + sAuthId+".value='';if (!document.frm." + sAuthId+".disabled)document.frm." + sAuthId+".focus();\" checked >" + AuthenName[i][0] + "��");
				}
				else
				{
					out.println("<input type=\"radio\" name=\"Radio" + AuthenGroup[i][0] + "\" value1=\"" +
							AuthenCode[i][0] + "\" v_name=\"" + AuthenName[i][0] + "\" onClick=\"document.frm." + sAuthId+".value='';if (!document.frm." + sAuthId+".disabled)document.frm." + sAuthId+".focus();\">" + AuthenName[i][0] + "��");
				}
%>
			</TD>
            <TD class="blue" width=20% height = 20  colspan="6">
<%
				if(AuthenType[i][0].equals("1"))
				{
					if (isAvoidPwdVerify)
					{
%>
					<input style="BACKGROUND-COLOR:wheat" type="password" name="<%=sAuthId%>" id="<%=sAuthId%>" maxlength="30" disabled>����������Ȩ�ޣ�
<%
					}
					else
					{
%>
						<jsp:include page="../../page/common/pwd_1.jsp">
		                  <jsp:param name="width1" value="16%" />
		                  <jsp:param name="width2" value="34%" />
		                  <jsp:param name="pname" value="<%=sAuthId%>"/>
		                  <jsp:param name="pwd" value="12345"  />
	 	                </jsp:include>
<%
					}
				}
				else
				{
					out.print("<input class=\"button\" type=text v_type=\"text\" v_minlength=0 v_maxlength=30 v_name=\"" +
							AuthenName[i][0] + "\" name=" + sAuthId + " id=" + sAuthId
							+ " maxlength=30 value=''>");
				}

				/*һ�����ж��ѡ���ǣ����ӡ�*����*/
				if(IsMustUsed[i][0].equals("Y"))
				{
					if (i == 0)
					{
						if(i!=AuthenCode.length-1)
						{
							if (!AuthenGroup[i][0].equals(AuthenGroup[i+1][0]))
							{
								out.print("<font color=\"#FF0000\">*</font>");
							}
						}
						else
						{
							out.print("<font color=\"#FF0000\">*</font>");
						}
					}
					else
					{
						if (!AuthenGroup[i][0].equals(AuthenGroup[i-1][0]))
						{
							if(i!=AuthenCode.length-1)
							{
								if (!AuthenGroup[i][0].equals(AuthenGroup[i+1][0]))
								{
									out.print("<font color=\"#FF0000\">*</font>");
								}
							}
							else
							{
								out.print("<font color=\"#FF0000\">*</font>");
							}
						}
					}
				}
%>
               </TD>
		</TR>
<%
			if(i!=AuthenCode.length-1)
			{
				if(!AuthenGroup[i][0].equals(AuthenGroup[i+1][0]))
				{
%>
		<TR   height=10> 
			<td colspan="7"></td>
		</TR>
<%
				}
			}
		}
%>
        <TR  > 
				<td colspan="7" > 
					<div align="center"> 
				 
						<input class="b_foot" type="button" name=qryPage value="ȷ��" onClick="doCfm()" index="2">      
						<input class="b_foot" type=button name=back value="���" onClick="frm.reset()"  >
						<input class="b_foot" type=button name=qryPage value="�ر�" onClick="window.close()"  >
					</div>
				</td>
		</TR>
  </table>

  </div>
	<%@ include file="../../page/public/foot.jsp" %>
   </form>
   	<%@ include file="../../page/common/pwd_comm.jsp" %>  <!--����С����  ע����������ļ�-->   
</body>
</html>
