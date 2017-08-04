   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
              
    <%
  String opName = "终端与APN对应";
%>          

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.boss.util.page.*"%>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("gb2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>

<%!
//得到输入参数
int recordNum = 0;
int iQuantity = 0;
String return_code,return_message;
String[][] result = new String[][]{};

%>

<%
/*
SQL语句        sql_content
选择类型       sel_type
标题           title
字段1名称      field_name1
*/
String pageTitle = request.getParameter("pageTitle");
String fieldNum = "";
String fieldName = request.getParameter("fieldName");
String sqlStr = request.getParameter("sqlStr");
String sqlStr1 = request.getParameter("sqlStr1")==null?"":request.getParameter("sqlStr1");
String selType = request.getParameter("selType");
String retQuence = request.getParameter("retQuence");
String opType = request.getParameter("opType");
String opCode = "3435";
String grpOutNo   = request.getParameter("grpUserNo");
String smCode   = "ap";
String oprType   = "q";
String loginNo = (String)session.getAttribute("workNo");
String loginPasswd = request.getParameter("loginPasswd");


int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
int iPageSize = 25;
int iStartPos = (iPageNumber-1)*iPageSize;
int iEndPos = iPageNumber*iPageSize;

System.out.println("sqlStr="+sqlStr);
System.out.println("sqlStr1="+sqlStr1);
if(selType.compareTo("S") == 0)
{   selType = "radio";    }
if(selType.compareTo("M") == 0)
{   selType = "checkbox";   }
if(selType.compareTo("N") == 0)
{   selType = "";   }
//=====================
int chPos = 0;
String typeStr = "";
String inputStr = "";
String valueStr = "";
%>

<HTML><HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

	<SCRIPT type=text/javascript>
		function saveTo()
		{
			var rIndex;        //选择框索引
			var retValue = ""; //返回值
			var chPos;         //字符位置
			var obj;
			var fieldNo;        //返回域序列号
			var retFieldNum = document.fPubSimpSel.retFieldNum.value;
			var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
			var retNum = retQuence.substring(0,retQuence.indexOf("|"));
			retQuence = retQuence.substring(retQuence.indexOf("|")+1);
			var tempQuence;
			if(retFieldNum == "")
			{     return false;   }
			//返回单条记录
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if (document.fPubSimpSel.elements[i].name=="List")
				{    //判断是否是单选或复选框
					if (document.fPubSimpSel.elements[i].checked==true)
					{     //判断是否被选中
						//alert(document.fPubSimpSel.elements[i].value);
						rIndex = document.fPubSimpSel.elements[i].RIndex;
						tempQuence = retQuence;
						//alert("retNum="+retNum);
						for(n=0;n<retNum;n++)
						{
							chPos = tempQuence.indexOf("|");
							fieldNo = tempQuence.substring(0,chPos);
							//alert("fieldNo="+fieldNo);
							obj = "Rinput" + rIndex + fieldNo;
							//alert("obj="+obj);
							retValue = retValue + document.all(obj).value + "|";
							//alert("retValue="+retValue);
							tempQuence = tempQuence.substring(chPos + 1);
						}
						//alert(retValue);
						window.returnValue= retValue
					}
				}
			}
			if(retValue =="")
			{
				rdShowMessageDialog("请选择信息项！",0);
				return false;
			}
			//alert("11111")
			opener.getValueGrp(retValue);
			window.close();
		}

		function allChoose()
		{   //复选框全部选中
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if(document.fPubSimpSel.elements[i].type=="checkbox")
				{    //判断是否是单选或复选框
					document.fPubSimpSel.elements[i].checked = true;
				}
			}
		}

		function cancelChoose()
		{   //取消复选框全部选中
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if(document.fPubSimpSel.elements[i].type =="checkbox")
				{    //判断是否是单选或复选框
					document.fPubSimpSel.elements[i].checked = false;
				}
			}
		}
	</SCRIPT>

	<!--**************************************************************************************-->
