<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<%
  String work_no = (String) session.getAttribute("workNo");
  String org_Code = (String) session.getAttribute("orgCode");
  String regionCode=org_Code.substring(0,2);
	String password= (String)session.getAttribute("password");

	String brandId = request.getParameter("brandId");
	String gCustId = request.getParameter("gCustId");
	String idNo = request.getParameter("idNo");
	String offerId = request.getParameter("offerId");
	String servBusiId = request.getParameter("servBusiId");
	String phoneNo = request.getParameter("phoneNo");
	String functionName = request.getParameter("functionName");
	String custAuthId = request.getParameter("custAuthId");
	if (custAuthId == null)
	{
		custAuthId = "";
	}
	%>

<wtc:utype name="sCustAuthQry" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:uparam value="<%=opCode%>" type="String"/>
      <wtc:uparam value="2" type="INT"/>
      <wtc:uparam value="<%=work_no%>" type="String"/>
      <wtc:uparam value="<%=regionCode%>" type="String"/>
</wtc:utype>
	<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	  
	String AuthFuncName = retVal.getValue("2.0.0");
	String JspName = retVal.getValue("2.0.1");
	String CustIdType = retVal.getValue("2.0.2");
	String IsLogAuthen = retVal.getValue("2.0.3");
	String IsLogContact = retVal.getValue("2.0.4");
	String sGroupRelaType = retVal.getValue("2.0.5");
	String  sGroupSize = retVal.getValue("2.0.6");
	
	int size1 = retVal.getSize("2.1");
	String [] AuthenCode = new String[size1];
	String [] AuthenName = new String[size1];
	String [] AuthenGroup = new String[size1];
	String [] GroupInnerType = new String[size1];
	String [] GroupName = new String[size1];
	String [] AuthenType = new String[size1];
	
	for(int i=0;i<size1;i++)
	{
		AuthenCode[i]=retVal.getValue("2.1."+i+".0");
		AuthenName[i]=retVal.getValue("2.1."+i+".1");
		AuthenGroup[i]=retVal.getValue("2.1."+i+".2");
		GroupInnerType[i]=retVal.getValue("2.1."+i+".3");
		GroupName[i]=retVal.getValue("2.1."+i+".4");
		AuthenType[i]=retVal.getValue("2.1."+i+".5");
	}
	
	String CustIdTypeName = retVal.getValue("2.2.1");
	String AuthenParamName = retVal.getValue("2.2.3");
	
	int size2 = retVal.getSize("2.3");
	String [] CodeValue = new String[size2];
	String [] CodeName = new String[size2];
	for(int i=0;i<size2;i++)
	{
		CodeValue[i]=retVal.getValue("2.3."+i+".0");
		CodeName[i]=retVal.getValue("2.3."+i+".1");
	}
	

	//检查是否做密码验证。
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] temfavStr=(String[][])arrSession.get(3);
	String[] favStr=new String[temfavStr.length];
	boolean isAvoidPwdVerify=false;
	for(int i=0;i<favStr.length;i++)
	{
		favStr[i]=temfavStr[i][0].trim();
		if (favStr[i].indexOf("a270") != -1)
		{
			isAvoidPwdVerify=true;
		}
	}
%>

<title></title>
<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
<%
	out.println("var vAthenArr = new Array();");
	out.println("vAthenArr[0] = new Array();");
	out.println("vAthenArr[1] = new Array();");
	for(int i=0;i<AuthenCode.length;i++)
	{
		out.println("vAthenArr[0][" + i + "]='" + AuthenCode[i] +"';");
		out.println("vAthenArr[1][" + i + "]='AuthId" + i +"';");
	}		

%>

onload=function()
{
	changetype('<%=CustIdType%>');
	SelectGroupType(null);
}

function changetype(CustIdType)
{
	if(CustIdType==0)document.all.persontype.innerHtml="<span class='red'>*客户ID：</span>";
	if(CustIdType==1)document.all.persontype.innerHtml="<span class='red'>*服务号码：</span>";
	if(CustIdType==2)document.all.persontype.innerHtml="<span class='red'>*帐户ID：</span>";
}

//----------------验证及提交函数-----------------
function doCfm()
{
	var tempStr="";
	
<%
	if (AuthenCode.length > 0)
	{
%>
		var iGroupRelaTypeCount = 1;
		if (typeof(frm.GroupRelaType.checked) == 'undefined')
		{
			iGroupRelaTypeCount = frm.GroupRelaType.length;
		}
		else
		{
			iGroupRelaTypeCount = 1;
		}
		for (var i = 0; i < frm.length; i ++)
		{
			var obj = frm.elements[i];
			if ((typeof(obj.name) != 'undefined') &&(typeof(obj.checked) != 'undefined'))
			{
				if (obj.name.substring(0, 5) == 'Radio')
				{
					if (   (iGroupRelaTypeCount > 1 && frm.GroupRelaType[obj.iTrGroupId].checked)
					    || (iGroupRelaTypeCount == 1 && frm.GroupRelaType.checked)
					    )
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
										alert(obj.v_name + "不能为空!");
										document.all(vAthenArr[1][j]).focus();
										return false;
									}
									else if (document.all(vAthenArr[1][j]).value != "")
									{
										tempStr = tempStr +vAthenArr[0][j] + "," + document.all(vAthenArr[1][j]).value + "|";
									}
									else
									{
										//
									}
								}
							}
						}
					}
					else
					{
						//
					}
				}
			}
			
		}
