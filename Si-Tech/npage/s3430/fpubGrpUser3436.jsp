   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-24
********************/
%>
              
    <%
  String opName = "�ն���APN��Ӧ";
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
//�õ��������
int recordNum = 0;
int iQuantity = 0;
String return_code,return_message;
String[][] result = new String[][]{};

%>

<%
/*
SQL���        sql_content
ѡ������       sel_type
����           title
�ֶ�1����      field_name1
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

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

	<SCRIPT type=text/javascript>
		function saveTo()
		{
			var rIndex;        //ѡ�������
			var retValue = ""; //����ֵ
			var chPos;         //�ַ�λ��
			var obj;
			var fieldNo;        //���������к�
			var retFieldNum = document.fPubSimpSel.retFieldNum.value;
			var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
			var retNum = retQuence.substring(0,retQuence.indexOf("|"));
			retQuence = retQuence.substring(retQuence.indexOf("|")+1);
			var tempQuence;
			if(retFieldNum == "")
			{     return false;   }
			//���ص�����¼
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if (document.fPubSimpSel.elements[i].name=="List")
				{    //�ж��Ƿ��ǵ�ѡ��ѡ��
					if (document.fPubSimpSel.elements[i].checked==true)
					{     //�ж��Ƿ�ѡ��
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
				rdShowMessageDialog("��ѡ����Ϣ�",0);
				return false;
			}
			//alert("11111")
			opener.getValueGrp(retValue);
			window.close();
		}

		function allChoose()
		{   //��ѡ��ȫ��ѡ��
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if(document.fPubSimpSel.elements[i].type=="checkbox")
				{    //�ж��Ƿ��ǵ�ѡ��ѡ��
					document.fPubSimpSel.elements[i].checked = true;
				}
			}
		}

		function cancelChoose()
		{   //ȡ����ѡ��ȫ��ѡ��
			for(i=0;i<document.fPubSimpSel.elements.length;i++)
			{
				if(document.fPubSimpSel.elements[i].type =="checkbox")
				{    //�ж��Ƿ��ǵ�ѡ��ѡ��
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
							<%  //���ƽ����
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
							//���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
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
								recordNum = result.length;//5��14��
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
								System.out.println("��ѯ����!!");
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
									out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
									out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");
									}
									%>

									<%
									if(selType.compareTo("") != 0)
									{
									%>
									<input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
									<%
									}
									%>
									<input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;
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