</HEAD>
<BODY>
	<FORM method=post name="fPubSimpSel">
		<%@ include file="/npage/include/header_pop.jsp" %>                         
	<div class="title">
		<div id="title_zi"><%=pageTitle%></div>
	</div>
 

					<table cellspacing="0">
						<tr>
							<%  //绘制界面表
								chPos = fieldName.indexOf("|");
								out.print("<Tr height=25>");
								String titleStr = "";
								int tempNum = 0;
								while(chPos != -1)
								{
									valueStr = fieldName.substring(0,chPos);
									titleStr = "<Th>&nbsp;&nbsp;" + valueStr + "</Th>";
									out.print(titleStr);
									fieldName = fieldName.substring(chPos + 1);
									tempNum = tempNum +1;
									chPos = fieldName.indexOf("|");
								}
								out.print("</TR>");
								fieldNum = String.valueOf(tempNum);
							%>

							<%
							//根据传入的Sql查询数据库，得到返回结果
							try
							{

								//retArray = callView.callFXService("s3435Init",inputPara,"13");
								String regionCode = (String)session.getAttribute("regCode");
%>


    <wtc:service name="s3435Init" outnum="14" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=grpOutNo%>" />
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=oprType%>" />
			<wtc:param value="<%=smCode%>" />		
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />

<%
System.out.println("s3435Inits3435Inits3435Inits3435Inits3435Inits3435Inits3435Init");
								result = result_t2;
								recordNum = result.length;//5行14列
								iQuantity = Integer.parseInt(result[0][13].trim());
								if (result[0][0].trim().length() == 0)
								recordNum = 0;
								for(int i=0;i<recordNum;i++)
								{
									typeStr = "";
									inputStr = "";
									out.print("<TR>");
									for(int j=0;j<13;j++)
									{
										if(j==0)
										{
											typeStr = "<TD>&nbsp;";
											if(selType.compareTo("") != 0)
											{
												typeStr = typeStr + "<input type='" + selType +
												"' name='List' style='cursor:hand' RIndex='" + i + "'" +
												"onkeydown='if(event.keyCode==13)saveTo();'" + ">";
											}
											typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
											" id='Rinput" + i + j + "'  value='" +
											(result[i][j]).trim() + "'readonly></TD>";
										}
										if(j<9&&j!=0&&j!=7)
										{
											inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
											" id='Rinput" + i + j + "'  value='" +
											(result[i][j]).trim() + "'readonly></TD>";
										}
										if(j>8){
											inputStr = inputStr + "<input type='hidden' " +
											" id='Rinput" + i + j + "' value='" +
											(result[i][j]).trim() + "'readonly>";
										}
										if(j==7){
											inputStr = inputStr + "<input type='hidden' " +
											" id='Rinput" + i + j + "'  value='" +
											(result[i][j]).trim() + "'readonly>";
										}
		
									}
									out.print(typeStr + inputStr);
									out.print("</TR>");
								}
							}catch(Exception e){
								System.out.println("查询错误!!");
							}
							%>
						</tr>
					</table>

					<%
					Page pg = new Page(iPageNumber,iPageSize,iQuantity);
					PageView view = new PageView(request,out,pg);
					
					%>
		<div style="position:relative;font-size:12px" align="center">
<%
    view.setVisible(true,true,0,0);      
%>
		</div>
		
					<!------------------------------------------------------>
					<TABLE cellSpacing="0">
						<TBODY>
							<TR>
								<TD align=center id="footer">
									<%
									if(selType.compareTo("checkbox") == 0)
									{
									out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
									out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");
									}
									%>

									<%
									if(selType.compareTo("") != 0)
									{
									%>
									<input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
									<%
									}
									%>
									<input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
								</TD>
							</TR>
						</TBODY>
					</TABLE>

						<!------------------------>
						<input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
						<input type="hidden" name="retQuence" value=<%=retQuence%>>
						<!------------------------>
					<%@ include file="/npage/include/footer_pop.jsp" %>
				</FORM>
			</BODY>
		</HTML>