<%
	}
%>
  if(check(frm))
  {
	  var myPacket = new AJAXPacket("fAuthentication_cfm.jsp?tempStr="+tempStr);
	  
	  myPacket.data.add("work_no","<%=work_no%>");
		myPacket.data.add("password","<%=password%>");
		myPacket.data.add("op_code","<%=opCode%>");
		myPacket.data.add("CustIdType","<%=CustIdType%>");
		myPacket.data.add("custAuthId",document.frm.custAuthId.value);
		myPacket.data.add("gCustId","<%=gCustId%>");
		myPacket.data.add("SmCode","<%=brandId%>");
		myPacket.data.add("JspName","<%=JspName%>");
		myPacket.data.add("IsLogAuthen","<%=IsLogAuthen%>");
		myPacket.data.add("IsLogContact","<%=IsLogContact%>");
		myPacket.data.add("phoneNo","<%=phoneNo%>");
		
		myPacket.data.add("contact_id","0");
		myPacket.data.add("interface_code","0");
		myPacket.data.add("group_id","0");
		myPacket.data.add("contact_status","0");
		myPacket.data.add("begin_time","0");
		myPacket.data.add("contract_type","0");
		myPacket.data.add("contact_reason","0");
		myPacket.data.add("contact_content","0");
		
		core.ajax.sendPacket(myPacket);
		
		myPacket=null;
		
  }
}

function doProcess(myPacket)
{
		var retCode    = myPacket.data.findValueByName("retCode");
		var retMsg     = myPacket.data.findValueByName("retMsg");		
 		self.status="";
		if(retCode=="000000")
		{
			parent.window.insertCar('<%=idNo%>','<%=offerId%>','<%=opCode%>','<%=servBusiId%>','<%=phoneNo%>','<%=functionName%>');
			closeDivWin();
		}else
		{
			rdShowMessageDialog("["+retCode+"]"+retMsg);	
		}		
}

function SelectGroupType(obj)
{
<%
	if (AuthenCode.length > 0)
	{
%>
		var i = 0;
		var iTrGroupId = 0;
		
		if (obj != null)
		{
			iTrGroupId = obj.iTrGroupId;
		}
		else
		{
			if (typeof(frm.GroupRelaType.length) == 'undefined')
			{
				obj=frm.GroupRelaType;
			}
			else
			{
				obj=frm.GroupRelaType[0];
			}
			obj.checked = true;
		}
	
		if (typeof(frm.GroupRelaType.length) == 'undefined')
		{
			//单行
			document.all("trGroupRelaType"+iTrGroupId).bgColor = "#e8e8e8";
		}
		else
		{
			//多行
			for(i = 0; i < document.frm.GroupRelaType.length; i ++)
			{
				document.all("trGroupRelaType"+i).bgColor = "#e8e8e8";
			}
		}
		document.all("trGroupRelaType"+iTrGroupId).bgColor = "lightgreen";
<%
	}
%>
}

</script>
</head>
<body >
<div id="operation">
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<div id="operation_table">
   <table>
     <TR> 			  
			<th id="persontype"><span class="red">*<%=CustIdTypeName%>:</span></th>
			<TD colspan="3">
				<input type=text name=custAuthId id=custAuthId maxlength=30 value='<%=custAuthId%>'>
			</TD>  
		</TR>
