<%
  /*
   * ����: 
   * �汾: 1.0
   * ����: gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));

	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
		String[] favStr = new String[temfavStr.length];
		boolean operFlag = false;
		for(int i = 0; i < favStr.length; i ++) {
			favStr[i] = temfavStr[i][0].trim();
		}
		if (WtcUtil.haveStr(favStr, "a996")) {
			operFlag = true;
		}
		
		HashMap hm=new HashMap();
	  hm.put("1","û�пͻ�ID��");
	  hm.put("3","�������");
	  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
	  ///////
	  //  ��������� START
	  hm.put("5","�Բ��𣬴˺���Ϊ����������룬���Ĺ���Ȩ�޲��㣡");
	  hm.put("6","�Բ��𣬴˺����������ʼ��ʵ���ҵ������ȡ����");
	  hm.put("7","�Բ��𣬴˺��������������ʵ���ҵ������ȡ����");
	  hm.put("8","�Բ��𣬴˺����������ʼ��ʵ����͡������ʵ���ҵ������ȡ����");
	  hm.put("9","δ��ȡ���û������Ļ�����Ϣ!");
	  ///////
	  //  ��������� END
	  hm.put("2", "�û����ϲ�����1����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("10","�û����ϲ�����2����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("11","�û����ϲ�����3����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("12","�û����ϲ�����4����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("13","�û����ϲ�����5����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("14","�û����ϲ�����6����˲����ݻ���ѯϵͳ����Ա��");
	  hm.put("15","�Բ��𣬴˺�������������ͨҵ��ҵ������ȡ����");
	  hm.put("30","���û�Ϊ����û������ܽ���ʵ���Ǽǣ�");
	  hm.put("31","ʡ��Я���û���ֻ����ԭ�����ؽ���ʵ���Ǽǣ�");
	  
	   boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = loginNo;
	int favFlag = 0 ;/*0û������Ȩ��1������Ȩ��*/
	%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	 
%>

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			<%
			if(ReqPageName.equals("s1238Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));			 
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {
		%>
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
		<%
			  }
			  else if(retMsg.equals("100"))
			  {
		%>
				rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ�ѣ����ܰ���ҵ��');

		<%
			  }
		      else if(retMsg.equals("101"))
			  {
		%>
		rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		       		<%
			  }
			}
		%>
			
		});
		
		function doCommit(){
			f1.action="/npage/sm058/s1238Main.jsp";
    	f1.submit();
			
		}
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">�ֻ�����</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="srv_no" name="srv_no" v_type="0_9" maxlength="11" value="<%=phoneNo%>" class="InputGrey" readonly onblur="checkElement(this)"/>&nbsp;&nbsp;
	  		</td>
	    </tr>
	    <tr>
	  		<td colspan="4" ><font color="red">*�����˽���Ĺ�����Ҫ�С�ʵ���Ǽ�(m058)��Ȩ��</font></td>
	    </tr>
	  </table>
	 <div>
	
	 <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="ȷ��"   onclick="doCommit();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=�ر�>
			</td>
		</tr>
		
		</table>
	
	</div>
	<input type="hidden" name="iLoginAcceptnew" id="iLoginAcceptnew" />
	<input type="hidden" name="oCustName" id="oCustName" value=""/>
	<input type="hidden" name="oIccidNo" id="oIccidNo" value=""/>
	<input type="hidden" name="realOpCode" id="realOpCode" value="<%=opCode%>"/>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