<%
		int iAuthenCodeCount = 0;
		int iTrGroupId = 0;
		String sAuthId="AuthId"+iAuthenCodeCount;
		while(iAuthenCodeCount<AuthenCode.length)
		{
%>
			<TR id=trGroupRelaType<%=iTrGroupId%> >
				<td colspan="1">
<%
					if(sGroupRelaType.equals("R"))
					{
						out.println("<input type='radio' name='GroupRelaType' iTrGroupId='" + iTrGroupId + "' onClick='SelectGroupType(this)'>");
					}
					else
					{
						out.println("<input type='checkbox' name='GroupRelaType' iTrGroupId='" + iTrGroupId + "' onClick='SelectGroupType(this)' checked disabled>");
					}
					out.println(GroupName[iAuthenCodeCount]);
%>
				</td>
				<td colspan="2">
					<table>
<%
					int i=0;
					while(iAuthenCodeCount < AuthenCode.length)
					{
%>
						 <TR> 
							<TD>
<%
							if (GroupInnerType[iAuthenCodeCount].equals("R"))
							{
								if (i == 0)
								{
									out.println("<input type=\"radio\" name=\"Radio" + AuthenGroup[iAuthenCodeCount] + "\" value1=\"" +
											AuthenCode[iAuthenCodeCount] + "\" v_name=\"" + AuthenName[iAuthenCodeCount] + "\" iTrGroupId=\"" + iTrGroupId + "\" onClick=\"document.frm." + sAuthId+".value='';if (!document.frm." + sAuthId+".disabled)document.frm." + sAuthId+".focus();\" checked>" + AuthenName[iAuthenCodeCount]);
								}
								else
								{
									out.println("<input type=\"radio\" name=\"Radio" + AuthenGroup[iAuthenCodeCount] + "\" value1=\"" +
											AuthenCode[iAuthenCodeCount] + "\" v_name=\"" + AuthenName[iAuthenCodeCount] + "\" iTrGroupId=\"" + iTrGroupId + "\" onClick=\"document.frm." + sAuthId+".value='';if (!document.frm." + sAuthId+".disabled)document.frm." + sAuthId+".focus();\">" + AuthenName[iAuthenCodeCount]);
								}
							}
							else
							{
								out.println("<input type=\"checkbox\" name=\"Radio" + AuthenGroup[iAuthenCodeCount] + "\" value1=\"" +
										AuthenCode[iAuthenCodeCount] + "\" v_name=\"" + AuthenName[iAuthenCodeCount] + "\" iTrGroupId=\"" + iTrGroupId + "\" onClick=\"document.frm." + sAuthId+".value='';if (!document.frm." + sAuthId+".disabled)document.frm." + sAuthId+".focus();\" checked disabled>" + AuthenName[iAuthenCodeCount]);
							}
%>
							</TD>
				      <TD>
<%
								if(AuthenType[iAuthenCodeCount].equals("1"))
								{
									if (isAvoidPwdVerify)
									{
%>
									<input style="BACKGROUND-COLOR:wheat" type="password" name="<%=sAuthId%>" id="<%=sAuthId%>" maxlength="30" disabled>（免输密码权限）
<%
									}
									else
									{
%>
									<input style="BACKGROUND-COLOR:wheat" type="password" name="<%=sAuthId%>" id="<%=sAuthId%>" maxlength="30" disabled>（免输密码权限）
                               <!--
                                     
										<--jsp:include page="/page/common/pwd_1.jsp">
						                  <jsp:param name="width1" value="16%" />
						                  <jsp:param name="width2" value="34%" />
						                  <jsp:param name="pname" value="<%=sAuthId%>"/>
						                  <jsp:param name="pwd" value="12345"  />
					 	                </jsp:include-->
									
<%
									}
								}
								else
								{
									String type="text";
									if(AuthenGroup[iAuthenCodeCount].equals("1"))
									{
										type="password";
									}

										//从session中取出已经输入的密码，放入input中
										Map sessionMap = (HashMap)session.getAttribute(gCustId);
										Map map = null;
										if(CustIdType.equals("0"))//客户
										{
											map = (HashMap)sessionMap.get(CustIdType);
										}else if(CustIdType.equals("1"))//用户
										{
											map = (HashMap)sessionMap.get(phoneNo);
										}
										
										String val ="";
										
										Iterator   it   =   map.entrySet().iterator()   ;  
									  while(it.hasNext())  
									  {
										  Map.Entry   entry   =   (Map.Entry)   it.next()   ;  
										  String   key   =  (String) entry.getKey()   ;  
										  String   value =  (String) entry.getValue()   ;  
										  
										  if(AuthenCode[iAuthenCodeCount].equals(key))
										  {
										  	val=(String)map.get(AuthenCode[iAuthenCodeCount]);
										  	break;
										  }
									  } 
									  
									  
		  
									out.print("<input type="+type+" v_type=\"text\" v_minlength=0 v_maxlength=30 v_name=\"" +
											AuthenName[iAuthenCodeCount] + "\" name=" + sAuthId + " id=" + sAuthId
											+ " maxlength=30 value="+val+">");
								}
%>
				               </TD>
						</TR>
<%
						iAuthenCodeCount ++;
						sAuthId="AuthId"+iAuthenCodeCount;
						if((iAuthenCodeCount >= AuthenCode.length) || !(AuthenGroup[iAuthenCodeCount].equals(AuthenGroup[iAuthenCodeCount-1])))
						{
							break;
						}
						i ++;
					}
%>
					</table>
				</td>
			</TR>
<%
			iTrGroupId ++;
		}
%>
			</table>
		</div>
		<div id="operation_button">
						<input type="button" class="b_foot" name=qryPage value="确认" onClick="doCfm()" >      
						<!--input type="button" class="b_foot" name=back value="清除" onClick="frm.reset()"  -->
  	</div>
	<%@ include file="/npage/include/footer.jsp" %>
   </form>
  </div>
   	<%@ include file="/npage/common/pwd_comm.jsp" %>  <!--密码小键盘  注意引入这个文件-->   
</body>
</html>
